From: shawnguo@kernel.org (shawnguo at kernel.org)
Date: Fri, 15 May 2015 16:11:43 +0800
Subject: [PATCH 5/9] ARM: imx: set up set_next_event hook in
 imx_timer_data_init()
In-Reply-To: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1431677507-27420-6-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Function imx_timer_data_init() was there for setting up device specific
data, so let's move the setup of set_next_event hook into there.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/time.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index c86e25922eb4..d79a00e24084 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -290,15 +290,11 @@ static struct clock_event_device clockevent_mxc = {
 	.name		= "mxc_timer1",
 	.features	= CLOCK_EVT_FEAT_ONESHOT,
 	.set_mode	= mxc_set_mode,
-	.set_next_event	= mx1_2_set_next_event,
 	.rating		= 200,
 };
 
 static int __init mxc_clockevent_init(void)
 {
-	if (timer_is_v2())
-		clockevent_mxc.set_next_event = v2_set_next_event;
-
 	clockevent_mxc.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&clockevent_mxc,
 					clk_get_rate(imxtm.clk_per),
@@ -351,15 +347,19 @@ static void __init imx_timer_data_init(void)
 	switch (imxtm.type) {
 	case GPT_TYPE_IMX1:
 		imxtm.gpt_setup_tctl = imx1_gpt_setup_tctl;
+		clockevent_mxc.set_next_event = mx1_2_set_next_event;
 		break;
 	case GPT_TYPE_IMX21:
 		imxtm.gpt_setup_tctl = imx21_gpt_setup_tctl;
+		clockevent_mxc.set_next_event = mx1_2_set_next_event;
 		break;
 	case GPT_TYPE_IMX31:
 		imxtm.gpt_setup_tctl = imx31_gpt_setup_tctl;
+		clockevent_mxc.set_next_event = v2_set_next_event;
 		break;
 	case GPT_TYPE_IMX6DL:
 		imxtm.gpt_setup_tctl = imx6dl_gpt_setup_tctl;
+		clockevent_mxc.set_next_event = v2_set_next_event;
 		break;
 	default:
 		BUG();
-- 
1.9.1
