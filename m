From: axel.lin@ingics.com (Axel Lin)
Date: Thu, 15 Nov 2012 12:51:36 +0800
Subject: [PATCH 1/4] pinctrl: dove: Prevent NULL dereference if
 of_match_device returns NULL
Message-ID: <1352955096.6793.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_match_device() may return NULL.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pinctrl/mvebu/pinctrl-dove.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index ffe74b2..a8b9b42 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -578,8 +578,12 @@ static struct of_device_id dove_pinctrl_of_match[] __devinitdata = {
 
 static int __devinit dove_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match =
-		of_match_device(dove_pinctrl_of_match, &pdev->dev);
+	const struct of_device_id *match;
+
+	match = of_match_device(dove_pinctrl_of_match, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
 	pdev->dev.platform_data = match->data;
 
 	/*
-- 
1.7.9.5
