From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  1 Dec 2016 22:00:20 +0100
Subject: [PATCH 2/2] clk: bcm: Allow rate change propagation to PLLH_AUX on
 VEC clock
In-Reply-To: <1480626020-20031-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1480626020-20031-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1480626020-20031-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VEC clock requires needs to be set at exactly 108MHz. Allow rate
change propagation on PLLH_AUX to match this requirement wihtout
impacting other IPs (PLLH is currently only used by the HDMI encoder,
which cannot be enabled when the VEC encoder is enabled).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/clk/bcm/clk-bcm2835.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index df96fe6dadab..eaf82f49dede 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1861,7 +1861,12 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.ctl_reg = CM_VECCTL,
 		.div_reg = CM_VECDIV,
 		.int_bits = 4,
-		.frac_bits = 0),
+		.frac_bits = 0,
+		/*
+		 * Allow rate change propagation only on PLLH_AUX which is
+		 * assigned index 7 in the parent array.
+		 */
+		.set_rate_parent = BIT(7)),
 
 	/* dsi clocks */
 	[BCM2835_CLOCK_DSI0E]	= REGISTER_PER_CLK(
-- 
2.7.4
