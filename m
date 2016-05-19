From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Thu, 19 May 2016 19:15:16 +0300
Subject: [PATCH v2 5/5] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
In-Reply-To: <1463674518-22477-1-git-send-email-aleksey.makarov@linaro.org>
References: <1463674518-22477-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1463674518-22477-6-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Masters <jcm@redhat.com>

This patch adds support for ACPI_TABLE_UPGRADE for ARM64

To access initrd image we need to move initialization
of linear mapping a bit earlier.

The implementation of the feature acpi_table_upgrade()
(drivers/acpi/tables.c) works with initrd data represented as an array
in virtual memory.  It uses some library utility to find the redefined
tables in that array and iterates over it to copy the data to new
allocated memory.  So to access the initrd data via fixmap
we need to rewrite it considerably.

In x86 arch, kernel memory is already mapped by the time when
acpi_table_upgrade() and acpi_boot_table_init() are called so I
think that we can just move this mapping one function earlier too.

Signed-off-by: Jon Masters <jcm@redhat.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/arm64/Kconfig            | 1 +
 arch/arm64/include/asm/acpi.h | 2 ++
 arch/arm64/kernel/setup.c     | 6 ++++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d30abf..f4f9f56 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -5,6 +5,7 @@ config ARM64
 	select ACPI_PCI_HOST_GENERIC if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index aee323b..d75f6c7 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -113,4 +113,6 @@ static inline const char *acpi_get_enable_method(int cpu)
 pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr);
 #endif
 
+#define ACPI_TABLE_UPGRADE_MAX_PHYS PFN_PHYS(max_pfn)
+
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index feab2ee..4bce811 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -261,11 +261,13 @@ void __init setup_arch(char **cmdline_p)
 	efi_init();
 	arm64_memblock_init();
 
+	paging_init();
+
+	acpi_table_upgrade();
+
 	/* Parse the ACPI tables for possible boot-time configuration */
 	acpi_boot_table_init();
 
-	paging_init();
-
 	if (acpi_disabled)
 		unflatten_device_tree();
 
-- 
2.8.2
