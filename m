From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Mon, 5 Nov 2018 11:14:28 +0000
Subject: [PATCH 3/4] power: reset: at91-poweroff: check shdwc data structure
 at the beginning of probe
In-Reply-To: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1541416443-4321-4-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check at91_shdwc before continuing with probe since we want only one instance of
this driver. Inspired from commit 9f1e44774be5 ("power: reset: at91-poweroff:
do not procede if at91_shdwc is allocated").

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-poweroff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
index 48661e04a3de..e75d8f0f0526 100644
--- a/drivers/power/reset/at91-poweroff.c
+++ b/drivers/power/reset/at91-poweroff.c
@@ -160,6 +160,9 @@ static int __init at91_poweroff_probe(struct platform_device *pdev)
 	u32 ddr_type;
 	int ret;
 
+	if (at91_shdwc)
+		return -EBUSY;
+
 	at91_shdwc = devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KERNEL);
 	if (!at91_shdwc)
 		return -ENOMEM;
-- 
2.7.4
