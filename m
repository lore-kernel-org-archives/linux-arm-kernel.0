From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 18 May 2017 10:26:32 +0100
Subject: [PATCH] ARM: MCPM: ensure not to enter __hyp_soft_restart from
 loopback and cpu_power_down
Message-ID: <1495099592-10439-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9da5ac236de6 ("ARM: soft-reboot into same mode that we entered
the kernel") added support to enter the new kernel in the same processor
mode as the previous one when we soft-reboot from one kernel into
another by pass a flag to cpu_reset() so it knows what to do exactly.

However it missed to make similar changes in MCPM code. Due to the
missing flag, the CPUs enter HYP mode which is not supported with MCPM.
MCPM works only in secure mode as it manages CCI.

This patch aligns the cpu_reset call in MCPM with other changes in the
above mentioned commit.

Fixes: 9da5ac236de6 ("ARM: soft-reboot into same mode that we entered the kernel")
Cc: Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/common/mcpm_entry.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Hi Nico, Russell,

I am seeing a boot failure without this patch on my TC2 where MCPM is
enabled and active. The loopback test fails on primary, if skipped fails
later on resume path.

Regards,
Sudeep

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index cf062472e07b..d2bd153484b6 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -235,7 +235,7 @@ int mcpm_cpu_power_up(unsigned int cpu, unsigned int cluster)
 	return ret;
 }

-typedef void (*phys_reset_t)(unsigned long);
+typedef void (*phys_reset_t)(unsigned long, bool);

 void mcpm_cpu_power_down(void)
 {
@@ -300,7 +300,7 @@ void mcpm_cpu_power_down(void)
 	 * on the CPU.
 	 */
 	phys_reset = (phys_reset_t)(unsigned long)__pa_symbol(cpu_reset);
-	phys_reset(__pa_symbol(mcpm_entry_point));
+	phys_reset(__pa_symbol(mcpm_entry_point), false);

 	/* should never get here */
 	BUG();
@@ -389,7 +389,7 @@ static int __init nocache_trampoline(unsigned long _arg)
 	__mcpm_cpu_down(cpu, cluster);

 	phys_reset = (phys_reset_t)(unsigned long)__pa_symbol(cpu_reset);
-	phys_reset(__pa_symbol(mcpm_entry_point));
+	phys_reset(__pa_symbol(mcpm_entry_point), false);
 	BUG();
 }

--
2.7.4
