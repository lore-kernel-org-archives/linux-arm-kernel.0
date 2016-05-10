From: eric@anholt.net (Eric Anholt)
Date: Mon,  9 May 2016 18:01:29 -0700
Subject: [PATCH 2/3] clk: bcm2835: Mark GPIO clocks enabled at boot as
 critical.
In-Reply-To: <1462842090-2017-1-git-send-email-eric@anholt.net>
References: <1462842090-2017-1-git-send-email-eric@anholt.net>
Message-ID: <1462842090-2017-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These divide off of PLLD_PER and are used for the ethernet and wifi
PHYs source PLLs.  Neither of them is currently represented by a phy
device that would grab the clock for us.

This keeps other drivers from killing the networking PHYs when they
disable their own clocks and trigger PLLD_PER's refcount going to 0.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/clk/bcm/clk-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index d9db03cb3fd8..1091012ecec6 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1708,13 +1708,15 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.div_reg = CM_GP1DIV,
 		.int_bits = 12,
 		.frac_bits = 12,
+		.flags = CLK_IS_CRITICAL,
 		.is_mash_clock = true),
 	[BCM2835_CLOCK_GP2]	= REGISTER_PER_CLK(
 		.name = "gp2",
 		.ctl_reg = CM_GP2CTL,
 		.div_reg = CM_GP2DIV,
 		.int_bits = 12,
-		.frac_bits = 12),
+		.frac_bits = 12,
+		.flags = CLK_IS_CRITICAL),
 
 	/* HDMI state machine */
 	[BCM2835_CLOCK_HSM]	= REGISTER_PER_CLK(
-- 
2.8.0.rc3
