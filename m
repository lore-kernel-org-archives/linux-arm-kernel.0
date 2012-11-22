From: nobuhiro.iwamatsu.yj@renesas.com (Nobuhiro Iwamatsu)
Date: Thu, 22 Nov 2012 17:00:01 +0900
Subject: [PATCH v5 04/15] ARM: mach-shmobile: Add support OF of INTC for sh73a0
In-Reply-To: <1353571213-26006-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1353571213-26006-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <1353571213-26006-5-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This CPU has four interrupt controllers (INTCS, INTCA pins, pint0 and pint1).
This supports these.

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---
v3 [Nobuhiro Iwamatsu]
* Rework the sh73a0 DT INTC init code to reduce the number of #ifdefs.

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

fix2

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/intc-sh73a0.c         |  161 ++++++++++++++++++--------
 2 files changed, 113 insertions(+), 49 deletions(-)

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
index f0c5e51..c9f6441 100644
--- a/arch/arm/mach-shmobile/intc-sh73a0.c
+++ b/arch/arm/mach-shmobile/intc-sh73a0.c
@@ -243,6 +243,43 @@ static struct intc_desc intcs_desc __initdata = {
 			   intcs_prio_registers, NULL, NULL),
 };
 
+/* IRQ PINS */
+#define RELOC_BASE 0x1200
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
@@ -259,14 +296,6 @@ static int sh73a0_set_wake(struct irq_data *data, unsigned int on)
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
@@ -366,33 +395,6 @@ static irqreturn_t sh73a0_irq_pin_demux(int irq, void *dev_id)
 
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
 
@@ -411,31 +413,27 @@ static void pint_demux(void __iomem *rr, void __iomem *er, int base_irq)
 
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
+static void __init sh73a0_init_intc(resource_size_t intcs0_start)
 {
-	void __iomem *gic_dist_base = IOMEM(0xf0001000);
-	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
-	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
 	int k, n;
+	void __iomem *intevtsa;
 
-	gic_init(0, 29, gic_dist_base, gic_cpu_base);
-	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
-
-	register_intc_controller(&intcs_desc);
-	register_intc_controller(&intca_irq_pins_desc);
-	register_intc_controller(&intc_pint0_desc);
-	register_intc_controller(&intc_pint1_desc);
-
+	intevtsa = ioremap_nocache(intcs0_start + 0x100, PAGE_SIZE);
+	
 	/* demux using INTEVTSA */
 	sh73a0_intcs_cascade.name = "INTCS cascade";
 	sh73a0_intcs_cascade.handler = sh73a0_intcs_demux;
@@ -464,3 +462,68 @@ void __init sh73a0_init_irq(void)
 	sh73a0_pint1_cascade.handler = sh73a0_pint1_demux;
 	setup_irq(gic_spi(34), &sh73a0_pint1_cascade);
 }
+
+#ifdef CONFIG_OF
+static unsigned short intevtsa_vect;
+
+#define INTC_RES_MAX 3
+struct {
+	struct intc_desc intc_desc;
+	struct resource intc_res[INTC_RES_MAX];
+} intc_data __initdata;
+
+static int __init intc_of_init(struct device_node *np,
+						 struct device_node *parent)
+{
+	int ret, i;
+
+	memset(&intc_data, 0, sizeof(intc_data));
+
+	for (i = 0; i < INTC_RES_MAX; i++) {
+		ret = of_address_to_resource(np, i, &intc_data.intc_res[i]);
+		if (ret < 0)
+			break;
+	}
+
+	intc_data.intc_desc.name = (char *)of_node_full_name(np);
+	intc_data.intc_desc.resource = intc_data.intc_res;
+	intc_data.intc_desc.num_resources = i;
+
+	ret = of_sh_intc_get_intc(np, &intc_data.intc_desc);
+	if (ret)
+		return ret;
+
+	of_sh_intc_get_intevtsa_vect(np, &intevtsa_vect);
+
+	register_intc_controller(&intc_data.intc_desc);
+	return 0;
+}
+
+static const struct of_device_id irq_of_match[] __initconst = {
+	{ .compatible = "renesas,sh_intc", .data = intc_of_init },
+	{ /*sentinel*/ }
+};
+
+void __init sh73a0_init_irq_of(void)
+{
+	of_irq_init(irq_of_match);
+
+	sh73a0_init_intc(0xffd20000);
+}
+#endif /* CONFIG_OF */
+
+void __init sh73a0_init_irq(void)
+{
+	void __iomem *gic_dist_base = IOMEM(0xf0001000);
+	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
+
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
+
+	register_intc_controller(&intcs_desc);
+	register_intc_controller(&intca_irq_pins_desc);
+	register_intc_controller(&intc_pint0_desc);
+	register_intc_controller(&intc_pint1_desc);
+
+	sh73a0_init_intc(0xffd20000);
+}
-- 
1.7.10.4
