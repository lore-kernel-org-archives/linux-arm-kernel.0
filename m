From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 24 Apr 2013 09:55:57 -0700
Subject: [PATCH v3 08/32] arm64: KVM: architecture specific MMU backend
In-Reply-To: <5177BBEE.1090209@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-9-git-send-email-marc.zyngier@arm.com>
 <20130423225816.GC20569@gmail.com> <5177BBEE.1090209@arm.com>
Message-ID: <CAEDV+g+H+NFc5gsQYBmQDx598Oz3BHWHcrYhBYsWPbXaVYataA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 4:03 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 23/04/13 23:58, Christoffer Dall wrote:
>> On Mon, Apr 08, 2013 at 05:17:10PM +0100, Marc Zyngier wrote:
>>> Define the arm64 specific MMU backend:
>>> - HYP/kernel VA offset
>>> - S2 4/64kB definitions
>>> - S2 page table populating and flushing
>>> - icache cleaning
>>>
>>> Reviewed-by: Christopher Covington <cov@codeaurora.org>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  arch/arm64/include/asm/kvm_mmu.h | 136 +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 136 insertions(+)
>>>  create mode 100644 arch/arm64/include/asm/kvm_mmu.h
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>>> new file mode 100644
>>> index 0000000..2eb2230
>>> --- /dev/null
>>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>>> @@ -0,0 +1,136 @@
>>> +/*
>>> + * Copyright (C) 2012,2013 - ARM Ltd
>>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#ifndef __ARM64_KVM_MMU_H__
>>> +#define __ARM64_KVM_MMU_H__
>>> +
>>> +#include <asm/page.h>
>>> +#include <asm/memory.h>
>>> +
>>> +/*
>>> + * As we only have the TTBR0_EL2 register, we cannot express
>>> + * "negative" addresses. This makes it impossible to directly share
>>> + * mappings with the kernel.
>>> + *
>>> + * Instead, give the HYP mode its own VA region at a fixed offset from
>>> + * the kernel by just masking the top bits (which are all ones for a
>>> + * kernel address).
>>
>> For some reason I keep choking on this, despite it being very simple.
>> We're just defining a different PAGE_OFFSET, right? Why not do a hard
>> define as:
>>
>> #define HYP_PAGE_OFFSET_MASK  0x0000ffffffffffff
>> #define HYP_PAGE_OFFSET               0x0000ffc000000000
>>
>> ...or change the second paragraph of the comment to say
>> that we definethe HYP_PAGE_OFFSET to be 0x 0000ffc0 00000000.
>
> One of these days, VA_BITS will change to accommodate for more virtual
> space. When that day comes, I don't want to touch any of this because it
> did hurt enough when writing it. As such, I'll refrain from hardcoding
> anything.
>
> I don't mind a comment, though.
>
>>> + */
>>> +#define HYP_PAGE_OFFSET_SHIFT       VA_BITS
>>> +#define HYP_PAGE_OFFSET_MASK        ((UL(1) << HYP_PAGE_OFFSET_SHIFT) - 1)
>>
>> In any case, is there a reason for the HYP_PAGE_OFFSET_SHIFT
>> indirection? It may be simpler without...
>
> It is common practice to have XXX_SHIFT and XXX_MASK together.
>
>>> +#define HYP_PAGE_OFFSET             (PAGE_OFFSET & HYP_PAGE_OFFSET_MASK)
>>> +
>>> +/*
>>> + * Our virtual mapping for the idmap-ed MMU-enable code. Must be
>>> + * shared across all the page-tables. Conveniently, we use the last
>>> + * possible page, where no kernel mapping will ever exist.
>>> + */
>>> +#define TRAMPOLINE_VA               (HYP_PAGE_OFFSET_MASK & PAGE_MASK)
>>
>> hmmm, ok, here it's kind of nice to have that define correlation, so
>> maybe it's not cleaner.  Something should be improved here in the define
>> or the comment to make it more clear.  Perhaps just adding the real
>> constants in the comment or in Documentation/arm64/memory.txt would
>> help.
>
> Yes, I plan to write something there.
>
>>> +
>>> +#ifdef __ASSEMBLY__
>>> +
>>> +/*
>>> + * Convert a kernel VA into a HYP VA.
>>> + * reg: VA to be converted.
>>> + */
>>> +.macro kern_hyp_va  reg
>>> +    and     \reg, \reg, #HYP_PAGE_OFFSET_MASK
>>> +.endm
>>> +
>>> +#else
>>> +
>>> +#include <asm/cacheflush.h>
>>> +
>>> +#define KERN_TO_HYP(kva)    ((unsigned long)kva - PAGE_OFFSET + HYP_PAGE_OFFSET)
>>> +
>>> +/*
>>> + * Align KVM with the kernel's view of physical memory. Should be
>>> + * 40bit IPA, with PGD being 8kB aligned.
>>> + */
>>> +#define KVM_PHYS_SHIFT      PHYS_MASK_SHIFT
>>> +#define KVM_PHYS_SIZE       (1UL << KVM_PHYS_SHIFT)
>>> +#define KVM_PHYS_MASK       (KVM_PHYS_SIZE - 1UL)
>>> +
>>> +#ifdef CONFIG_ARM64_64K_PAGES
>>> +#define PAGE_LEVELS 2
>>> +#define BITS_PER_LEVEL      13
>>> +#else  /* 4kB pages */
>>> +#define PAGE_LEVELS 3
>>> +#define BITS_PER_LEVEL      9
>>> +#endif
>>
>> What are the semantics of these defines exactly? They should be
>> S2_PAGE_LEVELS and make some assumptions of the VTCR_EL2.SL0 field
>> right?
>
> Indeed, we assume SL0 is always 1, just like for the kernel. As for the
> semantics, I though they were pretty obvious...
>

this is all stage2 right? so S2_PAGE_LEVELS may be more clear...

> PAGE_LEVELS is just that, the number of page levels. BITS_PER_LEVEL is
> the number of bits you need to index a particular level.
>
>>> +
>>> +/* Make sure we get the right size, and thus the right alignment */
>>
>> this comment is not particularly helpful, something explaining why the
>> max() thingy below makes sense would be more so :)  I really can't
>> follow the BITS_PER_S2_PGD and PTRS_PER_S2_PGD defines.
>
> Admittedly, they are a bit convoluted:
>
>>> +#define BITS_PER_S2_PGD (KVM_PHYS_SHIFT - (PAGE_LEVELS - 1) * BITS_PER_LEVEL - PAGE_SHIFT)
>
> This is how many bits of index you need in a PGD. With a 40bit IPA and a
> 4kB page size, you end up with a 10 bit index.
>

oh, I see it now, you're basically taking away all the other bits you
know are used to find your address and consider the remaining amount
the necessary number of bits used to index into the PGD. Right? So I
think at least a comment saying that BITS_ indicates bits used for
indexing, not bits for a single entry or something else...

>>> +#define PTRS_PER_S2_PGD (1 << max(BITS_PER_LEVEL, BITS_PER_S2_PGD))
>
> Now, in order to allocate your PGD, you need to find out how many
> pointers your PGD is going to contain. The max() is make sure we
> allocate at least a full page worth of pointers.

I still don't get this, sorry. Can you provide me with the sane
counter example where BITS_PER_S2_PGD is not sufficient?

>
>>> +#define S2_PGD_ORDER        get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
>>> +#define S2_PGD_SIZE (1 << S2_PGD_ORDER)
>>> +
>>> +int create_hyp_mappings(void *from, void *to);
>>> +int create_hyp_io_mappings(void *from, void *to, phys_addr_t);
>>> +void free_hyp_pgds(void);
>>> +
>>> +int kvm_alloc_stage2_pgd(struct kvm *kvm);
>>> +void kvm_free_stage2_pgd(struct kvm *kvm);
>>> +int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>>> +                      phys_addr_t pa, unsigned long size);
>>> +
>>> +int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run);
>>> +
>>> +void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
>>> +
>>> +phys_addr_t kvm_mmu_get_httbr(void);
>>> +phys_addr_t kvm_mmu_get_boot_httbr(void);
>>> +phys_addr_t kvm_get_idmap_vector(void);
>>> +int kvm_mmu_init(void);
>>> +void kvm_clear_hyp_idmap(void);
>>> +
>>> +#define     kvm_set_pte(ptep, pte)          set_pte(ptep, pte)
>>
>> I noticed that this doesn't do any cache cleaning.  Are the MMU page
>> table walks guaranteed to be coherent with the MMU on arm64?
>
> I suppose you meant the cache. In this case, yes. The hardware page
> table walker must snoop the caches.
>

yes, that's what I meant. thanks.
