From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 18 Jan 2016 20:34:58 +0100
Subject: [PATCH] clocksource: atmel-st: use return value from
 clk_prepare_enable()
Message-ID: <1453145698-23661-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ret is used to detect an error but it was not properly updated after
calling clk_prepare_enable() thus it made it impossible to detect an error
when enabling the slow clock.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clocksource/timer-atmel-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
index 29d21d68df5a..c69070c6ad91 100644
--- a/drivers/clocksource/timer-atmel-st.c
+++ b/drivers/clocksource/timer-atmel-st.c
@@ -225,7 +225,7 @@ static void __init atmel_st_timer_init(struct device_node *node)
 	if (IS_ERR(sclk))
 		panic(pr_fmt("Unable to get slow clock\n"));
 
-	clk_prepare_enable(sclk);
+	ret = clk_prepare_enable(sclk);
 	if (ret)
 		panic(pr_fmt("Could not enable slow clock\n"));
 
-- 
2.5.0
