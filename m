From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 May 2013 18:07:53 +0100
Subject: [PATCH 14/14] ARM: elf: add new hwcap for identifying atomic
 ldrd/strd instructions
In-Reply-To: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
References: <1368810473-26070-1-git-send-email-will.deacon@arm.com>
Message-ID: <1368810473-26070-15-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPUs implementing LPAE have atomic ldrd/strd instructions, meaning that
userspace software can avoid having to use the exclusive variants of
these instructions if they wish.

This patch advertises the atomicity of these instructions via the
hwcaps, so userspace can detect this CPU feature.

Reported-by: Vladimir Danushevsky <vladimir.danushevsky@oracle.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/uapi/asm/hwcap.h | 2 +-
 arch/arm/kernel/setup.c           | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
index 3688fd1..6d34d08 100644
--- a/arch/arm/include/uapi/asm/hwcap.h
+++ b/arch/arm/include/uapi/asm/hwcap.h
@@ -25,6 +25,6 @@
 #define HWCAP_IDIVT	(1 << 18)
 #define HWCAP_VFPD32	(1 << 19)	/* set if VFP has 32 regs (not 16) */
 #define HWCAP_IDIV	(HWCAP_IDIVA | HWCAP_IDIVT)
-
+#define HWCAP_LPAE	(1 << 20)
 
 #endif /* _UAPI__ASMARM_HWCAP_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1522c7a..bdcd4dd 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -355,7 +355,7 @@ void __init early_print(const char *str, ...)
 
 static void __init cpuid_init_hwcaps(void)
 {
-	unsigned int divide_instrs;
+	unsigned int divide_instrs, vmsa;
 
 	if (cpu_architecture() < CPU_ARCH_ARMv7)
 		return;
@@ -368,6 +368,11 @@ static void __init cpuid_init_hwcaps(void)
 	case 1:
 		elf_hwcap |= HWCAP_IDIVT;
 	}
+
+	/* LPAE implies atomic ldrd/strd instructions */
+	vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
+	if (vmsa >= 5)
+		elf_hwcap |= HWCAP_LPAE;
 }
 
 static void __init feat_v6_fixup(void)
@@ -872,6 +877,7 @@ static const char *hwcap_str[] = {
 	"vfpv4",
 	"idiva",
 	"idivt",
+	"lpae",
 	NULL
 };
 
-- 
1.8.2.2
