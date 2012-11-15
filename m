From: axel.lin@ingics.com (Axel Lin)
Date: Thu, 15 Nov 2012 12:56:05 +0800
Subject: [PATCH 4/4] pinctrl: nomadik: Prevent NULL dereference if
 of_match_device returns NULL
In-Reply-To: <1352955096.6793.1.camel@phoenix>
References: <1352955096.6793.1.camel@phoenix>
Message-ID: <1352955365.6793.6.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_match_device() may return NULL.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pinctrl/pinctrl-nomadik.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 238060e..40bd1b3 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -1863,9 +1863,14 @@ static int __devinit nmk_pinctrl_probe(struct platform_device *pdev)
 
 	if (platid)
 		version = platid->driver_data;
-	else if (np)
-		version = (unsigned int)
-			of_match_device(nmk_pinctrl_match, &pdev->dev)->data;
+	else if (np) {
+		const struct of_device_id *match;
+
+		match = of_match_device(nmk_pinctrl_match, &pdev->dev);
+		if (!match)
+			return -ENODEV;
+		version = (unsigned int) match->data;
+	}
 
 	/* Poke in other ASIC variants here */
 	if (version == PINCTRL_NMK_STN8815)
-- 
1.7.9.5
