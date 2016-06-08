From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 17:20:42 +0100
Subject: [PATCH] ARM: make unexported functions static
Message-ID: <1465402842-26798-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are three functions that do not get exported from the
psci_smp.c file that if we make static then the following
warnings get squashed:

arch/arm/kernel/psci_smp.c:61:5: warning: symbol 'psci_cpu_disable' was not declared. Should it be static?
arch/arm/kernel/psci_smp.c:74:6: warning: symbol 'psci_cpu_die' was not declared. Should it be static?
arch/arm/kernel/psci_smp.c:86:5: warning: symbol 'psci_cpu_kill' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: linux-arm-kernel at lists.infradead.org
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/kernel/psci_smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index cb3fcae..20d6343 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -58,7 +58,7 @@ static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-int psci_cpu_disable(unsigned int cpu)
+static int psci_cpu_disable(unsigned int cpu)
 {
 	/* Fail early if we don't have CPU_OFF support */
 	if (!psci_ops.cpu_off)
@@ -71,7 +71,7 @@ int psci_cpu_disable(unsigned int cpu)
 	return 0;
 }
 
-void psci_cpu_die(unsigned int cpu)
+static void psci_cpu_die(unsigned int cpu)
 {
 	u32 state = PSCI_POWER_STATE_TYPE_POWER_DOWN <<
 		    PSCI_0_2_POWER_STATE_TYPE_SHIFT;
@@ -83,7 +83,7 @@ void psci_cpu_die(unsigned int cpu)
 	panic("psci: cpu %d failed to shutdown\n", cpu);
 }
 
-int psci_cpu_kill(unsigned int cpu)
+static int psci_cpu_kill(unsigned int cpu)
 {
 	int err, i;
 
-- 
2.8.1
