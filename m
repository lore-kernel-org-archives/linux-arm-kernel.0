From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Thu, 10 Dec 2015 16:13:36 +0800
Subject: [PATCH v5] acpi, apei, arm64: APEI initial support for aarch64.
Message-ID: <1449735216-20999-1-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

This commit provides APEI arch-specific bits for aarch64

Meanwhile, add a new subfunction "hest_ia_init" for
"acpi_disable_cmcff" which is used by IA-32 Architecture
Corrected Machine Check (CMC), and add "HAVE_ACPI_APEI_HEST_IA32"
to make sure only x86 use "hest_ia_init".

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
---
Changelog:
v5: Add "HAVE_ACPI_APEI_HEST_IA32" instead of
    "#if defined(__i386__) || defined(__x86_64__)".

v4: Rebase to latest kernel version(4.4-rc4).
    Move arch_apei_flush_tlb_one into header file as a inline function
    Add a new subfunction "hest_ia_init" for "acpi_disable_cmcff".

v3: https://lkml.org/lkml/2015/12/3/521
    Remove "acpi_disable_cmcff" from arm64 code,
    and wrap it in hest.c by "#if defined(__i386__) || defined(__x86_64__)"

v2: https://lkml.org/lkml/2015/12/2/432
    Rebase to latest kernel version(4.4-rc3).
    Move arch_apei_flush_tlb_one() to arch/arm64/kernel/acpi.c

v1: https://lkml.org/lkml/2015/8/14/199
    Move arch_apei_flush_tlb_one() to arch/arm64/include/asm/apci.h.
    Delete arch/arm64/kernel/apei.c.
    Add "#ifdef CONFIG_ACPI_APEI" for "acpi_disable_cmcff".

 arch/arm64/Kconfig            |  1 +
 arch/arm64/include/asm/acpi.h |  7 ++++++-
 arch/x86/Kconfig              |  1 +
 drivers/acpi/apei/Kconfig     |  3 +++
 drivers/acpi/apei/hest.c      | 19 ++++++++++++++++---
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 871f217..58c8992 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -3,6 +3,7 @@ config ARM64
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select HAVE_ACPI_APEI if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index caafd63..da657a9 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -17,6 +17,7 @@
 
 #include <asm/cputype.h>
 #include <asm/smp_plat.h>
+#include <asm/tlbflush.h>
 
 /* Macros for consistency checks of the GICC subtable of MADT */
 #define ACPI_MADT_GICC_LENGTH	\
@@ -94,6 +95,10 @@ static inline const char *acpi_get_enable_method(int cpu)
 
 #ifdef	CONFIG_ACPI_APEI
 pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
-#endif
 
+static inline void arch_apei_flush_tlb_one(unsigned long addr)
+{
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+}
+#endif /* CONFIG_ACPI_APEI */
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index db3622f..1f9107b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -74,6 +74,7 @@ config X86
 	select GENERIC_TIME_VSYSCALL
 	select HAVE_ACPI_APEI			if ACPI
 	select HAVE_ACPI_APEI_NMI		if ACPI
+	select HAVE_ACPI_APEI_HEST_IA32		if ACPI
 	select HAVE_ALIGNED_STRUCT_PAGE		if SLUB
 	select HAVE_AOUT			if X86_32
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index b0140c8..a60bb00 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -4,6 +4,9 @@ config HAVE_ACPI_APEI
 config HAVE_ACPI_APEI_NMI
 	bool
 
+config HAVE_ACPI_APEI_HEST_IA32
+	bool
+
 config ACPI_APEI
 	bool "ACPI Platform Error Interface (APEI)"
 	select MISC_FILESYSTEMS
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 20b3fcf..c708c95 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -117,15 +117,27 @@ int apei_hest_parse(apei_hest_func_t func, void *data)
 }
 EXPORT_SYMBOL_GPL(apei_hest_parse);
 
+#ifdef CONFIG_HAVE_ACPI_APEI_HEST_IA32
 /*
  * Check if firmware advertises firmware first mode. We need FF bit to be set
  * along with a set of MC banks which work in FF mode.
  */
 static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr, void *data)
 {
-	return arch_apei_enable_cmcff(hest_hdr, data);
+	if (!acpi_disable_cmcff)
+		return !arch_apei_enable_cmcff(hest_hdr, data);
+
+	return 0;
 }
 
+static inline int __init hest_ia_init(void)
+{
+	return apei_hest_parse(hest_parse_cmc, NULL);
+}
+#else
+static inline int __init hest_ia_init(void) { return 0; }
+#endif
+
 struct ghes_arr {
 	struct platform_device **ghes_devs;
 	unsigned int count;
@@ -232,8 +244,9 @@ void __init acpi_hest_init(void)
 		goto err;
 	}
 
-	if (!acpi_disable_cmcff)
-		apei_hest_parse(hest_parse_cmc, NULL);
+	rc = hest_ia_init();
+	if (rc)
+		goto err;
 
 	if (!ghes_disable) {
 		rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
-- 
2.5.0
