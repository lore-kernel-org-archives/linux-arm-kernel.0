From: james.morse@arm.com (James Morse)
Date: Fri, 25 Nov 2016 18:30:37 +0000
Subject: [PATCH 1/2] arm64: Add enable/disable d-cache support for
 purgatory
In-Reply-To: <7a4866b928c0905ec1074dce1bfc7984c968a58a.1479788404.git.panand@redhat.com>
References: <cover.1479788404.git.panand@redhat.com>
 <7a4866b928c0905ec1074dce1bfc7984c968a58a.1479788404.git.panand@redhat.com>
Message-ID: <5838834D.90205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

(CC: Mark, mismatched memory attributes in paragraph 3?)

On 22/11/16 04:32, Pratyush Anand wrote:
> This patch adds support to enable/disable d-cache, which can be used for
> faster purgatory sha256 verification.

(I'm not clear why we want the sha256, but that is being discussed elsewhere on
 the thread)


> We are supporting only 4K and 64K page sizes. This code will not work if a
> hardware is not supporting at least one of these page sizes.  Therefore,
> D-cache is disabled by default and enabled only when "enable-dcache" is
> passed to the kexec().

I don't think the maybe-4K/maybe-64K/maybe-neither logic is needed. It would be
a lot simpler to only support one page size, which should be 4K as that is what
UEFI requires. (If there are CPUs that only support one size, I bet its 4K!)

I would go as far as to generate the page tables at 'kexec -l' time, and only if
'/sys/firmware/efi' exists to indicate we booted via UEFI. (and therefore must
support 4K pages). This would keep the purgatory code as simple as possible.

I don't think the performance difference between 4K and 64K page sizes will be
measurable, is purgatory really performance sensitive code?


> Since this is an identity mapped system, so VA_BITS will be same as max PA
> bits supported. If VA_BITS <= 42 for 64K and <= 39 for 4K then only one
> level of page table will be there with block descriptor entries.
> Otherwise, For 4K mapping, TTBR points to level 0 lookups, which will have
> only table entries pointing to a level 1 lookup. Level 1 will have only
> block entries which will map 1GB block. For 64K mapping, TTBR points to
> level 1 lookups, which will have only table entries pointing to a level 2
> lookup. Level 2 will have only block entries which will map 512MB block. If

This is more complexity to pick a VA size. Why not always use the maximum 48bit
VA? The cost is negligible compared to having simpler (easier to review!)
purgatory code.

By always using 1GB blocks you may be creating aliases with mismatched attributes:
* If kdump only reserves 128MB, your 1GB mapping will alias whatever else was
  in the same 1GB of address space. This could be a reserved region with some
  other memory attributes.
* With kdump, we may have failed to park the other CPUs if they are executing
  with interrupts masked and haven't yet handled the smp_send_stop() IPI.
* One of these other CPUs could be reading/writing in this area as it doesn't
  belong to the kdump reserved area, just happens to be in the same 1GB.

I need to dig through the ARM-ARM to find out what happens next, but I'm pretty
sure this is well into the "don't do that" territory.


It would be much better to force the memory areas to be a multiple of 2MB and
2MB aligned, which will allow you to use 2M section mappings for memory, (but
not the uart). This way we only map regions we had reserved and know are memory.


> UART base address and RAM addresses are not at least 1GB and 512MB apart
> for 4K and 64K respectively, then mapping result could be unpredictable. In
> that case we need to support one more level of granularity, but until
> someone needs that keep it like this only.
>
> We can not allocate dynamic memory in purgatory. Therefore we keep page
> table allocation size fixed as (3 * MAX_PAGE_SIZE). (page_table) points to
> first level (having only table entries) and (page_table + MAX_PAGE_SIZE)
> points to table at next level (having block entries).  If index for RAM
> area and UART area in first table is not same, then we will need another
> next level table which will be located at (page_table + 2 * MAX_PAGE_SIZE).


> diff --git a/purgatory/arch/arm64/cache-asm.S b/purgatory/arch/arm64/cache-asm.S
> new file mode 100644
> index 000000000000..bef97ef48888
> --- /dev/null
> +++ b/purgatory/arch/arm64/cache-asm.S
> @@ -0,0 +1,186 @@
> +/*
> + * Some of the routines have been copied from Linux Kernel, therefore
> + * copying the license as well.
> + *
> + * Copyright (C) 2001 Deep Blue Solutions Ltd.
> + * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 2015 Pratyush Anand <panand@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "cache.h"
> +
> +/*
> + * 	dcache_line_size - get the minimum D-cache line size from the CTR register.
> + */
> +	.macro	dcache_line_size, reg, tmp
> +	mrs	\tmp, ctr_el0			// read CTR
> +	ubfm	\tmp, \tmp, #16, #19		// cache line size encoding
> +	mov	\reg, #4			// bytes per word
> +	lsl	\reg, \reg, \tmp		// actual cache line size
> +	.endm
> +
> +/*
> + *	inval_cache_range(start, end)
> + *	- x0 - start	- start address of region
> + *	- x1 - end	- end address of region
> + */
> +.globl inval_cache_range
> +inval_cache_range:
> +	dcache_line_size x2, x3
> +	sub	x3, x2, #1
> +	tst	x1, x3				// end cache line aligned?
> +	bic	x1, x1, x3
> +	b.eq	1f
> +	dc	civac, x1			// clean & invalidate D / U line
> +1:	tst	x0, x3				// start cache line aligned?
> +	bic	x0, x0, x3
> +	b.eq	2f
> +	dc	civac, x0			// clean & invalidate D / U line
> +	b	3f
> +2:	dc	ivac, x0			// invalidate D / U line
> +3:	add	x0, x0, x2
> +	cmp	x0, x1
> +	b.lo	2b
> +	dsb	sy
> +	ret
> +/*
> + *	flush_dcache_range(start, end)
> + *	- x0 - start	- start address of region
> + *	- x1 - end	- end address of region
> + *
> + */
> +.globl flush_dcache_range
> +flush_dcache_range:
> +	dcache_line_size x2, x3
> +	sub	x3, x2, #1
> +	bic	x0, x0, x3
> +1:	dc	civac, x0			// clean & invalidate D line / unified line
> +	add	x0, x0, x2
> +	cmp	x0, x1
> +	b.lo	1b
> +	dsb	sy
> +	ret
> +
> +/*
> + *	invalidate_tlbs_el1()
> + */
> +.globl invalidate_tlbs_el1
> +invalidate_tlbs_el1:
> +	dsb	nshst
> +	tlbi	vmalle1
> +	dsb	nsh
> +	isb
> +	ret
> +
> +/*
> + *	invalidate_tlbs_el2()
> + */
> +.globl invalidate_tlbs_el2
> +invalidate_tlbs_el2:
> +	dsb	nshst
> +	tlbi	alle2
> +	dsb	nsh
> +	isb
> +	ret
> +
> +/*
> + * 	get_mm_feature_reg0_val - Get information about supported MM
> + * 	features
> + */
> +.globl get_mm_feature_reg0_val
> +get_mm_feature_reg0_val:
> +	mrs	x0, ID_AA64MMFR0_EL1
> +	ret
> +
> +/*
> + * 	get_current_el - Get information about current exception level
> + */
> +.globl get_current_el
> +get_current_el:
> +	mrs 	x0, CurrentEL
> +	lsr	x0, x0, #2
> +	ret
> +
> +/*
> + * 	invalidate_icache - Invalidate I-cache
> + */
> +.globl invalidate_icache
> +invalidate_icache:
> +	ic	iallu
> +	dsb	nsh
> +	isb
> +	ret
> +
> +/*
> + * 	set_mair_tcr_ttbr_sctlr_el1(page_table, tcr_flags) - sets MAIR, TCR , TTBR and SCTLR registers
> + * 	x0 - page_table - Page Table Base
> + * 	x1 - tcr_flags - TCR Flags to be set
> + */
> +.globl set_mair_tcr_ttbr_sctlr_el1
> +set_mair_tcr_ttbr_sctlr_el1:
> +	ldr	x2, =MEMORY_ATTRIBUTES
> +	msr	mair_el1, x2
> +	msr	tcr_el1, x1
> +	msr	ttbr0_el1, x0
> +	isb
> +	mrs	x0, sctlr_el1
> +	ldr	x3, =SCTLR_ELx_FLAGS
> +	orr	x0, x0, x3
> +	msr	sctlr_el1, x0
> +	isb
> +	ret
> +
> +/*
> + * 	set_mair_tcr_ttbr_sctlr_el2(page_table, tcr_flags) - sets MAIR, TCR , TTBR and SCTLR registers
> + * 	x0 - page_table - Page Table Base
> + * 	x1 - tcr_flags - TCR Flags to be set
> + */
> +.globl set_mair_tcr_ttbr_sctlr_el2
> +set_mair_tcr_ttbr_sctlr_el2:
> +	ldr	x2, =MEMORY_ATTRIBUTES
> +	msr	mair_el2, x2
> +	msr	tcr_el2, x1
> +	msr	ttbr0_el2, x0
> +	isb
> +	mrs	x0, sctlr_el2
> +	ldr	x3, =SCTLR_ELx_FLAGS
> +	orr	x0, x0, x3
> +	msr	sctlr_el2, x0
> +	isb
> +	ret
> +
> +/*
> + * reset_sctlr_el1 - disables cache and mmu
> + */
> +.globl reset_sctlr_el1
> +reset_sctlr_el1:
> +	mrs	x0, sctlr_el1
> +	bic	x0, x0, #SCTLR_ELx_C
> +	bic	x0, x0, #SCTLR_ELx_M
> +	msr	sctlr_el1, x0
> +	isb
> +	ret
> +
> +/*
> + * reset_sctlr_el2 - disables cache and mmu
> + */
> +.globl reset_sctlr_el2
> +reset_sctlr_el2:
> +	mrs	x0, sctlr_el2
> +	bic	x0, x0, #SCTLR_ELx_C
> +	bic	x0, x0, #SCTLR_ELx_M
> +	msr	sctlr_el2, x0
> +	isb
> +	ret
> diff --git a/purgatory/arch/arm64/cache.c b/purgatory/arch/arm64/cache.c
> new file mode 100644
> index 000000000000..3c7e058ccf11
> --- /dev/null
> +++ b/purgatory/arch/arm64/cache.c
> @@ -0,0 +1,330 @@
> +/*
> + * Copyright (C) 2015 Pratyush Anand <panand@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/* We are supporting only 4K and 64K page sizes. This code will not work if
> + * a hardware is not supporting at least one of these page sizes.
> + * Therefore, D-cache is disabled by default and enabled only when
> + * "enable-dcache" is passed to the kexec().
> + * Since this is an identity mapped system, so VA_BITS will be same as max
> + * PA bits supported. If VA_BITS <= 42 for 64K and <= 39 for 4K then only
> + * one level of page table will be there with block descriptor entries.
> + * Otherwise, For 4K mapping, TTBR points to level 0 lookups, which will
> + * have only table entries pointing to a level 1 lookup. Level 1 will have
> + * only block entries which will map 1GB block.For 64K mapping, TTBR points
> + * to level 1 lookups, which will have only table entries pointing to a
> + * level 2 lookup. Level 2 will have only block entries which will map
> + * 512MB block. If UART base address and RAM addresses are not at least 1GB
> + * and 512MB apart for 4K and 64K respectively, then mapping result could
> + * be unpredictable. In that case we need to support one more level of
> + * granularity, but until someone needs that keep it like this only.
> + * We can not allocate dynamic memory in purgatory. Therefore we keep page
> + * table allocation size fixed as (3 * MAX_PAGE_SIZE). (page_table) points
> + * to first level (having only table entries) and (page_table +
> + * MAX_PAGE_SIZE) points to table at next level (having block entries). If
> + * index for RAM area and UART area in first table is not same, then we
> + * will need another next level table which will be located at (page_table
> + * + 2 * MAX_PAGE_SIZE).
> + */
> +
> +#include <stdint.h>
> +#include <string.h>
> +#include <purgatory.h>
> +#include "cache.h"
> +
> +static uint64_t page_shift;
> +static uint64_t pgtable_level;
> +static uint64_t va_bits;
> +
> +static uint64_t page_table[PAGE_TABLE_SIZE / sizeof(uint64_t)] __attribute__ ((aligned (MAX_PAGE_SIZE))) = { };
> +static uint64_t page_table_used;
> +
> +#define PAGE_SIZE	(1 << page_shift)
> +/*
> + *	is_4k_page_supported - return true if 4k page is supported else
> + *	false
> + */
> +static int is_4k_page_supported(void)
> +{
> +	return ((get_mm_feature_reg0_val() & ID_AA64MMFR0_TGRAN4_MASK) ==
> +			ID_AA64MMFR0_TGRAN4_SUPPORTED);
> +}
> +
> +/*
> + *	is_64k_page_supported - return true if 64k page is supported else
> + *	false
> + */
> +static int is_64k_page_supported(void)
> +{
> +	return ((get_mm_feature_reg0_val() & ID_AA64MMFR0_TGRAN64_MASK) ==
> +			ID_AA64MMFR0_TGRAN64_SUPPORTED);
> +}
> +
> +/*
> + *	get_ips_bits - return supported IPS bits
> + */
> +static uint64_t get_ips_bits(void)
> +{
> +	return ((get_mm_feature_reg0_val() & ID_AA64MMFR0_PARANGE_MASK) >>
> +			ID_AA64MMFR0_PARANGE_SHIFT);
> +}
> +
> +/*
> + *	get_va_bits - return supported VA bits (For identity mapping VA = PA)
> + */
> +static uint64_t get_va_bits(void)
> +{
> +	uint64_t ips = get_ips_bits();
> +
> +	switch(ips) {
> +	case ID_AA64MMFR0_PARANGE_48:
> +		return 48;
> +	case ID_AA64MMFR0_PARANGE_44:
> +		return 44;
> +	case ID_AA64MMFR0_PARANGE_42:
> +		return 42;
> +	case ID_AA64MMFR0_PARANGE_40:
> +		return 40;
> +	case ID_AA64MMFR0_PARANGE_36:
> +		return 36;
> +	default:
> +		return 32;
> +	}
> +}
> +
> +/*
> + *	get_section_shift - get block shift for supported page size
> + */
> +static uint64_t get_section_shift(void)
> +{
> +	if (page_shift == 16)
> +		return 29;
> +	else if(page_shift == 12)
> +		return 30;
> +	else
> +		return 0;
> +}
> +
> +/*
> + *	get_section_mask - get section mask for supported page size
> + */
> +static uint64_t get_section_mask(void)
> +{
> +	if (page_shift == 16)
> +		return 0x1FFF;
> +	else if(page_shift == 12)
> +		return 0x1FF;
> +	else
> +		return 0;
> +}
> +
> +/*
> + *	get_pgdir_shift - get pgdir shift for supported page size
> + */
> +static uint64_t get_pgdir_shift(void)
> +{
> +	if (page_shift == 16)
> +		return 42;
> +	else if(page_shift == 12)
> +		return 39;
> +	else
> +		return 0;
> +}
> +
> +/*
> + *	init_page_table - Initializes page table locations
> + */
> +
> +static void init_page_table(void)
> +{
> +	/*
> +	 * Invalidate the page tables to avoid potential dirty cache lines
> +	 * being evicted.
> +	 */

How do these lines get dirty? arm64_relocate_new_kernel() invalidated these
pages to PoC before it copied the data. If they were speculatively fetched (I
don't know the rules of when/how that happens) they may be wrong, but will be
clean and not written back. If we change them in purgatory, you invalidate again
from enable_mmu_dcache(). I don't think this is needed.


> +	inval_cache_range((uint64_t)page_table,
> +			(uint64_t)page_table + PAGE_TABLE_SIZE);
> +	memset(page_table, 0, PAGE_TABLE_SIZE);
> +}
> +/*
> + *	create_identity_mapping(start, end, flags)
> + *	start		- start address
> + *	end		- end address
> + *	flags 		- MMU Flags for Normal or Device type memory
> + */
> +static void create_identity_mapping(uint64_t start, uint64_t end,
> +					uint64_t flags)
> +{
> +	uint32_t sec_shift, pgdir_shift, sec_mask;
> +	uint64_t desc, s1, e1, s2, e2;
> +	uint64_t *table2;
> +
> +	s1 = start;
> +	e1 = end - 1;
> +
> +	sec_shift = get_section_shift();
> +	if (pgtable_level == 1) {
> +		s1 >>= sec_shift;
> +		e1 >>= sec_shift;
> +		do {
> +			desc = s1 << sec_shift;
> +			desc |= flags;
> +			page_table[s1] = desc;
> +			s1++;
> +		} while (s1 <= e1);
> +	} else {
> +		pgdir_shift = get_pgdir_shift();
> +		sec_mask = get_section_mask();
> +		s1 >>= pgdir_shift;
> +		e1 >>= pgdir_shift;
> +		do {
> +			/*
> +			 * If there is no table entry then write a new
> +			 * entry else, use old entry
> +			 */
> +			if (!page_table[s1]) {
> +				table2 = &page_table[(++page_table_used *
> +						MAX_PAGE_SIZE) /
> +						sizeof(uint64_t)];
> +				desc = (uint64_t)table2 | PMD_TYPE_TABLE;
> +				page_table[s1] = desc;
> +			} else {
> +				table2 = (uint64_t *)(page_table[s1] &
> +						~PMD_TYPE_MASK);
> +			}
> +			s1++;
> +			s2 = start >> sec_shift;
> +			s2 &= sec_mask;
> +			e2 = (end - 1) >> sec_shift;
> +			e2 &= sec_mask;
> +			do {
> +				desc = s2 << sec_shift;
> +				desc |= flags;
> +				table2[s2] = desc;
> +				s2++;
> +			} while (s2 <= e2);
> +		} while (s1 <= e1);
> +	}
> +}

(I will need to come back to this ... it looks pretty complicated. If you mimic
Linux's p?d/pte macros it will be more familiar and easier to read.)


> +
> +/*
> + *	enable_mmu_dcache: Enable mmu and D-cache in sctlr_el1
> + */
> +static void enable_mmu_dcache(void)
> +{
> +	uint64_t tcr_flags = TCR_FLAGS | TCR_T0SZ(va_bits);
> +
> +	switch(page_shift) {
> +	case 16:
> +		tcr_flags |= TCR_TG0_64K;
> +		break;
> +	case 12:
> +		tcr_flags |= TCR_TG0_4K;
> +		break;
> +	default:
> +		printf("page shift not supported\n");
> +		return;
> +	}
> +	/*
> +	 * Since the page tables have been populated with non-cacheable
> +	 * accesses (MMU disabled), invalidate the page tables to remove
> +	 * any speculatively loaded cache lines.
> +	 */
> +	inval_cache_range((uint64_t)page_table,
> +				(uint64_t)page_table + PAGE_TABLE_SIZE);
> +
> +	switch(get_current_el()) {
> +	case 2:
> +		invalidate_tlbs_el2();
> +		tcr_flags |= (get_ips_bits() << TCR_PS_EL2_SHIFT);
> +		set_mair_tcr_ttbr_sctlr_el2((uint64_t)page_table, tcr_flags);
> +		break;
> +	case 1:
> +		invalidate_tlbs_el1();
> +		tcr_flags |= (get_ips_bits() << TCR_IPS_EL1_SHIFT);
> +		set_mair_tcr_ttbr_sctlr_el1((uint64_t)page_table, tcr_flags);
> +		break;
> +	default:
> +		return;
> +	}

> +	invalidate_icache();

What is this protecting against? We have executed instructions between here and
setting the I+M bits in set_mair_tcr_ttbr_sctlr_el1(). (so it may be too late)

arm64_relocate_new_kernel() already did 'ic iallu' before it branched into the
purgatory code. No executable code has been changed or moved since then, so I
don't think this is necessary.


> +}
> +
> +/*
> + *	enable_dcache: Enable D-cache and set appropriate attributes
> + *	ram_start - Start address of RAM
> + *	ram_end - End address of RAM
> + *	uart_base - Base address of uart
> + */
> +int enable_dcache(uint64_t ram_start, uint64_t ram_end, uint64_t uart_base)
> +{
> +	va_bits = get_va_bits();
> +
> +	page_table_used = 0;
> +	if (is_64k_page_supported()) {
> +		page_shift = 16;
> +		if (va_bits <= 42)
> +			pgtable_level = 1;
> +		else
> +			pgtable_level = 2;
> +	} else if (is_4k_page_supported()) {
> +		page_shift = 12;
> +		if (va_bits <= 39)
> +			pgtable_level = 1;
> +		else
> +			pgtable_level = 2;
> +	} else {
> +		printf("Valid Page Granule not supported by hardware\n");
> +		return -1;
> +	}
> +	init_page_table();
> +	create_identity_mapping(ram_start, ram_end, MM_MMUFLAGS_NORMAL);
> +	printf("Normal identity mapping created from %lx to %lx\n",
> +			ram_start, ram_end);
> +	if (uart_base) {
> +		create_identity_mapping((uint64_t)uart_base,
> +					(uint64_t)uart_base + PAGE_SIZE,
> +					MM_MMUFLAGS_DEVICE);
> +		printf("Device identity mapping created from %lx to %lx\n",
> +				(uint64_t)uart_base,
> +				(uint64_t)uart_base + PAGE_SIZE);
> +	}
> +	enable_mmu_dcache();
> +	printf("Cache Enabled\n");
> +
> +	return 0;
> +}
> +
> +/*
> + *	disable_dcache: Disable D-cache and flush RAM locations
> + *	ram_start - Start address of RAM
> + *	ram_end - End address of RAM
> + */
> +void disable_dcache(uint64_t ram_start, uint64_t ram_end)
> +{
> +	switch(get_current_el()) {
> +	case 2:
> +		reset_sctlr_el2();
> +		break;
> +	case 1:
> +		reset_sctlr_el1();

You have C code running between disabling the MMU and cleaning the cache. The
compiler is allowed to move data on and off the stack in here, but after
disabling the MMU it will see whatever was on the stack before we turned the MMU
on. Any data written at the beginning of this function is left in the caches.

I'm afraid this sort of stuff needs to be done in assembly!


> +		break;
> +	default:
> +		return;
> +	}
> +	invalidate_icache();
> +	flush_dcache_range(ram_start, ram_end);
> +	printf("Cache Disabled\n");
> +}
> diff --git a/purgatory/arch/arm64/cache.h b/purgatory/arch/arm64/cache.h
> new file mode 100644
> index 000000000000..c988020566e3
> --- /dev/null
> +++ b/purgatory/arch/arm64/cache.h
> @@ -0,0 +1,79 @@
> +#ifndef	__CACHE_H__
> +#define __CACHE_H__
> +
> +#define MT_DEVICE_NGNRNE	0
> +#define MT_DEVICE_NGNRE		1
> +#define MT_DEVICE_GRE		2
> +#define MT_NORMAL_NC		3
> +#define MT_NORMAL		4

You only use two of these. I guess this is so the MAIR value matches the kernel?


> +
> +#ifndef __ASSEMBLER__
> +
> +#define MAX_PAGE_SIZE		0x10000
> +#define PAGE_TABLE_SIZE		(3 * MAX_PAGE_SIZE)
> +#define ID_AA64MMFR0_TGRAN64_SHIFT	24
> +#define ID_AA64MMFR0_TGRAN4_SHIFT	28
> +#define ID_AA64MMFR0_TGRAN64_MASK	(0xFUL << ID_AA64MMFR0_TGRAN64_SHIFT)
> +#define ID_AA64MMFR0_TGRAN4_MASK	(0xFUL << ID_AA64MMFR0_TGRAN4_SHIFT)
> +#define ID_AA64MMFR0_TGRAN64_SUPPORTED	0x0
> +#define ID_AA64MMFR0_TGRAN4_SUPPORTED	0x0
> +#define ID_AA64MMFR0_PARANGE_SHIFT	0
> +#define ID_AA64MMFR0_PARANGE_MASK	(0xFUL << ID_AA64MMFR0_PARANGE_SHIFT)
> +#define ID_AA64MMFR0_PARANGE_48		0x5
> +#define ID_AA64MMFR0_PARANGE_44		0x4
> +#define ID_AA64MMFR0_PARANGE_42		0x3
> +#define ID_AA64MMFR0_PARANGE_40		0x2
> +#define ID_AA64MMFR0_PARANGE_36		0x1
> +#define ID_AA64MMFR0_PARANGE_32		0x0
> +
> +#define TCR_TG0_64K 		(1UL << 14)
> +#define TCR_TG0_4K 		(0UL << 14)
> +#define TCR_SHARED_NONE		(0UL << 12)
> +#define TCR_ORGN_WBWA		(1UL << 10)
> +#define TCR_IRGN_WBWA		(1UL << 8)
> +#define TCR_IPS_EL1_SHIFT	32
> +#define TCR_PS_EL2_SHIFT	16
> +#define TCR_T0SZ(x)		((unsigned long)(64 - (x)) << 0)
> +#define TCR_FLAGS (TCR_SHARED_NONE | TCR_ORGN_WBWA | TCR_IRGN_WBWA)
> +
> +#define PMD_TYPE_SECT		(1UL << 0)
> +#define PMD_TYPE_TABLE		(3UL << 0)
> +#define PMD_TYPE_MASK		0x3
> +#define PMD_SECT_AF		(1UL << 10)
> +#define PMD_ATTRINDX(t)		((unsigned long)(t) << 2)
> +#define PMD_FLAGS_NORMAL	(PMD_TYPE_SECT | PMD_SECT_AF)
> +#define PMD_SECT_PXN		(1UL << 53)
> +#define PMD_SECT_UXN		(1UL << 54)
> +#define PMD_FLAGS_DEVICE	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_PXN | PMD_SECT_UXN)
> +#define MM_MMUFLAGS_NORMAL	PMD_ATTRINDX(MT_NORMAL) | PMD_FLAGS_NORMAL
> +#define MM_MMUFLAGS_DEVICE	PMD_ATTRINDX(MT_DEVICE_NGNRE) | PMD_FLAGS_DEVICE
> +
> +void disable_dcache(uint64_t ram_start, uint64_t ram_end);
> +int enable_dcache(uint64_t ram_start, uint64_t ram_end, uint64_t uart_base);
> +uint64_t get_mm_feature_reg0_val(void);
> +void inval_cache_range(uint64_t start, uint64_t end);
> +void flush_dcache_range(uint64_t start, uint64_t end);
> +uint64_t get_current_el(void);
> +void set_mair_tcr_ttbr_sctlr_el1(uint64_t page_table, uint64_t tcr_flags);
> +void set_mair_tcr_ttbr_sctlr_el2(uint64_t page_table, uint64_t tcr_flags);
> +void invalidate_tlbs_el1(void);
> +void invalidate_tlbs_el2(void);
> +void invalidate_icache(void);
> +void reset_sctlr_el1(void);
> +void reset_sctlr_el2(void);
> +#else
> +#define MEMORY_ATTRIBUTES	((0x00 << (MT_DEVICE_NGNRNE*8)) | \
> +				(0x04 << (MT_DEVICE_NGNRE*8)) | \
> +				(0x0C << (MT_DEVICE_GRE*8)) | \
> +				(0x44 << (MT_NORMAL_NC*8)) | \
> +				(0xFF << (MT_NORMAL*8)))

Again, you only use two of these.


> +/* Common SCTLR_ELx flags. */
> +#define SCTLR_ELx_I		(1 << 12)
> +#define SCTLR_ELx_C		(1 << 2)
> +#define SCTLR_ELx_M		(1 << 0)
> +
> +#define SCTLR_ELx_FLAGS (SCTLR_ELx_M | SCTLR_ELx_C | SCTLR_ELx_I)
> +
> +#endif
> +#endif
> 


Thanks!

James
