From: emil@limesaudio.com (Emil Lundmark)
Date: Mon, 10 Oct 2016 12:03:05 +0200
Subject: [PATCH v2 1/2] clk: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <cover.1476092427.git.emil@limesaudio.com>
References: <cover.1476092427.git.emil@limesaudio.com>
Message-ID: <4e8696869cc82443825a590966bbd3a265befdfa.1476092427.git.emil@limesaudio.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 'parent_rate * mfn' may overflow 32 bits, the result should be
stored using 64 bits.

Fixes: ba7f4f557eb6 ("clk: imx: correct AV PLL rate formula")
Signed-off-by: Emil Lundmark <emil@limesaudio.com>
---
 drivers/clk/imx/clk-pllv3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 19f9b622981a..bc7f163ea13c 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -247,7 +247,11 @@ static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
 	do_div(temp64, parent_rate);
 	mfn = temp64;
 
-	return parent_rate * div + parent_rate * mfn / mfd;
+	temp64 = (u64)parent_rate;
+	temp64 *= mfn;
+	do_div(temp64, mfd);
+
+	return parent_rate * div + (u32)temp64;
 }
 
 static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.7.4
