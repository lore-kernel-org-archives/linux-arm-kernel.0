From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 15 Aug 2014 13:40:10 +0100
Subject: [PATCH 3/9] phy: phy-omap-usb2: Remove unncessary site specific OOM
 messages
In-Reply-To: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
References: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1408106416-19044-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The site specific OOM messages are unncessary, because they duplicate
messages from the memory subsystem which include dump_stack().

Removing these superflous messages makes the kernel smaller. A discussion
here http://patchwork.ozlabs.org/patch/324158/ found that all error paths
from kzalloc will print a error message, and that any error path which maybe
found which doesn't would be considered a bug in kzalloc.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/phy-omap-usb2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
index 93d7835..51c6f92 100644
--- a/drivers/phy/phy-omap-usb2.c
+++ b/drivers/phy/phy-omap-usb2.c
@@ -212,16 +212,12 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	phy_data = (struct usb_phy_data *)of_id->data;
 
 	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
-	if (!phy) {
-		dev_err(&pdev->dev, "unable to allocate memory for USB2 PHY\n");
+	if (!phy)
 		return -ENOMEM;
-	}
 
 	otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
-	if (!otg) {
-		dev_err(&pdev->dev, "unable to allocate memory for USB OTG\n");
+	if (!otg)
 		return -ENOMEM;
-	}
 
 	phy->dev		= &pdev->dev;
 
-- 
1.9.1
