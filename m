From: alison@she-devel.com (alison at she-devel.com)
Date: Fri, 13 Feb 2015 09:33:04 -0800
Subject: [PATCH] i.MX6: WEIM: put node reference on early loop exit
Message-ID: <1423848784-6988-1-git-send-email-alison_chaiken@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alison Chaiken <alison_chaiken@mentor.com>

Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>
---
 drivers/bus/imx-weim.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 0958b69..11f2c8b 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -158,7 +158,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 		if (ret) {
 			dev_err(&pdev->dev, "%s set timing failed.\n",
 				child->full_name);
-			return ret;
+			goto put_node;
 		}
 	}
 
@@ -166,7 +166,14 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 				   of_default_bus_match_table,
 				   NULL, &pdev->dev);
 	if (ret)
-		dev_err(&pdev->dev, "%s fail to create devices.\n",
+		goto out;
+
+	return 0;
+
+put_node:
+	of_node_put(child);
+out:
+	dev_err(&pdev->dev, "%s fail to create devices.\n",
 			pdev->dev.of_node->full_name);
 	return ret;
 }
-- 
2.1.4
