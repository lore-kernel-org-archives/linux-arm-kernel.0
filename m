From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 22 Sep 2014 11:02:45 -0700
Subject: [PATCH v3 1/2] bus: brcmstb_gisb: register the fault code hook
In-Reply-To: <1411408966-15390-1-git-send-email-f.fainelli@gmail.com>
References: <1411408966-15390-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1411408966-15390-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 44127b771d9c31 ("bus: add Broadcom GISB bus arbiter timeout/error
handler") added everything that is required to register an ARM fault
handler for imprecise external aborts, except that there is nothing
calling this currently.

We do not need to export that specific function and have to update
arch/arm/mach-bcm/brcmstb.c to call it, simply, register the fault
handler during the probe() function of the driver.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:
- moved hook_fault_code as part of the probe function

Changes in v2:
- removed the accidental hunk that added saved_timeout since it does
  not belong in this patch

 drivers/bus/brcmstb_gisb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index f2cd6a2d40b4..41b09418f515 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -160,12 +160,6 @@ static int brcmstb_bus_error_handler(unsigned long addr, unsigned int fsr,
 	return ret;
 }
 
-void __init brcmstb_hook_fault_code(void)
-{
-	hook_fault_code(22, brcmstb_bus_error_handler, SIGBUS, 0,
-			"imprecise external abort");
-}
-
 static irqreturn_t brcmstb_gisb_timeout_handler(int irq, void *dev_id)
 {
 	brcmstb_gisb_arb_decode_addr(dev_id, "timeout");
@@ -261,6 +255,9 @@ static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
 
 	list_add_tail(&gdev->next, &brcmstb_gisb_arb_device_list);
 
+	hook_fault_code(22, brcmstb_bus_error_handler, SIGBUS, 0,
+			"imprecise external abort");
+
 	dev_info(&pdev->dev, "registered mem: %p, irqs: %d, %d\n",
 			gdev->base, timeout_irq, tea_irq);
 
-- 
1.9.1
