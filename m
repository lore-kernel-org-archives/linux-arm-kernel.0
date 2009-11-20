From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 20 Nov 2009 17:50:34 +0100
Subject: [PATCH] ARM: PXA: CPUFREQ: Fix index assignments for end marker
Message-ID: <1258735834-23143-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I stumbled over two small things regarding the .index field assignment
in the dynamically created cpu frequency tables for pxa2xx and pxa3xx.

Even though that doesn't currently cause any problem, it should still be
fixed in case the logic in the CPUFREQ core changes.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/cpufreq-pxa2xx.c |    1 +
 arch/arm/mach-pxa/cpufreq-pxa3xx.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
index 983cc8c..9e4d981 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
@@ -447,6 +447,7 @@ static __init int pxa_cpufreq_init(struct cpufreq_policy *policy)
 		pxa27x_freq_table[i].frequency = freq;
 		pxa27x_freq_table[i].index = i;
 	}
+	pxa27x_freq_table[i].index = i;
 	pxa27x_freq_table[i].frequency = CPUFREQ_TABLE_END;
 
 	/*
diff --git a/arch/arm/mach-pxa/cpufreq-pxa3xx.c b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
index 67f34a8..149cdd9 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa3xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
@@ -102,7 +102,7 @@ static int setup_freqs_table(struct cpufreq_policy *policy,
 		table[i].index = i;
 		table[i].frequency = freqs[i].cpufreq_mhz * 1000;
 	}
-	table[num].frequency = i;
+	table[num].index = i;
 	table[num].frequency = CPUFREQ_TABLE_END;
 
 	pxa3xx_freqs = freqs;
-- 
1.6.5.2
