From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 19 Sep 2012 20:10:58 -0400
Subject: [PATCH 02/15] ARM: Add page table and page defines needed by KVM
In-Reply-To: <20120919092134.GA22271@mudshark.cambridge.arm.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153443.21241.37958.stgit@ubuntu>
 <20120918124724.GK32204@mudshark.cambridge.arm.com>
 <CANM98qJZBYjBh5Jqu4H_oiS+4vgVi3PNcOUP1prUApOTmhoqpQ@mail.gmail.com>
 <20120919092134.GA22271@mudshark.cambridge.arm.com>
Message-ID: <CANM98qKN-pzJS5Br1nw3TV2pXAq0Tdc039=uRVu-mD0p6L48Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 5:21 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Sep 18, 2012 at 11:01:27PM +0100, Christoffer Dall wrote:
>> On Tue, Sep 18, 2012 at 8:47 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Sat, Sep 15, 2012 at 04:34:43PM +0100, Christoffer Dall wrote:
>> >> +#define L_PTE2_SHARED                L_PTE_SHARED
>> >> +#define L_PTE2_READ          (_AT(pteval_t, 1) << 6) /* HAP[0] */
>> >> +#define L_PTE2_WRITE         (_AT(pteval_t, 1) << 7) /* HAP[1] */
>> >
>> > This is actually HAP[2:1], not HAP[1:0]. Also, can you follow what we do for
>> > stage 1 translation and name these RDONLY and WRONLY (do you even use
>> > that?).
>> >
>>
>> The ARM arm is actually ambiguous, B3-1335 defines it as HAP[2:1], but
>> B3-1355 defines it as HAP[1:0] and I chose the latter as it is more
>> clear to most people not knowing that for historical reasons {H}AP[0]
>> is not defined. If there's a consensus for the other choice here, then
>> I'm good with that.
>
> Just checked the latest ARM ARM (rev C) and "HAP[1:0]" doesn't appear anywhere
> in the document, so it looks like it's been fixed.
>
>> Also, these bits have a different meaning for stage-2, HAP[2] (ok, in
>> this case it's less misleading with bit index 2), HAP[2] actually
>> means you can write this, two clear bits means access denied, not
>> read/write, so it made more sense to me to do:
>>
>> prot = READ | WRITE;
>>
>> than
>>
>> prt = RDONLY | WRONLY; // (not mutually exclusive). See my point?
>
> If you define the bits like:
>
>   L_PTE_S2_RDONLY       (_AT(pteval_t, 1) << 6)
>   L_PTE_S2_WRONLY       (_AT(pteval_t, 2) << 6)
>
> then I think it's fairly clear and it also matches the ARM ARM descriptions
> for the HAP permissions. You could also add L_PTE_S2_RDWR if you don't like
> orring the things elsewhere.
>

ok

>> >
>> > It would be cleaner to separate the cacheability attributes out from here
>> > and into the cache_policies array. Then you just need L_PTE_HYP_RDONLY here.
>> >
>>
>> ok, below is an attempt to rework all this, comments please:
>>
>>
>> diff --git a/arch/arm/include/asm/pgtable-3level.h
>> b/arch/arm/include/asm/pgtable-3level.h
>> index 7351eee..6df235c 100644
>> --- a/arch/arm/include/asm/pgtable-3level.h
>> +++ b/arch/arm/include/asm/pgtable-3level.h
>> @@ -103,13 +103,19 @@
>>  #define L_PGD_SWAPPER                (_AT(pgdval_t, 1) << 55)        /* swapper_pg_dir entry */
>>
>>  /*
>> - * 2-nd stage PTE definitions for LPAE.
>> + * 2nd stage PTE definitions for LPAE.
>>   */
>> -#define L_PTE2_SHARED                L_PTE_SHARED
>> -#define L_PTE2_READ          (_AT(pteval_t, 1) << 6) /* HAP[0] */
>> -#define L_PTE2_WRITE         (_AT(pteval_t, 1) << 7) /* HAP[1] */
>> -#define L_PTE2_NORM_WB               (_AT(pteval_t, 3) << 4) /* MemAttr[3:2] */
>> -#define L_PTE2_INNER_WB              (_AT(pteval_t, 3) << 2) /* MemAttr[1:0] */
>> +#define L_PTE_S2_SHARED              L_PTE_SHARED
>> +#define L_PTE_S2_READ                (_AT(pteval_t, 1) << 6)   /* HAP[1] */
>> +#define L_PTE_S2_WRITE               (_AT(pteval_t, 1) << 7)   /* HAP[2] */
>> +#define L_PTE_S2_MT_UNCACHED (_AT(pteval_t, 0x5) << 2) /* MemAttr[3:0] */
>> +#define L_PTE_S2_MT_WRTHROUGH        (_AT(pteval_t, 0xa) << 2) /* MemAttr[3:0] */
>> +#define L_PTE_S2_MT_WRBACK   (_AT(pteval_t, 0xf) << 2) /* MemAttr[3:0] */
>
> Again, just use the same names as we do for stage 1. It really makes the
> code easier to read (L_PTE_S2_MT_WRITETHROUGH etc.).
>

ok, I've changed it, they're just really long

>> +/*
>> + * Hyp-mode PL2 PTE definitions for LPAE.
>> + */
>> +#define L_PTE_HYP            L_PTE_USER
>>
>>  #ifndef __ASSEMBLY__
>>
>> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
>> index c422f62..6ab276b 100644
>> --- a/arch/arm/include/asm/pgtable.h
>> +++ b/arch/arm/include/asm/pgtable.h
>> @@ -83,10 +83,8 @@ extern pgprot_t            pgprot_guest;
>>  #define PAGE_READONLY_EXEC   _MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY)
>>  #define PAGE_KERNEL          _MOD_PROT(pgprot_kernel, L_PTE_XN)
>>  #define PAGE_KERNEL_EXEC     pgprot_kernel
>> -#define PAGE_HYP             _MOD_PROT(pgprot_kernel, L_PTE_USER)
>> -#define PAGE_KVM_GUEST               _MOD_PROT(pgprot_guest, L_PTE2_READ | \
>> -                                       L_PTE2_NORM_WB | L_PTE2_INNER_WB | \
>> -                                       L_PTE2_SHARED)
>> +#define PAGE_HYP             _MOD_PROT(pgprot_kernel, L_PTE_HYP)
>> +#define PAGE_KVM_GUEST               _MOD_PROT(pgprot_guest, L_PTE_S2_READ)
>>
>>  #define __PAGE_NONE          __pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN)
>>  #define __PAGE_SHARED                __pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 82d0edf..3ff427b 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -476,7 +476,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm,
>> phys_addr_t guest_ipa,
>>
>>       end = (guest_ipa + size + PAGE_SIZE - 1) & PAGE_MASK;
>>       prot = __pgprot(get_mem_type_prot_pte(MT_DEVICE) | L_PTE_USER |
>> -                     L_PTE2_READ | L_PTE2_WRITE);
>> +                     L_PTE_S2_READ | L_PTE_S2_WRITE);
>>       pfn = __phys_to_pfn(pa);
>>
>>       for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
>> @@ -567,7 +567,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu,
>> phys_addr_t fault_ipa,
>>               goto out;
>>       new_pte = pfn_pte(pfn, PAGE_KVM_GUEST);
>>       if (writable)
>> -             pte_val(new_pte) |= L_PTE2_WRITE;
>> +             pte_val(new_pte) |= L_PTE_S2_WRITE;
>>       coherent_icache_guest_page(vcpu->kvm, gfn);
>>
>>       spin_lock(&vcpu->kvm->arch.pgd_lock);
>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> index f2b6287..a06f3496 100644
>> --- a/arch/arm/mm/mmu.c
>> +++ b/arch/arm/mm/mmu.c
>> @@ -67,6 +67,7 @@ struct cachepolicy {
>>       unsigned int    cr_mask;
>>       pmdval_t        pmd;
>>       pteval_t        pte;
>> +     pteval_t        pte_s2;
>>  };
>>
>>  static struct cachepolicy cache_policies[] __initdata = {
>> @@ -75,26 +76,31 @@ static struct cachepolicy cache_policies[] __initdata = {
>>               .cr_mask        = CR_W|CR_C,
>>               .pmd            = PMD_SECT_UNCACHED,
>>               .pte            = L_PTE_MT_UNCACHED,
>> +             .pte_s2         = L_PTE_S2_MT_UNCACHED,
>>       }, {
>>               .policy         = "buffered",
>>               .cr_mask        = CR_C,
>>               .pmd            = PMD_SECT_BUFFERED,
>>               .pte            = L_PTE_MT_BUFFERABLE,
>> +             .pte_s2         = L_PTE_S2_MT_UNCACHED,
>>       }, {
>>               .policy         = "writethrough",
>>               .cr_mask        = 0,
>>               .pmd            = PMD_SECT_WT,
>>               .pte            = L_PTE_MT_WRITETHROUGH,
>> +             .pte_s2         = L_PTE_S2_MT_WRTHROUGH,
>>       }, {
>>               .policy         = "writeback",
>>               .cr_mask        = 0,
>>               .pmd            = PMD_SECT_WB,
>>               .pte            = L_PTE_MT_WRITEBACK,
>> +             .pte_s2         = L_PTE_S2_MT_WRBACK,
>>       }, {
>>               .policy         = "writealloc",
>>               .cr_mask        = 0,
>>               .pmd            = PMD_SECT_WBWA,
>>               .pte            = L_PTE_MT_WRITEALLOC,
>> +             .pte_s2         = L_PTE_S2_MT_WRBACK,
>>       }
>>  };
>
> Does this still compile for classic MMU? It might be nicer to use arrays for
> the pte types instead of the extra field too -- I assume you'll want
> something similar for the pmd if/when you map stage2 translations using
> sections?
>

definitely did not compile for MMU, and was just an RFC. I don't think
it's nicer to have an opaque array than an explicit field as it is
clearer and requires less code changes, and I think we will add the
pmd_s2 field when we need it, so we don't merge untested code. Perhaps
I am missing some good reason to use an array.

>> @@ -318,7 +324,7 @@ static void __init build_mem_type_table(void)
>>  {
>>       struct cachepolicy *cp;
>>       unsigned int cr = get_cr();
>> -     pteval_t user_pgprot, kern_pgprot, vecs_pgprot;
>> +     pteval_t user_pgprot, kern_pgprot, vecs_pgprot, guest_pgprot;
>>       int cpu_arch = cpu_architecture();
>>       int i;
>>
>> @@ -430,6 +436,7 @@ static void __init build_mem_type_table(void)
>>        */
>>       cp = &cache_policies[cachepolicy];
>>       vecs_pgprot = kern_pgprot = user_pgprot = cp->pte;
>> +     guest_pgprot = cp->pte_s2;
>>
>>       /*
>>        * Enable CPU-specific coherency if supported.
>> @@ -464,6 +471,7 @@ static void __init build_mem_type_table(void)
>>                       user_pgprot |= L_PTE_SHARED;
>>                       kern_pgprot |= L_PTE_SHARED;
>>                       vecs_pgprot |= L_PTE_SHARED;
>> +                     guest_pgprot |= L_PTE_SHARED;
>
> If we're using L_PTE_SHARED directly, do we even need L_PTE_S2_SHARED to be
> defined?
>

nope, removed it.

>>                       mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
>>                       mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
>>                       mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
>> @@ -518,7 +526,7 @@ static void __init build_mem_type_table(void)
>>       pgprot_user   = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | user_pgprot);
>>       pgprot_kernel = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG |
>>                                L_PTE_DIRTY | kern_pgprot);
>> -     pgprot_guest  = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG);
>> +     pgprot_guest  = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | guest_pgprot);
>
> We don't have L_PTE_S2_PRESENT, for example.
>
> I'll try and get on to the meat of the code at some point, but there's an
> awful lot of it and it's hard to see how it fits together.
>
I don't think it's that bad once you understand the KVM structure
(which you will need to anyway to review the code) and it's very much
self-contained. In any case, I'll be available for any questions to
clarify things if needed. I appreciate the review very much!

Here's an updated version of the entire patch that compile both
with/without LPAE:


Author: Christoffer Dall <c.dall@virtualopensystems.com>
Date:   Wed Sep 19 17:50:07 2012 -0400

    ARM: Add page table and page defines needed by KVM

    KVM uses the stage-2 page tables and the Hyp page table format,
    so let's define the fields we need to access in KVM.

    We use pgprot_guest to indicate stage-2 entries.

    Christoffer Dall <c.dall@virtualopensystems.com>

diff --git a/arch/arm/include/asm/pgtable-3level.h
b/arch/arm/include/asm/pgtable-3level.h
index b249035..eaba5a4 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -102,11 +102,29 @@
  */
 #define L_PGD_SWAPPER		(_AT(pgdval_t, 1) << 55)	/* swapper_pg_dir entry */

+/*
+ * 2nd stage PTE definitions for LPAE.
+ */
+#define L_PTE_S2_MT_UNCACHED	 (_AT(pteval_t, 0x5) << 2) /* MemAttr[3:0] */
+#define L_PTE_S2_MT_WRITETHROUGH (_AT(pteval_t, 0xa) << 2) /* MemAttr[3:0] */
+#define L_PTE_S2_MT_WRITEBACK	 (_AT(pteval_t, 0xf) << 2) /* MemAttr[3:0] */
+#define L_PTE_S2_RDONLY		 (_AT(pteval_t, 1) << 6)   /* HAP[1]   */
+#define L_PTE_S2_RDWR		 (_AT(pteval_t, 2) << 6)   /* HAP[2:1] */
+
+/*
+ * Hyp-mode PL2 PTE definitions for LPAE.
+ */
+#define L_PTE_HYP		L_PTE_USER
+
 #ifndef __ASSEMBLY__

 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & 2))
 #define pud_present(pud)	(pud_val(pud))
+#define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
+						 PMD_TYPE_TABLE)
+#define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
+						 PMD_TYPE_SECT)

 #define pud_clear(pudp)			\
 	do {				\
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 41dc31f..f9a124a 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -70,6 +70,7 @@ extern void __pgd_error(const char *file, int line, pgd_t);

 extern pgprot_t		pgprot_user;
 extern pgprot_t		pgprot_kernel;
+extern pgprot_t		pgprot_guest;

 #define _MOD_PROT(p, b)	__pgprot(pgprot_val(p) | (b))

@@ -82,6 +83,8 @@ extern pgprot_t		pgprot_kernel;
 #define PAGE_READONLY_EXEC	_MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY)
 #define PAGE_KERNEL		_MOD_PROT(pgprot_kernel, L_PTE_XN)
 #define PAGE_KERNEL_EXEC	pgprot_kernel
+#define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_HYP)
+#define PAGE_KVM_GUEST		_MOD_PROT(pgprot_guest, L_PTE_S2_RDONLY)

 #define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN)
 #define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 57f21de..6267f38 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -56,43 +56,57 @@ static unsigned int cachepolicy __initdata =
CPOLICY_WRITEBACK;
 static unsigned int ecc_mask __initdata = 0;
 pgprot_t pgprot_user;
 pgprot_t pgprot_kernel;
+pgprot_t pgprot_guest;

 EXPORT_SYMBOL(pgprot_user);
 EXPORT_SYMBOL(pgprot_kernel);
+EXPORT_SYMBOL(pgprot_guest);

 struct cachepolicy {
 	const char	policy[16];
 	unsigned int	cr_mask;
 	pmdval_t	pmd;
 	pteval_t	pte;
+	pteval_t	pte_s2;
 };

+#ifdef CONFIG_ARM_LPAE
+#define s2_policy(policy)	policy
+#else
+#define s2_policy(policy)	0
+#endif
+
 static struct cachepolicy cache_policies[] __initdata = {
 	{
 		.policy		= "uncached",
 		.cr_mask	= CR_W|CR_C,
 		.pmd		= PMD_SECT_UNCACHED,
 		.pte		= L_PTE_MT_UNCACHED,
+		.pte_s2		= s2_policy(L_PTE_S2_MT_UNCACHED),
 	}, {
 		.policy		= "buffered",
 		.cr_mask	= CR_C,
 		.pmd		= PMD_SECT_BUFFERED,
 		.pte		= L_PTE_MT_BUFFERABLE,
+		.pte_s2		= s2_policy(L_PTE_S2_MT_UNCACHED),
 	}, {
 		.policy		= "writethrough",
 		.cr_mask	= 0,
 		.pmd		= PMD_SECT_WT,
 		.pte		= L_PTE_MT_WRITETHROUGH,
+		.pte_s2		= s2_policy(L_PTE_S2_MT_WRITETHROUGH),
 	}, {
 		.policy		= "writeback",
 		.cr_mask	= 0,
 		.pmd		= PMD_SECT_WB,
 		.pte		= L_PTE_MT_WRITEBACK,
+		.pte_s2		= s2_policy(L_PTE_S2_MT_WRITEBACK),
 	}, {
 		.policy		= "writealloc",
 		.cr_mask	= 0,
 		.pmd		= PMD_SECT_WBWA,
 		.pte		= L_PTE_MT_WRITEALLOC,
+		.pte_s2		= s2_policy(L_PTE_S2_MT_WRITEBACK),
 	}
 };

@@ -314,7 +328,7 @@ static void __init build_mem_type_table(void)
 {
 	struct cachepolicy *cp;
 	unsigned int cr = get_cr();
-	pteval_t user_pgprot, kern_pgprot, vecs_pgprot;
+	pteval_t user_pgprot, kern_pgprot, vecs_pgprot, guest_pgprot;
 	int cpu_arch = cpu_architecture();
 	int i;

@@ -426,6 +440,7 @@ static void __init build_mem_type_table(void)
 	 */
 	cp = &cache_policies[cachepolicy];
 	vecs_pgprot = kern_pgprot = user_pgprot = cp->pte;
+	guest_pgprot = cp->pte_s2;

 	/*
 	 * Enable CPU-specific coherency if supported.
@@ -460,6 +475,7 @@ static void __init build_mem_type_table(void)
 			user_pgprot |= L_PTE_SHARED;
 			kern_pgprot |= L_PTE_SHARED;
 			vecs_pgprot |= L_PTE_SHARED;
+			guest_pgprot |= L_PTE_SHARED;
 			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
 			mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
 			mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
@@ -514,6 +530,7 @@ static void __init build_mem_type_table(void)
 	pgprot_user   = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | user_pgprot);
 	pgprot_kernel = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG |
 				 L_PTE_DIRTY | kern_pgprot);
+	pgprot_guest  = __pgprot(L_PTE_PRESENT | L_PTE_YOUNG | guest_pgprot);

 	mem_types[MT_LOW_VECTORS].prot_l1 |= ecc_mask;
 	mem_types[MT_HIGH_VECTORS].prot_l1 |= ecc_mask;
