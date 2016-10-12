From: emil@limesaudio.com (Emil Lundmark)
Date: Wed, 12 Oct 2016 12:31:40 +0200
Subject: [PATCH v3 1/2] clk: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <cover.1476267249.git.emil@limesaudio.com>
References: <cover.1476267249.git.emil@limesaudio.com>
Message-ID: <4d2e3a91dfb74209735c940b51d7efc9ba2ed69b.1476267249.git.emil@limesaudio.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 'parent_rate * mfn' may overflow 32 bits, the result should be
stored using 64 bits.

The problem was discovered when trying to set the rate of the audio PLL
(pll4_post_div) on an i.MX6Q. The desired rate was 196.608 MHz, but
the actual rate returned was 192.000570 MHz. The round rate function should
have been able to return 196.608 MHz, i.e., the desired rate.

Fixes: ba7f4f557eb6 ("clk: imx: correct AV PLL rate formula")
Cc: Anson Huang <b20788@freescale.com>
Signed-off-by: Emil Lundmark <emil@limesaudio.com>
---
 drivers/clk/imx/clk-pllv3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 19f9b622981a..7a6acc3e4a92 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -223,7 +223,7 @@ static unsigned long clk_pllv3_av_recalc_rate(struct clk_hw *hw,
 	temp64 *= mfn;
 	do_div(temp64, mfd);
 
-	return (parent_rate * div) + (u32)temp64;
+	return parent_rate * div + (unsigned long)temp64;
 }
 
 static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -247,7 +247,11 @@ static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
 	do_div(temp64, parent_rate);
 	mfn = temp64;
 
-	return parent_rate * div + parent_rate * mfn / mfd;
+	temp64 = (u64)parent_rate;
+	temp64 *= mfn;
+	do_div(temp64, mfd);
+
+	return parent_rate * div + (unsigned long)temp64;
 }
 
 static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.7.4
