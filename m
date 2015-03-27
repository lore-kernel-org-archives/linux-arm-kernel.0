From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Mar 2015 14:15:02 +0000
Subject: [PATCH 1/4] irqchip: gicv3-its: Fix encoding of collection's target
 redistributor
In-Reply-To: <1427465705-17126-1-git-send-email-marc.zyngier@arm.com>
References: <1427465705-17126-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1427465705-17126-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With a monolithic GICv3, redistributors are addressed using a linear
number, while a distributed implementation uses physical addresses.

When encoding a target address into a command, we strip the lower
16 bits, as redistributors are always 64kB aligned. This works
perfectly well with a distributed implementation, but has the
silly effect of always encoding target 0 in the monolithic case
(unless you have more than 64k CPUs, of course).

The obvious fix is to shift the linear target number by 16 when
computing the target address, so that we don't loose any precious
bit.

Reported-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 596b0a9..7318dba 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1026,7 +1026,7 @@ static void its_cpu_init_collection(void)
 			 * This ITS wants a linear CPU number.
 			 */
 			target = readq_relaxed(gic_data_rdist_rd_base() + GICR_TYPER);
-			target = GICR_TYPER_CPU_NUMBER(target);
+			target = GICR_TYPER_CPU_NUMBER(target) << 16;
 		}
 
 		/* Perform collection mapping */
-- 
2.1.4
