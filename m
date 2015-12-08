From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Tue,  8 Dec 2015 15:03:03 +0800
Subject: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
Message-ID: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

This commit provides APEI arch-specific bits for aarch64

Meanwhile, add a new subfunction "hest_ia_init" for
"acpi_disable_cmcff" which is used by IA-32 Architecture
Corrected Machine Check (CMC).

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
Changelog:
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
 arch/arm64/include/asm/acpi.h |  5 +++++
 drivers/acpi/apei/hest.c      | 19 ++++++++++++++++---
 3 files changed, 22 insertions(+), 3 deletions(-)

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
index caafd63..31d3d9a 100644
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
+static inline void arch_apei_flush_tlb_one(unsigned long addr)
+{
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+}
 #endif
 
 #endif /*_ASM_ACPI_H*/
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 20b3fcf..715c58b 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -117,15 +117,27 @@ int apei_hest_parse(apei_hest_func_t func, void *data)
 }
 EXPORT_SYMBOL_GPL(apei_hest_parse);
 
+#if defined(__i386__) || defined(__x86_64__)
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
