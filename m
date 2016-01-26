From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 26 Jan 2016 15:52:46 +0000
Subject: [PATCH] arm64: Add support for Half precision floating point
Message-ID: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8.2 extensions [1] include an optional feature, which supports
half precision(16bit) floating point/asimd data processing
instructions. This patch adds support for detecting and exposing
the same to the userspace via HWCAPs

[1] https://community.arm.com/groups/processors/blog/2016/01/05/armv8-a-architecture-evolution

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/uapi/asm/hwcap.h |    2 ++
 arch/arm64/kernel/cpufeature.c      |    2 ++
 arch/arm64/kernel/cpuinfo.c         |    2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 361c8a8..a739287 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -28,5 +28,7 @@
 #define HWCAP_SHA2		(1 << 6)
 #define HWCAP_CRC32		(1 << 7)
 #define HWCAP_ATOMICS		(1 << 8)
+#define HWCAP_FPHP		(1 << 9)
+#define HWCAP_ASIMDHP		(1 << 10)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5c90aa4..798898e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -673,7 +673,9 @@ static const struct arm64_cpu_capabilities arm64_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_CRC32_SHIFT, 1, CAP_HWCAP, HWCAP_CRC32),
 	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_ATOMICS_SHIFT, 2, CAP_HWCAP, HWCAP_ATOMICS),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, 0, CAP_HWCAP, HWCAP_FP),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, 1, CAP_HWCAP, HWCAP_FPHP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, 0, CAP_HWCAP, HWCAP_ASIMD),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, 1, CAP_HWCAP, HWCAP_ASIMDHP),
 #ifdef CONFIG_COMPAT
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, 2, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_PMULL),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_AES),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 212ae63..05523f0 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -59,6 +59,8 @@ static const char *const hwcap_str[] = {
 	"sha2",
 	"crc32",
 	"atomics",
+	"fphp",
+	"asimdhp",
 	NULL
 };
 
-- 
1.7.9.5
