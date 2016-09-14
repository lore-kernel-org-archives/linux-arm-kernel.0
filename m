From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 14 Sep 2016 14:27:51 +0100
Subject: [PATCH 13/19] pinctrl: st: Remove STiH415/6 SoC pinctrl driver
 support.
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1473859677-9231-14-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

STiH415/6 SoC support is being removed from the kernel.
This patch updates the ST pinctrl driver and removes
references to these obsolete platforms. As some structures
referenced by STiH407 based configuration were shared with
STiH416 we update these names to match the remaining
supported platform.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: <linus.walleij@linaro.org>
Cc: <linux-gpio@vger.kernel.org>
---
 drivers/pinctrl/pinctrl-st.c | 76 ++++++++------------------------------------
 1 file changed, 14 insertions(+), 62 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 0de1c67..e110441 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -335,61 +335,25 @@ struct st_pinctrl {
 };
 
 /* SOC specific data */
-/* STiH415 data */
-static const unsigned int stih415_input_delays[] = {0, 500, 1000, 1500};
-static const unsigned int stih415_output_delays[] = {0, 1000, 2000, 3000};
-
-#define STIH415_PCTRL_COMMON_DATA				\
-	.rt_style	= st_retime_style_packed,		\
-	.input_delays	= stih415_input_delays,			\
-	.ninput_delays	= ARRAY_SIZE(stih415_input_delays),	\
-	.output_delays = stih415_output_delays,			\
-	.noutput_delays = ARRAY_SIZE(stih415_output_delays)
-
-static const struct st_pctl_data  stih415_sbc_data = {
-	STIH415_PCTRL_COMMON_DATA,
-	.alt = 0, .oe = 5, .pu = 7, .od = 9, .rt = 16,
-};
-
-static const struct st_pctl_data  stih415_front_data = {
-	STIH415_PCTRL_COMMON_DATA,
-	.alt = 0, .oe = 8, .pu = 10, .od = 12, .rt = 16,
-};
-
-static const struct st_pctl_data  stih415_rear_data = {
-	STIH415_PCTRL_COMMON_DATA,
-	.alt = 0, .oe = 6, .pu = 8, .od = 10, .rt = 38,
-};
-
-static const struct st_pctl_data  stih415_left_data = {
-	STIH415_PCTRL_COMMON_DATA,
-	.alt = 0, .oe = 3, .pu = 4, .od = 5, .rt = 6,
-};
-
-static const struct st_pctl_data  stih415_right_data = {
-	STIH415_PCTRL_COMMON_DATA,
-	.alt = 0, .oe = 5, .pu = 7, .od = 9, .rt = 11,
-};
 
-/* STiH416 data */
-static const unsigned int stih416_delays[] = {0, 300, 500, 750, 1000, 1250,
+static const unsigned int stih407_delays[] = {0, 300, 500, 750, 1000, 1250,
 			1500, 1750, 2000, 2250, 2500, 2750, 3000, 3250 };
 
-static const struct st_pctl_data  stih416_data = {
-	.rt_style	= st_retime_style_dedicated,
-	.input_delays	= stih416_delays,
-	.ninput_delays	= ARRAY_SIZE(stih416_delays),
-	.output_delays	= stih416_delays,
-	.noutput_delays = ARRAY_SIZE(stih416_delays),
+static const struct st_pctl_data  stih407_data = {
+	.rt_style       = st_retime_style_dedicated,
+	.input_delays   = stih407_delays,
+	.ninput_delays  = ARRAY_SIZE(stih407_delays),
+	.output_delays  = stih407_delays,
+	.noutput_delays = ARRAY_SIZE(stih407_delays),
 	.alt = 0, .oe = 40, .pu = 50, .od = 60, .rt = 100,
 };
 
 static const struct st_pctl_data stih407_flashdata = {
 	.rt_style	= st_retime_style_none,
-	.input_delays	= stih416_delays,
-	.ninput_delays	= ARRAY_SIZE(stih416_delays),
-	.output_delays	= stih416_delays,
-	.noutput_delays = ARRAY_SIZE(stih416_delays),
+	.input_delays	= stih407_delays,
+	.ninput_delays	= ARRAY_SIZE(stih407_delays),
+	.output_delays	= stih407_delays,
+	.noutput_delays = ARRAY_SIZE(stih407_delays),
 	.alt = 0,
 	.oe = -1, /* Not Available */
 	.pu = -1, /* Not Available */
@@ -1579,21 +1543,9 @@ static int st_gpiolib_register_bank(struct st_pinctrl *info,
 }
 
 static const struct of_device_id st_pctl_of_match[] = {
-	{ .compatible = "st,stih415-sbc-pinctrl", .data = &stih415_sbc_data },
-	{ .compatible = "st,stih415-rear-pinctrl", .data = &stih415_rear_data },
-	{ .compatible = "st,stih415-left-pinctrl", .data = &stih415_left_data },
-	{ .compatible = "st,stih415-right-pinctrl",
-		.data = &stih415_right_data },
-	{ .compatible = "st,stih415-front-pinctrl",
-		.data = &stih415_front_data },
-	{ .compatible = "st,stih416-sbc-pinctrl", .data = &stih416_data},
-	{ .compatible = "st,stih416-front-pinctrl", .data = &stih416_data},
-	{ .compatible = "st,stih416-rear-pinctrl", .data = &stih416_data},
-	{ .compatible = "st,stih416-fvdp-fe-pinctrl", .data = &stih416_data},
-	{ .compatible = "st,stih416-fvdp-lite-pinctrl", .data = &stih416_data},
-	{ .compatible = "st,stih407-sbc-pinctrl", .data = &stih416_data},
-	{ .compatible = "st,stih407-front-pinctrl", .data = &stih416_data},
-	{ .compatible = "st,stih407-rear-pinctrl", .data = &stih416_data},
+	{ .compatible = "st,stih407-sbc-pinctrl", .data = &stih407_data},
+	{ .compatible = "st,stih407-front-pinctrl", .data = &stih407_data},
+	{ .compatible = "st,stih407-rear-pinctrl", .data = &stih407_data},
 	{ .compatible = "st,stih407-flash-pinctrl", .data = &stih407_flashdata},
 	{ /* sentinel */ }
 };
-- 
1.9.1
