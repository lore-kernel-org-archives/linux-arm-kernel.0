From: eric@anholt.net (Eric Anholt)
Date: Wed, 13 Apr 2016 13:05:03 -0700
Subject: [PATCH v2 2/2] clk: bcm2835: Fix PLL poweron
In-Reply-To: <1460577903-32192-1-git-send-email-eric@anholt.net>
References: <1460577903-32192-1-git-send-email-eric@anholt.net>
Message-ID: <1460577903-32192-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In poweroff, we set the reset bit and the power down bit, but only
managed to unset the reset bit for poweron.  This meant that if HDMI
did -EPROBE_DEFER after it had grabbed its clocks, we'd power down the
PLLH (that had been on at boot time) and never recover.

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
Cc: stable at vger.kernel.org
---

v2: add fixes tag

 drivers/clk/bcm/clk-bcm2835.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 87616ded5bbe..7a7970865c2d 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -554,6 +554,10 @@ static int bcm2835_pll_on(struct clk_hw *hw)
 	const struct bcm2835_pll_data *data = pll->data;
 	ktime_t timeout;
 
+	cprman_write(cprman, data->a2w_ctrl_reg,
+		     cprman_read(cprman, data->a2w_ctrl_reg) &
+		     ~A2W_PLL_CTRL_PWRDN);
+
 	/* Take the PLL out of reset. */
 	cprman_write(cprman, data->cm_ctrl_reg,
 		     cprman_read(cprman, data->cm_ctrl_reg) & ~CM_PLL_ANARST);
-- 
2.8.0.rc3
