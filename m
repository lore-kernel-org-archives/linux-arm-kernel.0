From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 14:04:40 +0100
Subject: [PATCH 4/8] ARM: mpu: add MPU probe and initialisation functions in C
In-Reply-To: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
References: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368536684-13608-5-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new functions for probing and initialising the ARMv7
PMSA-compliant MPU.

These use the pre-defined and reserved MPU_PROBE_REGION for establishing
properties of the MPU, which is necessary because certain probe operations
require modifying region properties and reading back the results.

This patch also introduces a minimal sanity_check_meminfo_mpu function, that
ensures that the memory set-up passed to the kernel can be used in conjunction
with the MPU. The base address of a region must be aligned to the region size,
otherwise behavior is unpredictable and region sizes can only be specified as a
power-of-two. To simplify the satisfaction of these requirements this
implementation currently enforces that all memory is contiguous from
PHYS_OFFSET, merging banks that are contiguous but passed in separately.

The functions are added in this patch but wired in to the boot process later
in the series.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
CC: Hyok S. Choi <hyok.choi@samsung.com>
---
 arch/arm/mm/nommu.c |  249 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index d51225f..0a9eb24 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -8,6 +8,7 @@
 #include <linux/pagemap.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
+#include <linux/kernel.h>
 
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
@@ -15,9 +16,257 @@
 #include <asm/setup.h>
 #include <asm/traps.h>
 #include <asm/mach/arch.h>
+#include <asm/cputype.h>
+#include <asm/mpu.h>
 
 #include "mm.h"
 
+#ifdef CONFIG_ARM_MPU
+struct mpu_rgn_info mpu_rgn_info;
+
+/* Region number */
+static void rgnr_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c2, 0" : : "r" (v));
+}
+
+/* Data-side / unified region attributes */
+
+/* Region access control register */
+static void dracr_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c1, 4" : : "r" (v));
+}
+
+/* Region size register */
+static void drsr_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c1, 2" : : "r" (v));
+}
+
+/* Region base address register */
+static void drbar_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c1, 0" : : "r" (v));
+}
+
+static u32 drbar_read(void)
+{
+	u32 v;
+	asm("mrc        p15, 0, %0, c6, c1, 0" : "=r" (v));
+	return v;
+}
+/* Optional instruction-side region attributes */
+
+/* I-side Region access control register */
+static void iracr_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c1, 5" : : "r" (v));
+}
+
+/* I-side Region size register */
+static void irsr_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c1, 3" : : "r" (v));
+}
+
+/* I-side Region base address register */
+static void irbar_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c1, 1" : : "r" (v));
+}
+
+static unsigned long irbar_read(void)
+{
+	unsigned long v;
+	asm("mrc        p15, 0, %0, c6, c1, 1" : "=r" (v));
+	return v;
+}
+
+/* MPU initialisation functions */
+void __init sanity_check_meminfo_mpu(void)
+{
+	int i;
+	struct membank *bank = meminfo.bank;
+	phys_addr_t phys_offset = PHYS_OFFSET;
+	phys_addr_t aligned_region_size, specified_mem_size, rounded_mem_size;
+
+	/* Initially only use memory continuous from PHYS_OFFSET */
+	if (bank_phys_start(&bank[0]) != phys_offset)
+		panic("First memory bank must be contiguous from PHYS_OFFSET");
+
+	/* Banks have already been sorted by start address */
+	for (i = 1; i < meminfo.nr_banks; i++) {
+		if (bank[i].start <= bank_phys_end(&bank[0]) &&
+		    bank_phys_end(&bank[i]) > bank_phys_end(&bank[0])) {
+			bank[0].size = bank_phys_end(&bank[i]) - bank[0].start;
+		} else {
+			pr_notice("Ignoring RAM after 0x%.8lx. "
+			"First non-contiguous (ignored) bank start: 0x%.8lx\n",
+				(unsigned long)bank_phys_end(&bank[0]),
+				(unsigned long)bank_phys_start(&bank[i]));
+			break;
+		}
+	}
+	/* All contiguous banks are now merged in to the first bank */
+	meminfo.nr_banks = 1;
+	specified_mem_size = bank[0].size;
+
+	/*
+	 * MPU has curious alignment requirements: Size must be power of 2, and
+	 * region start must be aligned to the region size
+	 */
+	if (phys_offset != 0)
+		pr_info("PHYS_OFFSET != 0 => MPU Region size constrained by alignment requirements\n");
+
+	/*
+	 * Maximum aligned region might overflow phys_addr_t if phys_offset is
+	 * 0. Hence we keep everything below 4G until we take the smaller of
+	 * the aligned_region_size and rounded_mem_size, one of which is
+	 * guaranteed to be smaller than the maximum physical address.
+	 */
+	aligned_region_size = (phys_offset - 1) ^ (phys_offset);
+	/* Find the max power-of-two sized region that fits inside our bank */
+	rounded_mem_size = (1 <<  __fls(bank[0].size)) - 1;
+
+	/* The actual region size is the smaller of the two */
+	aligned_region_size = aligned_region_size < rounded_mem_size
+				? aligned_region_size + 1
+				: rounded_mem_size + 1;
+
+	if (aligned_region_size != specified_mem_size)
+		pr_warn("Truncating memory from 0x%.8lx to 0x%.8lx (MPU region constraints)",
+				(unsigned long)specified_mem_size,
+				(unsigned long)aligned_region_size);
+
+	meminfo.bank[0].size = aligned_region_size;
+	pr_debug("MPU Region from 0x%.8lx size 0x%.8lx (end 0x%.8lx))\n",
+		(unsigned long)phys_offset,
+		(unsigned long)aligned_region_size,
+		(unsigned long)bank_phys_end(&bank[0]));
+
+}
+
+static int mpu_present(void)
+{
+	return ((read_cpuid_ext(CPUID_EXT_MMFR0) & MMFR0_PMSA) == MMFR0_PMSAv7);
+}
+
+static int mpu_max_regions(void)
+{
+	/*
+	 * We don't support a different number of I/D side regions so if we
+	 * have separate instruction and data memory maps then return
+	 * whichever side has a smaller number of supported regions.
+	 */
+	u32 dregions, iregions, mpuir;
+	mpuir = read_cpuid(CPUID_MPUIR);
+
+	dregions = iregions = (mpuir & MPUIR_DREGION_SZMASK) >> MPUIR_DREGION;
+
+	/* Check for separate d-side and i-side memory maps */
+	if (mpuir & MPUIR_nU)
+		iregions = (mpuir & MPUIR_IREGION_SZMASK) >> MPUIR_IREGION;
+
+	/* Use the smallest of the two maxima */
+	return min(dregions, iregions);
+}
+
+static int mpu_iside_independent(void)
+{
+	/* MPUIR.nU specifies whether there is *not* a unified memory map */
+	return read_cpuid(CPUID_MPUIR) & MPUIR_nU;
+}
+
+static int mpu_min_region_order(void)
+{
+	u32 drbar_result, irbar_result;
+	/* We've kept a region free for this probing */
+	rgnr_write(MPU_PROBE_REGION);
+	isb();
+	/*
+	 * As per ARM ARM, write 0xFFFFFFFC to DRBAR to find the minimum
+	 * region order
+	*/
+	drbar_write(0xFFFFFFFC);
+	drbar_result = irbar_result = drbar_read();
+	drbar_write(0x0);
+	/* If the MPU is non-unified, we use the larger of the two minima*/
+	if (mpu_iside_independent()) {
+		irbar_write(0xFFFFFFFC);
+		irbar_result = irbar_read();
+		irbar_write(0x0);
+	}
+	isb(); /* Ensure that MPU region operations have completed */
+	/* Return whichever result is larger */
+	return __ffs(max(drbar_result, irbar_result));
+}
+
+static int mpu_setup_region(unsigned int number, phys_addr_t start,
+			unsigned int size_order, unsigned int properties)
+{
+	u32 size_data;
+
+	/* We kept a region free for probing resolution of MPU regions*/
+	if (number > mpu_max_regions() || number == MPU_PROBE_REGION)
+		return -ENOENT;
+
+	if (size_order > 32)
+		return -ENOMEM;
+
+	if (size_order < mpu_min_region_order())
+		return -ENOMEM;
+
+	/* Writing N to bits 5:1 (RSR_SZ)  specifies region size 2^N+1 */
+	size_data = ((size_order - 1) << MPU_RSR_SZ) | 1 << MPU_RSR_EN;
+
+	dsb(); /* Ensure all previous data accesses occur with old mappings */
+	rgnr_write(number);
+	isb();
+	drbar_write(start);
+	dracr_write(properties);
+	isb(); /* Propagate properties before enabling region */
+	drsr_write(size_data);
+
+	/* Check for independent I-side registers */
+	if (mpu_iside_independent()) {
+		irbar_write(start);
+		iracr_write(properties);
+		isb();
+		irsr_write(size_data);
+	}
+	isb();
+
+	/* Store region info (we treat i/d side the same, so only store d) */
+	mpu_rgn_info.rgns[number].dracr = properties;
+	mpu_rgn_info.rgns[number].drbar = start;
+	mpu_rgn_info.rgns[number].drsr = size_data;
+	return 0;
+}
+
+/*
+* Set up default MPU regions, doing nothing if there is no MPU
+*/
+void __init mpu_setup(void)
+{
+	int region_err;
+	if (!mpu_present())
+		return;
+
+	region_err = mpu_setup_region(MPU_RAM_REGION, PHYS_OFFSET,
+					ilog2(meminfo.bank[0].size),
+					MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL);
+	if (region_err) {
+		panic("MPU region initialization failure! %d", region_err);
+	} else {
+		pr_info("Using ARMv7 PMSA Compliant MPU. "
+			 "Region independence: %s, Max regions: %d\n",
+			mpu_iside_independent() ? "Yes" : "No",
+			mpu_max_regions());
+	}
+}
+#endif /* CONFIG_ARM_MPU */
+
 void __init arm_mm_memblock_reserve(void)
 {
 	/*
-- 
1.7.9.5
