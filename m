From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 18 May 2012 12:43:03 +0800
Subject: [PATCH] ARM: OMAP2+: fix gpmc request_irq
Message-ID: <1337316183-1203-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ52 on OMAP2+ is not a shared interrupt line. If IRQF_SHARED
is passed to request_irq and dev_id is set as NULL, request_irq will
return -EINVAL.

This patch just removes the flag of IRQF_SHARED to make the irq
registration successful.

Cc: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/mach-omap2/gpmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2286410..e45d31b 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -769,7 +769,7 @@ static int __init gpmc_init(void)
 		irq++;
 	}
 
-	ret = request_irq(gpmc_irq, gpmc_handle_irq, IRQF_SHARED, "gpmc", NULL);
+	ret = request_irq(gpmc_irq, gpmc_handle_irq, 0, "gpmc", NULL);
 	if (ret)
 		pr_err("gpmc: irq-%d could not claim: err %d\n",
 						gpmc_irq, ret);
-- 
1.7.9.5
