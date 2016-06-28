From: james.morse@arm.com (James Morse)
Date: Tue, 28 Jun 2016 15:51:47 +0100
Subject: [PATCH v3 4/7] arm64: hibernate: Detect hibernate image created on
 non-boot CPU
In-Reply-To: <1467125510-18758-1-git-send-email-james.morse@arm.com>
References: <1467125510-18758-1-git-send-email-james.morse@arm.com>
Message-ID: <1467125510-18758-5-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64 the cpu with logical id 0 is assumed to be the boot CPU. If a
user hotplugs this CPU out, then uses kexec to boot a new kernel, the new
kernel will assign logical id 0 to a different physical CPU.
This breaks hibernate as hibernate and resume will be attempted on different
CPUs.

Save the MPIDR of the CPU we hibernated on in the hibernate arch-header,
and fail to resume if it doesn't match CPU0's when we come to read the
header.

This will still lead to data loss (hibernate image is discarded), but
we at least get the opportunity to print an error message. Later patches
will allow hibernate to disable all but the CPU we hibernated on.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
Change since v2:
 * This patch was split out of v2:patch4. Without any core-code changes,
   printing an error like this is the best we can do.

This patch will cause a trivial merge conflict with mainline, due to a fix
for hibernate which added an include for asm/smp.h. The fix is to keep
both hunks.

 arch/arm64/kernel/hibernate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 1c1278d5ec50..8c7c6d7d4cd4 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -15,6 +15,7 @@
  * License terms: GNU General Public License (GPL) version 2
  */
 #define pr_fmt(x) "hibernate: " x
+#include <linux/cpu.h>
 #include <linux/kvm_host.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
@@ -26,6 +27,7 @@
 
 #include <asm/barrier.h>
 #include <asm/cacheflush.h>
+#include <asm/cputype.h>
 #include <asm/irqflags.h>
 #include <asm/memory.h>
 #include <asm/mmu_context.h>
@@ -33,6 +35,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/sections.h>
+#include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/virt.h>
 
@@ -59,6 +62,12 @@ extern char hibernate_el2_vectors[];
 extern char __hyp_stub_vectors[];
 
 /*
+ * The logical cpu number we should resume on, initialised to a non-cpu
+ * number.
+ */
+static int sleep_cpu = -EINVAL;
+
+/*
  * Values that may not change over hibernate/resume. We put the build number
  * and date in here so that we guarantee not to resume with a different
  * kernel.
@@ -80,6 +89,8 @@ static struct arch_hibernate_hdr {
 	 * re-configure el2.
 	 */
 	phys_addr_t	__hyp_stub_vectors;
+
+	u64		sleep_cpu_mpidr;
 } resume_hdr;
 
 static inline void arch_hdr_invariants(struct arch_hibernate_hdr_invariants *i)
@@ -122,6 +133,11 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	else
 		hdr->__hyp_stub_vectors = 0;
 
+	/* Save the mpidr of the cpu we called cpu_suspend() on... */
+	hdr->sleep_cpu_mpidr = cpu_logical_map(sleep_cpu);
+	pr_info("Hibernating on CPU %d [mpidr:0x%llx]\n", sleep_cpu,
+		hdr->sleep_cpu_mpidr);
+
 	return 0;
 }
 EXPORT_SYMBOL(arch_hibernation_header_save);
@@ -137,6 +153,14 @@ int arch_hibernation_header_restore(void *addr)
 		return -EINVAL;
 	}
 
+	sleep_cpu = get_logical_index(hdr->sleep_cpu_mpidr);
+	pr_info("Hibernated on CPU %d [mpidr:0x%llx]\n", sleep_cpu,
+		hdr->sleep_cpu_mpidr);
+	if (sleep_cpu != 0) {
+		pr_crit("Didn't hibernate on the firmware boot CPU!\n");
+		sleep_cpu = -EINVAL;
+		return -EINVAL;
+	}
 	resume_hdr = *hdr;
 
 	return 0;
@@ -234,6 +258,7 @@ int swsusp_arch_suspend(void)
 	local_dbg_save(flags);
 
 	if (__cpu_suspend_enter(&state)) {
+		sleep_cpu = smp_processor_id();
 		ret = swsusp_save();
 	} else {
 		/* Clean kernel core startup/idle code to PoC*/
@@ -251,6 +276,7 @@ int swsusp_arch_suspend(void)
 		 */
 		in_suspend = 0;
 
+		sleep_cpu = -EINVAL;
 		__cpu_suspend_exit();
 	}
 
-- 
2.8.0.rc3
