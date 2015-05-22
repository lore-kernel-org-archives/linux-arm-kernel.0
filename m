From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 May 2015 23:29:53 +0800
Subject: [PATCH v2 06/12] ARM: imx: set up .set_next_event hook via
 imx_gpt_data
In-Reply-To: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1432308599-28643-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set up .set_next_event hook via imx_gpt_data, so that we can save the
use of timer_is_v2().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 2fbc3022ce3f..ceba782a1f1d 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -97,6 +97,8 @@ struct imx_timer {
 
 struct imx_gpt_data {
 	void (*gpt_setup_tctl)(struct imx_timer *imxtm);
+	int (*set_next_event)(unsigned long evt,
+			      struct clock_event_device *ced);
 };
 
 static void __iomem *timer_base;
@@ -301,9 +303,7 @@ static struct clock_event_device clockevent_mxc = {
 
 static int __init mxc_clockevent_init(struct imx_timer *imxtm)
 {
-	if (timer_is_v2())
-		clockevent_mxc.set_next_event = v2_set_next_event;
-
+	clockevent_mxc.set_next_event = imxtm->gpt->set_next_event;
 	clockevent_mxc.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&clockevent_mxc,
 					clk_get_rate(imxtm->clk_per),
@@ -353,18 +353,22 @@ static void imx6dl_gpt_setup_tctl(struct imx_timer *imxtm)
 
 static const struct imx_gpt_data imx1_gpt_data = {
 	.gpt_setup_tctl = imx1_gpt_setup_tctl,
+	.set_next_event = mx1_2_set_next_event,
 };
 
 static const struct imx_gpt_data imx21_gpt_data = {
 	.gpt_setup_tctl = imx21_gpt_setup_tctl,
+	.set_next_event = mx1_2_set_next_event,
 };
 
 static const struct imx_gpt_data imx31_gpt_data = {
 	.gpt_setup_tctl = imx31_gpt_setup_tctl,
+	.set_next_event = v2_set_next_event,
 };
 
 static const struct imx_gpt_data imx6dl_gpt_data = {
 	.gpt_setup_tctl = imx6dl_gpt_setup_tctl,
+	.set_next_event = v2_set_next_event,
 };
 
 static void __init _mxc_timer_init(struct imx_timer *imxtm)
-- 
1.9.1
