From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Mon, 20 Jun 2016 13:56:13 +0300
Subject: [PATCH v4 5/5] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
In-Reply-To: <20160620105615.15538-1-aleksey.makarov@linaro.org>
References: <20160620105615.15538-1-aleksey.makarov@linaro.org>
Message-ID: <20160620105615.15538-6-aleksey.makarov@linaro.org>
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
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig            | 1 +
 arch/arm64/include/asm/acpi.h | 2 ++
 arch/arm64/kernel/setup.c     | 6 ++++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a377a1f..0cf7b43 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -5,6 +5,7 @@ config ARM64
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 4b13ecd..5420cb0 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -121,4 +121,6 @@ static inline int arm64_acpi_numa_init(void) { return -ENOSYS; }
 static inline int acpi_numa_get_nid(unsigned int cpu, u64 hwid) { return NUMA_NO_NODE; }
 #endif /* CONFIG_ACPI_NUMA */
 
+#define ACPI_TABLE_UPGRADE_MAX_PHYS MEMBLOCK_ALLOC_ACCESSIBLE
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
2.8.3
