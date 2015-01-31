From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 30 Jan 2015 16:43:30 -0800
Subject: [PATCH] irqchip: gic: Don't complain in gic_get_cpumask() if UP system
Message-ID: <1422665010-5854-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a uniprocessor implementation the interrupt processor targets
registers are read-as-zero/write-ignored (RAZ/WI). Unfortunately
gic_get_cpumask() will print a critical message saying

 GIC CPU mask not found - kernel will fail to boot.

if these registers all read as zero, but there won't actually be
a problem on uniprocessor systems and the kernel will boot just
fine. Skip this check if we're running a UP kernel or if we
detect that the hardware only supports a single processor.

Acked-by: Nicolas Pitre <nico@linaro.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Stefan Agner <stefan@agner.ch>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/irqchip/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index d617ee5a3d8a..1b70e0de0f6e 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -346,7 +346,7 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
 			break;
 	}
 
-	if (!mask)
+	if (!mask && num_possible_cpus() > 1)
 		pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
 
 	return mask;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
