From: robh@kernel.org (Rob Herring)
Date: Sun, 12 Jul 2015 09:26:44 -0500
Subject: [PATCH v2 06/13] irqchip: kill off set_irq_flags usage
In-Reply-To: <1436711211-18223-1-git-send-email-robh@kernel.org>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
Message-ID: <1436711211-18223-7-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_irq_flags is ARM specific with custom flags which have genirq
equivalents. Convert drivers to use the genirq interfaces directly, so we
can kill off set_irq_flags. The translation of flags is as follows:

IRQF_VALID -> !IRQ_NOREQUEST
IRQF_PROBE -> !IRQ_NOPROBE
IRQF_NOAUTOEN -> IRQ_NOAUTOEN

For IRQs managed by an irqdomain, the irqdomain core code handles clearing
and setting IRQ_NOREQUEST already, so there is no need to do this in
.map() functions and we can simply remove the set_irq_flags calls. Some
users also set IRQ_NOPROBE and this has been maintained although it is not
clear that is really needed. There appears to be a great deal of blind
copy and paste of this code.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-rpi-kernel at lists.infradead.org
---
v2:
- Fix build error on clps711x

 drivers/irqchip/exynos-combiner.c         |  2 +-
 drivers/irqchip/irq-armada-370-xp.c       |  3 +--
 drivers/irqchip/irq-bcm2835.c             |  2 +-
 drivers/irqchip/irq-clps711x.c            |  6 +++---
 drivers/irqchip/irq-gic-v3.c              |  5 ++---
 drivers/irqchip/irq-gic.c                 |  4 ++--
 drivers/irqchip/irq-hip04.c               |  4 ++--
 drivers/irqchip/irq-keystone.c            |  2 +-
 drivers/irqchip/irq-mmp.c                 |  3 ---
 drivers/irqchip/irq-mxs.c                 |  1 -
 drivers/irqchip/irq-renesas-intc-irqpin.c |  1 -
 drivers/irqchip/irq-renesas-irqc.c        |  1 -
 drivers/irqchip/irq-s3c24xx.c             | 14 ++------------
 drivers/irqchip/irq-sun4i.c               |  2 +-
 drivers/irqchip/irq-versatile-fpga.c      |  2 +-
 drivers/irqchip/irq-vic.c                 |  2 +-
 drivers/irqchip/irq-vt8500.c              |  1 -
 drivers/irqchip/spear-shirq.c             |  1 -
 18 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 5c82e3b..81aacb8 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -165,7 +165,7 @@ static int combiner_irq_domain_map(struct irq_domain *d, unsigned int irq,

 	irq_set_chip_and_handler(irq, &combiner_chip, handle_level_irq);
 	irq_set_chip_data(irq, &combiner_data[hw >> 3]);
-	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	irq_set_noprobe(irq);

 	return 0;
 }
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 0d3b0fe..b8bf8b0 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -201,7 +201,6 @@ static int armada_370_xp_msi_map(struct irq_domain *domain, unsigned int virq,
 {
 	irq_set_chip_and_handler(virq, &armada_370_xp_msi_irq_chip,
 				 handle_simple_irq);
-	set_irq_flags(virq, IRQF_VALID);

 	return 0;
 }
@@ -318,7 +317,7 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
 					handle_level_irq);
 	}
-	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
+	irq_set_noprobe(virq);

 	return 0;
 }
diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index e68c3b6..5ae2fd4 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -165,7 +165,7 @@ static int __init armctrl_of_init(struct device_node *node,
 			BUG_ON(irq <= 0);
 			irq_set_chip_and_handler(irq, &armctrl_chip,
 				handle_level_irq);
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+			irq_set_noprobe(irq);
 		}
 	}

diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index 33127f1..2e74e81 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -133,14 +133,14 @@ static int __init clps711x_intc_irq_map(struct irq_domain *h, unsigned int virq,
 					irq_hw_number_t hw)
 {
 	irq_flow_handler_t handler = handle_level_irq;
-	unsigned int flags = IRQF_VALID | IRQF_PROBE;
+	unsigned int flags = 0;

 	if (!clps711x_irqs[hw].flags)
 		return 0;

 	if (clps711x_irqs[hw].flags & CLPS711X_FLAG_FIQ) {
 		handler = handle_bad_irq;
-		flags |= IRQF_NOAUTOEN;
+		flags |= IRQ_NOAUTOEN;
 	} else if (clps711x_irqs[hw].eoi) {
 		handler = handle_fasteoi_irq;
 	}
@@ -150,7 +150,7 @@ static int __init clps711x_intc_irq_map(struct irq_domain *h, unsigned int virq,
 		writel_relaxed(0, clps711x_intc->base + clps711x_irqs[hw].eoi);

 	irq_set_chip_and_handler(virq, &clps711x_intc_chip, handler);
-	set_irq_flags(virq, flags);
+	irq_modify_status(virq, IRQ_NOPROBE, flags);

 	return 0;
 }
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c52f7ba..16f9028 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -681,13 +681,13 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
-		set_irq_flags(irq, IRQF_VALID | IRQF_NOAUTOEN);
+		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	}
 	/* SPIs */
 	if (hw >= 32 && hw < gic_data.irq_nr) {
 		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_set_probe(irq);
 	}
 	/* LPIs */
 	if (hw >= 8192 && hw < GIC_ID_NR) {
@@ -695,7 +695,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			return -EPERM;
 		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
-		set_irq_flags(irq, IRQF_VALID);
 	}

 	return 0;
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 8d7e1c8..ba16399 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -793,11 +793,11 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
-		set_irq_flags(irq, IRQF_VALID | IRQF_NOAUTOEN);
+		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	} else {
 		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_set_noprobe(irq);
 	}
 	return 0;
 }
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 0cae45d..af07a91 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -305,11 +305,11 @@ static int hip04_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_set_percpu_devid(irq);
 		irq_set_chip_and_handler(irq, &hip04_irq_chip,
 					 handle_percpu_devid_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_NOAUTOEN);
+		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	} else {
 		irq_set_chip_and_handler(irq, &hip04_irq_chip,
 					 handle_fasteoi_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_set_noprobe(irq);
 	}
 	irq_set_chip_data(irq, d->host_data);
 	return 0;
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index 81e3cf5..bbbe78a 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -127,7 +127,7 @@ static int keystone_irq_map(struct irq_domain *h, unsigned int virq,

 	irq_set_chip_data(virq, kirq);
 	irq_set_chip_and_handler(virq, &kirq->chip, handle_level_irq);
-	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
+	irq_set_noprobe(virq);
 	return 0;
 }

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index c0da57b..3dfef63 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -164,7 +164,6 @@ static int mmp_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hw)
 {
 	irq_set_chip_and_handler(irq, &icu_irq_chip, handle_level_irq);
-	set_irq_flags(irq, IRQF_VALID);
 	return 0;
 }

@@ -234,7 +233,6 @@ void __init icu_init_irq(void)
 	for (irq = 0; irq < 64; irq++) {
 		icu_mask_irq(irq_get_irq_data(irq));
 		irq_set_chip_and_handler(irq, &icu_irq_chip, handle_level_irq);
-		set_irq_flags(irq, IRQF_VALID);
 	}
 	irq_set_default_host(icu_data[0].domain);
 	set_handle_irq(mmp_handle_irq);
@@ -337,7 +335,6 @@ void __init mmp2_init_icu(void)
 			irq_set_chip_and_handler(irq, &icu_irq_chip,
 						 handle_level_irq);
 		}
-		set_irq_flags(irq, IRQF_VALID);
 	}
 	irq_set_default_host(icu_data[0].domain);
 	set_handle_irq(mmp2_handle_irq);
diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index 04bf97b..ffe85d6 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -85,7 +85,6 @@ static int icoll_irq_domain_map(struct irq_domain *d, unsigned int virq,
 				irq_hw_number_t hw)
 {
 	irq_set_chip_and_handler(virq, &mxs_icoll_chip, handle_level_irq);
-	set_irq_flags(virq, IRQF_VALID);

 	return 0;
 }
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 0670ab4..20a86de 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -343,7 +343,6 @@ static int intc_irqpin_irq_domain_map(struct irq_domain *h, unsigned int virq,
 	intc_irqpin_dbg(&p->irq[hw], "map");
 	irq_set_chip_data(virq, h->host_data);
 	irq_set_chip_and_handler(virq, &p->irq_chip, handle_level_irq);
-	set_irq_flags(virq, IRQF_VALID); /* kill me now */
 	return 0;
 }

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 778bd07..74e980f 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -162,7 +162,6 @@ static int irqc_irq_domain_map(struct irq_domain *h, unsigned int virq,
 	irqc_dbg(&p->irq[hw], "map");
 	irq_set_chip_data(virq, h->host_data);
 	irq_set_chip_and_handler(virq, &p->irq_chip, handle_level_irq);
-	set_irq_flags(virq, IRQF_VALID); /* kill me now */
 	return 0;
 }

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index e96717f..19d1fc4 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -469,13 +469,11 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,

 	irq_set_chip_data(virq, irq_data);

-	set_irq_flags(virq, IRQF_VALID);
-
 	if (parent_intc && irq_data->type != S3C_IRQTYPE_NONE) {
 		if (irq_data->parent_irq > 31) {
 			pr_err("irq-s3c24xx: parent irq %lu is out of range\n",
 			       irq_data->parent_irq);
-			goto err;
+			return -EINVAL;
 		}

 		parent_irq_data = &parent_intc->irqs[irq_data->parent_irq];
@@ -488,18 +486,12 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
 		if (!irqno) {
 			pr_err("irq-s3c24xx: could not find mapping for parent irq %lu\n",
 			       irq_data->parent_irq);
-			goto err;
+			return -EINVAL;
 		}
 		irq_set_chained_handler(irqno, s3c_irq_demux);
 	}

 	return 0;
-
-err:
-	set_irq_flags(virq, 0);
-
-	/* the only error can result from bad mapping data*/
-	return -EINVAL;
 }

 static const struct irq_domain_ops s3c24xx_irq_ops = {
@@ -1177,8 +1169,6 @@ static int s3c24xx_irq_map_of(struct irq_domain *h, unsigned int virq,

 	irq_set_chip_data(virq, irq_data);

-	set_irq_flags(virq, IRQF_VALID);
-
 	return 0;
 }

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 83d6aa6..fdc1a80 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -84,7 +84,7 @@ static int sun4i_irq_map(struct irq_domain *d, unsigned int virq,
 			 irq_hw_number_t hw)
 {
 	irq_set_chip_and_handler(virq, &sun4i_irq_chip, handle_fasteoi_irq);
-	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
+	irq_set_noprobe(virq);

 	return 0;
 }
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 888111b..e53aa98 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -128,7 +128,7 @@ static int fpga_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	irq_set_chip_data(irq, f);
 	irq_set_chip_and_handler(irq, &f->chip,
 				handle_level_irq);
-	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	irq_set_noprobe(irq);
 	return 0;
 }

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index d4ce331..33d64b1 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -202,7 +202,7 @@ static int vic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 		return -EPERM;
 	irq_set_chip_and_handler(irq, &vic_chip, handle_level_irq);
 	irq_set_chip_data(irq, v->base);
-	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	irq_set_noprobe(irq);
 	return 0;
 }

diff --git a/drivers/irqchip/irq-vt8500.c b/drivers/irqchip/irq-vt8500.c
index 0b29700..8b235c9 100644
--- a/drivers/irqchip/irq-vt8500.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -168,7 +168,6 @@ static int vt8500_irq_map(struct irq_domain *h, unsigned int virq,
 							irq_hw_number_t hw)
 {
 	irq_set_chip_and_handler(virq, &vt8500_irq_chip, handle_level_irq);
-	set_irq_flags(virq, IRQF_VALID);

 	return 0;
 }
diff --git a/drivers/irqchip/spear-shirq.c b/drivers/irqchip/spear-shirq.c
index a4512154..187c0f6 100644
--- a/drivers/irqchip/spear-shirq.c
+++ b/drivers/irqchip/spear-shirq.c
@@ -212,7 +212,6 @@ static void __init spear_shirq_register(struct spear_shirq *shirq,
 	for (i = 0; i < shirq->nr_irqs; i++) {
 		irq_set_chip_and_handler(shirq->virq_base + i,
 					 shirq->irq_chip, handle_simple_irq);
-		set_irq_flags(shirq->virq_base + i, IRQF_VALID);
 		irq_set_chip_data(shirq->virq_base + i, shirq);
 	}
 }
--
2.1.0
