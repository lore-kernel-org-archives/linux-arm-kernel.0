From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 29 Aug 2016 14:26:56 +0200
Subject: [PATCH v3 04/14] drivers: clk: st: Add fs660c32 synthesizer algorithm
In-Reply-To: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
References: <1472473626-15398-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1472473626-15398-5-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Use an algorithm instead of a table to compute clocks for fs660c32
synthesizer.
During a video playback we need to adjust audio & video frequencies.
A table can't cover all HDMI resolutions and audio adjustment.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/clk/st/clkgen-fsyn.c | 180 ++++++++++++++++++++++++++-----------------
 1 file changed, 111 insertions(+), 69 deletions(-)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index 2f11bbd..14819d9 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -42,40 +42,6 @@ struct stm_fs {
 	unsigned long nsdiv;
 };
 
-static const struct stm_fs fs660c32_rtbl[] = {
-	{ .mdiv = 0x14, .pe = 0x376b,	.sdiv = 0x4,	.nsdiv = 1 },	/* 25.175  MHz */
-	{ .mdiv = 0x14, .pe = 0x30c3,	.sdiv = 0x4,	.nsdiv = 1 },	/* 25.200  MHz */
-	{ .mdiv = 0x10, .pe = 0x71c7,	.sdiv = 0x4,	.nsdiv = 1 },	/* 27.000  MHz */
-	{ .mdiv = 0x00, .pe = 0x47af,	.sdiv = 0x3,	.nsdiv = 0 },	/* 27.027  MHz */
-	{ .mdiv = 0x0e, .pe = 0x4e1a,	.sdiv = 0x4,	.nsdiv = 1 },	/* 28.320  MHz */
-	{ .mdiv = 0x0b, .pe = 0x534d,	.sdiv = 0x4,	.nsdiv = 1 },	/* 30.240  MHz */
-	{ .mdiv = 0x17, .pe = 0x6fbf,	.sdiv = 0x2,	.nsdiv = 0 },	/* 31.500  MHz */
-	{ .mdiv = 0x01, .pe = 0x0,	.sdiv = 0x4,	.nsdiv = 1 },	/* 40.000  MHz */
-	{ .mdiv = 0x15, .pe = 0x2aab,	.sdiv = 0x3,	.nsdiv = 1 },	/* 49.500  MHz */
-	{ .mdiv = 0x14, .pe = 0x6666,	.sdiv = 0x3,	.nsdiv = 1 },	/* 50.000  MHz */
-	{ .mdiv = 0x1d, .pe = 0x395f,	.sdiv = 0x1,	.nsdiv = 0 },	/* 57.284  MHz */
-	{ .mdiv = 0x08, .pe = 0x4ec5,	.sdiv = 0x3,	.nsdiv = 1 },	/* 65.000  MHz */
-	{ .mdiv = 0x05, .pe = 0x1770,	.sdiv = 0x3,	.nsdiv = 1 },	/* 71.000  MHz */
-	{ .mdiv = 0x03, .pe = 0x4ba7,	.sdiv = 0x3,	.nsdiv = 1 },	/* 74.176  MHz */
-	{ .mdiv = 0x0f, .pe = 0x3426,	.sdiv = 0x1,	.nsdiv = 0 },	/* 74.250  MHz */
-	{ .mdiv = 0x0e, .pe = 0x7777,	.sdiv = 0x1,	.nsdiv = 0 },	/* 75.000  MHz */
-	{ .mdiv = 0x01, .pe = 0x4053,	.sdiv = 0x3,	.nsdiv = 1 },	/* 78.800  MHz */
-	{ .mdiv = 0x09, .pe = 0x15b5,	.sdiv = 0x1,	.nsdiv = 0 },	/* 85.500  MHz */
-	{ .mdiv = 0x1b, .pe = 0x3f19,	.sdiv = 0x2,	.nsdiv = 1 },	/* 88.750  MHz */
-	{ .mdiv = 0x10, .pe = 0x71c7,	.sdiv = 0x2,	.nsdiv = 1 },	/* 108.000 MHz */
-	{ .mdiv = 0x00, .pe = 0x47af,	.sdiv = 0x1,	.nsdiv = 0 },	/* 108.108 MHz */
-	{ .mdiv = 0x0c, .pe = 0x3118,	.sdiv = 0x2,	.nsdiv = 1 },	/* 118.963 MHz */
-	{ .mdiv = 0x0c, .pe = 0x2f54,	.sdiv = 0x2,	.nsdiv = 1 },	/* 119.000 MHz */
-	{ .mdiv = 0x07, .pe = 0xe39,	.sdiv = 0x2,	.nsdiv = 1 },	/* 135.000 MHz */
-	{ .mdiv = 0x03, .pe = 0x4ba7,	.sdiv = 0x2,	.nsdiv = 1 },	/* 148.352 MHz */
-	{ .mdiv = 0x0f, .pe = 0x3426,	.sdiv = 0x0,	.nsdiv = 0 },	/* 148.500 MHz */
-	{ .mdiv = 0x03, .pe = 0x4ba7,	.sdiv = 0x1,	.nsdiv = 1 },	/* 296.704 MHz */
-	{ .mdiv = 0x03, .pe = 0x471c,	.sdiv = 0x1,	.nsdiv = 1 },	/* 297.000 MHz */
-	{ .mdiv = 0x00, .pe = 0x295f,	.sdiv = 0x1,	.nsdiv = 1 },	/* 326.700 MHz */
-	{ .mdiv = 0x1f, .pe = 0x3633,	.sdiv = 0x0,	.nsdiv = 1 },	/* 333.000 MHz */
-	{ .mdiv = 0x1c, .pe = 0x0,	.sdiv = 0x0,	.nsdiv = 1 },	/* 352.000 Mhz */
-};
-
 struct clkgen_quadfs_data {
 	bool reset_present;
 	bool bwfilter_present;
@@ -99,8 +65,7 @@ struct clkgen_quadfs_data {
 	struct clkgen_field nsdiv[QUADFS_MAX_CHAN];
 
 	const struct clk_ops *pll_ops;
-	const struct stm_fs *rtbl;
-	u8 rtbl_cnt;
+	int  (*get_params)(unsigned long, unsigned long, struct stm_fs *);
 	int  (*get_rate)(unsigned long , const struct stm_fs *,
 			unsigned long *);
 };
@@ -108,6 +73,8 @@ struct clkgen_quadfs_data {
 static const struct clk_ops st_quadfs_pll_c32_ops;
 static const struct clk_ops st_quadfs_fs660c32_ops;
 
+static int clk_fs660c32_dig_get_params(unsigned long input,
+		unsigned long output, struct stm_fs *fs);
 static int clk_fs660c32_dig_get_rate(unsigned long, const struct stm_fs *,
 		unsigned long *);
 
@@ -149,8 +116,7 @@ static const struct clkgen_quadfs_data st_fs660c32_C = {
 	.powerup_polarity = 1,
 	.standby_polarity = 1,
 	.pll_ops	= &st_quadfs_pll_c32_ops,
-	.rtbl		= fs660c32_rtbl,
-	.rtbl_cnt	= ARRAY_SIZE(fs660c32_rtbl),
+	.get_params	= clk_fs660c32_dig_get_params,
 	.get_rate	= clk_fs660c32_dig_get_rate,
 };
 
@@ -192,8 +158,7 @@ static const struct clkgen_quadfs_data st_fs660c32_D = {
 	.powerup_polarity = 1,
 	.standby_polarity = 1,
 	.pll_ops	= &st_quadfs_pll_c32_ops,
-	.rtbl		= fs660c32_rtbl,
-	.rtbl_cnt	= ARRAY_SIZE(fs660c32_rtbl),
+	.get_params	= clk_fs660c32_dig_get_params,
 	.get_rate	= clk_fs660c32_dig_get_rate,};
 
 /**
@@ -620,6 +585,107 @@ static int clk_fs660c32_dig_get_rate(unsigned long input,
 	return 0;
 }
 
+
+static int clk_fs660c32_get_pe(int m, int si, unsigned long *deviation,
+		signed long input, unsigned long output, uint64_t *p,
+		struct stm_fs *fs)
+{
+	unsigned long new_freq, new_deviation;
+	struct stm_fs fs_tmp;
+	uint64_t val;
+
+	val = (uint64_t)output << si;
+
+	*p = (uint64_t)input * P20 - (32LL  + (uint64_t)m) * val * (P20 / 32LL);
+
+	*p = div64_u64(*p, val);
+
+	if (*p > 32767LL)
+		return 1;
+
+	fs_tmp.mdiv = (unsigned long) m;
+	fs_tmp.pe = (unsigned long)*p;
+	fs_tmp.sdiv = si;
+	fs_tmp.nsdiv = 1;
+
+	clk_fs660c32_dig_get_rate(input, &fs_tmp, &new_freq);
+
+	new_deviation = abs(output - new_freq);
+
+	if (new_deviation < *deviation) {
+		fs->mdiv = m;
+		fs->pe = (unsigned long)*p;
+		fs->sdiv = si;
+		fs->nsdiv = 1;
+		*deviation = new_deviation;
+	}
+	return 0;
+}
+
+static int clk_fs660c32_dig_get_params(unsigned long input,
+		unsigned long output, struct stm_fs *fs)
+{
+	int si;	/* sdiv_reg (8 downto 0) */
+	int m; /* md value */
+	unsigned long new_freq, new_deviation;
+	/* initial condition to say: "infinite deviation" */
+	unsigned long deviation = ~0;
+	uint64_t p, p1, p2;	/* pe value */
+	int r1, r2;
+
+	struct stm_fs fs_tmp;
+
+	for (si = 0; (si <= 8) && deviation; si++) {
+
+		/* Boundary test to avoid useless iteration */
+		r1 = clk_fs660c32_get_pe(0, si, &deviation,
+				input, output, &p1, fs);
+		r2 = clk_fs660c32_get_pe(31, si, &deviation,
+				input, output, &p2, fs);
+
+		/* No solution */
+		if (r1 && r2 && (p1 > p2))
+			continue;
+
+		/* Try to find best deviation */
+		for (m = 1; (m < 31) && deviation; m++)
+			clk_fs660c32_get_pe(m, si, &deviation,
+					input, output, &p, fs);
+
+	}
+
+	if (deviation == ~0) /* No solution found */
+		return -1;
+
+	/* pe fine tuning if deviation not 0: +/- 2 around computed pe value */
+	if (deviation) {
+		fs_tmp.mdiv = fs->mdiv;
+		fs_tmp.sdiv = fs->sdiv;
+		fs_tmp.nsdiv = fs->nsdiv;
+
+		if (fs->pe > 2)
+			p2 = fs->pe - 2;
+		else
+			p2 = 0;
+
+		for (; p2 < 32768ll && (p2 <= (fs->pe + 2)); p2++) {
+			fs_tmp.pe = (unsigned long)p2;
+
+			clk_fs660c32_dig_get_rate(input, &fs_tmp, &new_freq);
+
+			new_deviation = abs(output - new_freq);
+
+			/* Check if this is a better solution */
+			if (new_deviation < deviation) {
+				fs->pe = (unsigned long)p2;
+				deviation = new_deviation;
+
+			}
+		}
+	}
+	return 0;
+}
+
 static int quadfs_fsynt_get_hw_value_for_recalc(struct st_clk_quadfs_fsynth *fs,
 		struct stm_fs *params)
 {
@@ -655,38 +721,14 @@ static long quadfs_find_best_rate(struct clk_hw *hw, unsigned long drate,
 	struct st_clk_quadfs_fsynth *fs = to_quadfs_fsynth(hw);
 	int (*clk_fs_get_rate)(unsigned long ,
 				const struct stm_fs *, unsigned long *);
-	struct stm_fs prev_params;
-	unsigned long prev_rate, rate = 0;
-	unsigned long diff_rate, prev_diff_rate = ~0;
-	int index;
+	int (*clk_fs_get_params)(unsigned long, unsigned long, struct stm_fs *);
+	unsigned long rate = 0;
 
 	clk_fs_get_rate = fs->data->get_rate;
+	clk_fs_get_params = fs->data->get_params;
 
-	for (index = 0; index < fs->data->rtbl_cnt; index++) {
-		prev_rate = rate;
-
-		*params = fs->data->rtbl[index];
-		prev_params = *params;
-
-		clk_fs_get_rate(prate, &fs->data->rtbl[index], &rate);
-
-		diff_rate = abs(drate - rate);
-
-		if (diff_rate > prev_diff_rate) {
-			rate = prev_rate;
-			*params = prev_params;
-			break;
-		}
-
-		prev_diff_rate = diff_rate;
-
-		if (drate == rate)
-			return rate;
-	}
-
-
-	if (index == fs->data->rtbl_cnt)
-		*params = prev_params;
+	if (!clk_fs_get_params(prate, drate, params))
+		clk_fs_get_rate(prate, params, &rate);
 
 	return rate;
 }
-- 
1.9.1
