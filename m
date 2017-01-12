From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 12 Jan 2017 16:37:28 +0000
Subject: [PATCH] arm64: Advertise support for Rounding double multiply
 instructions
Message-ID: <1484239048-15817-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM v8.1 extensions include support for rounding double multiply
add/subtract instructions to the A64 SIMD instructions set. Let
the userspace know about it via a HWCAP bit.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Applies on top of the MRS CPUID feature emulation series [1]

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/478007.html
---
 arch/arm64/include/uapi/asm/hwcap.h | 1 +
 arch/arm64/kernel/cpufeature.c      | 1 +
 arch/arm64/kernel/cpuinfo.c         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 773c90b..61c263c 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -31,5 +31,6 @@
 #define HWCAP_FPHP		(1 << 9)
 #define HWCAP_ASIMDHP		(1 << 10)
 #define HWCAP_CPUID		(1 << 11)
+#define HWCAP_ASIMDRDM		(1 << 12)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index fa707e3..936a129 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -872,6 +872,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_SHA2_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SHA2),
 	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_CRC32_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_CRC32),
 	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_ATOMICS_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, HWCAP_ATOMICS),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_RDM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_ASIMDRDM),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_FP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_FPHP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 4d44edd..5b22c68 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -64,6 +64,7 @@ static const char *const hwcap_str[] = {
 	"fphp",
 	"asimdhp",
 	"cpuid",
+	"asimdrdm",
 	NULL
 };
 
-- 
2.7.4
