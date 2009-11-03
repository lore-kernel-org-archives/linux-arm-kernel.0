From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue,  3 Nov 2009 14:42:07 +0000
Subject: [PATCH 4/9] S3C64XX: Provide logging when CPU frequencies are
	eliminated due to clocks
In-Reply-To: <1257259332-7867-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1257259332-7867-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1257259332-7867-4-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This provides symmetry with the voltage based checks done for the
regulator.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-s3c64xx/cpufreq.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/cpufreq.c b/arch/arm/plat-s3c64xx/cpufreq.c
index e6e0843..bdc3c96 100644
--- a/arch/arm/plat-s3c64xx/cpufreq.c
+++ b/arch/arm/plat-s3c64xx/cpufreq.c
@@ -217,8 +217,11 @@ static int __init s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 		/* Check for frequencies we can generate */
 		r = clk_round_rate(armclk, freq->frequency * 1000);
 		r /= 1000;
-		if (r != freq->frequency)
+		if (r != freq->frequency) {
+			pr_debug("cpufreq: %dkHz unsupported by clock\n",
+				 freq->frequency);
 			freq->frequency = CPUFREQ_ENTRY_INVALID;
+		}
 
 		/* If we have no regulator then assume startup
 		 * frequency is the maximum we can support. */
-- 
1.6.5.2
