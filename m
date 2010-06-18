From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 18 Jun 2010 07:48:52 +0200
Subject: [PATCH 1/4] pxa2xx/cpufreq: Simplify CPU frequency change asm
Message-ID: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch does the following changes to cpufreq-pxa2xx:
1) Simplifies the assembler code for frequency change
2) Reads back the MDREFR value to make sure data latched
3) Does as little operations in lock as possible

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/cpufreq-pxa2xx.c |   35 ++++++++++++++++-------------------
 1 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
index 9e4d981..1949850 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
@@ -297,7 +297,7 @@ static int pxa_set_target(struct cpufreq_policy *policy,
 	unsigned int idx;
 	unsigned long flags;
 	unsigned int new_freq_cpu, new_freq_mem;
-	unsigned int unused, preset_mdrefr, postset_mdrefr, cclkcfg;
+	unsigned int preset_mdrefr, postset_mdrefr, cclkcfg;
 	int ret = 0;
 
 	/* Get the current policy */
@@ -355,29 +355,26 @@ static int pxa_set_target(struct cpufreq_policy *policy,
 		postset_mdrefr &= ~MDREFR_DB2_MASK;
 	}
 
+	/* Prepare CCLKCFG */
+	cclkcfg = pxa_freq_settings[idx].cclkcfg;
+
 	local_irq_save(flags);
 
-	/* Set new the CCCR and prepare CCLKCFG */
+	/* Set new the CCCR */
 	CCCR = pxa_freq_settings[idx].cccr;
-	cclkcfg = pxa_freq_settings[idx].cclkcfg;
 
 	asm volatile("							\n\
-		ldr	r4, [%1]		/* load MDREFR */	\n\
-		b	2f						\n\
-		.align	5						\n\
-1:									\n\
-		str	%3, [%1]		/* preset the MDREFR */	\n\
-		mcr	p14, 0, %2, c6, c0, 0	/* set CCLKCFG[FCS] */	\n\
-		str	%4, [%1]		/* postset the MDREFR */ \n\
-									\n\
-		b	3f						\n\
-2:		b	1b						\n\
-3:		nop							\n\
-	  "
-		     : "=&r" (unused)
-		     : "r" (&MDREFR), "r" (cclkcfg),
-		       "r" (preset_mdrefr), "r" (postset_mdrefr)
-		     : "r4", "r5");
+		.align	5		/* align to cache line */	\n\
+		str	%2, [%0]	/* preset the MDREFR */		\n\
+		ldr	r4, [%0]	/* make sure data latched */	\n\
+		mcr	p14, 0, %1, c6, c0, 0	/* set CCLKCFG[FCS] */	\n\
+		str	%3, [%0]	/* postset the MDREFR */	\n\
+		ldr	r4, [%0]	/* make sure data latched */	\n\
+	"
+		:: "r" (&MDREFR), "r" (cclkcfg),
+		   "r" (preset_mdrefr), "r" (postset_mdrefr)
+		: "r4");
+
 	local_irq_restore(flags);
 
 	/*
-- 
1.7.1
