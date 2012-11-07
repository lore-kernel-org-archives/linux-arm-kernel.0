From: horms@verge.net.au (Simon Horman)
Date: Wed,  7 Nov 2012 17:50:34 +0900
Subject: [PATCH 05/15] ARM: shmobile: Add support OF of INTC for sh7372
In-Reply-To: <1352278244-26702-1-git-send-email-horms@verge.net.au>
References: <1352278244-26702-1-git-send-email-horms@verge.net.au>
Message-ID: <1352278244-26702-6-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

This CPU has four interrupt controllers (INTCA, INTCS, pins-High and pins-Low).
This supports these.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

v2 [Simon Horman]
* Don't add trailing blank line
* Use #ifdef instead of #if defined
* Use CONFIG_OF in place of CONFIG_OF_SH_INTC
* Allow OF and non OF code to be compiled in the same binary and
  provide sh7372_init_irq_of() as a way to initialise INTC
  using DT while sh7372_init_irq() still initialises INTC
  using the previous code paths. This is because we would
  like to be able to use a single configuration to compile a kernel
  for multiple boards and not all sh7372 boards have DT support yet.

v1 [Nobuhiro Iwamatsu]
---
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/intc-sh7372.c         |  210 +++++++++++++++++++++++---
 2 files changed, 190 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 7696a96..f44a36b 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -36,6 +36,7 @@ extern void sh7377_pinmux_init(void);
 extern struct clk sh7377_extalc1_clk;
 extern struct clk sh7377_extal2_clk;
 
+extern void sh7372_init_irq_of(void);
 extern void sh7372_init_irq(void);
 extern void sh7372_map_io(void);
 extern void sh7372_add_early_devices(void);
diff --git a/arch/arm/mach-shmobile/intc-sh7372.c b/arch/arm/mach-shmobile/intc-sh7372.c
index a91caad..27bd6d5 100644
--- a/arch/arm/mach-shmobile/intc-sh7372.c
+++ b/arch/arm/mach-shmobile/intc-sh7372.c
@@ -28,6 +28,137 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#ifdef CONFIG_OF
+
+static struct intc_desc intca_desc __initdata;
+static struct resource intca_resources[2] __initdata;
+static struct intc_desc intcs_desc __initdata;
+static struct resource intcs_resources[2] __initdata;
+static struct intc_desc intca_irq_pins_lo_desc __initdata;
+static struct resource intca_pins_lo_resources[1] __initdata;
+static struct intc_desc intca_irq_pins_hi_desc __initdata;
+static struct resource intca_pins_hi_resources[1] __initdata;
+static unsigned short intevtsa_vect;
+
+static int sh7372_intca_of_init(struct device_node *np,
+			struct device_node *parent)
+{
+	int ret;
+
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	ret = of_sh_intc_get_meminfo(np,
+				intca_resources, ARRAY_SIZE(intcs_resources));
+	if (ret)
+		goto error;
+
+	intca_desc.resource = intca_resources;
+	intca_desc.num_resources = ARRAY_SIZE(intca_resources);
+
+	ret = of_sh_intc_get_intc(np, &intca_desc);
+	if (ret)
+		goto error;
+
+	intca_desc.name = "sh7372-intca";
+error:
+	return ret;
+}
+
+static int sh7372_intcs_of_init(struct device_node *np,
+			struct device_node *parent)
+{
+	int ret;
+
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	ret = of_sh_intc_get_meminfo(np,
+				intcs_resources, ARRAY_SIZE(intcs_resources));
+	if (ret)
+		goto error;
+
+	intcs_desc.resource = intcs_resources;
+	intcs_desc.num_resources = ARRAY_SIZE(intcs_resources);
+
+	ret = of_sh_intc_get_intc(np, &intcs_desc);
+	if (ret)
+		goto error;
+
+	of_sh_intc_get_intevtsa_vect(np, &intevtsa_vect);
+
+	intcs_desc.name = "sh7372-intcs";
+
+error:
+	return ret;
+}
+
+static int sh7372_intca_pins_lo_of_init(struct device_node *np,
+				    struct device_node *parent)
+{
+	int ret;
+
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	ret = of_sh_intc_get_meminfo(np, intca_pins_lo_resources,
+			ARRAY_SIZE(intca_pins_lo_resources));
+	if (ret)
+		goto error;
+
+	intca_irq_pins_lo_desc.resource = intca_pins_lo_resources;
+	intca_irq_pins_lo_desc.num_resources
+			= ARRAY_SIZE(intca_pins_lo_resources);
+
+	ret = of_sh_intc_get_intc_pins(np, &intca_irq_pins_lo_desc);
+	if (ret)
+		goto error;
+
+	intca_irq_pins_lo_desc.name = "sh7372-intca-irq-lo";
+
+error:
+	return ret;
+}
+
+static int sh7372_intca_pins_hi_of_init(struct device_node *np,
+				    struct device_node *parent)
+{
+	int ret;
+
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	ret = of_sh_intc_get_meminfo(np, intca_pins_hi_resources,
+			ARRAY_SIZE(intca_pins_hi_resources));
+	if (ret)
+		goto error;
+
+	intca_irq_pins_hi_desc.resource = intca_pins_hi_resources;
+	intca_irq_pins_hi_desc.num_resources
+			= ARRAY_SIZE(intca_pins_hi_resources);
+
+	ret = of_sh_intc_get_intc_pins(np, &intca_irq_pins_hi_desc);
+	if (ret)
+		goto error;
+
+	intca_irq_pins_hi_desc.name = "sh7372-intca-irq-hi";
+
+error:
+	return ret;
+}
+
+static const struct of_device_id irq_of_match[] __initconst = {
+	{ .compatible = "renesas,sh_intcs", .data = sh7372_intcs_of_init },
+	{ .compatible = "renesas,sh_intca_irq_pins_lo",
+		.data = sh7372_intca_pins_lo_of_init },
+	{ .compatible = "renesas,sh_intca_irq_pins_hi",
+		.data = sh7372_intca_pins_hi_of_init },
+	{ .compatible = "renesas,sh_intca", .data = sh7372_intca_of_init },
+	{ /*sentinel*/ }
+};
+
+#endif /* CONFIG_OF */
+
 enum {
 	UNUSED_INTCA = 0,
 
@@ -551,23 +682,51 @@ static void intcs_demux(unsigned int irq, struct irq_desc *desc)
 
 static void __iomem *intcs_ffd2;
 static void __iomem *intcs_ffd5;
+static void __iomem *intca_e694;
+static void __iomem *intca_e695;
 
-void __init sh7372_init_irq(void)
+static void __init sh7372_init_irq__(bool of)
 {
 	void __iomem *intevtsa;
 	int n;
 
-	intcs_ffd2 = ioremap_nocache(0xffd20000, PAGE_SIZE);
-	intevtsa = intcs_ffd2 + 0x100;
-	intcs_ffd5 = ioremap_nocache(0xffd50000, PAGE_SIZE);
+#ifdef CONFIG_OF
+	if (of)
+		of_irq_init(irq_of_match);
+#endif
 
 	register_intc_controller(&intca_desc);
 	register_intc_controller(&intca_irq_pins_lo_desc);
 	register_intc_controller(&intca_irq_pins_hi_desc);
 	register_intc_controller(&intcs_desc);
 
-	/* setup dummy cascade chip for INTCS */
-	n = evt2irq(0xf80);
+#ifdef CONFIG_OF
+	if (of) {
+		intca_e694 = IOMEM(intca_resources[0].start);
+		intca_e695 = IOMEM(intca_resources[1].start);
+
+		intcs_ffd2 = ioremap_nocache(intcs_resources[0].start,
+					     PAGE_SIZE);
+		intevtsa = intcs_ffd2 + 0x100;
+		intcs_ffd5 = ioremap_nocache(intcs_resources[1].start,
+					     PAGE_SIZE);
+
+		/* setup dummy cascade chip for INTCS */
+		n = evt2irq(intevtsa_vect);
+	} else
+#endif
+	{
+		intca_e694 = IOMEM(0xe6940000);
+		intca_e695 = IOMEM(0xe6950000);
+
+		intcs_ffd2 = ioremap_nocache(0xffd20000, PAGE_SIZE);
+		intevtsa = intcs_ffd2 + 0x100;
+		intcs_ffd5 = ioremap_nocache(0xffd50000, PAGE_SIZE);
+
+		/* setup dummy cascade chip for INTCS */
+		n = evt2irq(0xf80);
+	}
+
 	irq_alloc_desc_at(n, numa_node_id());
 	irq_set_chip_and_handler_name(n, &dummy_irq_chip,
 				      handle_level_irq, "level");
@@ -581,6 +740,18 @@ void __init sh7372_init_irq(void)
 	iowrite16(0, intcs_ffd2 + 0x104);
 }
 
+#ifdef CONFIG_OF
+void __init sh7372_init_irq_of(void)
+{
+	sh7372_init_irq__(true);
+}
+#endif
+
+void __init sh7372_init_irq(void)
+{
+	sh7372_init_irq__(false);
+}
+
 static unsigned short ffd2[0x200];
 static unsigned short ffd5[0x100];
 
@@ -624,9 +795,6 @@ void sh7372_intcs_resume(void)
 		__raw_writeb(ffd5[k], intcs_ffd5 + k);
 }
 
-#define E694_BASE IOMEM(0xe6940000)
-#define E695_BASE IOMEM(0xe6950000)
-
 static unsigned short e694[0x200];
 static unsigned short e695[0x200];
 
@@ -635,22 +803,22 @@ void sh7372_intca_suspend(void)
 	int k;
 
 	for (k = 0x00; k <= 0x38; k += 4)
-		e694[k] = __raw_readw(E694_BASE + k);
+		e694[k] = __raw_readw(intca_e694 + k);
 
 	for (k = 0x80; k <= 0xb4; k += 4)
-		e694[k] = __raw_readb(E694_BASE + k);
+		e694[k] = __raw_readb(intca_e694 + k);
 
 	for (k = 0x180; k <= 0x1b4; k += 4)
-		e694[k] = __raw_readb(E694_BASE + k);
+		e694[k] = __raw_readb(intca_e694 + k);
 
 	for (k = 0x00; k <= 0x50; k += 4)
-		e695[k] = __raw_readw(E695_BASE + k);
+		e695[k] = __raw_readw(intca_e695 + k);
 
 	for (k = 0x80; k <= 0xa8; k += 4)
-		e695[k] = __raw_readb(E695_BASE + k);
+		e695[k] = __raw_readb(intca_e695 + k);
 
 	for (k = 0x180; k <= 0x1a8; k += 4)
-		e695[k] = __raw_readb(E695_BASE + k);
+		e695[k] = __raw_readb(intca_e695+ k);
 }
 
 void sh7372_intca_resume(void)
@@ -658,20 +826,20 @@ void sh7372_intca_resume(void)
 	int k;
 
 	for (k = 0x00; k <= 0x38; k += 4)
-		__raw_writew(e694[k], E694_BASE + k);
+		__raw_writew(e694[k], intca_e694 + k);
 
 	for (k = 0x80; k <= 0xb4; k += 4)
-		__raw_writeb(e694[k], E694_BASE + k);
+		__raw_writeb(e694[k], intca_e694 + k);
 
 	for (k = 0x180; k <= 0x1b4; k += 4)
-		__raw_writeb(e694[k], E694_BASE + k);
+		__raw_writeb(e694[k], intca_e694 + k);
 
 	for (k = 0x00; k <= 0x50; k += 4)
-		__raw_writew(e695[k], E695_BASE + k);
+		__raw_writew(e695[k], intca_e695 + k);
 
 	for (k = 0x80; k <= 0xa8; k += 4)
-		__raw_writeb(e695[k], E695_BASE + k);
+		__raw_writeb(e695[k], intca_e695 + k);
 
 	for (k = 0x180; k <= 0x1a8; k += 4)
-		__raw_writeb(e695[k], E695_BASE + k);
+		__raw_writeb(e695[k], intca_e695 + k);
 }
-- 
1.7.10.4
