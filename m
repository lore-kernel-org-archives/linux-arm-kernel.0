From: apinski@cavium.com (Andrew Pinski)
Date: Sun, 30 Aug 2015 02:38:40 +0800
Subject: [PATCH] ARM64: Add AT_ARM64_MIDR to the aux vector
Message-ID: <1440873520-43899-1-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is useful to pass down MIDR register down to userland if all of
the online cores are all the same type.  This adds AT_ARM64_MIDR
aux vector type and passes down the midr system register.

This is alternative to MIDR_EL1 part of
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358995.html.
It allows for faster access to midr_el1 than going through a trap and
does not exist if the set of cores are not the same.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/include/asm/cpu.h |    1 +
 arch/arm64/include/asm/elf.h |    6 ++++++
 arch/arm64/kernel/cpuinfo.c  |   22 ++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 8e797b2..fab0aa1 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -62,5 +62,6 @@ DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 
 void cpuinfo_store_cpu(void);
 void __init cpuinfo_store_boot_cpu(void);
+u32 get_arm64_midr(void);
 
 #endif /* __ASM_CPU_H */
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index faad6df..d3549de 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -17,6 +17,7 @@
 #define __ASM_ELF_H
 
 #include <asm/hwcap.h>
+#include <asm/cpu.h>
 
 /*
  * ELF register definitions..
@@ -138,8 +139,13 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 
 #define ARCH_DLINFO							\
 do {									\
+	u32 midr;							\
+									\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
 		    (elf_addr_t)current->mm->context.vdso);		\
+	midr = get_arm64_midr();					\
+	if (midr != 0)							\
+		NEW_AUX_ENT(AT_ARM64_MIDR, (elf_addr_t)midr);		\
 } while (0)
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 75d5a86..b14c87d 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -254,3 +254,25 @@ void __init cpuinfo_store_boot_cpu(void)
 
 	boot_cpu_data = *info;
 }
+
+u32 get_arm64_midr(void)
+{
+	int i;
+	u32 midr = 0;
+
+	for_each_online_cpu(i) {
+		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
+		u32 oldmidr = midr;
+
+		midr = cpuinfo->reg_midr;
+		/*
+		 * If there are cpus which have a different
+		 * midr just return 0.
+		 */
+		if (oldmidr && oldmidr != midr)
+			return 0;
+	}
+
+	return midr;
+}
+
-- 
1.7.10.4
