From: horms@verge.net.au (Simon Horman)
Date: Mon, 19 Nov 2012 14:13:17 +0900
Subject: [RFC 05/15] ARM: mach-shmobile: Add support OF of INTC for sh7372
In-Reply-To: <1353302007-31045-1-git-send-email-horms@verge.net.au>
References: <1353302007-31045-1-git-send-email-horms@verge.net.au>
Message-ID: <1353302007-31045-6-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

This CPU has four interrupt controllers (INTCA, INTCS, pins-High and pins-Low).
This supports these.

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

v4 [Magnus Damm]
* Fix the sh7372 INTC DT code for INTCA to use ARRAY_SIZE()
  on intca_resources instead of intcs_resources.
* Fix section mismatches in the sh7372 INTC DT code.
* Rework the sh7372 DT INTC init code to reduce the number of #ifdefs.
* Rework the sh7372 DT INTC setup code to only make use of
  "renesas,sh_intc" instead of using zillions of special cases.

  In the future the INTC DT code really wants to be moved to a
  separate file that can be shared between multiple SoCs using
  INTC as primary interrupt controller like for instance sh7372
  and r8a7740.

  The major ugly portion left is the intevtsa stuff that really
  should be updated to make use of the parent interrupt controller
  information in DT. intc_of_init() can be extended to install
  the chained interrupt handler directly if the function call to
  of_sh_intc_get_intevtsa_vect() succeeds.

  When all SoCs are reworked like sh7372 then we can share the
  SoC INTC DT code in one place and after that remove unused stuff
  from of_intc.c like the following functions:
   - of_sh_intc_get_meminfo()
   - of_sh_intc_get_pint()
   - of_sh_intc_get_intc_pins()

v3
* No change

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
 arch/arm/mach-shmobile/intc-sh7372.c         |  112 ++++++++++++++++++++------
 2 files changed, 88 insertions(+), 25 deletions(-)

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
index a91caad..c923518 100644
--- a/arch/arm/mach-shmobile/intc-sh7372.c
+++ b/arch/arm/mach-shmobile/intc-sh7372.c
@@ -551,23 +551,28 @@ static void intcs_demux(unsigned int irq, struct irq_desc *desc)
 
 static void __iomem *intcs_ffd2;
 static void __iomem *intcs_ffd5;
-
-void __init sh7372_init_irq(void)
+static void __iomem *intca_e694;
+static void __iomem *intca_e695;
+
+static void __init sh7372_init_intc(resource_size_t intca0_start,
+				    resource_size_t intca1_start,
+				    resource_size_t intcs0_start,
+				    resource_size_t intcs1_start,
+				    unsigned short vect)
 {
 	void __iomem *intevtsa;
 	int n;
 
-	intcs_ffd2 = ioremap_nocache(0xffd20000, PAGE_SIZE);
-	intevtsa = intcs_ffd2 + 0x100;
-	intcs_ffd5 = ioremap_nocache(0xffd50000, PAGE_SIZE);
+	intca_e694 = IOMEM(intca0_start);
+	intca_e695 = IOMEM(intca1_start);
 
-	register_intc_controller(&intca_desc);
-	register_intc_controller(&intca_irq_pins_lo_desc);
-	register_intc_controller(&intca_irq_pins_hi_desc);
-	register_intc_controller(&intcs_desc);
+	intcs_ffd2 = ioremap_nocache(intcs0_start, PAGE_SIZE);
+	intevtsa = intcs_ffd2 + 0x100;
+	intcs_ffd5 = ioremap_nocache(intcs1_start, PAGE_SIZE);
 
 	/* setup dummy cascade chip for INTCS */
-	n = evt2irq(0xf80);
+	n = evt2irq(vect);
+
 	irq_alloc_desc_at(n, numa_node_id());
 	irq_set_chip_and_handler_name(n, &dummy_irq_chip,
 				      handle_level_irq, "level");
@@ -581,6 +586,66 @@ void __init sh7372_init_irq(void)
 	iowrite16(0, intcs_ffd2 + 0x104);
 }
 
+#ifdef CONFIG_OF
+static unsigned short intevtsa_vect;
+
+#define INTC_RES_MAX 2
+static struct {
+	struct intc_desc intc_desc;
+	struct resource intc_res[INTC_RES_MAX];
+} intc_data __initdata;
+
+static int __init intc_of_init(struct device_node *np,
+			       struct device_node *parent)
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
+void __init sh7372_init_irq_of(void)
+{
+	of_irq_init(irq_of_match);
+
+	sh7372_init_intc(0xe6940000, 0xe6950000, 0xffd20000, 0xffd50000,
+			  intevtsa_vect);
+}
+#endif /* CONFIG_OF */
+
+void __init sh7372_init_irq(void)
+{
+	register_intc_controller(&intca_desc);
+	register_intc_controller(&intca_irq_pins_lo_desc);
+	register_intc_controller(&intca_irq_pins_hi_desc);
+	register_intc_controller(&intcs_desc);
+
+	sh7372_init_intc(0xe6940000, 0xe6950000, 0xffd20000, 0xffd50000, 0xf80);
+}
+
 static unsigned short ffd2[0x200];
 static unsigned short ffd5[0x100];
 
@@ -624,9 +689,6 @@ void sh7372_intcs_resume(void)
 		__raw_writeb(ffd5[k], intcs_ffd5 + k);
 }
 
-#define E694_BASE IOMEM(0xe6940000)
-#define E695_BASE IOMEM(0xe6950000)
-
 static unsigned short e694[0x200];
 static unsigned short e695[0x200];
 
@@ -635,22 +697,22 @@ void sh7372_intca_suspend(void)
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
@@ -658,20 +720,20 @@ void sh7372_intca_resume(void)
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
