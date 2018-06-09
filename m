From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 09 Jun 2018 13:34:33 +0100
Subject: [PATCH v2 4/6] KVM: arm/arm64: Consolidate page-table accessors
In-Reply-To: <20180609093148.GF5097@C02W217FHV2R.local>
References: <20180530124706.25284-1-marc.zyngier@arm.com>
 <20180530124706.25284-5-marc.zyngier@arm.com>
 <20180609093148.GF5097@C02W217FHV2R.local>
Message-ID: <861sdg9m06.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 09 Jun 2018 10:31:48 +0100,
Christoffer Dall wrote:
> 
> On Wed, May 30, 2018 at 01:47:04PM +0100, Marc Zyngier wrote:
> > The arm and arm64 KVM page tables accessors are pointlessly different
> > between the two architectures, and likely both wrong one way or another:
> > arm64 lacks a dsb(), and arm doesn't use WRITE_ONCE.
> > 
> > Let's unify them.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm/include/asm/kvm_mmu.h   | 12 -----------
> >  arch/arm64/include/asm/kvm_mmu.h |  3 ---
> >  virt/kvm/arm/mmu.c               | 35 ++++++++++++++++++++++++++++----
> >  3 files changed, 31 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> > index 707a1f06dc5d..468ff945efa0 100644
> > --- a/arch/arm/include/asm/kvm_mmu.h
> > +++ b/arch/arm/include/asm/kvm_mmu.h
> > @@ -75,18 +75,6 @@ phys_addr_t kvm_get_idmap_vector(void);
> >  int kvm_mmu_init(void);
> >  void kvm_clear_hyp_idmap(void);
> >  
> > -static inline void kvm_set_pmd(pmd_t *pmd, pmd_t new_pmd)
> > -{
> > -	*pmd = new_pmd;
> > -	dsb(ishst);
> > -}
> > -
> > -static inline void kvm_set_pte(pte_t *pte, pte_t new_pte)
> > -{
> > -	*pte = new_pte;
> > -	dsb(ishst);
> > -}
> > -
> >  static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
> >  {
> >  	pte_val(pte) |= L_PTE_S2_RDWR;
> > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> > index 9dbca5355029..26c89b63f604 100644
> > --- a/arch/arm64/include/asm/kvm_mmu.h
> > +++ b/arch/arm64/include/asm/kvm_mmu.h
> > @@ -170,9 +170,6 @@ phys_addr_t kvm_get_idmap_vector(void);
> >  int kvm_mmu_init(void);
> >  void kvm_clear_hyp_idmap(void);
> >  
> > -#define	kvm_set_pte(ptep, pte)		set_pte(ptep, pte)
> > -#define	kvm_set_pmd(pmdp, pmd)		set_pmd(pmdp, pmd)
> > -
> >  static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
> >  {
> >  	pte_val(pte) |= PTE_S2_RDWR;
> > diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> > index ba66bf7ae299..c9ed239c0840 100644
> > --- a/virt/kvm/arm/mmu.c
> > +++ b/virt/kvm/arm/mmu.c
> > @@ -177,6 +177,33 @@ static void clear_stage2_pmd_entry(struct kvm *kvm, pmd_t *pmd, phys_addr_t addr
> >  	put_page(virt_to_page(pmd));
> >  }
> >  
> > +static inline void kvm_set_pte(pte_t *ptep, pte_t new_pte)
> > +{
> > +	WRITE_ONCE(*ptep, new_pte);
> > +	dsb(ishst);
> > +}
> > +
> > +static inline void kvm_set_pmd(pmd_t *pmdp, pmd_t new_pmd)
> > +{
> > +	WRITE_ONCE(*pmdp, new_pmd);
> > +	dsb(ishst);
> > +}
> > +
> 
> arm64 set_pte and set_pmd have an isb() in addition to the dsb(), why
> can we let go of that here?

Good point. There was an offline discussion with Will and Mark a
couple of weeks ago, where we agreed that this ISB wasn't
required. I've of course paged it out. Mark, do you remember the
rational?

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
