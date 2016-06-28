From: james.morse@arm.com (James Morse)
Date: Tue, 28 Jun 2016 15:51:49 +0100
Subject: [PATCH v3 6/7] arm64: hibernate: Resume on the CPU that created the
 hibernate image
In-Reply-To: <1467125510-18758-1-git-send-email-james.morse@arm.com>
References: <1467125510-18758-1-git-send-email-james.morse@arm.com>
Message-ID: <1467125510-18758-7-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64 the cpu with logical id 0 is assumed to be the boot CPU. If a
user hotplugs this CPU out, then uses kexec to boot a new kernel, the new
kernel will assign logical id 0 to a different physical CPU.
This breaks hibernate as hibernate and resume will be attempted on different
CPUs. A previous patch detects this situation when we come to resume,
and returns an error. (data stored in the hibernate image is lost)

We currently forbid hibernate if CPU0 has been hotplugged out to avoid
this situation without kexec.

Use arch_hibernation_disable_cpus() to direct which CPU we should resume
on based on the MPIDR of the CPU we hibernated on. This allows us to
hibernate/resume on any CPU, even if the logical numbers have been
shuffled by kexec.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
Changes since v2:
 * Storing/reading/checking sleep_cpu moved into an earlier patch
 * Moved to macro approach.
 * Added hidden ARCH_HIBERNATION_CPUHP config option.

 arch/arm64/Kconfig               |  4 ++++
 arch/arm64/include/asm/suspend.h |  4 ++++
 arch/arm64/kernel/hibernate.c    | 48 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 79341f6d1b6a..14ef59a90cfd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1017,6 +1017,10 @@ config ARCH_HIBERNATION_HEADER
 	def_bool y
 	depends on HIBERNATION
 
+config ARCH_HIBERNATION_CPUHP
+	def_bool y
+	depends on HIBERNATION
+
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 024d623f662e..9b3e8d9bfc8c 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -47,4 +47,8 @@ int swsusp_arch_resume(void);
 int arch_hibernation_header_save(void *addr, unsigned int max_size);
 int arch_hibernation_header_restore(void *addr);
 
+/* Used to resume on the CPU we hibernated on */
+int _arch_hibernation_disable_cpus(bool suspend);
+#define arch_hibernation_disable_cpus(x) _arch_hibernation_disable_cpus(x)
+
 #endif
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 8c7c6d7d4cd4..cbcc8243575e 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -144,6 +144,7 @@ EXPORT_SYMBOL(arch_hibernation_header_save);
 
 int arch_hibernation_header_restore(void *addr)
 {
+	int ret;
 	struct arch_hibernate_hdr_invariants invariants;
 	struct arch_hibernate_hdr *hdr = addr;
 
@@ -156,11 +157,21 @@ int arch_hibernation_header_restore(void *addr)
 	sleep_cpu = get_logical_index(hdr->sleep_cpu_mpidr);
 	pr_info("Hibernated on CPU %d [mpidr:0x%llx]\n", sleep_cpu,
 		hdr->sleep_cpu_mpidr);
-	if (sleep_cpu != 0) {
-		pr_crit("Didn't hibernate on the firmware boot CPU!\n");
+	if (sleep_cpu <= 0) {
+		pr_crit("Hibernated on a CPU not known to this kernel!\n");
 		sleep_cpu = -EINVAL;
 		return -EINVAL;
 	}
+	if (!cpu_online(sleep_cpu)) {
+		pr_info("Hibernated on a CPU that is offline! Bringing CPU up.\n");
+		ret = cpu_up(sleep_cpu);
+		if (ret) {
+			pr_err("Failed to bring hibernate-CPU up!\n");
+			sleep_cpu = -EINVAL;
+			return ret;
+		}
+	}
+
 	resume_hdr = *hdr;
 
 	return 0;
@@ -532,3 +543,36 @@ static int __init check_boot_cpu_online_init(void)
 	return 0;
 }
 core_initcall(check_boot_cpu_online_init);
+
+int _arch_hibernation_disable_cpus(bool suspend)
+{
+	int cpu, ret;
+
+	if (suspend) {
+		/*
+		 * During hibernate we need frozen_cpus to be updated and saved.
+		 */
+		ret = disable_nonboot_cpus();
+	} else {
+		/*
+		 * Resuming from hibernate. From here, we can't race with
+		 * userspace, and don't need to update frozen_cpus.
+		 */
+		pr_info("Disabling secondary CPUs ...\n");
+
+		/* sleep_cpu must have been loaded from the arch header */
+		BUG_ON(sleep_cpu < 0);
+
+		for_each_online_cpu(cpu) {
+			if (cpu == sleep_cpu)
+				continue;
+			ret = cpu_down(cpu);
+			if (ret) {
+				pr_err("Secondary CPUs are not disabled\n");
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
-- 
2.8.0.rc3
