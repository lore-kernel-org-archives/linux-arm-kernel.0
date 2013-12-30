From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 11:19:27 +0100
Subject: [PATCH 08/20] clocksource: arm_global_timer: Switch to
 sched_clock_register()
In-Reply-To: <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
References: <52C1479E.80808@linaro.org>
 <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388398779-11222-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

The 32 bit sched_clock interface now supports 64 bits. Upgrade to
the 64 bit function to allow us to remove the 32 bit registration
interface. While we're here increase the number of bits that
sched_clock can handle to 64 to make full use of the counter.

Cc: Stuart Menefy <stuart.menefy@st.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Acked-by: Stuart Menefy <stuart.menefy@st.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_global_timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index c639b1a..0fc31d0 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -202,7 +202,7 @@ static struct clocksource gt_clocksource = {
 };
 
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-static u32 notrace gt_sched_clock_read(void)
+static u64 notrace gt_sched_clock_read(void)
 {
 	return gt_counter_read();
 }
@@ -217,7 +217,7 @@ static void __init gt_clocksource_init(void)
 	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
 
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-	setup_sched_clock(gt_sched_clock_read, 32, gt_clk_rate);
+	sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
 #endif
 	clocksource_register_hz(&gt_clocksource, gt_clk_rate);
 }
-- 
1.7.9.5
