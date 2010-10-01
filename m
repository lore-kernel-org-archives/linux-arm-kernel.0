From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:28 -0700
Subject: [PATCH 04/47] davinci: cpufreq: bailout on regulator errors
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-5-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Current cpufreq code does not consider errors that can occur while
changing voltage. Code to increase CPU  frequency goes ahead even in
the case the regulator has failed to increase the voltage. This leads
to hard error since lower voltages cannot support increased frequency.

Prevent this by not increasing frequency in case increasing voltage
is not successful.

Also, do not lower the voltage if changing the cpu frequency has failed
for some reason.

Note that we do not return error on failure to decrease voltage as
that is not a hard error.

Build fix for non-cpufreq kernels by Caglar Akyuz.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Cc: Caglar Akyuz <caglar@bilkon-kontrol.com.tr>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/cpufreq.c |   10 ++++++++--
 arch/arm/mach-davinci/da850.c   |    2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/cpufreq.c b/arch/arm/mach-davinci/cpufreq.c
index d3fa6de..bc80142 100644
--- a/arch/arm/mach-davinci/cpufreq.c
+++ b/arch/arm/mach-davinci/cpufreq.c
@@ -104,15 +104,21 @@ static int davinci_target(struct cpufreq_policy *policy,
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
 	/* if moving to higher frequency, up the voltage beforehand */
-	if (pdata->set_voltage && freqs.new > freqs.old)
-		pdata->set_voltage(idx);
+	if (pdata->set_voltage && freqs.new > freqs.old) {
+		ret = pdata->set_voltage(idx);
+		if (ret)
+			goto out;
+	}
 
 	ret = clk_set_rate(armclk, idx);
+	if (ret)
+		goto out;
 
 	/* if moving to lower freq, lower the voltage after lowering freq */
 	if (pdata->set_voltage && freqs.new < freqs.old)
 		pdata->set_voltage(idx);
 
+out:
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	return ret;
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 68ed58a..868227e 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -983,7 +983,7 @@ static int da850_set_pll0rate(struct clk *clk, unsigned long index)
 	return 0;
 }
 #else
-int __init da850_register_cpufreq(void)
+int __init da850_register_cpufreq(char *async_clk)
 {
 	return 0;
 }
-- 
1.7.2.1
