From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Jan 2016 12:12:03 +0100
Subject: [PATCH 4/6] ARM: integrator: move flash registration to device tree
In-Reply-To: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
References: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1453806725-4880-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flash on the Integrator was already defined by the device
tree, but VPP control and flash protection was in the
boardfiles. Simply add the compatible string
"arm,versatile-flash" and the special add-on code for flash
programming voltage and protection kicks in in the MTD
layer.

Remove the board file code and augment the device tree in
one go for seamless transition.

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integrator.dtsi        |  3 +-
 arch/arm/mach-integrator/integrator_ap.c | 62 --------------------------------
 arch/arm/mach-integrator/integrator_cp.c | 51 --------------------------
 3 files changed, 2 insertions(+), 114 deletions(-)

diff --git a/arch/arm/boot/dts/integrator.dtsi b/arch/arm/boot/dts/integrator.dtsi
index 3807d4f46ef7..adc4befea46d 100644
--- a/arch/arm/boot/dts/integrator.dtsi
+++ b/arch/arm/boot/dts/integrator.dtsi
@@ -52,8 +52,9 @@
 	};
 
 	flash at 24000000 {
-		compatible = "cfi-flash";
+		compatible = "arm,versatile-flash", "cfi-flash";
 		reg = <0x24000000 0x02000000>;
+		bank-width = <4>;
 	};
 
 	fpga {
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 5b0e363fe5ba..2b118f20c62c 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -29,7 +29,6 @@
 #include <linux/amba/kmi.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
-#include <linux/mtd/physmap.h>
 #include <linux/platform_data/clk-integrator.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
@@ -147,65 +146,6 @@ static int __init irq_syscore_init(void)
 device_initcall(irq_syscore_init);
 
 /*
- * Flash handling.
- */
-static int ap_flash_init(struct platform_device *dev)
-{
-	u32 tmp;
-
-	writel(INTEGRATOR_SC_CTRL_nFLVPPEN | INTEGRATOR_SC_CTRL_nFLWP,
-	       ap_syscon_base + INTEGRATOR_SC_CTRLC_OFFSET);
-
-	tmp = readl(ebi_base + INTEGRATOR_EBI_CSR1_OFFSET) |
-		INTEGRATOR_EBI_WRITE_ENABLE;
-	writel(tmp, ebi_base + INTEGRATOR_EBI_CSR1_OFFSET);
-
-	if (!(readl(ebi_base + INTEGRATOR_EBI_CSR1_OFFSET)
-	      & INTEGRATOR_EBI_WRITE_ENABLE)) {
-		writel(0xa05f, ebi_base + INTEGRATOR_EBI_LOCK_OFFSET);
-		writel(tmp, ebi_base + INTEGRATOR_EBI_CSR1_OFFSET);
-		writel(0, ebi_base + INTEGRATOR_EBI_LOCK_OFFSET);
-	}
-	return 0;
-}
-
-static void ap_flash_exit(struct platform_device *dev)
-{
-	u32 tmp;
-
-	writel(INTEGRATOR_SC_CTRL_nFLVPPEN | INTEGRATOR_SC_CTRL_nFLWP,
-	       ap_syscon_base + INTEGRATOR_SC_CTRLC_OFFSET);
-
-	tmp = readl(ebi_base + INTEGRATOR_EBI_CSR1_OFFSET) &
-		~INTEGRATOR_EBI_WRITE_ENABLE;
-	writel(tmp, ebi_base + INTEGRATOR_EBI_CSR1_OFFSET);
-
-	if (readl(ebi_base + INTEGRATOR_EBI_CSR1_OFFSET) &
-	    INTEGRATOR_EBI_WRITE_ENABLE) {
-		writel(0xa05f, ebi_base + INTEGRATOR_EBI_LOCK_OFFSET);
-		writel(tmp, ebi_base + INTEGRATOR_EBI_CSR1_OFFSET);
-		writel(0, ebi_base + INTEGRATOR_EBI_LOCK_OFFSET);
-	}
-}
-
-static void ap_flash_set_vpp(struct platform_device *pdev, int on)
-{
-	if (on)
-		writel(INTEGRATOR_SC_CTRL_nFLVPPEN,
-		       ap_syscon_base + INTEGRATOR_SC_CTRLS_OFFSET);
-	else
-		writel(INTEGRATOR_SC_CTRL_nFLVPPEN,
-		       ap_syscon_base + INTEGRATOR_SC_CTRLC_OFFSET);
-}
-
-static struct physmap_flash_data ap_flash_data = {
-	.width		= 4,
-	.init		= ap_flash_init,
-	.exit		= ap_flash_exit,
-	.set_vpp	= ap_flash_set_vpp,
-};
-
-/*
  * For the PL010 found in the Integrator/AP some of the UART control is
  * implemented in the system controller and accessed using a callback
  * from the driver.
@@ -266,8 +206,6 @@ static struct of_dev_auxdata ap_auxdata_lookup[] __initdata = {
 		"kmi0", NULL),
 	OF_DEV_AUXDATA("arm,primecell", KMI1_BASE,
 		"kmi1", NULL),
-	OF_DEV_AUXDATA("cfi-flash", INTEGRATOR_FLASH_BASE,
-		"physmap-flash", &ap_flash_data),
 	{ /* sentinel */ },
 };
 
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index b5fb71a36ee6..6f6b051e81e0 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -23,7 +23,6 @@
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/gfp.h>
-#include <linux/mtd/physmap.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -43,14 +42,8 @@
 /* Base address to the CP controller */
 static void __iomem *intcp_con_base;
 
-#define INTCP_PA_FLASH_BASE		0x24000000
-
 #define INTCP_PA_CLCD_BASE		0xc0000000
 
-#define INTCP_FLASHPROG			0x04
-#define CINTEGRATOR_FLASHPROG_FLVPPEN	(1 << 0)
-#define CINTEGRATOR_FLASHPROG_FLWREN	(1 << 1)
-
 /*
  * Logical      Physical
  * f1000000	10000000	Core module registers
@@ -108,48 +101,6 @@ static void __init intcp_map_io(void)
 }
 
 /*
- * Flash handling.
- */
-static int intcp_flash_init(struct platform_device *dev)
-{
-	u32 val;
-
-	val = readl(intcp_con_base + INTCP_FLASHPROG);
-	val |= CINTEGRATOR_FLASHPROG_FLWREN;
-	writel(val, intcp_con_base + INTCP_FLASHPROG);
-
-	return 0;
-}
-
-static void intcp_flash_exit(struct platform_device *dev)
-{
-	u32 val;
-
-	val = readl(intcp_con_base + INTCP_FLASHPROG);
-	val &= ~(CINTEGRATOR_FLASHPROG_FLVPPEN|CINTEGRATOR_FLASHPROG_FLWREN);
-	writel(val, intcp_con_base + INTCP_FLASHPROG);
-}
-
-static void intcp_flash_set_vpp(struct platform_device *pdev, int on)
-{
-	u32 val;
-
-	val = readl(intcp_con_base + INTCP_FLASHPROG);
-	if (on)
-		val |= CINTEGRATOR_FLASHPROG_FLVPPEN;
-	else
-		val &= ~CINTEGRATOR_FLASHPROG_FLVPPEN;
-	writel(val, intcp_con_base + INTCP_FLASHPROG);
-}
-
-static struct physmap_flash_data intcp_flash_data = {
-	.width		= 4,
-	.init		= intcp_flash_init,
-	.exit		= intcp_flash_exit,
-	.set_vpp	= intcp_flash_set_vpp,
-};
-
-/*
  * It seems that the card insertion interrupt remains active after
  * we've acknowledged it.  We therefore ignore the interrupt, and
  * rely on reading it from the SIC.  This also means that we must
@@ -260,8 +211,6 @@ static struct of_dev_auxdata intcp_auxdata_lookup[] __initdata = {
 		"aaci", &mmc_data),
 	OF_DEV_AUXDATA("arm,primecell", INTCP_PA_CLCD_BASE,
 		"clcd", &clcd_data),
-	OF_DEV_AUXDATA("cfi-flash", INTCP_PA_FLASH_BASE,
-		"physmap-flash", &intcp_flash_data),
 	{ /* sentinel */ },
 };
 
-- 
2.4.3
