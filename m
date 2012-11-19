From: horms@verge.net.au (Simon Horman)
Date: Mon, 19 Nov 2012 14:13:16 +0900
Subject: [RFC 04/15] ARM: mach-shmobile: Add support OF of INTC for sh73a0
In-Reply-To: <1353302007-31045-1-git-send-email-horms@verge.net.au>
References: <1353302007-31045-1-git-send-email-horms@verge.net.au>
Message-ID: <1353302007-31045-5-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

This CPU has four interrupt controllers (INTCS, INTCA pins, pint0 and pint1).
This supports these.

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

v2 [Simon Horman]
* Use #ifdef instead of #if and #if defined
* Use CONFIG_OF in place of CONFIG_OF_SH_INTC
* Allow OF and non OF code to be compiled in the same binary and
  provide sh73a0_init_irq_of() as a way to initialise INTC
  using DT while sh73a0_init_irq() still initialises INTC
  using the previous code paths. This is because we would
  like to be able to use a single configuration to compile a kernel
  for multiple boards and not all sh73a0 boards have DT support yet.

v1 [Nobuhiro Iwamatsu]
---
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/intc-sh73a0.c         |  239 +++++++++++++++++++++-----
 2 files changed, 201 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 8402b5d..7696a96 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -48,6 +48,7 @@ extern int sh7372_do_idle_sysc(unsigned long sleep_mode);
 extern struct clk sh7372_extal1_clk;
 extern struct clk sh7372_extal2_clk;
 
+extern void sh73a0_init_irq_of(void);
 extern void sh73a0_init_irq(void);
 extern void sh73a0_map_io(void);
 extern void sh73a0_add_early_devices(void);
diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
index f0c5e51..ee62349 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -30,6 +30,137 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#define RELOC_BASE 0x1200
+#ifdef CONFIG_OF
+
+static struct intc_desc intcs_desc __initdata;
+static struct resource intcs_resources[3] __initdata;
+static struct intc_desc intca_irq_pins_desc __initdata;
+static struct resource intca_irq_pins_resources[1] __initdata;
+static struct intc_desc intc_pint0_desc __initdata;
+static struct resource intc_pint0_resources[1] __initdata;
+static struct intc_desc intc_pint1_desc __initdata;
+static struct resource intc_pint1_resources[1] __initdata;
+static unsigned short intevtsa_vect;
+
+static int sh73a0_intcs_of_init(struct device_node *np,
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
+	intcs_desc.name = "sh73a0-intcs";
+
+error:
+	return ret;
+}
+
+static int sh73a0_intca_pins_of_init(struct device_node *np,
+				    struct device_node *parent)
+{
+	int ret;
+
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	ret = of_sh_intc_get_meminfo(np, intca_irq_pins_resources,
+			ARRAY_SIZE(intca_irq_pins_resources));
+	if (ret)
+		goto error;
+
+	intca_irq_pins_desc.resource = intca_irq_pins_resources;
+	intca_irq_pins_desc.num_resources
+			= ARRAY_SIZE(intca_irq_pins_resources);
+
+	ret = of_sh_intc_get_intc_pins(np, &intca_irq_pins_desc);
+	if (ret)
+		goto error;
+
+	intca_irq_pins_desc.name = "sh73a0-intca-irq-pins";
+
+error:
+	return ret;
+}
+
+static int sh73a0_intc_pint0_of_init(struct device_node *np,
+				    struct device_node *parent)
+{
+	int ret;
+
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	ret = of_sh_intc_get_meminfo(np, intc_pint0_resources,
+			ARRAY_SIZE(intc_pint0_resources));
+	if (ret)
+		goto error;
+
+	intc_pint0_desc.resource = intc_pint0_resources;
+	intc_pint0_desc.num_resources = ARRAY_SIZE(intc_pint0_resources);
+
+	ret = of_sh_intc_get_pint(np, &intc_pint0_desc);
+	if (ret)
+		goto error;
+
+	intc_pint0_desc.name = "sh73a0-pint0";
+
+error:
+	return ret;
+}
+
+static int sh73a0_intc_pint1_of_init(struct device_node *np,
+				    struct device_node *parent)
+{
+	int ret;
+
+	if (WARN_ON(!np))
+		return -ENODEV;
+
+	ret = of_sh_intc_get_meminfo(np, intc_pint1_resources,
+			ARRAY_SIZE(intc_pint1_resources));
+	if (ret)
+		goto error;
+
+	intc_pint1_desc.resource = intc_pint1_resources;
+	intc_pint1_desc.num_resources = ARRAY_SIZE(intc_pint1_resources);
+
+	ret = of_sh_intc_get_pint(np, &intc_pint1_desc);
+	if (ret)
+		goto error;
+
+	intc_pint1_desc.name = "sh73a0-pint1";
+
+error:
+	return ret;
+}
+
+static const struct of_device_id irq_of_match[] __initconst = {
+	{ .compatible = "renesas,sh_intcs", .data = sh73a0_intcs_of_init },
+	{ .compatible = "renesas,sh_intca_irq_pins",
+		.data = sh73a0_intca_pins_of_init },
+	{ .compatible = "renesas,sh_pint0", .data = sh73a0_intc_pint0_of_init },
+	{ .compatible = "renesas,sh_pint1", .data = sh73a0_intc_pint1_of_init },
+	{ /*sentinel*/ }
+};
+
+#endif /* CONFIG_OF */
+
 enum {
 	UNUSED = 0,
 
@@ -243,6 +374,42 @@ static struct intc_desc intcs_desc __initdata = {
 			   intcs_prio_registers, NULL, NULL),
 };
 
+/* IRQ PINS */
+
+/* INTCA IRQ pins at INTCS + RELOC_BASE to make space for GIC+INTC handling */
+#define INTCS_VECT_RELOC(n, vect) INTCS_VECT((n), (vect) + RELOC_BASE)
+
+INTC_IRQ_PINS_32(intca_irq_pins, 0xe6900000,
+		 INTCS_VECT_RELOC, "sh73a0-intca-irq-pins");
+
+/* PINT */
+#define PINTER0_PHYS 0xe69000a0
+#define PINTER1_PHYS 0xe69000a4
+#define PINTER0_VIRT IOMEM(0xe69000a0)
+#define PINTER1_VIRT IOMEM(0xe69000a4)
+#define PINTRR0 IOMEM(0xe69000d0)
+#define PINTRR1 IOMEM(0xe69000d4)
+
+#define PINT0A_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT0_IRQ(irq))
+#define PINT0B_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT0_IRQ(irq + 8))
+#define PINT0C_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT0_IRQ(irq + 16))
+#define PINT0D_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT0_IRQ(irq + 24))
+#define PINT1E_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT1_IRQ(irq))
+
+INTC_PINT(intc_pint0, PINTER0_PHYS, 0xe69000b0, "sh73a0-pint0",		\
+  INTC_PINT_E(A), INTC_PINT_E(B), INTC_PINT_E(C), INTC_PINT_E(D),	\
+  INTC_PINT_V(A, PINT0A_IRQ), INTC_PINT_V(B, PINT0B_IRQ),		\
+  INTC_PINT_V(C, PINT0C_IRQ), INTC_PINT_V(D, PINT0D_IRQ),		\
+  INTC_PINT_E(A), INTC_PINT_E(B), INTC_PINT_E(C), INTC_PINT_E(D),	\
+  INTC_PINT_E(A), INTC_PINT_E(B), INTC_PINT_E(C), INTC_PINT_E(D));
+
+INTC_PINT(intc_pint1, PINTER1_PHYS, 0xe69000c0, "sh73a0-pint1",		\
+  INTC_PINT_E(E), INTC_PINT_E_EMPTY, INTC_PINT_E_EMPTY, INTC_PINT_E_EMPTY, \
+  INTC_PINT_V(E, PINT1E_IRQ), INTC_PINT_V_NONE,				\
+  INTC_PINT_V_NONE, INTC_PINT_V_NONE,					\
+  INTC_PINT_E_NONE, INTC_PINT_E_NONE, INTC_PINT_E_NONE, INTC_PINT_E(E), \
+  INTC_PINT_E(E), INTC_PINT_E_NONE, INTC_PINT_E_NONE, INTC_PINT_E_NONE);
+
 static struct irqaction sh73a0_intcs_cascade;
 
 static irqreturn_t sh73a0_intcs_demux(int irq, void *dev_id)
@@ -259,14 +426,6 @@ static int sh73a0_set_wake(struct irq_data *data, unsigned int on)
 	return 0; /* always allow wakeup */
 }
 
-#define RELOC_BASE 0x1200
-
-/* INTCA IRQ pins at INTCS + RELOC_BASE to make space for GIC+INTC handling */
-#define INTCS_VECT_RELOC(n, vect) INTCS_VECT((n), (vect) + RELOC_BASE)
-
-INTC_IRQ_PINS_32(intca_irq_pins, 0xe6900000,
-		 INTCS_VECT_RELOC, "sh73a0-intca-irq-pins");
-
 static int to_gic_irq(struct irq_data *data)
 {
 	unsigned int vect = irq2evt(data->irq) - INTCS_VECT_BASE;
@@ -366,33 +525,6 @@ static irqreturn_t sh73a0_irq_pin_demux(int irq, void *dev_id)
 
 static struct irqaction sh73a0_irq_pin_cascade[32];
 
-#define PINTER0_PHYS 0xe69000a0
-#define PINTER1_PHYS 0xe69000a4
-#define PINTER0_VIRT IOMEM(0xe69000a0)
-#define PINTER1_VIRT IOMEM(0xe69000a4)
-#define PINTRR0 IOMEM(0xe69000d0)
-#define PINTRR1 IOMEM(0xe69000d4)
-
-#define PINT0A_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT0_IRQ(irq))
-#define PINT0B_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT0_IRQ(irq + 8))
-#define PINT0C_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT0_IRQ(irq + 16))
-#define PINT0D_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT0_IRQ(irq + 24))
-#define PINT1E_IRQ(n, irq) INTC_IRQ((n), SH73A0_PINT1_IRQ(irq))
-
-INTC_PINT(intc_pint0, PINTER0_PHYS, 0xe69000b0, "sh73a0-pint0",		\
-  INTC_PINT_E(A), INTC_PINT_E(B), INTC_PINT_E(C), INTC_PINT_E(D),	\
-  INTC_PINT_V(A, PINT0A_IRQ), INTC_PINT_V(B, PINT0B_IRQ),		\
-  INTC_PINT_V(C, PINT0C_IRQ), INTC_PINT_V(D, PINT0D_IRQ),		\
-  INTC_PINT_E(A), INTC_PINT_E(B), INTC_PINT_E(C), INTC_PINT_E(D),	\
-  INTC_PINT_E(A), INTC_PINT_E(B), INTC_PINT_E(C), INTC_PINT_E(D));
-
-INTC_PINT(intc_pint1, PINTER1_PHYS, 0xe69000c0, "sh73a0-pint1",		\
-  INTC_PINT_E(E), INTC_PINT_E_EMPTY, INTC_PINT_E_EMPTY, INTC_PINT_E_EMPTY, \
-  INTC_PINT_V(E, PINT1E_IRQ), INTC_PINT_V_NONE,				\
-  INTC_PINT_V_NONE, INTC_PINT_V_NONE,					\
-  INTC_PINT_E_NONE, INTC_PINT_E_NONE, INTC_PINT_E_NONE, INTC_PINT_E(E), \
-  INTC_PINT_E(E), INTC_PINT_E_NONE, INTC_PINT_E_NONE, INTC_PINT_E_NONE);
-
 static struct irqaction sh73a0_pint0_cascade;
 static struct irqaction sh73a0_pint1_cascade;
 
@@ -411,31 +543,48 @@ static void pint_demux(void __iomem *rr, void __iomem *er, int base_irq)
 
 static irqreturn_t sh73a0_pint0_demux(int irq, void *dev_id)
 {
-	pint_demux(PINTRR0, PINTER0_VIRT, SH73A0_PINT0_IRQ(0));
+	pint_demux(IOMEM(intca_irq_pins_resources[0].start + 0xd0),
+			IOMEM(intca_irq_pins_resources[0].start + 0xa0),
+			SH73A0_PINT0_IRQ(0));
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t sh73a0_pint1_demux(int irq, void *dev_id)
 {
-	pint_demux(PINTRR1, PINTER1_VIRT, SH73A0_PINT1_IRQ(0));
+	pint_demux(IOMEM(intca_irq_pins_resources[0].start + 0xd4),
+			IOMEM(intca_irq_pins_resources[0].start + 0xa4),
+			SH73A0_PINT1_IRQ(0));
 	return IRQ_HANDLED;
 }
 
-void __init sh73a0_init_irq(void)
+static void __init sh73a0_init_irq__(bool of)
 {
 	void __iomem *gic_dist_base = IOMEM(0xf0001000);
 	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
-	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
+	void __iomem *intevtsa;
 	int k, n;
 
 	gic_init(0, 29, gic_dist_base, gic_cpu_base);
 	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
 
+#ifdef CONFIG_OF
+	if (of)
+		of_irq_init(irq_of_match);
+#endif
+
 	register_intc_controller(&intcs_desc);
 	register_intc_controller(&intca_irq_pins_desc);
 	register_intc_controller(&intc_pint0_desc);
 	register_intc_controller(&intc_pint1_desc);
 
+#ifdef CONFIG_OF
+	if (of)
+		intevtsa = ioremap_nocache(intcs_resources[0].start + 0x100,
+					   PAGE_SIZE);
+	else
+#endif
+		intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
+
 	/* demux using INTEVTSA */
 	sh73a0_intcs_cascade.name = "INTCS cascade";
 	sh73a0_intcs_cascade.handler = sh73a0_intcs_demux;
@@ -464,3 +613,15 @@ void __init sh73a0_init_irq(void)
 	sh73a0_pint1_cascade.handler = sh73a0_pint1_demux;
 	setup_irq(gic_spi(34), &sh73a0_pint1_cascade);
 }
+
+#ifdef CONFIG_OF
+void __init sh73a0_init_irq_of(void)
+{
+	sh73a0_init_irq__(true);
+}
+#endif
+
+void __init sh73a0_init_irq(void)
+{
+	sh73a0_init_irq__(false);
+}
-- 
1.7.10.4
