From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Sun, 12 May 2013 22:17:37 -0700
Subject: [PATCH v2 3/5] ARM: KVM: relax cache maintainance when building
 page tables
In-Reply-To: <20130502151753.GB25022@mudshark.cambridge.arm.com>
References: <1367505542-2231-1-git-send-email-marc.zyngier@arm.com>
 <1367505542-2231-4-git-send-email-marc.zyngier@arm.com>
 <20130502150355.GA25022@mudshark.cambridge.arm.com>
 <CAEDV+gJwYpHzehWZci2bmgYedJoBxMOGZFhjGeGRQ_cT8TKkyw@mail.gmail.com>
 <20130502151753.GB25022@mudshark.cambridge.arm.com>
Message-ID: <20130513051737.GB64337@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 04:17:53PM +0100, Will Deacon wrote:
> On Thu, May 02, 2013 at 04:15:05PM +0100, Christoffer Dall wrote:
> > On Thu, May 2, 2013 at 8:03 AM, Will Deacon <will.deacon@arm.com> wrote:
> > > On Thu, May 02, 2013 at 03:39:00PM +0100, Marc Zyngier wrote:
> > >> Patch 5a677ce044f1 (ARM: KVM: switch to a dual-step HYP init code)
> > >> introduced code that flushes page tables to the point of coherency.
> > >> This is overkill (point of unification is enough and already done),
> > >> and actually not required if running on a SMP capable platform
> > >> (the HW PTW can snoop other cpus' L1).
> > >>
> > >> Remove this code and let ae8a8b9553bd (ARM: 7691/1: mm: kill unused
> > >> TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead) turn it into
> > >> a no-op for SMP ARMv7.
> > >>
> > >> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> > >> Cc: Will Deacon <will.deacon@arm.com>
> > >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > >> ---
> > >>  arch/arm/kvm/mmu.c | 3 ---
> > >>  1 file changed, 3 deletions(-)
> > >>
> > >> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> > >> index 4a838db..d79b594 100644
> > >> --- a/arch/arm/kvm/mmu.c
> > >> +++ b/arch/arm/kvm/mmu.c
> > >> @@ -234,7 +234,6 @@ static void create_hyp_pte_mappings(pmd_t *pmd, unsigned long start,
> > >>               pte = pte_offset_kernel(pmd, addr);
> > >>               kvm_set_pte(pte, pfn_pte(pfn, prot));
> > >>               get_page(virt_to_page(pte));
> > >> -             kvm_flush_dcache_to_poc(pte, sizeof(*pte));
> > >>               pfn++;
> > >>       } while (addr += PAGE_SIZE, addr != end);
> > >
> > > Could you remove the flushing code out of kvm_set_pte, then flush the range
> > > after the loop? Then you get one flush and one barrier for the whole range.
> > >
> > that would be different from how it's done in the rest of the kernel
> > where you're expecting set_pte to do the necessary flushing for you,
> > no?
> 
> Correct, but since kvm_set_pte seems only to be called from this file, I'm
> not sure you need to match thes rest of the kernel.
> 
> > instead, if this optimization is worth it, the code could just use
> > pte_val(pte) = XX;
> 
> or just *pte = XX;
> 
That won't work with STRICT_M_TYPECHECKS though will it?

-Christoffer
