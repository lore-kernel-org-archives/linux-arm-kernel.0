From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Jan 2014 14:47:26 +0800
Subject: [PATCH RFC 1/6] net: rfkill: gpio: fix gpio name buffer size off by 1
In-Reply-To: <1389941251-32692-1-git-send-email-wens@csie.org>
References: <1389941251-32692-1-git-send-email-wens@csie.org>
Message-ID: <1389941251-32692-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

snprintf should be passed the complete size of the buffer, including
the space for '\0'. The previous code resulted in the *_reset and
*_shutdown strings being truncated.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 net/rfkill/rfkill-gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index bd2a5b9..97ec12a 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -117,8 +117,8 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 	if (!rfkill->shutdown_name)
 		return -ENOMEM;
 
-	snprintf(rfkill->reset_name, len + 6 , "%s_reset", rfkill->name);
-	snprintf(rfkill->shutdown_name, len + 9, "%s_shutdown", rfkill->name);
+	snprintf(rfkill->reset_name, len + 7 , "%s_reset", rfkill->name);
+	snprintf(rfkill->shutdown_name, len + 10, "%s_shutdown", rfkill->name);
 
 	rfkill->clk = devm_clk_get(&pdev->dev, clk_name);
 
-- 
1.8.5.2
