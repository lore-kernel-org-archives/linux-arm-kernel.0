From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu,  1 Dec 2016 18:15:16 +0100
Subject: [PATCH 3/3] ARM: da850: fix da850_set_pll0rate()
In-Reply-To: <1480612516-18853-1-git-send-email-bgolaszewski@baylibre.com>
References: <1480612516-18853-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1480612516-18853-4-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is broken - its second argument is an index to the freq
table, not the requested clock rate in Hz. It leads to an oops when
called from clk_set_rate() since this argument isn't bounds checked
either.

Fix it by iterating over the array of supported frequencies and
selecting a one that matches or returning -EINVAL for unsupported
rates.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 855b720..1c0f296 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1173,14 +1173,28 @@ static int da850_set_armrate(struct clk *clk, unsigned long index)
 	return clk_set_rate(pllclk, index);
 }
 
-static int da850_set_pll0rate(struct clk *clk, unsigned long index)
+static int da850_set_pll0rate(struct clk *clk, unsigned long requested_rate)
 {
-	unsigned int prediv, mult, postdiv;
-	struct da850_opp *opp;
 	struct pll_data *pll = clk->pll_data;
+	struct cpufreq_frequency_table *freq;
+	unsigned int prediv, mult, postdiv;
+	struct da850_opp *opp = NULL;
 	int ret;
 
-	opp = (struct da850_opp *) cpufreq_info.freq_table[index].driver_data;
+	for (freq = da850_freq_table;
+	     freq->frequency != CPUFREQ_TABLE_END; freq++) {
+		/* requested_rate is in Hz, freq->frequency is in KHz */
+		unsigned long freq_rate = freq->frequency * 1000;
+
+		if (freq_rate == requested_rate) {
+			opp = (struct da850_opp *)freq->driver_data;
+			break;
+		}
+	}
+
+	if (opp == NULL)
+		return -EINVAL;
+
 	prediv = opp->prediv;
 	mult = opp->mult;
 	postdiv = opp->postdiv;
-- 
2.9.3
