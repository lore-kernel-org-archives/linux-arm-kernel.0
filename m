From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:38:57 +0000
Subject: [RFC PATCH 09/29] arm64/sve: Boot-time feature detection and reporting
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-10-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds feature detection for the ARM Scalable Vector
Extension, and adds basic informative feature reporting via
/proc/cpuinfo.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/sysreg.h     | 1 +
 arch/arm64/include/uapi/asm/hwcap.h | 1 +
 arch/arm64/kernel/cpufeature.c      | 3 +++
 arch/arm64/kernel/cpuinfo.c         | 1 +
 4 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6c80b36..ccce9ad 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -113,6 +113,7 @@
 #define ID_AA64ISAR0_AES_SHIFT		4
 
 /* id_aa64pfr0 */
+#define ID_AA64PFR0_SVE_SHIFT		32
 #define ID_AA64PFR0_GIC_SHIFT		24
 #define ID_AA64PFR0_ASIMD_SHIFT		20
 #define ID_AA64PFR0_FP_SHIFT		16
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index a739287..f0de828 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -30,5 +30,6 @@
 #define HWCAP_ATOMICS		(1 << 8)
 #define HWCAP_FPHP		(1 << 9)
 #define HWCAP_ASIMDHP		(1 << 10)
+#define HWCAP_SVE		(1 << 11)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c02504e..5126288 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -856,6 +856,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_FPHP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_ASIMDHP),
+#ifdef CONFIG_ARM64_SVE
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SVE),
+#endif
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index b3d5b3e..53e9fe2 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -63,6 +63,7 @@ static const char *const hwcap_str[] = {
 	"atomics",
 	"fphp",
 	"asimdhp",
+	"sve",
 	NULL
 };
 
-- 
2.1.4
