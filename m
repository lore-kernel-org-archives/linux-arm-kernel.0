From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Feb 2016 11:19:10 +0100
Subject: [PATCH] clk: vt8500: don't return possibly uninitialized data
Message-ID: <4790407.6zgSQCdsSB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk-vt8500.c driver would previously enter an endless loop
when invalid settings got requested, this was now fixed. However,
the driver will now return uninitialized data for a subset of those
cases instead, as the gcc correctly warns:

clk/clk-vt8500.c: In function 'wm8650_find_pll_bits':
clk/clk-vt8500.c:423:12: error: 'best_div2' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  *divisor2 = best_div2;
            ^
clk/clk-vt8500.c:422:12: error: 'best_div1' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  *divisor1 = best_div1;
            ^
clk/clk-vt8500.c:421:14: error: 'best_mul' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  *multiplier = best_mul;

This reworks the error handling in the driver so we now return
-EINVAL from clk_round_rate() and clk_set_rate() when we get
impossible inputs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 090341b0a95d ("clk: vt8500: fix sign of possible PLL values")

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index 98c4492d2c0d..b0f76a84f1e9 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -355,7 +355,7 @@ CLK_OF_DECLARE(vt8500_device, "via,vt8500-device-clock", vtwm_device_clk_init);
 #define WM8850_BITS_TO_VAL(m, d1, d2)					\
 		((((m / 2) - 1) << 16) | ((d1 - 1) << 8) | d2)
 
-static void vt8500_find_pll_bits(unsigned long rate, unsigned long parent_rate,
+static int vt8500_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 				u32 *multiplier, u32 *prediv)
 {
 	unsigned long tclk;
@@ -365,7 +365,7 @@ static void vt8500_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 		pr_err("%s: requested rate out of range\n", __func__);
 		*multiplier = 0;
 		*prediv = 1;
-		return;
+		return -EINVAL;
 	}
 	if (rate <= parent_rate * 31)
 		/* use the prediv to double the resolution */
@@ -379,9 +379,11 @@ static void vt8500_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 	if (tclk != rate)
 		pr_warn("%s: requested rate %lu, found rate %lu\n", __func__,
 								rate, tclk);
+
+	return 0;
 }
 
-static void wm8650_find_pll_bits(unsigned long rate, unsigned long parent_rate,
+static int wm8650_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 				u32 *multiplier, u32 *divisor1, u32 *divisor2)
 {
 	u32 mul, div1;
@@ -404,7 +406,7 @@ static void wm8650_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 					*multiplier = mul;
 					*divisor1 = div1;
 					*divisor2 = div2;
-					return;
+					return 0;
 				}
 
 				if (rate_err < best_err) {
@@ -415,12 +417,19 @@ static void wm8650_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 				}
 			}
 
+	if (best_err == (unsigned long)-1) {
+		pr_warn("%s: impossible rate %lu\n", __func__, rate);
+		return -EINVAL;
+	}
+
 	/* if we got here, it wasn't an exact match */
 	pr_warn("%s: requested rate %lu, found rate %lu\n", __func__, rate,
 							rate - best_err);
 	*multiplier = best_mul;
 	*divisor1 = best_div1;
 	*divisor2 = best_div2;
+
+	return 0;
 }
 
 static u32 wm8750_get_filter(u32 parent_rate, u32 divisor1)
@@ -450,7 +459,7 @@ static u32 wm8750_get_filter(u32 parent_rate, u32 divisor1)
 	return 0;
 }
 
-static void wm8750_find_pll_bits(unsigned long rate, unsigned long parent_rate,
+static int wm8750_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 				u32 *filter, u32 *multiplier, u32 *divisor1, u32 *divisor2)
 {
 	u32 mul;
@@ -474,7 +483,7 @@ static void wm8750_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 					*multiplier = mul;
 					*divisor1 = div1;
 					*divisor2 = div2;
-					return;
+					return 0;
 				}
 
 				if (rate_err < best_err) {
@@ -485,6 +494,11 @@ static void wm8750_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 				}
 			}
 
+	if (best_err == (unsigned long)-1) {
+		pr_warn("%s: impossible rate %lu\n", __func__, rate);
+		return -EINVAL;
+	}
+
 	/* if we got here, it wasn't an exact match */
 	pr_warn("%s: requested rate %lu, found rate %lu\n", __func__, rate,
 							rate - best_err);
@@ -493,9 +507,11 @@ static void wm8750_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 	*multiplier = best_mul;
 	*divisor1 = best_div1;
 	*divisor2 = best_div2;
+
+	return 0;
 }
 
-static void wm8850_find_pll_bits(unsigned long rate, unsigned long parent_rate,
+static int wm8850_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 				u32 *multiplier, u32 *divisor1, u32 *divisor2)
 {
 	u32 mul;
@@ -519,7 +535,7 @@ static void wm8850_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 					*multiplier = mul;
 					*divisor1 = div1;
 					*divisor2 = div2;
-					return;
+					return 0;
 				}
 
 				if (rate_err < best_err) {
@@ -530,6 +546,11 @@ static void wm8850_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 				}
 			}
 
+	if (best_err == (unsigned long)-1) {
+		pr_warn("%s: impossible rate %lu\n", __func__, rate);
+		return -EINVAL;
+	}
+
 	/* if we got here, it wasn't an exact match */
 	pr_warn("%s: requested rate %lu, found rate %lu\n", __func__, rate,
 							rate - best_err);
@@ -537,6 +558,8 @@ static void wm8850_find_pll_bits(unsigned long rate, unsigned long parent_rate,
 	*multiplier = best_mul;
 	*divisor1 = best_div1;
 	*divisor2 = best_div2;
+
+	return 0;
 }
 
 static int vtwm_pll_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -546,31 +569,39 @@ static int vtwm_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 filter, mul, div1, div2;
 	u32 pll_val;
 	unsigned long flags = 0;
+	int ret;
 
 	/* sanity check */
 
 	switch (pll->type) {
 	case PLL_TYPE_VT8500:
-		vt8500_find_pll_bits(rate, parent_rate, &mul, &div1);
-		pll_val = VT8500_BITS_TO_VAL(mul, div1);
+		ret = vt8500_find_pll_bits(rate, parent_rate, &mul, &div1);
+		if (!ret)
+			pll_val = VT8500_BITS_TO_VAL(mul, div1);
 		break;
 	case PLL_TYPE_WM8650:
-		wm8650_find_pll_bits(rate, parent_rate, &mul, &div1, &div2);
-		pll_val = WM8650_BITS_TO_VAL(mul, div1, div2);
+		ret = wm8650_find_pll_bits(rate, parent_rate, &mul, &div1, &div2);
+		if (!ret)
+			pll_val = WM8650_BITS_TO_VAL(mul, div1, div2);
 		break;
 	case PLL_TYPE_WM8750:
-		wm8750_find_pll_bits(rate, parent_rate, &filter, &mul, &div1, &div2);
-		pll_val = WM8750_BITS_TO_VAL(filter, mul, div1, div2);
+		ret = wm8750_find_pll_bits(rate, parent_rate, &filter, &mul, &div1, &div2);
+		if (!ret)
+			pll_val = WM8750_BITS_TO_VAL(filter, mul, div1, div2);
 		break;
 	case PLL_TYPE_WM8850:
-		wm8850_find_pll_bits(rate, parent_rate, &mul, &div1, &div2);
-		pll_val = WM8850_BITS_TO_VAL(mul, div1, div2);
+		ret = wm8850_find_pll_bits(rate, parent_rate, &mul, &div1, &div2);
+		if (!ret)
+			pll_val = WM8850_BITS_TO_VAL(mul, div1, div2);
 		break;
 	default:
 		pr_err("%s: invalid pll type\n", __func__);
-		return 0;
+		ret = -EINVAL;
 	}
 
+	if (ret)
+		return ret;
+
 	spin_lock_irqsave(pll->lock, flags);
 
 	vt8500_pmc_wait_busy();
@@ -588,28 +619,36 @@ static long vtwm_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_pll *pll = to_clk_pll(hw);
 	u32 filter, mul, div1, div2;
 	long round_rate;
+	int ret;
 
 	switch (pll->type) {
 	case PLL_TYPE_VT8500:
-		vt8500_find_pll_bits(rate, *prate, &mul, &div1);
-		round_rate = VT8500_BITS_TO_FREQ(*prate, mul, div1);
+		ret = vt8500_find_pll_bits(rate, *prate, &mul, &div1);
+		if (!ret)
+			round_rate = VT8500_BITS_TO_FREQ(*prate, mul, div1);
 		break;
 	case PLL_TYPE_WM8650:
-		wm8650_find_pll_bits(rate, *prate, &mul, &div1, &div2);
-		round_rate = WM8650_BITS_TO_FREQ(*prate, mul, div1, div2);
+		ret = wm8650_find_pll_bits(rate, *prate, &mul, &div1, &div2);
+		if (!ret)
+			round_rate = WM8650_BITS_TO_FREQ(*prate, mul, div1, div2);
 		break;
 	case PLL_TYPE_WM8750:
-		wm8750_find_pll_bits(rate, *prate, &filter, &mul, &div1, &div2);
-		round_rate = WM8750_BITS_TO_FREQ(*prate, mul, div1, div2);
+		ret = wm8750_find_pll_bits(rate, *prate, &filter, &mul, &div1, &div2);
+		if (!ret)
+			round_rate = WM8750_BITS_TO_FREQ(*prate, mul, div1, div2);
 		break;
 	case PLL_TYPE_WM8850:
-		wm8850_find_pll_bits(rate, *prate, &mul, &div1, &div2);
-		round_rate = WM8850_BITS_TO_FREQ(*prate, mul, div1, div2);
+		ret = wm8850_find_pll_bits(rate, *prate, &mul, &div1, &div2);
+		if (!ret)
+			round_rate = WM8850_BITS_TO_FREQ(*prate, mul, div1, div2);
 		break;
 	default:
-		round_rate = 0;
+		ret = -EINVAL;
 	}
 
+	if (ret)
+		return ret;
+
 	return round_rate;
 }
 
