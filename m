From: eric@anholt.net (Eric Anholt)
Date: Mon, 15 May 2017 10:35:04 -0700
Subject: [PATCH] clk: bcm2835: Correct the prediv logic
Message-ID: <20170515173504.11337-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Phil Elwell <phil@raspberrypi.org>

If a clock has the prediv flag set, both the integer and fractional
parts must be scaled when calculating the resulting frequency.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---

While this is a bugfix, I haven't put a "Fixes:" line in here to get
it automatically backported to stable.  We had trouble with the
out-of-tree DSI panel driver, at least: Our old set_rate() didn't
work, because the new PLL was just barely too fast to get the integer
PLL divider we needed.  We may run into similar troubles
elsewhere. --anholt

 drivers/clk/bcm/clk-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 025853870619..7a35df6b45bd 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -616,8 +616,10 @@ static unsigned long bcm2835_pll_get_rate(struct clk_hw *hw,
 	using_prediv = cprman_read(cprman, data->ana_reg_base + 4) &
 		data->ana->fb_prediv_mask;
 
-	if (using_prediv)
+	if (using_prediv) {
 		ndiv *= 2;
+		fdiv *= 2;
+	}
 
 	return bcm2835_pll_rate_from_divisors(parent_rate, ndiv, fdiv, pdiv);
 }
-- 
2.11.0
