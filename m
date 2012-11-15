From: axel.lin@ingics.com (Axel Lin)
Date: Thu, 15 Nov 2012 12:52:39 +0800
Subject: [PATCH 2/4] pinctrl: kirkwood: Prevent NULL dereference if
 of_match_device returns NULL
In-Reply-To: <1352955096.6793.1.camel@phoenix>
References: <1352955096.6793.1.camel@phoenix>
Message-ID: <1352955159.6793.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_match_device() may return NULL.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index 9a74ef6..fe885ca 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -444,8 +444,11 @@ static struct of_device_id kirkwood_pinctrl_of_match[] __devinitdata = {
 
 static int __devinit kirkwood_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match =
-		of_match_device(kirkwood_pinctrl_of_match, &pdev->dev);
+	const struct of_device_id *match;
+
+	match = of_match_device(kirkwood_pinctrl_of_match, &pdev->dev);
+	if (!match)
+		return -ENODEV;
 	pdev->dev.platform_data = match->data;
 	return mvebu_pinctrl_probe(pdev);
 }
-- 
1.7.9.5
