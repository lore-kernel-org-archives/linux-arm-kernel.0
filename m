From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 22 May 2014 12:10:52 +0200
Subject: [PATCH] ASoC: samsung: Handle errors when getting the op_clk clock
Message-ID: <1400753452-6943-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure i2s->op_clk is not used when clk_get() for this clock fails.
This prevents working with an incorrectly configured clock in some
conditions.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index ae02811..a634a66 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -488,7 +488,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 			clk_id = 1;
 
 		if (!any_active(i2s)) {
-			if (i2s->op_clk) {
+			if (i2s->op_clk && !IS_ERR(i2s->op_clk)) {
 				if ((clk_id && !(mod & MOD_IMS_SYSMUX)) ||
 					(!clk_id && (mod & MOD_IMS_SYSMUX))) {
 					clk_disable_unprepare(i2s->op_clk);
@@ -506,6 +506,10 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 			else
 				i2s->op_clk = clk_get(&i2s->pdev->dev,
 						"i2s_opclk0");
+
+			if (WARN_ON(IS_ERR(i2s->op_clk)))
+				return PTR_ERR(i2s->op_clk);
+
 			clk_prepare_enable(i2s->op_clk);
 			i2s->rclk_srcrate = clk_get_rate(i2s->op_clk);
 
-- 
1.7.9.5
