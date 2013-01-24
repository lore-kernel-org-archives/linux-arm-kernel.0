From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Thu, 24 Jan 2013 12:04:32 -0500
Subject: [PATCH v6 01/15] ARM: Add page table and page defines needed by
 KVM
In-Reply-To: <20130124170220.GF18233@arm.com>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130116175726.29147.57548.stgit@ubuntu>
 <20130124113935.GA1658@localhost.cambridge.arm.com>
 <CANM98qKYhvb6YVUr_jF0iYrgcmoMqtom+9tsZw1PkWFabRKVNQ@mail.gmail.com>
 <20130124170220.GF18233@arm.com>
Message-ID: <CANM98q+mmU4R1yQ7mnp_QynhX4mbBiViP96FMjSob=fzAHLp6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 12:02 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, Jan 24, 2013 at 04:05:33PM +0000, Christoffer Dall wrote:
>> On Thu, Jan 24, 2013 at 6:39 AM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > On Wed, Jan 16, 2013 at 05:57:26PM +0000, Christoffer Dall wrote:
>> >> diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
>> >> index a3f3792..6ef8afd 100644
>> >> --- a/arch/arm/include/asm/pgtable-3level.h
>> >> +++ b/arch/arm/include/asm/pgtable-3level.h
>> >> @@ -104,11 +104,29 @@
>> >>   */
>> >>  #define L_PGD_SWAPPER                (_AT(pgdval_t, 1) << 55)        /* swapper_pg_dir entry */
>> >>
>> >> +/*
>> >> + * 2nd stage PTE definitions for LPAE.
>> >> + */
>> >> +#define L_PTE_S2_MT_UNCACHED  (_AT(pteval_t, 0x5) << 2) /* MemAttr[3:0] */
>> >> +#define L_PTE_S2_MT_WRITETHROUGH (_AT(pteval_t, 0xa) << 2) /* MemAttr[3:0] */
>> >> +#define L_PTE_S2_MT_WRITEBACK         (_AT(pteval_t, 0xf) << 2) /* MemAttr[3:0] */
>> >> +#define L_PTE_S2_RDONLY               (_AT(pteval_t, 1) << 6)   /* HAP[1]   */
>> >> +#define L_PTE_S2_RDWR                 (_AT(pteval_t, 2) << 6)   /* HAP[2:1] */
>> >
>> > Why is this called L_PTE_S2_RDWR? The ARM ARM shows HAP[2:1] as 0b11 for
>> > read/write and 0b10 for WRONLY.
>>
>> it should be
>>
>> +#define L_PTE_S2_RDWR                 (_AT(pteval_t, 3) << 6)   /* HAP[2:1] */
>
> OK.
>
>>
>> >> --- a/arch/arm/include/asm/pgtable.h
>> >> +++ b/arch/arm/include/asm/pgtable.h
>> >> @@ -70,6 +70,9 @@ extern void __pgd_error(const char *file, int line, pgd_t);
>> >>
>> >>  extern pgprot_t              pgprot_user;
>> >>  extern pgprot_t              pgprot_kernel;
>> >> +extern pgprot_t              pgprot_hyp_device;
>> >> +extern pgprot_t              pgprot_s2;
>> >> +extern pgprot_t              pgprot_s2_device;
>> >>
>> >>  #define _MOD_PROT(p, b)      __pgprot(pgprot_val(p) | (b))
>> >>
>> >> @@ -82,6 +85,10 @@ extern pgprot_t            pgprot_kernel;
>> >>  #define PAGE_READONLY_EXEC   _MOD_PROT(pgprot_user, L_PTE_USER | L_PTE_RDONLY)
>> >>  #define PAGE_KERNEL          _MOD_PROT(pgprot_kernel, L_PTE_XN)
>> >>  #define PAGE_KERNEL_EXEC     pgprot_kernel
>> >> +#define PAGE_HYP             _MOD_PROT(pgprot_kernel, L_PTE_HYP)
>> >> +#define PAGE_HYP_DEVICE              _MOD_PROT(pgprot_hyp_device, L_PTE_HYP)
>> >> +#define PAGE_S2                      _MOD_PROT(pgprot_s2, L_PTE_S2_RDONLY)
>> >> +#define PAGE_S2_DEVICE               _MOD_PROT(pgprot_s2_device, L_PTE_USER | L_PTE_S2_RDONLY)
>> >
>> > Are these S2 read-only by default?
>>
>> not sure I understand what you're asking here?
>
> Why do you pass L_PTE_S2_RDONLY? Do you need to restrict guest writes
> via the stage 2 attributes?
>
yes, for example when KSM merges two pages, then it must be mapped
read-only to the guest so that we catch writes and perform COW.
