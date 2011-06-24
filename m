From: premi@ti.com (Sanjeev Premi)
Date: Fri, 24 Jun 2011 19:23:38 +0530
Subject: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Message-ID: <1308923618-5333-1-git-send-email-premi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, loops_per_jiffy is being calculated twice for
non-SMP processors.
 - Before calling cpufreq_notify_transition()
 - From within cpufreq_notify_transition()

Double adjustment leads to incorrect value being assigned to
loops_per_jiffy. This manifests as incorrect BogoMIPS in
"cat /proc/cpuinfo".

The value of loops_per_jiffy needs to be calculated only
when CONFIG_SMP is true. It is the core change included
in this patch.

The patch also leverages the definition of for_each_cpu()
with and without CONFIG_SMP to consolidate the mechanism
to call cpufreq_notify_transition().

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 Changes since v1:
   * loops_per_jiffy are updated when CONFIG_SMP is true.
   * leverage definition of for_each_cpu()

 Tested on OMAP3EVM with and without CONFIG_SMP.
 Since the log is rather long, will be posting the log in
 a follow-up mail.

 arch/arm/mach-omap2/omap2plus-cpufreq.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 346519e..0263cae 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -97,12 +97,8 @@ static int omap_target(struct cpufreq_policy *policy,
 		return ret;

 	/* Notify transitions */
-	if (is_smp()) {
-		for_each_cpu(i, policy->cpus) {
-			freqs.cpu = i;
-			cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-		}
-	} else {
+	for_each_cpu(i, policy->cpus) {
+		freqs.cpu = i;
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 	}

@@ -114,13 +110,20 @@ static int omap_target(struct cpufreq_policy *policy,

 	freqs.new = omap_getspeed(policy->cpu);

+#ifdef CONFIG_SMP
+	/* Adjust jiffies before transition */
+	for_each_cpu(i, policy->cpus) {
+		unsigned long lpj = per_cpu(cpu_data, i).loops_per_jiffy;
+
+		per_cpu(cpu_data, i).loops_per_jiffy = cpufreq_scale(lpj,
+							freqs.old,
+							freqs.new);
+	}
+#endif
+
 	/* Notify transitions */
-	if (is_smp()) {
-		for_each_cpu(i, policy->cpus) {
-			freqs.cpu = i;
-			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-		}
-	} else {
+	for_each_cpu(i, policy->cpus) {
+		freqs.cpu = i;
 		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 	}

--
1.7.2.2
