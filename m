From: stefan@agner.ch (Stefan Agner)
Date: Sat,  6 Jan 2018 15:25:50 +0100
Subject: [PATCH v2 2/5] pinctrl: imx7d: simplify imx7d_pinctrl_probe
In-Reply-To: <20180106142553.15322-1-stefan@agner.ch>
References: <20180106142553.15322-1-stefan@agner.ch>
Message-ID: <20180106142553.15322-3-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using of_device_get_match_data in imx7d_pinctrl_probe simplifies
the function. Also get rid of the void pointer cast since
imx_pinctrl_probe now accepts const struct imx_pinctrl_soc_info.

Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pinctrl/freescale/pinctrl-imx7d.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx7d.c b/drivers/pinctrl/freescale/pinctrl-imx7d.c
index 754159ee7b1e..0b0a2f33b06a 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx7d.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx7d.c
@@ -378,16 +378,12 @@ static const struct of_device_id imx7d_pinctrl_of_match[] = {
 
 static int imx7d_pinctrl_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
-	struct imx_pinctrl_soc_info *pinctrl_info;
+	const struct imx_pinctrl_soc_info *pinctrl_info;
 
-	match = of_match_device(imx7d_pinctrl_of_match, &pdev->dev);
-
-	if (!match)
+	pinctrl_info = of_device_get_match_data(&pdev->dev);
+	if (!pinctrl_info)
 		return -ENODEV;
 
-	pinctrl_info = (struct imx_pinctrl_soc_info *) match->data;
-
 	return imx_pinctrl_probe(pdev, pinctrl_info);
 }
 
-- 
2.15.1
