From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Apr 2018 11:41:49 +0100
Subject: [PATCH] ARM: avoid Cortex-A9 livelock on tight dmb loops
Message-ID: <E1f5qij-00033R-Sl@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Executing loops such as:

	while (1)
		cpu_relax();

with interrupts disabled results in a livelock of the entire system,
as other CPUs are prevented making progress.  This is most noticable
as a failure of crashdump kexec, which stops just after issuing:

	Loading crashdump kernel...

to the system console.  Two other locations of these loops within the
ARM code have been identified and fixed up.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/machine_kexec.c  | 3 ++-
 arch/arm/kernel/smp.c            | 2 +-
 arch/arm/mach-omap2/prm_common.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 6b38d7a634c1..75d4f5ce6cfd 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -91,8 +91,9 @@ void machine_crash_nonpanic_core(void *unused)
 
 	set_cpu_online(smp_processor_id(), false);
 	atomic_dec(&waiting_for_crash_ipi);
+
 	while (1)
-		cpu_relax();
+		cpu_do_idle();
 }
 
 static void machine_kexec_mask_interrupts(void)
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 5c7ec00a500e..cbaba4a15a3a 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -568,7 +568,7 @@ static void ipi_cpu_stop(unsigned int cpu)
 	local_irq_disable();
 
 	while (1)
-		cpu_relax();
+		cpu_do_idle();
 }
 
 static DEFINE_PER_CPU(struct completion *, cpu_completion);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 021b5a8b9c0a..d4ddc78b2a0b 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -523,7 +523,7 @@ void omap_prm_reset_system(void)
 	prm_ll_data->reset_system();
 
 	while (1)
-		cpu_relax();
+		cpu_do_idle();
 }
 
 /**
-- 
2.7.4
