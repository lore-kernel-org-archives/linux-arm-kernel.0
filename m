From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 29 Jul 2015 16:23:08 +0530
Subject: [PATCH V3 13/16] cpufreq: Update boost flag while initializing freq
 table from OPPs
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Message-ID: <62971ce19528d707b89e6521f50779fef3ecf145.1438166099.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

cpufreq table entries for OPPs with turbo modes enabled, should be
marked with CPUFREQ_BOOST_FREQ flag. This ensures that these states are
only used while operating in boost or turbo mode.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_opp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_opp.c b/drivers/cpufreq/cpufreq_opp.c
index 773bcde893c0..0f5e6d5f6da0 100644
--- a/drivers/cpufreq/cpufreq_opp.c
+++ b/drivers/cpufreq/cpufreq_opp.c
@@ -75,6 +75,10 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 		}
 		freq_table[i].driver_data = i;
 		freq_table[i].frequency = rate / 1000;
+
+		/* Is Boost/turbo opp ? */
+		if (dev_pm_opp_is_turbo(opp))
+			freq_table[i].flags = CPUFREQ_BOOST_FREQ;
 	}
 
 	freq_table[i].driver_data = i;
-- 
2.4.0
