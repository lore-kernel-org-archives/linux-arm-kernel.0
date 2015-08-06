From: nm@ti.com (Nishanth Menon)
Date: Thu, 6 Aug 2015 10:54:24 -0500
Subject: [PATCH] ARM: OMAP5 / DRA7: Introduce workaround for 801819
Message-ID: <1438876464-15424-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add workaround for Cortex-A15 ARM erratum 801819 which says in summary
that "A livelock can occur in the L2 cache arbitration that might
prevent a snoop from completing. Under certain conditions this can
cause the system to deadlock. "

Recommended workaround is as follows:
Do both of the following:

1) Do not use the write-back no-allocate memory type.
2) Do not issue write-back cacheable stores at any time when the cache
is disabled (SCTLR.C=0) and the MMU is enabled (SCTLR.M=1). Because it
is implementation defined whether cacheable stores update the cache when
the cache is disabled it is not expected that any portable code will
execute cacheable stores when the cache is disabled.

For implementations of Cortex-A15 configured without the ?L2 arbitration
register slice? option (typically one or two core systems), you must
also do the following:

3) Disable write-streaming in each CPU by setting ACTLR[28:25] = 0b1111

So, we provide an option to disable write streaming on OMAP5 and DRA7.
It is a rare condition to occur and may be enabled selectively based
on platform acceptance of risk.

Applies to: A15 revisions r2p0, r2p1, r2p2, r2p3 or r2p4 and REVIDR[3]
is set to 0.

Based on ARM errata Document revision 18.0 (22 Nov 2013)

Note: the configuration for the workaround needs to be done with
each CPU bringup, since CPU0 bringup is done by bootloader, it is
recommended to have the workaround in the bootloader, kernel also does
ensure that CPU0 has the workaround and makes the workaround active
when CPU1 gets active.

With CONFIG_SMP disabled, it is expected to be done by the bootloader.

This does show significant degradation in synthetic tests such as
mbw (https://packages.qa.debian.org/m/mbw.html)
mbw -n 100 100|grep AVG (on a test platform)
Without enabling the erratum:
AVG Method: MEMCPY  Elapsed: 0.13406  MiB: 100.00000  Copy: 745.913 MiB/s
AVG Method: DUMB    Elapsed: 0.06746  MiB: 100.00000  Copy: 1482.357 MiB/s
AVG Method: MCBLOCK Elapsed: 0.03058  MiB: 100.00000  Copy: 3270.569 MiB/s
After enabling the erratum:
AVG Method: MEMCPY  Elapsed: 0.13757  MiB: 100.00000  Copy: 726.913 MiB/s
AVG Method: DUMB    Elapsed: 0.12024  MiB: 100.00000  Copy: 831.668 MiB/s
AVG Method: MCBLOCK Elapsed: 0.09243  MiB: 100.00000  Copy: 1081.942 MiB/s

Most benchmarks are designed for specific performance analysis, so
overall usecase must be considered before making a decision to
enable/disable the erratum workaround.

Pending internal investigation, the erratum is kept disabled by default.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tony Lindgren <tony@atomide.com>
Suggested-by: Richard Woodruff <r-woodruff2@ti.com>
Suggested-by: Brad Griffis <bgriffis@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Since this is a generic ARM erratum with potentially other SoCs
benefitting from a workaround.. the only problem with a generic
workaround, as far as I can see if the SoC specific smc based acr
modification. It will be great to get some direction in this front.

Also note:

We did notice that this erratum was discussed earlier [1] however,
with internal evaluation, it was summarized that this does impact our
SoCs.


[1] https://lists.linaro.org/pipermail/linaro-kernel/2013-June/004687.html
 arch/arm/mach-omap2/Kconfig       |  8 +++++++
 arch/arm/mach-omap2/omap-secure.h |  1 +
 arch/arm/mach-omap2/omap-smp.c    | 48 +++++++++++++++++++++++++++++++++++----
 3 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4a023e8d1bdb..b62835562ff0 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -245,4 +245,12 @@ endmenu
 
 endif
 
+config OMAP5_ERRATA_801819
+	bool "Errata 801819: An eviction from L1 data cache might stall indefinitely"
+	depends on SOC_OMAP5 || SOC_DRA7XX
+	help
+	  A livelock can occur in the L2 cache arbitration that might prevent
+	  a snoop from completing. Under certain conditions this can cause the
+	  system to deadlock.
+
 endmenu
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index af2851fbcdf0..bae263fba640 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -46,6 +46,7 @@
 
 #define OMAP5_DRA7_MON_SET_CNTFRQ_INDEX	0x109
 #define OMAP5_MON_AMBA_IF_INDEX		0x108
+#define OMAP5_DRA7_MON_SET_ACR_INDEX	0x107
 
 /* Secure PPA(Primary Protected Application) APIs */
 #define OMAP4_PPA_L2_POR_INDEX		0x23
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 5305ec7341ec..faaf366c220e 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -50,6 +50,39 @@ void __iomem *omap4_get_scu_base(void)
 	return scu_base;
 }
 
+#ifdef CONFIG_OMAP5_ERRATA_801819
+void omap5_erratum_workaround_801819(void)
+{
+	u32 acr, revidr;
+	u32 acr_mask;
+
+	/* REVIDR[3] indicates erratum fix available on silicon */
+	asm volatile ("mrc p15, 0, %0, c0, c0, 6" : "=r" (revidr));
+	if (revidr & (0x1 << 3))
+		return;
+
+	asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=r" (acr));
+	/*
+	 * BIT(27) - Disables streaming. All write-allocate lines allocate in
+	 * the L1 or L2 cache.
+	 * BIT(25) - Disables streaming. All write-allocate lines allocate in
+	 * the L1 cache.
+	 */
+	acr_mask = (0x3 << 25) | (0x3 << 27);
+	/* do we already have it done.. if yes, skip expensive smc */
+	if ((acr & acr_mask) == acr_mask)
+		return;
+
+	acr |= acr_mask;
+	omap_smc1(OMAP5_DRA7_MON_SET_ACR_INDEX, acr);
+
+	pr_debug("%s: ARM erratum workaround 801819 applied on CPU%d\n",
+		 __func__, smp_processor_id());
+}
+#else
+static inline void omap5_erratum_workaround_801819(void) { }
+#endif
+
 static void omap4_secondary_init(unsigned int cpu)
 {
 	/*
@@ -64,12 +97,15 @@ static void omap4_secondary_init(unsigned int cpu)
 		omap_secure_dispatcher(OMAP4_PPA_CPU_ACTRL_SMP_INDEX,
 							4, 0, 0, 0, 0, 0);
 
-	/*
-	 * Configure the CNTFRQ register for the secondary cpu's which
-	 * indicates the frequency of the cpu local timers.
-	 */
-	if (soc_is_omap54xx() || soc_is_dra7xx())
+	if (soc_is_omap54xx() || soc_is_dra7xx()) {
+		/*
+		 * Configure the CNTFRQ register for the secondary cpu's which
+		 * indicates the frequency of the cpu local timers.
+		 */
 		set_cntfreq();
+		/* Configure ACR to disable streaming WA for 801819 */
+		omap5_erratum_workaround_801819();
+	}
 
 	/*
 	 * Synchronise with the boot thread.
@@ -218,6 +254,8 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
 
 	if (cpu_is_omap446x())
 		startup_addr = omap4460_secondary_startup;
+	if (soc_is_dra74x() || soc_is_omap54xx())
+		omap5_erratum_workaround_801819();
 
 	/*
 	 * Write the address of secondary startup routine into the
-- 
2.1.4
