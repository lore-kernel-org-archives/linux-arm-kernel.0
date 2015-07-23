From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 23 Jul 2015 14:05:07 +0100
Subject: [PATCH v2 1/7] genirq: irqdomain: Use an accessor for the of_node
 field
In-Reply-To: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com>
References: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1437656713-9677-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The struct irq_domain contains a "struct device_node *" field
(of_node) that is almost the only link between the irqdomain
and the device tree infrastructure.

In order to prepare for the removal of that field, convert all
users outside of kernel/irq/irqdomain.c to use an accessor.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/c6x/platforms/megamod-pic.c              | 2 +-
 arch/mips/cavium-octeon/octeon-irq.c          | 4 ++--
 arch/powerpc/platforms/cell/axon_msi.c        | 2 +-
 arch/powerpc/platforms/cell/spider-pic.c      | 9 ++++++---
 arch/powerpc/platforms/pasemi/msi.c           | 6 ++++--
 arch/powerpc/platforms/powernv/opal-irqchip.c | 2 +-
 arch/powerpc/sysdev/ehv_pic.c                 | 3 ++-
 arch/powerpc/sysdev/fsl_msi.c                 | 2 +-
 arch/powerpc/sysdev/i8259.c                   | 3 ++-
 arch/powerpc/sysdev/ipic.c                    | 3 ++-
 arch/powerpc/sysdev/mpic.c                    | 3 ++-
 arch/powerpc/sysdev/mpic_msi.c                | 2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c            | 3 ++-
 drivers/gpio/gpio-sodaville.c                 | 2 +-
 drivers/irqchip/exynos-combiner.c             | 2 +-
 drivers/irqchip/irq-atmel-aic-common.c        | 2 +-
 drivers/irqchip/irq-crossbar.c                | 4 ++--
 drivers/irqchip/irq-gic-v2m.c                 | 2 +-
 drivers/irqchip/irq-gic-v3-its.c              | 2 +-
 drivers/irqchip/irq-gic-v3.c                  | 2 +-
 drivers/irqchip/irq-gic.c                     | 2 +-
 drivers/irqchip/irq-hip04.c                   | 2 +-
 drivers/irqchip/irq-mtk-sysirq.c              | 2 +-
 drivers/irqchip/irq-s3c24xx.c                 | 4 ++--
 drivers/irqchip/irq-tegra.c                   | 4 ++--
 drivers/irqchip/irq-vf610-mscm-ir.c           | 5 +++--
 drivers/spmi/spmi-pmic-arb.c                  | 2 +-
 include/linux/irqdomain.h                     | 5 +++++
 28 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/arch/c6x/platforms/megamod-pic.c b/arch/c6x/platforms/megamod-pic.c
index 74e3371..2966072 100644
--- a/arch/c6x/platforms/megamod-pic.c
+++ b/arch/c6x/platforms/megamod-pic.c
@@ -177,7 +177,7 @@ static void __init set_megamod_mux(struct megamod_pic *pic, int src, int output)
 static void __init parse_priority_map(struct megamod_pic *pic,
 				      int *mapping, int size)
 {
-	struct device_node *np = pic->irqhost->of_node;
+	struct device_node *np = irq_domain_get_of_node(pic->irqhost);
 	const __be32 *map;
 	int i, maplen;
 	u32 val;
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index d8124a3..f1fbb1f 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1097,7 +1097,7 @@ static int octeon_irq_gpio_xlat(struct irq_domain *d,
 	unsigned int pin;
 	unsigned int trigger;
 
-	if (d->of_node != node)
+	if (irq_domain_get_of_node(d) != node)
 		return -EINVAL;
 
 	if (intsize < 2)
@@ -2161,7 +2161,7 @@ static int octeon_irq_cib_map(struct irq_domain *d,
 
 	if (hw >= host_data->max_bits) {
 		pr_err("ERROR: %s mapping %u is to big!\n",
-		       d->of_node->name, (unsigned)hw);
+		       irq_domain_get_of_node(d)->name, (unsigned)hw);
 		return -EINVAL;
 	}
 
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 306888a..bcbe341 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -327,7 +327,7 @@ static void axon_msi_shutdown(struct platform_device *device)
 	u32 tmp;
 
 	pr_devel("axon_msi: disabling %s\n",
-		  msic->irq_domain->of_node->full_name);
+		 irq_domain_get_of_node(msic->irq_domain)->full_name);
 	tmp  = dcr_read(msic->dcr_host, MSIC_CTRL_REG);
 	tmp &= ~MSIC_CTRL_ENABLE & ~MSIC_CTRL_IRQ_ENABLE;
 	msic_dcr_write(msic, MSIC_CTRL_REG, tmp);
diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/platforms/cell/spider-pic.c
index 1f72f4a..078b633 100644
--- a/arch/powerpc/platforms/cell/spider-pic.c
+++ b/arch/powerpc/platforms/cell/spider-pic.c
@@ -231,20 +231,23 @@ static unsigned int __init spider_find_cascade_and_node(struct spider_pic *pic)
 	const u32 *imap, *tmp;
 	int imaplen, intsize, unit;
 	struct device_node *iic;
+	struct device_node *of_node;
+
+	of_node = irq_domain_get_of_node(pic->host);
 
 	/* First, we check whether we have a real "interrupts" in the device
 	 * tree in case the device-tree is ever fixed
 	 */
-	virq = irq_of_parse_and_map(pic->host->of_node, 0);
+	virq = irq_of_parse_and_map(of_node, 0);
 	if (virq)
 		return virq;
 
 	/* Now do the horrible hacks */
-	tmp = of_get_property(pic->host->of_node, "#interrupt-cells", NULL);
+	tmp = of_get_property(of_node, "#interrupt-cells", NULL);
 	if (tmp == NULL)
 		return NO_IRQ;
 	intsize = *tmp;
-	imap = of_get_property(pic->host->of_node, "interrupt-map", &imaplen);
+	imap = of_get_property(of_node, "interrupt-map", &imaplen);
 	if (imap == NULL || imaplen < (intsize + 1))
 		return NO_IRQ;
 	iic = of_find_node_by_phandle(imap[intsize]);
diff --git a/arch/powerpc/platforms/pasemi/msi.c b/arch/powerpc/platforms/pasemi/msi.c
index e66ef19..b92ca5f 100644
--- a/arch/powerpc/platforms/pasemi/msi.c
+++ b/arch/powerpc/platforms/pasemi/msi.c
@@ -143,9 +143,11 @@ int mpic_pasemi_msi_init(struct mpic *mpic)
 {
 	int rc;
 	struct pci_controller *phb;
+	struct device_node *of_node;
 
-	if (!mpic->irqhost->of_node ||
-	    !of_device_is_compatible(mpic->irqhost->of_node,
+	of_node = irq_domain_get_of_node(mpic->irqhost);
+	if (!of_node ||
+	    !of_device_is_compatible(of_node,
 				     "pasemi,pwrficient-openpic"))
 		return -ENODEV;
 
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index 2c91ee7..6ccfb6c 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -137,7 +137,7 @@ static void opal_handle_irq_work(struct irq_work *work)
 static int opal_event_match(struct irq_domain *h, struct device_node *node,
 			    enum irq_domain_bus_token bus_token)
 {
-	return h->of_node == node;
+	return irq_domain_get_of_node(h) == node;
 }
 
 static int opal_event_xlate(struct irq_domain *h, struct device_node *np,
diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index eca0b00..bffcc7a 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -181,7 +181,8 @@ static int ehv_pic_host_match(struct irq_domain *h, struct device_node *node,
 			      enum irq_domain_bus_token bus_token)
 {
 	/* Exact match, unless ehv_pic node is NULL */
-	return h->of_node == NULL || h->of_node == node;
+	struct device_node *of_node = irq_domain_get_of_node(h);
+	return of_node == NULL || of_node == node;
 }
 
 static int ehv_pic_host_map(struct irq_domain *h, unsigned int virq,
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 5916da1..a9bdc4b 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -110,7 +110,7 @@ static int fsl_msi_init_allocator(struct fsl_msi *msi_data)
 	int rc, hwirq;
 
 	rc = msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS_MAX,
-			      msi_data->irqhost->of_node);
+			      irq_domain_get_of_node(msi_data->irqhost));
 	if (rc)
 		return rc;
 
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index e1a9c2c..6f99ed3 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -165,7 +165,8 @@ static struct resource pic_edgectrl_iores = {
 static int i8259_host_match(struct irq_domain *h, struct device_node *node,
 			    enum irq_domain_bus_token bus_token)
 {
-	return h->of_node == NULL || h->of_node == node;
+	struct device_node *of_node = irq_domain_get_of_node(h);
+	return of_node == NULL || of_node == node;
 }
 
 static int i8259_host_map(struct irq_domain *h, unsigned int virq,
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 6b2b689..1fbae68 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -675,7 +675,8 @@ static int ipic_host_match(struct irq_domain *h, struct device_node *node,
 			   enum irq_domain_bus_token bus_token)
 {
 	/* Exact match, unless ipic node is NULL */
-	return h->of_node == NULL || h->of_node == node;
+	struct device_node *of_node = irq_domain_get_of_node(h);
+	return of_node == NULL || of_node == node;
 }
 
 static int ipic_host_map(struct irq_domain *h, unsigned int virq,
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 97a8ae8..aea54c2 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1011,7 +1011,8 @@ static int mpic_host_match(struct irq_domain *h, struct device_node *node,
 			   enum irq_domain_bus_token bus_token)
 {
 	/* Exact match, unless mpic node is NULL */
-	return h->of_node == NULL || h->of_node == node;
+	struct device_node *of_node = irq_domain_get_of_node(h);
+	return of_node == NULL || of_node == node;
 }
 
 static int mpic_host_map(struct irq_domain *h, unsigned int virq,
diff --git a/arch/powerpc/sysdev/mpic_msi.c b/arch/powerpc/sysdev/mpic_msi.c
index 7dc39f3..1d48a53 100644
--- a/arch/powerpc/sysdev/mpic_msi.c
+++ b/arch/powerpc/sysdev/mpic_msi.c
@@ -84,7 +84,7 @@ int mpic_msi_init_allocator(struct mpic *mpic)
 	int rc;
 
 	rc = msi_bitmap_alloc(&mpic->msi_bitmap, mpic->num_sources,
-			      mpic->irqhost->of_node);
+			      irq_domain_get_of_node(mpic->irqhost));
 	if (rc)
 		return rc;
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 47b352e..8378dd5 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -248,7 +248,8 @@ static int qe_ic_host_match(struct irq_domain *h, struct device_node *node,
 			    enum irq_domain_bus_token bus_token)
 {
 	/* Exact match, unless qe_ic node is NULL */
-	return h->of_node == NULL || h->of_node == node;
+	struct device_node *of_node = irq_domain_get_of_node(h);
+	return of_node == NULL || of_node == node;
 }
 
 static int qe_ic_host_map(struct irq_domain *h, unsigned int virq,
diff --git a/drivers/gpio/gpio-sodaville.c b/drivers/gpio/gpio-sodaville.c
index 65bc9f4..34b02b4 100644
--- a/drivers/gpio/gpio-sodaville.c
+++ b/drivers/gpio/gpio-sodaville.c
@@ -102,7 +102,7 @@ static int sdv_xlate(struct irq_domain *h, struct device_node *node,
 {
 	u32 line, type;
 
-	if (node != h->of_node)
+	if (node != irq_domain_get_of_node(h))
 		return -EINVAL;
 
 	if (intsize < 2)
diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 5c82e3b..312cb86 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -146,7 +146,7 @@ static int combiner_irq_domain_xlate(struct irq_domain *d,
 				     unsigned long *out_hwirq,
 				     unsigned int *out_type)
 {
-	if (d->of_node != controller)
+	if (irq_domain_get_of_node(d) != controller)
 		return -EINVAL;
 
 	if (intsize < 2)
diff --git a/drivers/irqchip/irq-atmel-aic-common.c b/drivers/irqchip/irq-atmel-aic-common.c
index 63cd031..b12a5d5 100644
--- a/drivers/irqchip/irq-atmel-aic-common.c
+++ b/drivers/irqchip/irq-atmel-aic-common.c
@@ -114,7 +114,7 @@ int aic_common_irq_domain_xlate(struct irq_domain *d,
 
 static void __init aic_common_ext_irq_of_init(struct irq_domain *domain)
 {
-	struct device_node *node = domain->of_node;
+	struct device_node *node = irq_domain_get_of_node(domain);
 	struct irq_chip_generic *gc;
 	struct aic_chip_data *aic;
 	struct property *prop;
diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 692fe2b..1a3248b 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -93,7 +93,7 @@ static int allocate_gic_irq(struct irq_domain *domain, unsigned virq,
 	if (i < 0)
 		return -ENODEV;
 
-	args.np = domain->parent->of_node;
+	args.np = irq_domain_get_of_node(domain->parent);
 	args.args_count = 3;
 	args.args[0] = 0;	/* SPI */
 	args.args[1] = i;
@@ -171,7 +171,7 @@ static int crossbar_domain_xlate(struct irq_domain *d,
 				 unsigned long *out_hwirq,
 				 unsigned int *out_type)
 {
-	if (d->of_node != controller)
+	if (irq_domain_get_of_node(d) != controller)
 		return -EINVAL;	/* Shouldn't happen, really... */
 	if (intsize != 3)
 		return -EINVAL;	/* Not GIC compliant */
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index db04fc1..d0fcbf8 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -117,7 +117,7 @@ static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
 	struct irq_data *d;
 	int err;
 
-	args.np = domain->parent->of_node;
+	args.np = irq_domain_get_of_node(domain->parent);
 	args.args_count = 3;
 	args.args[0] = 0;
 	args.args[1] = hwirq - 32;
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 21b002f..e85a7e3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1201,7 +1201,7 @@ static int its_irq_gic_domain_alloc(struct irq_domain *domain,
 {
 	struct of_phandle_args args;
 
-	args.np = domain->parent->of_node;
+	args.np = irq_domain_get_of_node(domain->parent);
 	args.args_count = 3;
 	args.args[0] = GIC_IRQ_TYPE_LPI;
 	args.args[1] = hwirq;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c52f7ba..5492f4e 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -706,7 +706,7 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 				const u32 *intspec, unsigned int intsize,
 				unsigned long *out_hwirq, unsigned int *out_type)
 {
-	if (d->of_node != controller)
+	if (irq_domain_get_of_node(d) != controller)
 		return -EINVAL;
 	if (intsize < 3)
 		return -EINVAL;
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4dd8826..b41ccf5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -813,7 +813,7 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 {
 	unsigned long ret = 0;
 
-	if (d->of_node != controller)
+	if (irq_domain_get_of_node(d) != controller)
 		return -EINVAL;
 	if (intsize < 3)
 		return -EINVAL;
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 0cae45d..73e5263 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -323,7 +323,7 @@ static int hip04_irq_domain_xlate(struct irq_domain *d,
 {
 	unsigned long ret = 0;
 
-	if (d->of_node != controller)
+	if (irq_domain_get_of_node(d) != controller)
 		return -EINVAL;
 	if (intsize < 3)
 		return -EINVAL;
diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 15c1303..f3567b8 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -107,7 +107,7 @@ static int mtk_sysirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 					      &mtk_sysirq_chip,
 					      domain->host_data);
 
-	gic_data.np = domain->parent->of_node;
+	gic_data.np = irq_domain_get_of_node(domain->parent);
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_data);
 }
 
diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index e96717f..85cccc2 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -314,7 +314,7 @@ static void s3c_irq_demux(unsigned int irq, struct irq_desc *desc)
 	 * and one big domain for the dt case where the subintc
 	 * starts at hwirq number 32.
 	 */
-	offset = (intc->domain->of_node) ? 32 : 0;
+	offset = irq_domain_get_of_node(intc->domain) ? 32 : 0;
 
 	chained_irq_enter(chip, desc);
 
@@ -345,7 +345,7 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
 		return false;
 
 	/* non-dt machines use individual domains */
-	if (!intc->domain->of_node)
+	if (!irq_domain_get_of_node(intc->domain))
 		intc_offset = 0;
 
 	/* We have a problem that the INTOFFSET register does not always
diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
index f67bbd8..0eef868 100644
--- a/drivers/irqchip/irq-tegra.c
+++ b/drivers/irqchip/irq-tegra.c
@@ -228,7 +228,7 @@ static int tegra_ictlr_domain_xlate(struct irq_domain *domain,
 				    unsigned long *out_hwirq,
 				    unsigned int *out_type)
 {
-	if (domain->of_node != controller)
+	if (irq_domain_get_of_node(domain) != controller)
 		return -EINVAL;	/* Shouldn't happen, really... */
 	if (intsize != 3)
 		return -EINVAL;	/* Not GIC compliant */
@@ -268,7 +268,7 @@ static int tegra_ictlr_domain_alloc(struct irq_domain *domain,
 	}
 
 	parent_args = *args;
-	parent_args.np = domain->parent->of_node;
+	parent_args.np = irq_domain_get_of_node(domain->parent);
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
 }
 
diff --git a/drivers/irqchip/irq-vf610-mscm-ir.c b/drivers/irqchip/irq-vf610-mscm-ir.c
index f5c01cb..3f74676 100644
--- a/drivers/irqchip/irq-vf610-mscm-ir.c
+++ b/drivers/irqchip/irq-vf610-mscm-ir.c
@@ -143,7 +143,7 @@ static int vf610_mscm_ir_domain_alloc(struct irq_domain *domain, unsigned int vi
 					      &vf610_mscm_ir_irq_chip,
 					      domain->host_data);
 
-	gic_data.np = domain->parent->of_node;
+	gic_data.np = irq_domain_get_of_node(domain->parent);
 
 	if (mscm_ir_data->is_nvic) {
 		gic_data.args_count = 1;
@@ -206,7 +206,8 @@ static int __init vf610_mscm_ir_of_init(struct device_node *node,
 		goto out_unmap;
 	}
 
-	if (of_device_is_compatible(domain->parent->of_node, "arm,armv7m-nvic"))
+	if (of_device_is_compatible(irq_domain_get_of_node(domain->parent),
+				    "arm,armv7m-nvic"))
 		mscm_ir_data->is_nvic = true;
 
 	cpu_pm_register_notifier(&mscm_ir_notifier_block);
diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index d7119db..7f04635 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -640,7 +640,7 @@ static int qpnpint_irq_domain_dt_translate(struct irq_domain *d,
 		"intspec[0] 0x%1x intspec[1] 0x%02x intspec[2] 0x%02x\n",
 		intspec[0], intspec[1], intspec[2]);
 
-	if (d->of_node != controller)
+	if (irq_domain_get_of_node(d) != controller)
 		return -EINVAL;
 	if (intsize != 4)
 		return -EINVAL;
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d3ca792..f644fdb 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -161,6 +161,11 @@ enum {
 	IRQ_DOMAIN_FLAG_NONCORE		= (1 << 16),
 };
 
+static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
+{
+	return d->of_node;
+}
+
 #ifdef CONFIG_IRQ_DOMAIN
 struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
-- 
2.1.4
