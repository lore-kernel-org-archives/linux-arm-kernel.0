From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Wed,  2 Dec 2015 22:59:05 +0800
Subject: [PATCH v2] acpi, apei, arm64: APEI initial support for aarch64.
Message-ID: <1449068345-9021-1-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

This commit provides APEI arch-specific bits for aarch64

Changelog:
v2: Rebase to latest kernel version(4.4-rc3).
    Move arch_apei_flush_tlb_one() to arch/arm64/kernel/acpi.c

v1: https://lkml.org/lkml/2015/8/14/199
    Move arch_apei_flush_tlb_one() to arch/arm64/include/asm/apci.h.
    Delete arch/arm64/kernel/apei.c.
    Add "#ifdef CONFIG_ACPI_APEI" for "acpi_disable_cmcff".

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Tested-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 arch/arm64/Kconfig            |  1 +
 arch/arm64/include/asm/acpi.h |  4 ++++
 arch/arm64/kernel/acpi.c      | 10 ++++++++++
 3 files changed, 15 insertions(+)

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
index caafd63..0d70c74 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -46,6 +46,9 @@ typedef u64 phys_cpuid_t;
 extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
+#ifdef CONFIG_ACPI_APEI
+extern int acpi_disable_cmcff;
+#endif
 
 static inline void disable_acpi(void)
 {
@@ -94,6 +97,7 @@ static inline const char *acpi_get_enable_method(int cpu)
 
 #ifdef	CONFIG_ACPI_APEI
 pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
+void arch_apei_flush_tlb_one(unsigned long addr);
 #endif
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index d1ce8e2..811fea2 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -32,6 +32,7 @@
 #ifdef CONFIG_ACPI_APEI
 # include <linux/efi.h>
 # include <asm/pgtable.h>
+# include <asm/tlbflush.h>
 #endif
 
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
@@ -41,6 +42,10 @@ EXPORT_SYMBOL(acpi_disabled);
 int acpi_pci_disabled = 1;	/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
+#ifdef CONFIG_ACPI_APEI
+int acpi_disable_cmcff;
+#endif
+
 static bool param_acpi_off __initdata;
 static bool param_acpi_force __initdata;
 
@@ -233,4 +238,9 @@ pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 		return __pgprot(PROT_NORMAL_NC);
 	return __pgprot(PROT_DEVICE_nGnRnE);
 }
+
+void arch_apei_flush_tlb_one(unsigned long addr)
+{
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+}
 #endif
-- 
2.5.0
