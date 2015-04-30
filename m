From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 30 Apr 2015 19:45:54 +0200
Subject: [PATCH 4/4] clk: si5351: Reset PLL after rate change
In-Reply-To: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1430415954-29517-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When changing PLL rate significantly, PLLs have to be reset. Add a function
to perform and check for successful PLL reset.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Michael Welling <mwelling@ieee.org>
Cc: Russell King <rmk+linux@arm.linux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-clk at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/clk-si5351.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index beeb57bbb04c..9b97c134e3c1 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -366,6 +366,32 @@ static const struct clk_ops si5351_vxco_ops = {
  *         = (MSNx_P1*MSNx_P3 + MSNx_P2 + 512*MSNx_P3)/(128*MSNx_P3)
  *
  */
+static int si5351_pll_reset(struct si5351_hw_data *hwdata)
+{
+	unsigned long timeout;
+	u8 mask = (hwdata->num == 0) ?
+		SI5351_STATUS_LOL_A : SI5351_STATUS_LOL_B;
+
+	si5351_reg_write(hwdata->drvdata, SI5351_PLL_RESET,
+			 (hwdata->num == 0) ? SI5351_PLL_RESET_A :
+			 SI5351_PLL_RESET_B);
+	timeout = jiffies + msecs_to_jiffies(100);
+	do {
+		if ((si5351_reg_read(hwdata->drvdata, SI5351_DEVICE_STATUS) &
+		     mask) == 0)
+			break;
+		if (time_after(jiffies, timeout)) {
+			dev_err(&hwdata->drvdata->client->dev,
+				"timeout waiting for pll %d reset\n",
+				hwdata->num);
+			return -EBUSY;
+		};
+		udelay(250);
+	} while (true);
+
+	return 0;
+}
+
 static int _si5351_pll_reparent(struct si5351_driver_data *drvdata,
 				int num, enum si5351_pll_src parent)
 {
@@ -519,6 +545,9 @@ static int si5351_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 		SI5351_CLK_INTEGER_MODE,
 		(hwdata->params.p2 == 0) ? SI5351_CLK_INTEGER_MODE : 0);
 
+	/* reset pll after rate change */
+	si5351_pll_reset(hwdata);
+
 	dev_dbg(&hwdata->drvdata->client->dev,
 		"%s - %s: p1 = %lu, p2 = %lu, p3 = %lu, parent_rate = %lu, rate = %lu\n",
 		__func__, __clk_get_name(hwdata->hw.clk),
-- 
2.1.0
