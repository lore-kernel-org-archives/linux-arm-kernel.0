From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Dec 2013 17:36:38 +0100
Subject: [PATCH 2/2] ARM: integrator: move EBI to the device tree
Message-ID: <1386174998-6012-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the External Bus Interface (EBI) over to a device
tree node and deletes the static mappings from the platform.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/arm-boards |  8 ++++
 arch/arm/boot/dts/integrator.dtsi                |  5 +++
 arch/arm/mach-integrator/integrator_ap.c         | 52 ++++++++++++++----------
 arch/arm/mach-integrator/integrator_cp.c         |  6 ---
 4 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index 5fac246a9530..3509707f9320 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -14,6 +14,9 @@ Required nodes:
 - core-module: the root node to the Integrator platforms must have
   a core-module with regs and the compatible string
   "arm,core-module-integrator"
+- external-bus-interface: the root node to the Integrator platforms
+  must have an external bus interface with regs and the
+  compatible-string "arm,external-bus-interface"
 
   Required properties for the core module:
   - regs: the location and size of the core module registers, one
@@ -48,6 +51,11 @@ Required nodes:
 		reg = <0x10000000 0x200>;
 	};
 
+	ebi at 12000000 {
+		compatible = "arm,external-bus-interface";
+		reg = <0x12000000 0x100>;
+	};
+
 	syscon {
 		compatible = "arm,integrator-ap-syscon";
 		reg = <0x11000000 0x100>;
diff --git a/arch/arm/boot/dts/integrator.dtsi b/arch/arm/boot/dts/integrator.dtsi
index 0f06f8687b0b..88e3d477bf16 100644
--- a/arch/arm/boot/dts/integrator.dtsi
+++ b/arch/arm/boot/dts/integrator.dtsi
@@ -10,6 +10,11 @@
 		reg = <0x10000000 0x200>;
 	};
 
+	ebi at 12000000 {
+		compatible = "arm,external-bus-interface";
+		reg = <0x12000000 0x100>;
+	};
+
 	timer at 13000000 {
 		reg = <0x13000000 0x100>;
 		interrupt-parent = <&pic>;
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index a762712bc2f2..cc1d3fe21c4e 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -63,6 +63,8 @@
 
 /* Base address to the AP system controller */
 void __iomem *ap_syscon_base;
+/* Base address to the external bus interface */
+static void __iomem *ebi_base;
 
 
 /*
@@ -73,13 +75,11 @@ void __iomem *ap_syscon_base;
  * just for now).
  */
 #define VA_IC_BASE	__io_address(INTEGRATOR_IC_BASE)
-#define VA_EBI_BASE	__io_address(INTEGRATOR_EBI_BASE)
 
 /*
  * Logical      Physical
  * ef000000			Cache flush
  * f1100000	11000000	System controller registers
- * f1200000	12000000	EBI registers
  * f1300000	13000000	Counter/Timer
  * f1400000	14000000	Interrupt controller
  * f1600000	16000000	UART 0
@@ -90,11 +90,6 @@ void __iomem *ap_syscon_base;
 
 static struct map_desc ap_io_desc[] __initdata __maybe_unused = {
 	{
-		.virtual	= IO_ADDRESS(INTEGRATOR_EBI_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_EBI_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	= IO_ADDRESS(INTEGRATOR_CT_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_CT_BASE),
 		.length		= SZ_4K,
@@ -168,9 +163,6 @@ device_initcall(irq_syscore_init);
 /*
  * Flash handling.
  */
-#define EBI_CSR1 (VA_EBI_BASE + INTEGRATOR_EBI_CSR1_OFFSET)
-#define EBI_LOCK (VA_EBI_BASE + INTEGRATOR_EBI_LOCK_OFFSET)
-
 static int ap_flash_init(struct platform_device *dev)
 {
 	u32 tmp;
@@ -178,13 +170,15 @@ static int ap_flash_init(struct platform_device *dev)
 	writel(INTEGRATOR_SC_CTRL_nFLVPPEN | INTEGRATOR_SC_CTRL_nFLWP,
 	       ap_syscon_base + INTEGRATOR_SC_CTRLC_OFFSET);
 
-	tmp = readl(EBI_CSR1) | INTEGRATOR_EBI_WRITE_ENABLE;
-	writel(tmp, EBI_CSR1);
+	tmp = readl(ebi_base + INTEGRATOR_EBI_CSR1_OFFSET) |
+		INTEGRATOR_EBI_WRITE_ENABLE;
+	writel(tmp, ebi_base + INTEGRATOR_EBI_CSR1_OFFSET);
 
-	if (!(readl(EBI_CSR1) & INTEGRATOR_EBI_WRITE_ENABLE)) {
-		writel(0xa05f, EBI_LOCK);
-		writel(tmp, EBI_CSR1);
-		writel(0, EBI_LOCK);
+	if (!(readl(ebi_base + INTEGRATOR_EBI_CSR1_OFFSET)
+	      & INTEGRATOR_EBI_WRITE_ENABLE)) {
+		writel(0xa05f, ebi_base + INTEGRATOR_EBI_LOCK_OFFSET);
+		writel(tmp, ebi_base + INTEGRATOR_EBI_CSR1_OFFSET);
+		writel(0, ebi_base + INTEGRATOR_EBI_LOCK_OFFSET);
 	}
 	return 0;
 }
@@ -196,13 +190,15 @@ static void ap_flash_exit(struct platform_device *dev)
 	writel(INTEGRATOR_SC_CTRL_nFLVPPEN | INTEGRATOR_SC_CTRL_nFLWP,
 	       ap_syscon_base + INTEGRATOR_SC_CTRLC_OFFSET);
 
-	tmp = readl(EBI_CSR1) & ~INTEGRATOR_EBI_WRITE_ENABLE;
-	writel(tmp, EBI_CSR1);
+	tmp = readl(ebi_base + INTEGRATOR_EBI_CSR1_OFFSET) &
+		~INTEGRATOR_EBI_WRITE_ENABLE;
+	writel(tmp, ebi_base + INTEGRATOR_EBI_CSR1_OFFSET);
 
-	if (readl(EBI_CSR1) & INTEGRATOR_EBI_WRITE_ENABLE) {
-		writel(0xa05f, EBI_LOCK);
-		writel(tmp, EBI_CSR1);
-		writel(0, EBI_LOCK);
+	if (readl(ebi_base + INTEGRATOR_EBI_CSR1_OFFSET) &
+	    INTEGRATOR_EBI_WRITE_ENABLE) {
+		writel(0xa05f, ebi_base + INTEGRATOR_EBI_LOCK_OFFSET);
+		writel(tmp, ebi_base + INTEGRATOR_EBI_CSR1_OFFSET);
+		writel(0, ebi_base + INTEGRATOR_EBI_LOCK_OFFSET);
 	}
 }
 
@@ -469,11 +465,17 @@ static const struct of_device_id ap_syscon_match[] = {
 	{ },
 };
 
+static const struct of_device_id ebi_match[] = {
+	{ .compatible = "arm,external-bus-interface"},
+	{ },
+};
+
 static void __init ap_init_of(void)
 {
 	unsigned long sc_dec;
 	struct device_node *root;
 	struct device_node *syscon;
+	struct device_node *ebi;
 	struct device *parent;
 	struct soc_device *soc_dev;
 	struct soc_device_attribute *soc_dev_attr;
@@ -489,10 +491,16 @@ static void __init ap_init_of(void)
 	syscon = of_find_matching_node(root, ap_syscon_match);
 	if (!syscon)
 		return;
+	ebi = of_find_matching_node(root, ebi_match);
+	if (!ebi)
+		return;
 
 	ap_syscon_base = of_iomap(syscon, 0);
 	if (!ap_syscon_base)
 		return;
+	ebi_base = of_iomap(ebi, 0);
+	if (!ebi_base)
+		return;
 
 	ap_sc_id = readl(ap_syscon_base);
 
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 916c0f345a3a..5e84149d1790 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -64,7 +64,6 @@ static void __iomem *intcp_con_base;
 
 /*
  * Logical      Physical
- * f1200000	12000000	EBI registers
  * f1300000	13000000	Counter/Timer
  * f1400000	14000000	Interrupt controller
  * f1600000	16000000	UART 0
@@ -76,11 +75,6 @@ static void __iomem *intcp_con_base;
 
 static struct map_desc intcp_io_desc[] __initdata __maybe_unused = {
 	{
-		.virtual	= IO_ADDRESS(INTEGRATOR_EBI_BASE),
-		.pfn		= __phys_to_pfn(INTEGRATOR_EBI_BASE),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE
-	}, {
 		.virtual	= IO_ADDRESS(INTEGRATOR_CT_BASE),
 		.pfn		= __phys_to_pfn(INTEGRATOR_CT_BASE),
 		.length		= SZ_4K,
-- 
1.8.3.1
