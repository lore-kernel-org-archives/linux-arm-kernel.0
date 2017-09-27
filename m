From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 27 Sep 2017 15:33:16 +0100
Subject: [PATCH] arm64: Expose ASIMD dot product instruction support
Message-ID: <20170927143316.14761-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM v8-A adds two new optional instructions in architecture version v8.2
and v8.3, for performing dot product of 8bit elements in each 32bit element
of two vectors and accumulating the result into a third vector. Expose the
functionality via ELF HWCAPs and MRS emulation.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/arm64/cpu-feature-registers.txt | 6 +++++-
 arch/arm64/include/asm/sysreg.h               | 1 +
 arch/arm64/include/uapi/asm/hwcap.h           | 1 +
 arch/arm64/kernel/cpufeature.c                | 2 ++
 arch/arm64/kernel/cpuinfo.c                   | 1 +
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/cpu-feature-registers.txt b/Documentation/arm64/cpu-feature-registers.txt
index dad411d635d8..f25cfbfa91a7 100644
--- a/Documentation/arm64/cpu-feature-registers.txt
+++ b/Documentation/arm64/cpu-feature-registers.txt
@@ -110,7 +110,11 @@ infrastructure:
      x--------------------------------------------------x
      | Name                         |  bits   | visible |
      |--------------------------------------------------|
-     | RES0                         | [63-32] |    n    |
+     | RES0                         | [63-48] |    n    |
+     |--------------------------------------------------|
+     | DP                           | [47-44] |    y    |
+     |--------------------------------------------------|
+     | RES0                         | [43-32] |    n    |
      |--------------------------------------------------|
      | RDM                          | [31-28] |    y    |
      |--------------------------------------------------|
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index f707fed5886f..2084c70ce164 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -318,6 +318,7 @@
 #define SCTLR_EL1_CP15BEN	(1 << 5)
 
 /* id_aa64isar0 */
+#define ID_AA64ISAR0_DP_SHIFT		44
 #define ID_AA64ISAR0_RDM_SHIFT		28
 #define ID_AA64ISAR0_ATOMICS_SHIFT	20
 #define ID_AA64ISAR0_CRC32_SHIFT	16
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index 4b9344cba83a..7af8ef6f5297 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -36,5 +36,6 @@
 #define HWCAP_FCMA		(1 << 14)
 #define HWCAP_LRCPC		(1 << 15)
 #define HWCAP_DCPOP		(1 << 16)
+#define HWCAP_ASIMDDP		(1 << 17)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index cd52d365d1f0..415450017d70 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -107,6 +107,7 @@ cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
  * sync with the documentation of the CPU feature register ABI.
  */
 static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_DP_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64ISAR0_RDM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_ATOMICS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_CRC32_SHIFT, 4, 0),
@@ -924,6 +925,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_CRC32_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_CRC32),
 	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_ATOMICS_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, HWCAP_ATOMICS),
 	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_RDM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_ASIMDRDM),
+	HWCAP_CAP(SYS_ID_AA64ISAR0_EL1, ID_AA64ISAR0_DP_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_ASIMDDP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_FP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_FP_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_FPHP),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 311885962830..027a321ba6d3 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -69,6 +69,7 @@ static const char *const hwcap_str[] = {
 	"fcma",
 	"lrcpc",
 	"dcpop",
+	"asimddp",
 	NULL
 };
 
-- 
2.13.5
