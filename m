From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 11 Oct 2017 10:41:47 +0100
Subject: [PATCH 2/3] irqchip/gic-v3: Report firmwware provided address in case
 of error
In-Reply-To: <20171011094148.15674-1-punit.agrawal@arm.com>
References: <20171011094148.15674-1-punit.agrawal@arm.com>
Message-ID: <20171011094148.15674-3-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a redistributor is not found at the address provided by the
firmware, report the firmware provided address to help user identify the
offending firmware data.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 8cb383b6e605..881d327c53fa 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -430,13 +430,14 @@ static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
 
 	for (i = 0; i < gic_data.nr_redist_regions; i++) {
 		void __iomem *ptr = gic_data.redist_regions[i].redist_base;
+		struct resource *res = &gic_data.redist_regions[i].res;
 		u64 typer;
 		u32 reg;
 
 		reg = readl_relaxed(ptr + GICR_PIDR2) & GIC_PIDR2_ARCH_MASK;
 		if (reg != GIC_PIDR2_ARCH_GICv3 &&
 		    reg != GIC_PIDR2_ARCH_GICv4) { /* We're in trouble... */
-			pr_warn("No redistributor present @%p\n", ptr);
+			pr_warn("No redistributor present @%llx\n", res->start);
 			break;
 		}
 
-- 
2.14.1
