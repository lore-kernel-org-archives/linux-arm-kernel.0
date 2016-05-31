From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 May 2016 15:55:03 +0100
Subject: [PATCH 1/2] arm64: Provide "model name" in /proc/cpuinfo for
 PER_LINUX32 tasks
In-Reply-To: <1464706504-25224-1-git-send-email-catalin.marinas@arm.com>
References: <1464706504-25224-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1464706504-25224-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch brings the PER_LINUX32 /proc/cpuinfo format more in line with
the 32-bit ARM one by providing an additional line:

model name      : ARMv8 Processor rev X (v8l)

Cc: <stable@vger.kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/elf.h | 4 ++--
 arch/arm64/kernel/cpuinfo.c  | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 7a09c48c0475..579b6e654f2d 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -160,14 +160,14 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 #define STACK_RND_MASK			(0x3ffff >> (PAGE_SHIFT - 12))
 #endif
 
-#ifdef CONFIG_COMPAT
-
 #ifdef __AARCH64EB__
 #define COMPAT_ELF_PLATFORM		("v8b")
 #else
 #define COMPAT_ELF_PLATFORM		("v8l")
 #endif
 
+#ifdef CONFIG_COMPAT
+
 #define COMPAT_ELF_ET_DYN_BASE		(2 * TASK_SIZE_32 / 3)
 
 /* AArch32 registers. */
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 3808470486f3..c173d329397f 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -22,6 +22,8 @@
 
 #include <linux/bitops.h>
 #include <linux/bug.h>
+#include <linux/compat.h>
+#include <linux/elf.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/personality.h>
@@ -104,6 +106,7 @@ static const char *const compat_hwcap2_str[] = {
 static int c_show(struct seq_file *m, void *v)
 {
 	int i, j;
+	bool compat = personality(current->personality) == PER_LINUX32;
 
 	for_each_online_cpu(i) {
 		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
@@ -115,6 +118,9 @@ static int c_show(struct seq_file *m, void *v)
 		 * "processor".  Give glibc what it expects.
 		 */
 		seq_printf(m, "processor\t: %d\n", i);
+		if (compat)
+			seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
+				   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
 
 		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
 			   loops_per_jiffy / (500000UL/HZ),
@@ -127,7 +133,7 @@ static int c_show(struct seq_file *m, void *v)
 		 * software which does already (at least for 32-bit).
 		 */
 		seq_puts(m, "Features\t:");
-		if (personality(current->personality) == PER_LINUX32) {
+		if (compat) {
 #ifdef CONFIG_COMPAT
 			for (j = 0; compat_hwcap_str[j]; j++)
 				if (compat_elf_hwcap & (1 << j))
