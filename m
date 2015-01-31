From: stefan@agner.ch (Stefan Agner)
Date: Sat, 31 Jan 2015 01:26:10 +0100
Subject: [PATCH] irqchip: gic: ignore empty processor target registers
Message-ID: <1422663970-3563-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On initialization time, the GIC driver reads the processor target
register (ICDIPTR) to determine the CPU's mask. On uniprocessor
systems with GIC controller (e.g. Cortex-A5 SoC's) this register
is RAZ/WI and hence the mask ends up being zero. This leads to the
somewhat confusing boot message:
[    0.000000] GIC CPU mask not found - kernel will fail to boot.

To avoid the message, print the error only on SMP systems.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
I would like to get rid of this critical message in my bootlog, it
sounds somewhat... intimidating...

Actually the driver could also conditionally avoid setting up
GIC_DIST_TARGET, since it's RAZ/WI (write ignored) on uniprocessor
systems. But I'm not sure if is_smp() is really reflecting all
SoC's using GIC which need the Interrupt Processor Targets register
configured.

 drivers/irqchip/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index d617ee5..7d4f0f5 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -346,7 +346,7 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
 			break;
 	}
 
-	if (!mask)
+	if (!mask && is_smp())
 		pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
 
 	return mask;
-- 
2.2.2
