From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 15 Apr 2014 14:41:38 +0800
Subject: [PATCH 4/7] net: rfkill: gpio: fix reversed clock enable state
In-Reply-To: <1397544101-18135-1-git-send-email-wens@csie.org>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
Message-ID: <1397544101-18135-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rfkill-gpio has clk_enabled = blocked, which is true when rfkill
blocks the device. This results in calling clock enable/disable at
the wrong time. Reversing the value fixes this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 net/rfkill/rfkill-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 29ff07c..f46ddf7 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -57,7 +57,7 @@ static int rfkill_gpio_set_power(void *data, bool blocked)
 		gpiod_set_value(rfkill->shutdown_gpio, 1);
 	}
 
-	rfkill->clk_enabled = blocked;
+	rfkill->clk_enabled = !blocked;
 
 	return 0;
 }
-- 
1.9.1
