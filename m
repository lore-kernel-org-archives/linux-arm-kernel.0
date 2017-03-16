From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 16 Mar 2017 17:05:42 +0000
Subject: [PATCH 2/2] irqchip/gic-v3-its: always check for cacheability
 attributes
In-Reply-To: <20170316170542.3568-1-andre.przywara@arm.com>
References: <20170316170542.3568-1-andre.przywara@arm.com>
Message-ID: <20170316170542.3568-3-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we only enable cache flushing if the redistributor denied
our shareability attribute, because we turn off cacheability in this
case.
But if it would just turn down our cacheability request, we would miss
setting the flag.

Re-check the cacheability attribute as reported back by the
redistributor to make sure we flush properly if needed.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b777c57..5cd4d58 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1156,7 +1156,12 @@ static int its_cpu_init_lpis(void)
 				 GICR_PROPBASER_CACHEABILITY_MASK);
 			val |= GICR_PROPBASER_nC;
 			gicr_write_propbaser(val, rbase + GICR_PROPBASER);
+			tmp = gicr_read_propbaser(rbase + GICR_PROPBASER);
 		}
+	}
+
+	if (((tmp & GICR_PROPBASER_CACHEABILITY_MASK) == GICR_PROPBASER_nC) ||
+	    ((tmp & GICR_PROPBASER_CACHEABILITY_MASK) == GICR_PROPBASER_nCnB)) {
 		pr_info_once("GIC: using cache flushing for LPI property table\n");
 		gic_rdists->flags |= RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING;
 	}
-- 
2.9.0
