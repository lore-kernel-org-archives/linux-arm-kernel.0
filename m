From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 Apr 2016 19:03:02 +0200
Subject: [PATCH 13/17] kvm-arm: Add stage2 page table modifiers
In-Reply-To: <5707D01E.1050309@arm.com>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
 <1459787177-12767-14-git-send-email-suzuki.poulose@arm.com>
 <20160408134257.GW8961@cbox> <5707D01E.1050309@arm.com>
Message-ID: <20160408170302.GA13247@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2016 at 04:37:02PM +0100, Suzuki K Poulose wrote:
> On 08/04/16 14:42, Christoffer Dall wrote:
> >On Mon, Apr 04, 2016 at 05:26:13PM +0100, Suzuki K Poulose wrote:
> 
> >>
> >>-static void clear_pud_entry(struct kvm *kvm, pud_t *pud, phys_addr_t addr)
> >>+static void clear_stage2_pud_entry(struct kvm *kvm, pud_t *pud, phys_addr_t addr)
> >>  {
> >>-	pmd_t *pmd_table = pmd_offset(pud, 0);
> >>-	VM_BUG_ON(pud_huge(*pud));
> >>-	pud_clear(pud);
> >>+	pmd_t *pmd_table __maybe_unused = stage2_pmd_offset(pud, 0);
> >
> >The __maybe_unused are slightly ugly, so it may be nicer to create the
> >stage2_pmd_free() as static inline's if they're defined to do nothing
> >instead.
> >
> 
> Sure, we could do that for stage2. However, we will need to fix the host helpers
> as well for making such a change in the _hyp version (for 16K + 36bit VA).
> 

I thought the host helpers were already done like that, since we don't
need the __maybe_unused currently.  If it involves changing core code
etc. then don't bother.

Thanks,
-Christoffer
