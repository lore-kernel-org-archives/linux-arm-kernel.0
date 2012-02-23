From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 23 Feb 2012 23:23:17 +0100
Subject: [PATCH 1/5] ARM: OMAP2+: l3_noc: Remove references to static IRQ
 defines
In-Reply-To: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
References: <1330035801-14937-1-git-send-email-b-cousson@ti.com>
Message-ID: <1330035801-14937-2-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq numbers are retrieved dynamically but the error logging
is still referring to the OMAP44XX_IRQ_XXX defines instead of the
irq number returned by platform_get_irq.

Remove this reference to allow deletion of the irqs-44xx.h files.
Clean the message and replace the pr_ macro by the dev_ equivalent.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_l3_noc.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
index d15225f..46e44f4 100644
--- a/arch/arm/mach-omap2/omap_l3_noc.c
+++ b/arch/arm/mach-omap2/omap_l3_noc.c
@@ -189,8 +189,7 @@ static int __devinit omap4_l3_probe(struct platform_device *pdev)
 			l3_interrupt_handler,
 			IRQF_DISABLED, "l3-dbg-irq", l3);
 	if (ret) {
-		pr_crit("L3: request_irq failed to register for 0x%x\n",
-						OMAP44XX_IRQ_L3_DBG);
+		dev_crit(&pdev->dev, "Request IRQ %d failed\n", l3->debug_irq);
 		goto err3;
 	}
 
@@ -199,8 +198,7 @@ static int __devinit omap4_l3_probe(struct platform_device *pdev)
 			l3_interrupt_handler,
 			IRQF_DISABLED, "l3-app-irq", l3);
 	if (ret) {
-		pr_crit("L3: request_irq failed to register for 0x%x\n",
-						OMAP44XX_IRQ_L3_APP);
+		dev_crit(&pdev->dev, "Request IRQ %d failed\n", l3->app_irq);
 		goto err4;
 	}
 
-- 
1.7.0.4
