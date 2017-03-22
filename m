From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:39 +0000
Subject: [RFC PATCH v2 09/41] arm64/sve: Boot-time feature detection and
 reporting
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-10-git-send-email-Dave.Martin@arm.com>
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
index ac24b6e..8f1a43e 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -157,6 +157,7 @@
 #define ID_AA64ISAR0_AES_SHIFT		4
 
 /* id_aa64pfr0 */
+#define ID_AA64PFR0_SVE_SHIFT		32
 #define ID_AA64PFR0_GIC_SHIFT		24
 #define ID_AA64PFR0_ASIMD_SHIFT		20
 #define ID_AA64PFR0_FP_SHIFT		16
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 61c263c..7f0f86d 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -32,5 +32,6 @@
 #define HWCAP_ASIMDHP		(1 << 10)
 #define HWCAP_CPUID		(1 << 11)
 #define HWCAP_ASIMDRDM		(1 << 12)
+#define HWCAP_SVE		(1 << 13)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index abda8e8..707dfdb 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -888,6 +888,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_FPHP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_ASIMDHP),
+#ifdef CONFIG_ARM64_SVE
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SVE),
+#endif
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 5b22c68..8dd410e 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -65,6 +65,7 @@ static const char *const hwcap_str[] = {
 	"asimdhp",
 	"cpuid",
 	"asimdrdm",
+	"sve",
 	NULL
 };
 
-- 
2.1.4
