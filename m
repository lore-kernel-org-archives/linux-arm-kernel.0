From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  5 Dec 2014 11:15:43 -0800
Subject: [PATCH for-next] bus: brcmstb_gisb: use gdev_{read,
 write} in suspend/resume paths
Message-ID: <1417806943-1200-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a small merge issue between:
Commit 2b53eadcea05 ("bus: brcmstb_gisb: Introduce wrapper functions for
MMIO accesses") and 203bb85ed605 ("bus: brcmstb_gisb: save and restore
GISB timeout"), the former introducing wrapper I/O accessors to be
decoupled from the register offsets and use table, while the latter had
not been converted to using these wrapper.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Arnd, Olof,

This applies on top of your arm-soc/for-next branch as of
921caee4a849443bcda286f903b6ec01c5aa7fd8 ("arm-soc: document merges")

Thanks!

 drivers/bus/brcmstb_gisb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index fa7b3cd09fc0..46de8dc39eb4 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -359,7 +359,7 @@ static int brcmstb_gisb_arb_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
 
-	gdev->saved_timeout = ioread32(gdev->base + ARB_TIMER);
+	gdev->saved_timeout = gisb_read(gdev, ARB_TIMER);
 
 	return 0;
 }
@@ -372,7 +372,7 @@ static int brcmstb_gisb_arb_resume_noirq(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
 
-	iowrite32(gdev->saved_timeout, gdev->base + ARB_TIMER);
+	gisb_write(gdev, gdev->saved_timeout, ARB_TIMER);
 
 	return 0;
 }
-- 
2.1.0
