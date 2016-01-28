From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 28 Jan 2016 11:32:17 +0000
Subject: [PATCH 6/6] arm64: compat: Check for AArch32 state
In-Reply-To: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
References: <1453980737-6126-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1453980737-6126-7-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure we have AArch32 state available for running COMPAT binaries.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
[ Added checks for ELF HWCAP, Use cap bit in cap_hwcaps ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/elf.h   |    3 ++-
 arch/arm64/kernel/cpufeature.c |    7 +++++--
 arch/arm64/kernel/cpuinfo.c    |    3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index faad6df..a1946f2 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -173,7 +173,8 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 
 /* AArch32 EABI. */
 #define EF_ARM_EABI_MASK		0xff000000
-#define compat_elf_check_arch(x)	(((x)->e_machine == EM_ARM) && \
+#define compat_elf_check_arch(x)	(system_supports_32bit_el0() && \
+					 ((x)->e_machine == EM_ARM) && \
 					 ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 8deaa20..cccc7ce 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -931,7 +931,8 @@ void verify_local_cpu_capabilities(void)
 
 	verify_local_cpu_features(arm64_features);
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);
-	verify_local_elf_hwcaps(compat_elf_hwcaps);
+	if (system_supports_32bit_el0())
+		verify_local_elf_hwcaps(compat_elf_hwcaps);
 }
 
 static void __init setup_feature_capabilities(void)
@@ -948,7 +949,9 @@ void __init setup_cpu_features(void)
 	/* Set the CPU feature capabilies */
 	setup_feature_capabilities();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
-	setup_elf_hwcaps(compat_elf_hwcaps);
+
+	if (system_supports_32bit_el0())
+		setup_elf_hwcaps(compat_elf_hwcaps);
 
 	/* Advertise that we have computed the system capabilities */
 	set_sys_caps_initialised();
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 8cc2a86..2890b74 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -124,7 +124,8 @@ static int c_show(struct seq_file *m, void *v)
 		 * software which does already (at least for 32-bit).
 		 */
 		seq_puts(m, "Features\t:");
-		if (personality(current->personality) == PER_LINUX32) {
+		if (system_supports_32bit_el0() &&
+			personality(current->personality) == PER_LINUX32) {
 #ifdef CONFIG_COMPAT
 			for (j = 0; compat_hwcap_str[j]; j++)
 				if (compat_elf_hwcap & (1 << j))
-- 
1.7.9.5
