From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Thu, 29 Nov 2012 13:59:07 -0500
Subject: [PATCH v4 02/14] ARM: Section based HYP idmap
In-Reply-To: <20121119141631.GU3205@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154224.2836.21775.stgit@chazy-air>
 <20121119141631.GU3205@mudshark.cambridge.arm.com>
Message-ID: <CANM98q+PnhXAxPQwo3Nu3B9okSsCxLitJ82tjF=awOuvSSS=nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 9:16 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Nov 10, 2012 at 03:42:24PM +0000, Christoffer Dall wrote:
>> Add a method (hyp_idmap_setup) to populate a hyp pgd with an
>> identity mapping of the code contained in the .hyp.idmap.text
>> section.
>>
>> Offer a method to drop this identity mapping through
>> hyp_idmap_teardown.
>>
>> Make all the above depend on CONFIG_ARM_VIRT_EXT and CONFIG_ARM_LPAE.
>>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>> ---
>>  arch/arm/include/asm/idmap.h                |    5 ++
>>  arch/arm/include/asm/pgtable-3level-hwdef.h |    1
>>  arch/arm/kernel/vmlinux.lds.S               |    6 ++
>>  arch/arm/mm/idmap.c                         |   74 +++++++++++++++++++++++----
>>  4 files changed, 73 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
>> index bf863ed..36708ba 100644
>> --- a/arch/arm/include/asm/idmap.h
>> +++ b/arch/arm/include/asm/idmap.h
>> @@ -11,4 +11,9 @@ extern pgd_t *idmap_pgd;
>>
>>  void setup_mm_for_reboot(void);
>>
>> +#ifdef CONFIG_ARM_VIRT_EXT
>> +void hyp_idmap_teardown(pgd_t *hyp_pgd);
>> +void hyp_idmap_setup(pgd_t *hyp_pgd);
>> +#endif
>
> I wonder whether the dependency is quite right here. Functionally, we're
> only dependent on LPAE but it doesn't make sense if !ARM_VIRT_EXT. In
> fact, I start to question whether CONFIG_ARM_VIRT_EXT is worthwhile at
> all as it stands. Maybe it would be better to add the LPAE dependency
> there and make the hyp_stub stuff that's currently in mainline
> unconditional?
>

perhaps it would be more clean, but it's not something that would
break to fix later, and not in that sense something this patch series
would depend on. If the hyp_stub stuff is truly compatible with all
legacy stuff then yes, we could remove that define, but if not, then I
guess it's necessary.

For now, I'll simply remove these ifdef's as Rob pointed out.

>> +/*
>> + * This version actually frees the underlying pmds for all pgds in range and
>> + * clear the pgds themselves afterwards.
>> + */
>> +void hyp_idmap_teardown(pgd_t *hyp_pgd)
>> +{
>> +     unsigned long addr, end;
>> +     unsigned long next;
>> +     pgd_t *pgd = hyp_pgd;
>> +
>> +     addr = virt_to_phys(__hyp_idmap_text_start);
>> +     end = virt_to_phys(__hyp_idmap_text_end);
>> +
>> +     pgd += pgd_index(addr);
>> +     do {
>> +             next = pgd_addr_end(addr, end);
>> +             if (!pgd_none_or_clear_bad(pgd))
>> +                     hyp_idmap_del_pmd(pgd, addr);
>> +     } while (pgd++, addr = next, addr < end);
>> +}
>> +EXPORT_SYMBOL_GPL(hyp_idmap_teardown);
>> +
>> +void hyp_idmap_setup(pgd_t *hyp_pgd)
>> +{
>> +     identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
>> +                          __hyp_idmap_text_end, PMD_SECT_AP1);
>> +}
>> +EXPORT_SYMBOL_GPL(hyp_idmap_setup);
>> +#endif
>
> Again, do we need these exports?

no we don't

>
> I also think it might be cleaner to declare the hyp_pgd next to the
> idmap_pgd then add the hyp_idmap_setup code to init_static_idmap, so
> that we don't add new entry points to this file. The teardown can all be
> moved into the kvm/ code as it doesn't need any of the existing idmap
> functions.
>

hmm, we had some attempts at this earlier, but it wasn't all that
nice. Allocating the hyp_pgd inside idmap.c requires some more logic,
and the #ifdefs inside init_static_idmap are also not pretty.
Additionally, other potential users of Hyp mode might have a separate
hyp_pgd, in theory.

While KVM is the only current user of hyp_idmap_teardown it's not
really KVM specific, and the could theoretically be other users of hyp
idmaps. Also, the externs __hyp_idmap_text_<start|end> would have to
be either moved to a header file or duplicated inside KVM, which is
also not that pretty.

I see how you would like to clean this up, but it's not really hard to
read or understand, imho:

The ifdef cleanup patch:

>From 9cbe2830b74072b4d7167254562fc06c08f724e1 Mon Sep 17 00:00:00 2001
From: Christoffer Dall <c.dall@virtualopensystems.com>
Date: Thu, 29 Nov 2012 13:56:03 -0500
Subject: [PATCH] KVM: ARM: Remove exports and ifdefs in hyp idmap code

The exports are no longer needed as KVM/ARM cannot be compiled as a
module and the the #ifdef is not required around a declaration.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Rob Herring <robherring2@gmail.com>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/idmap.h |    2 --
 arch/arm/mm/idmap.c          |    2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/idmap.h b/arch/arm/include/asm/idmap.h
index 36708ba..6ddb707 100644
--- a/arch/arm/include/asm/idmap.h
+++ b/arch/arm/include/asm/idmap.h
@@ -11,9 +11,7 @@ extern pgd_t *idmap_pgd;

 void setup_mm_for_reboot(void);

-#ifdef CONFIG_ARM_VIRT_EXT
 void hyp_idmap_teardown(pgd_t *hyp_pgd);
 void hyp_idmap_setup(pgd_t *hyp_pgd);
-#endif

 #endif	/* __ASM_IDMAP_H */
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index ea7430e..0b002ee 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -136,14 +136,12 @@ void hyp_idmap_teardown(pgd_t *hyp_pgd)
 			hyp_idmap_del_pmd(pgd, addr);
 	} while (pgd++, addr = next, addr < end);
 }
-EXPORT_SYMBOL_GPL(hyp_idmap_teardown);

 void hyp_idmap_setup(pgd_t *hyp_pgd)
 {
 	identity_mapping_add(hyp_pgd, __hyp_idmap_text_start,
 			     __hyp_idmap_text_end, PMD_SECT_AP1);
 }
-EXPORT_SYMBOL_GPL(hyp_idmap_setup);
 #endif

 /*
-- 
1.7.9.5

-Christoffer
