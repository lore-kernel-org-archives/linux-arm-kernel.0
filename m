From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  5 Sep 2014 12:22:19 +0100
Subject: [PATCH 2/2] arm: psci: don't call CPU_OFF blindly
In-Reply-To: <1409916139-20127-1-git-send-email-mark.rutland@arm.com>
References: <1409916139-20127-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1409916139-20127-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic PSCI operations for arm check the presence of a CPU_OFF ID
far too late, and in the absence of an ID will panic(), rather than
producing a warning.

This patch adds a psci_cpu_disable callback which tests the presence of
a CPU_OFF id. As this is called earlier than psci_cpu_die, the failure
can be handled gracefully without brining down the system. Additionally
a check is added for a UP trusted OS in the presence of PSCI 0.2+. Full
support will require the use of MIGRATE, but for now rejecting hotplug
will prevent psci_cpu_die from brining down the system.

The now redundant check for scpi_ops.cpu_off is removed from
psci_cpu_die. At the same time, the whitespace is corrected from seven
spaces to tabs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/psci_smp.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

Stefano, I've followed your lead with the __ref annotation here, but I couldn't
figure out why they exist on cpu_die and cpu_kill; it feels rather dodgy. Do
you know why they were added, or if they are superfluous?

There are some other cleanups that should happen here (static,
CPU_METHOD_OF_DECLARE), but those will come as a later cleanups series.

diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index 28a1db4..2b00d3c 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -56,17 +56,38 @@ static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+int __ref psci_cpu_disable(unsigned int cpu)
+{
+	/* Fail early if we don't have CPU_OFF support */
+	if (!psci_ops.cpu_off)
+		return -EOPNOTSUPP;
+
+	/*
+	 * In the presence of a UP trusted OS, it might not be possible to
+	 * hotplug certain CPUs, and CPU_OFF may return (which would be bad).
+	 * Supporting a UP trusted OS requires careful use of
+	 * MIGRATE_INFO_UP_CPU and MIGRATE, so for now fail in the presence of
+	 * a UP Trusted OS.
+	 */
+	if (psci_ops.migrate_info_type &&
+		psci_ops.migrate_info_type() != PSCI_0_2_TOS_MP) {
+			pr_warn("Unable to handle UP trusted OS\n");
+			return -EPERM;
+	}
+
+	return 0;
+}
+
 void __ref psci_cpu_die(unsigned int cpu)
 {
-       const struct psci_power_state ps = {
-               .type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
-       };
+	const struct psci_power_state ps = {
+		.type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
+	};
 
-       if (psci_ops.cpu_off)
-               psci_ops.cpu_off(ps);
+	psci_ops.cpu_off(ps);
 
-       /* We should never return */
-       panic("psci: cpu %d failed to shutdown\n", cpu);
+	/* We should never return */
+	panic("psci: cpu %d failed to shutdown\n", cpu);
 }
 
 int __ref psci_cpu_kill(unsigned int cpu)
@@ -109,6 +130,7 @@ bool __init psci_smp_available(void)
 struct smp_operations __initdata psci_smp_ops = {
 	.smp_boot_secondary	= psci_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= psci_cpu_disable,
 	.cpu_die		= psci_cpu_die,
 	.cpu_kill		= psci_cpu_kill,
 #endif
-- 
1.9.1
