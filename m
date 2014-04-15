From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 15 Apr 2014 14:41:37 +0800
Subject: [PATCH 3/7] net: rfkill: gpio: use
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1397544101-18135-1-git-send-email-wens@csie.org>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
Message-ID: <1397544101-18135-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rfkill-gpio calls clk_enable() without first calling clk_prepare(),
resulting in a warning and no effect. Switch to clk_prepare_enable()
and clk_disable_unprepare.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 net/rfkill/rfkill-gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 9c4a5eb..29ff07c 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -49,10 +49,10 @@ static int rfkill_gpio_set_power(void *data, bool blocked)
 		gpiod_set_value(rfkill->shutdown_gpio, 0);
 		gpiod_set_value(rfkill->reset_gpio, 0);
 		if (!IS_ERR(rfkill->clk) && rfkill->clk_enabled)
-			clk_disable(rfkill->clk);
+			clk_disable_unprepare(rfkill->clk);
 	} else {
 		if (!IS_ERR(rfkill->clk) && !rfkill->clk_enabled)
-			clk_enable(rfkill->clk);
+			clk_prepare_enable(rfkill->clk);
 		gpiod_set_value(rfkill->reset_gpio, 1);
 		gpiod_set_value(rfkill->shutdown_gpio, 1);
 	}
-- 
1.9.1
