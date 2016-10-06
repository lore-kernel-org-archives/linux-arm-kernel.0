From: emil@limesaudio.com (Emil Lundmark)
Date: Thu,  6 Oct 2016 13:12:11 +0200
Subject: [PATCH 2/2] ARM: imx: improve precision of AV PLL to 1 Hz
In-Reply-To: <1475752331-19525-1-git-send-email-emil@limesaudio.com>
References: <1475752331-19525-1-git-send-email-emil@limesaudio.com>
Message-ID: <1475752331-19525-2-git-send-email-emil@limesaudio.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audio and video PLLs are designed to have a precision of 1 Hz if some
conditions are met. The current implementation only allows a precision that
depends on the rate of the parent clock. E.g., if the parent clock is 24
MHz, the precision will be 24 Hz; or more generally the precision will be

    p / 10^6 Hz

where p is the parent clock rate. This comes down to how the register
values for the PLL's fractional loop divider is chosen.

The clock rate calculation for the PLL is

    PLL output frequency = Fref * (DIV_SELECT + NUM / DENOM)

or with a shorter notation

    r = p * (d + a / b)

In addition to all variables being integers, we also have the following
conditions:

    27 <= d <= 54

    0 <= a <= 2^30-1
    0 <  b <= 2^30-1
    a < b

Here, d, a and b are register values for the fractional loop divider. We
want to chose d, a and b such that f(p, r) = p, i.e. f is our round_rate
function. Currently, d and b are chosen as

    d = r / p
    b = 10^6

hence we get the poor precision. And a is defined in terms of r, d, p and
b:

    a = (r - d * p) * b / p

I propose that if p <= 2^30-1 (i.e., the max value for b), we chose b as

    b = p

The rationale behind this is that if b = p:

    a = (r - d * p) * b / p
      = (r - d * p) * p / p
      = r - d * p

    r = p * (d + a / b)
      = p * d + p * a / b
      = p * d + p * a / p
      = p * d + a

and if d = r / p:

    a = r - d * p
      = r - r / p * p
      = 0

    r = p * d + a
      = p * d + 0
      = p * r / p
      = r

I reckon this is the intention by the design of the clock rate formula.

Signed-off-by: Emil Lundmark <emil@limesaudio.com>
---
 drivers/clk/imx/clk-pllv3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index bc7f163..5ff55ff 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -234,6 +234,7 @@ static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long max_rate = parent_rate * 54;
 	u32 div;
 	u32 mfn, mfd = 1000000;
+	u32 max_mfd = 0x3FFFFFFF;
 	u64 temp64;
 
 	if (rate > max_rate)
@@ -241,6 +242,9 @@ static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
 	else if (rate < min_rate)
 		rate = min_rate;
 
+	if (parent_rate <= max_mfd)
+		mfd = parent_rate;
+
 	div = rate / parent_rate;
 	temp64 = (u64) (rate - div * parent_rate);
 	temp64 *= mfd;
@@ -262,11 +266,15 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long max_rate = parent_rate * 54;
 	u32 val, div;
 	u32 mfn, mfd = 1000000;
+	u32 max_mfd = 0x3FFFFFFF;
 	u64 temp64;
 
 	if (rate < min_rate || rate > max_rate)
 		return -EINVAL;
 
+	if (parent_rate <= max_mfd)
+		mfd = parent_rate;
+
 	div = rate / parent_rate;
 	temp64 = (u64) (rate - div * parent_rate);
 	temp64 *= mfd;
-- 
2.7.4
