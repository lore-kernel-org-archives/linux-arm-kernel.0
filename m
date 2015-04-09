From: grygorii.strashko@linaro.org (Grygorii.Strashko@linaro.org)
Date: Thu, 09 Apr 2015 17:51:14 +0300
Subject: [PATCH 2/6] ARM: keystone2: move update of the phys-to-virt
 constants into generic code
In-Reply-To: <20150408175959.GO12732@n2100.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmXq-0006Wr-M7@rmk-PC.arm.linux.org.uk> <552541B1.2000501@linaro.org>
 <20150408175959.GO12732@n2100.arm.linux.org.uk>
Message-ID: <552691E2.2050000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 04/08/2015 09:00 PM, Russell King - ARM Linux wrote:
> On Wed, Apr 08, 2015 at 05:56:49PM +0300, Grygorii.Strashko at linaro.org wrote:
>> Hi Russell,
>>
>> On 04/08/2015 12:45 PM, Russell King wrote:
>>> Make the init_meminfo function return the offset to be applied to the
>>> phys-to-virt translation constants.  This allows us to move the update
>>> into generic code, along with the requirements for this update.
>>
>>
>> I have a question (or may be proposition) regarding this patch.
>>
>> Could it be reasonable if .init_meminfo() will return new PHYS offset
>> of RAM (new start address), instead of translation's offset?
> 
> I'm not that interested in such a change, for the simple reason that
> what we mostly want to know is what the _difference_ between what's
> already in the page tables, and what we want to update them to.
> 
> The page table update is a case of merely adding the delta to each
> page table entry.
> 
> If we were to want to pass the actual new physical address, we would
> have to have the fixup code mask out the old address, and insert the
> new address, keeping track of the offset into the kernel's mapping.
> We'd also have to do something weirder for the DT mapping too.
> 
> Using an offset makes the page table update rather trivial and easy.
> 
> I actually did start off with passing the new physical address
> initially, and I changed to this way because it simplified the
> assembly code.
> 

Ok, I understand the point, but still wish to try this proposition
(even if I'll be punished)).


First, the current commit description confused me a bit and that was the main
reason why I commented here. Commit message said:
 "Make the init_meminfo function return the offset to be applied to the
  phys-to-virt translation constants"

 but actual return value can't be applied to 
 "phys-to-virt translation constants" without modification.
 The offset to be applied to "phys-to-virt translation constants" should be
 (NEW_PHYS_OFFSET - PAGE_OFFSET) as per commit dc21af9.

 But now, the .init_meminfo() assumed to return offset between NEW and OLD
 RAM starting addresses : (NEW_PHYS_OFFSET - OLD_PHYS_OFFSET). 
 And, It looks like this offset actually needed only for lpae_pgtables_remap().

 I think, We can get all data needed for physical address switching and pgtables
 updating code from inside early_paging_init() except the NEW_PHYS_OFFSET -
 - new starting physical address of the RAM and, therefore, It seems reasonable
 to get it as return value of .pv_fixup().

 Therefore, I did a patch/diff on top of your series to illustrate this
 (no changes in the assembly code) - K2HK board boots.

Regardless of will you accept this change or not - I've tested boot on K2HK board
with yours patches (applied on top of k4.0-rc7), so
 Tested-by: Grygorii Strashko <grygorii.strashko@linaro.org>

-- 
regards,
-grygorii

----------->
>From ac22a2f5f163f09a7d51314fdaea231b98c22ec7 Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko@linaro.org>
Date: Thu, 9 Apr 2015 17:29:57 +0300
Subject: [PATCH] ARM: update .pv_fixup() to return new start phys address of ram

Update .pv_fixup() to return new start phys address of RAM instead
of offset between new and old RAM addresses. This will make code
a bit clear and can be done because three parameters need to be known
for proper physical address switching in early_paging_init():
 - OLD_PHYS_OFFSET
 - NEW_PHYS_OFFSET
 - PAGE_OFFSET (constant)

These parameters are used for calculation:
 -  __pv_offset = NEW_PHYS_OFFSET - PAGE_OFFSET which is
    used by phys-to-virt translation routines

 -  (NEW_PHYS_OFFSET - OLD_PHYS_OFFSET) offset which is
    used by pgtables updating routine lpae_pgtables_remap().

The OLD_PHYS_OFFSET == PHYS_OFFSET and can be saved at the
beginning of early_paging_init(). So, only NEW_PHYS_OFFSET is
unknown from inside early_paging_init() and, therefore, need
to be provided by platform code.

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 arch/arm/include/asm/mach/arch.h  |  2 +-
 arch/arm/mach-keystone/keystone.c |  4 ++--
 arch/arm/mm/mmu.c                 | 18 ++++++++++--------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index cb3a407..84acaba 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -51,7 +51,7 @@ struct machine_desc {
 	bool			(*smp_init)(void);
 	void			(*fixup)(struct tag *, char **);
 	void			(*dt_fixup)(void);
-	long long		(*pv_fixup)(void);
+	phys_addr_t		(*pv_fixup)(void);
 	void			(*reserve)(void);/* reserve mem blocks	*/
 	void			(*map_io)(void);/* IO mapping function	*/
 	void			(*init_early)(void);
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index e288010..f3816b1 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -68,7 +68,7 @@ static phys_addr_t keystone_virt_to_idmap(unsigned long x)
 	return (phys_addr_t)(x) - CONFIG_PAGE_OFFSET + KEYSTONE_LOW_PHYS_START;
 }
 
-static long long __init keystone_pv_fixup(void)
+static phys_addr_t __init keystone_pv_fixup(void)
 {
 	long long offset;
 	phys_addr_t mem_start, mem_end;
@@ -88,7 +88,7 @@ static long long __init keystone_pv_fixup(void)
 		return 0;
 	}
 
-	offset = KEYSTONE_HIGH_PHYS_START - KEYSTONE_LOW_PHYS_START;
+	offset = KEYSTONE_HIGH_PHYS_START;
 
 	/* Populate the arch idmap hook */
 	arch_virt_to_idmap = keystone_virt_to_idmap;
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b2e96bc..1d6c119 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1401,14 +1401,15 @@ void __init early_paging_init(const struct machine_desc *mdesc)
 	pgtables_remap *lpae_pgtables_remap;
 	unsigned long pa_pgd;
 	unsigned int cr;
-	long long offset;
+	phys_addr_t new_phys_offset;
+	phys_addr_t old_phys_offset = PHYS_OFFSET;
 	void *boot_data;
 
 	if (!mdesc->pv_fixup)
 		return;
 
-	offset = mdesc->pv_fixup();
-	if (offset == 0)
+	new_phys_offset = mdesc->pv_fixup();
+	if (new_phys_offset == 0)
 		return;
 
 	/*
@@ -1422,12 +1423,12 @@ void __init early_paging_init(const struct machine_desc *mdesc)
 	boot_data = __va(__atags_pointer);
 	barrier();
 
-	pr_info("Switching physical address space to 0x%08llx\n",
-		(u64)PHYS_OFFSET + offset);
+	pr_info("Switching physical address space to %pa\n",
+		&new_phys_offset);
 
 	/* Re-set the phys pfn offset, and the pv offset */
-	__pv_offset = PHYS_OFFSET + offset - PAGE_OFFSET;
-	__pv_phys_pfn_offset = PFN_DOWN(PHYS_OFFSET + offset);
+	__pv_offset = new_phys_offset - PAGE_OFFSET;
+	__pv_phys_pfn_offset = PFN_DOWN(new_phys_offset);
 
 	/* Run the patch stub to update the constants */
 	fixup_pv_table(&__pv_table_begin,
@@ -1451,7 +1452,8 @@ void __init early_paging_init(const struct machine_desc *mdesc)
 	 * needs to be assembly.  It's fairly simple, as we're using the
 	 * temporary tables setup by the initial assembly code.
 	 */
-	lpae_pgtables_remap(offset, pa_pgd, boot_data);
+	lpae_pgtables_remap((new_phys_offset - old_phys_offset),
+			    pa_pgd, boot_data);
 
 	/* Re-enable the caches */
 	set_cr(cr);
-- 
1.9.1
