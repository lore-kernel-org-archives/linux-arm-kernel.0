From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  8 Jul 2016 01:15:29 +0200
Subject: [PATCH] pinctrl: qcom: establish proper EBI2 pin groups
Message-ID: <1467933329-2854-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After some digging around I found documentation (!) of the APQ8060
EBI2 pin groups. It turns out I first need to split the group in
two: ebi2cs and ebi2 proper. The chip select pins are kind of
orthogonal to the other EBI2 pins since CS1B and CS2B can be muxed
over address bits 7 and 6 (don't know why, but they can). This
is good to fix up before we add users.

Also found what the "holes" in the assignment all the way up to
gpio158 was actually for.

All mux documentation comes from "Snapdragon(TM) S3 APQ8060-based
DragonBoard(TM) GPIO User Guide Rev. E August 10, 2012", published
by Bsquare Corporation.

As the documentation seems a bit hard to come by I put some comments
in the group definitions so that it is clear to all readers what
is going on here and what the lines are used for.

Cc: Bj?rn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm8660.c | 68 +++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8660.c b/drivers/pinctrl/qcom/pinctrl-msm8660.c
index 98eb0e33df84..5591d093bf78 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8660.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8660.c
@@ -506,6 +506,7 @@ enum msm8660_functions {
 	MSM_MUX_usb_fs2_oe_n,
 	MSM_MUX_vfe,
 	MSM_MUX_vsens_alarm,
+	MSM_MUX_ebi2cs,
 	MSM_MUX_ebi2,
 	MSM_MUX__,
 };
@@ -697,13 +698,35 @@ static const char * const vfe_groups[] = {
 static const char * const vsens_alarm_groups[] = {
 	"gpio127"
 };
+static const char * const ebi2cs_groups[] = {
+	"gpio39", /* CS1A */
+	"gpio40", /* CS2A */
+	"gpio123", /* CS1B */
+	"gpio124", /* CS2B */
+	"gpio131", /* CS5 */
+	"gpio132", /* CS4 */
+	"gpio133", /* CS3 */
+	"gpio134", /* CS0 */
+};
 static const char * const ebi2_groups[] = {
-	"gpio39", "gpio40", "gpio123", "gpio124", "gpio125", "gpio126",
-	"gpio127", "gpio128", "gpio129", "gpio130", "gpio132", "gpio133",
-	"gpio134", "gpio135", "gpio136", "gpio137", "gpio138", "gpio139",
-	"gpio140", "gpio141", "gpio142", "gpio143", "gpio144", "gpio145",
-	"gpio146", "gpio147", "gpio148", "gpio149", "gpio150", "gpio151",
-	"gpio153", "gpio157"
+	/* ADDR9 & ADDR8 */
+	"gpio37", "gpio38",
+	/* ADDR7 - ADDR 0 */
+	"gpio123", "gpio124", "gpio125", "gpio126",
+	"gpio127", "gpio128", "gpio129", "gpio130",
+	/* (muxed address+data) AD15 - AD0 */
+	"gpio135", "gpio136", "gpio137", "gpio138", "gpio139",
+	"gpio140", "gpio141", "gpio142", "gpio143", "gpio144",
+	"gpio145", "gpio146", "gpio147", "gpio148", "gpio149",
+	"gpio150",
+	"gpio151", /* OE output enable */
+	"gpio152", /* clock */
+	"gpio153", /* ADV */
+	"gpio154", /* WAIT (input) */
+	"gpio155", /* UB Upper Byte Enable */
+	"gpio156", /* LB Lower Byte Enable */
+	"gpio157", /* WE Write Enable */
+	"gpio158", /* busy */
 };
 
 static const struct msm_function msm8660_functions[] = {
@@ -758,7 +781,8 @@ static const struct msm_function msm8660_functions[] = {
 	FUNCTION(usb_fs2_oe_n),
 	FUNCTION(vfe),
 	FUNCTION(vsens_alarm),
-	FUNCTION(ebi2),
+	FUNCTION(ebi2cs), /* for EBI2 chip selects */
+	FUNCTION(ebi2), /* for general EBI2 pins */
 };
 
 static const struct msm_pingroup msm8660_groups[] = {
@@ -799,10 +823,10 @@ static const struct msm_pingroup msm8660_groups[] = {
 	PINGROUP(34, gsbi1, _, _, _, _, _, _),
 	PINGROUP(35, gsbi1, _, _, _, _, _, _),
 	PINGROUP(36, gsbi1, _, _, _, _, _, _),
-	PINGROUP(37, gsbi2, _, _, _, _, _, _),
-	PINGROUP(38, gsbi2, _, _, _, _, _, _),
-	PINGROUP(39, gsbi2, ebi2, mdp_vsync, _, _, _, _),
-	PINGROUP(40, gsbi2, ebi2, _, _, _, _, _),
+	PINGROUP(37, gsbi2, ebi2, _, _, _, _, _),
+	PINGROUP(38, gsbi2, ebi2, _, _, _, _, _),
+	PINGROUP(39, gsbi2, ebi2cs, mdp_vsync, _, _, _, _),
+	PINGROUP(40, gsbi2, ebi2cs, _, _, _, _, _),
 	PINGROUP(41, gsbi3, mdp_vsync, _, _, _, _, _),
 	PINGROUP(42, gsbi3, vfe, _, _, _, _, _),
 	PINGROUP(43, gsbi3, _, _, _, _, _, _),
@@ -885,18 +909,18 @@ static const struct msm_pingroup msm8660_groups[] = {
 	PINGROUP(120, i2s, _, _, _, _, _, _),
 	PINGROUP(121, i2s, _, _, _, _, _, _),
 	PINGROUP(122, i2s, gp_clk_1b, _, _, _, _, _),
-	PINGROUP(123, ebi2, gsbi2_spi_cs1_n, _, _, _, _, _),
-	PINGROUP(124, ebi2, gsbi2_spi_cs2_n, _, _, _, _, _),
+	PINGROUP(123, ebi2, gsbi2_spi_cs1_n, ebi2cs, _, _, _, _),
+	PINGROUP(124, ebi2, gsbi2_spi_cs2_n, ebi2cs, _, _, _, _),
 	PINGROUP(125, ebi2, gsbi2_spi_cs3_n, _, _, _, _, _),
 	PINGROUP(126, ebi2, _, _, _, _, _, _),
 	PINGROUP(127, ebi2, vsens_alarm, _, _, _, _, _),
 	PINGROUP(128, ebi2, _, _, _, _, _, _),
 	PINGROUP(129, ebi2, _, _, _, _, _, _),
 	PINGROUP(130, ebi2, _, _, _, _, _, _),
-	PINGROUP(131, _, _, _, _, _, _, _),
-	PINGROUP(132, ebi2, _, _, _, _, _, _),
-	PINGROUP(133, ebi2, _, _, _, _, _, _),
-	PINGROUP(134, ebi2, _, _, _, _, _, _),
+	PINGROUP(131, ebi2cs, _, _, _, _, _, _),
+	PINGROUP(132, ebi2cs, _, _, _, _, _, _),
+	PINGROUP(133, ebi2cs, _, _, _, _, _, _),
+	PINGROUP(134, ebi2cs, _, _, _, _, _, _),
 	PINGROUP(135, ebi2, _, _, _, _, _, _),
 	PINGROUP(136, ebi2, _, _, _, _, _, _),
 	PINGROUP(137, ebi2, _, _, _, _, _, _),
@@ -914,13 +938,13 @@ static const struct msm_pingroup msm8660_groups[] = {
 	PINGROUP(149, ebi2, sdc2, _, _, _, _, _),
 	PINGROUP(150, ebi2, sdc2, _, _, _, _, _),
 	PINGROUP(151, ebi2, sdc2, _, _, _, _, _),
-	PINGROUP(152, _, sdc2, _, _, _, _, _),
+	PINGROUP(152, ebi2, sdc2, _, _, _, _, _),
 	PINGROUP(153, ebi2, _, _, _, _, _, _),
-	PINGROUP(154, _, _, _, _, _, _, _),
-	PINGROUP(155, _, _, _, _, _, _, _),
-	PINGROUP(156, _, _, _, _, _, _, _),
+	PINGROUP(154, ebi2, _, _, _, _, _, _),
+	PINGROUP(155, ebi2, _, _, _, _, _, _),
+	PINGROUP(156, ebi2, _, _, _, _, _, _),
 	PINGROUP(157, ebi2, _, _, _, _, _, _),
-	PINGROUP(158, _, _, _, _, _, _, _),
+	PINGROUP(158, ebi2, _, _, _, _, _, _),
 	PINGROUP(159, sdc1, _, _, _, _, _, _),
 	PINGROUP(160, sdc1, _, _, _, _, _, _),
 	PINGROUP(161, sdc1, _, _, _, _, _, _),
-- 
2.7.4
