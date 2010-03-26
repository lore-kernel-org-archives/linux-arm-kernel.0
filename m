From: mroberto@cpti.cetuc.puc-rio.br (Marcelo Roberto Jimenez)
Date: Fri, 26 Mar 2010 18:53:11 -0300
Subject: [PATCH 2/2] ARM: mach-sa1100: fix checkpatch.pl issues.
In-Reply-To: <1269640391-23451-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
References: <1269640391-23451-1-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
Message-ID: <1269640391-23451-2-git-send-email-mroberto@cpti.cetuc.puc-rio.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes checkpatch.pl issues in
arch/arm/mach-sa1100/cpu-sa1110.c

Signed-off-by: Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
---
 arch/arm/mach-sa1100/cpu-sa1110.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-sa1100/cpu-sa1110.c b/arch/arm/mach-sa1100/cpu-sa1110.c
index 7236fcd..bf1fa37 100644
--- a/arch/arm/mach-sa1100/cpu-sa1110.c
+++ b/arch/arm/mach-sa1100/cpu-sa1110.c
@@ -187,11 +187,13 @@ sdram_calculate_timing(struct sdram_info *sd, u_int cpu_khz,
 		sd->mdrefr |= MDREFR_K1DB2;
 
 	/* initial number of '1's in MDCAS + 1 */
-	set_mdcas(sd->mdcas, sd_khz >= 62000, ns_to_cycles(sdram->trcd, mem_khz));
+	set_mdcas(sd->mdcas, sd_khz >= 62000,
+		ns_to_cycles(sdram->trcd, mem_khz));
 
 #ifdef DEBUG
-	printk("MDCNFG: %08x MDREFR: %08x MDCAS0: %08x MDCAS1: %08x MDCAS2: %08x\n",
-		sd->mdcnfg, sd->mdrefr, sd->mdcas[0], sd->mdcas[1], sd->mdcas[2]);
+	printk(KERN_DEBUG "MDCNFG: %08x MDREFR: %08x MDCAS0: %08x MDCAS1: %08x MDCAS2: %08x\n",
+		sd->mdcnfg, sd->mdrefr, sd->mdcas[0], sd->mdcas[1],
+		sd->mdcas[2]);
 #endif
 }
 
@@ -220,7 +222,7 @@ sdram_update_refresh(u_int cpu_khz, struct sdram_params *sdram)
 
 #ifdef DEBUG
 	mdelay(250);
-	printk("new dri value = %d\n", dri);
+	printk(KERN_DEBUG "new dri value = %d\n", dri);
 #endif
 
 	sdram_set_refresh(dri);
@@ -239,7 +241,7 @@ static int sa1110_target(struct cpufreq_policy *policy,
 	unsigned long flags;
 	unsigned int ppcr, unused;
 
-	switch(relation){
+	switch (relation) {
 	case CPUFREQ_RELATION_L:
 		ppcr = sa11x0_freq_to_ppcr(target_freq);
 		if (sa11x0_ppcr_to_freq(ppcr) > policy->max)
@@ -287,11 +289,10 @@ static int sa1110_target(struct cpufreq_policy *policy,
 	 * We wait 20ms to be safe.
 	 */
 	sdram_set_refresh(2);
-	if (!irqs_disabled()) {
+	if (!irqs_disabled())
 		msleep(20);
-	} else {
+	else
 		mdelay(20);
-	}
 
 	/*
 	 * Reprogram the DRAM timings with interrupts disabled, and
@@ -302,7 +303,7 @@ static int sa1110_target(struct cpufreq_policy *policy,
 	local_irq_save(flags);
 	asm("mcr p15, 0, %0, c7, c10, 4" : : "r" (0));
 	udelay(10);
-	__asm__ __volatile__("					\n\
+	__asm__ __volatile__("\n\
 		b	2f					\n\
 		.align	5					\n\
 1:		str	%3, [%1, #0]		@ MDCNFG	\n\
@@ -356,7 +357,8 @@ static struct sdram_params *sa1110_find_sdram(const char *name)
 {
 	struct sdram_params *sdram;
 
-	for (sdram = sdram_tbl; sdram < sdram_tbl + ARRAY_SIZE(sdram_tbl); sdram++)
+	for (sdram = sdram_tbl; sdram < sdram_tbl + ARRAY_SIZE(sdram_tbl);
+	     sdram++)
 		if (strcmp(name, sdram->name) == 0)
 			return sdram;
 
@@ -378,7 +380,7 @@ static int __init sa1110_clk_init(void)
 		if (machine_is_h3100())
 			name = "KM416S4030CT";
 		if (machine_is_jornada720())
-		        name = "K4S281632B-1H";
+			name = "K4S281632B-1H";
 		if (machine_is_nanoengine())
 			name = "MT48LC8M16A2TG-75";
 	}
-- 
1.7.0.3
