From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 3 May 2016 10:36:51 +0200
Subject: [PATCH] arm64: kvm: Fix kvm teardown for systems using the
 extended idmap
In-Reply-To: <20160502130535.19b20b79@arm.com>
References: <1461775633-29715-1-git-send-email-james.morse@arm.com>
 <1461950823-9790-1-git-send-email-james.morse@arm.com>
 <20160502130535.19b20b79@arm.com>
Message-ID: <20160503083651.GB17923@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 01:05:35PM +0100, Marc Zyngier wrote:
> On Fri, 29 Apr 2016 18:27:03 +0100
> James Morse <james.morse@arm.com> wrote:
> 
> Hi James,
> 
> > If memory is located above 1<<VA_BITS, kvm adds an extra level to its page
> > tables, merging the runtime tables and boot tables that contain the idmap.
> > This lets us avoid the trampoline dance during initialisation.
> > 
> > This also means there is no trampoline page mapped, so
> > __cpu_reset_hyp_mode() can't call __kvm_hyp_reset() in this page. The good
> > news is the idmap is still mapped, so we don't need the trampoline page.
> > The bad news is we can't call it directly as the idmap is above
> > HYP_PAGE_OFFSET, so its address is masked by kvm_call_hyp.
> > 
> > Add a function __extended_idmap_trampoline which will branch into
> > __kvm_hyp_reset in the idmap, change kvm_hyp_reset_entry() to return
> > this address if __kvm_cpu_uses_extended_idmap(). In this case
> > __kvm_hyp_reset() will still switch to the boot tables (which are the
> > merged tables that were already in use), and branch into the idmap (where
> > it already was).
> > 
> > This fixes boot failures on these systems, where we fail to execute the
> > missing trampoline page when tearing down kvm in init_subsystems():
> > [    2.508922] kvm [1]: 8-bit VMID
> > [    2.512057] kvm [1]: Hyp mode initialized successfully
> > [    2.517242] kvm [1]: interrupt-controller at e1140000 IRQ13
> > [    2.522622] kvm [1]: timer IRQ3
> > [    2.525783] Kernel panic - not syncing: HYP panic:
> > [    2.525783] PS:200003c9 PC:0000007ffffff820 ESR:86000005
> > [    2.525783] FAR:0000007ffffff820 HPFAR:00000000003ffff0 PAR:0000000000000000
> > [    2.525783] VCPU:          (null)
> > [    2.525783]
> > [    2.547667] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.6.0-rc5+ #1
> > [    2.555137] Hardware name: Default string Default string/Default string, BIOS ROD0084E 09/03/2015
> > [    2.563994] Call trace:
> > [    2.566432] [<ffffff80080888d0>] dump_backtrace+0x0/0x240
> > [    2.571818] [<ffffff8008088b24>] show_stack+0x14/0x20
> > [    2.576858] [<ffffff80083423ac>] dump_stack+0x94/0xb8
> > [    2.581899] [<ffffff8008152130>] panic+0x10c/0x250
> > [    2.586677] [<ffffff8008152024>] panic+0x0/0x250
> > [    2.591281] SMP: stopping secondary CPUs
> > [    3.649692] SMP: failed to stop secondary CPUs 0-2,4-7
> > [    3.654818] Kernel Offset: disabled
> > [    3.658293] Memory Limit: none
> > [    3.661337] ---[ end Kernel panic - not syncing: HYP panic:
> > [    3.661337] PS:200003c9 PC:0000007ffffff820 ESR:86000005
> > [    3.661337] FAR:0000007ffffff820 HPFAR:00000000003ffff0 PAR:0000000000000000
> > [    3.661337] VCPU:          (null)
> > [    3.661337]
> > 
> > 
> > Reported-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h |  3 ++-
> >  arch/arm64/kvm/hyp-init.S         |  5 +++++
> >  arch/arm64/kvm/hyp/entry.S        | 19 +++++++++++++++++++
> >  arch/arm64/kvm/reset.c            | 30 +++++++++++++++++++++++-------
> >  4 files changed, 49 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index b6f194d9f6b2..88a34670ddef 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -46,7 +46,8 @@
> >  int __attribute_const__ kvm_target_cpu(void);
> >  int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
> >  int kvm_arch_dev_ioctl_check_extension(long ext);
> > -phys_addr_t kvm_hyp_reset_entry(void);
> > +unsigned long kvm_hyp_reset_entry(void);
> > +void __extended_idmap_trampoline(phys_addr_t boot_pgd, phys_addr_t idmap_start);
> >  
> >  struct kvm_arch {
> >  	/* The VMID generation used for the virt. memory system */
> > diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
> > index 44ec4cb23ae7..a873a6d8be90 100644
> > --- a/arch/arm64/kvm/hyp-init.S
> > +++ b/arch/arm64/kvm/hyp-init.S
> > @@ -140,6 +140,11 @@ merged:
> >  ENDPROC(__kvm_hyp_init)
> >  
> >  	/*
> > +	 * Reset kvm back to the hyp stub. This is the trampoline dance in
> > +	 * reverse. If kvm used an extended idmap, __extended_idmap_trampoline
> > +	 * calls this code directly in the idmap. In this case switching to the
> > +	 * boot tables is a no-op.
> > +	 *
> >  	 * x0: HYP boot pgd
> >  	 * x1: HYP phys_idmap_start
> >  	 */
> > diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
> > index ce9e5e5f28cf..70254a65bd5b 100644
> > --- a/arch/arm64/kvm/hyp/entry.S
> > +++ b/arch/arm64/kvm/hyp/entry.S
> > @@ -164,3 +164,22 @@ alternative_endif
> >  
> >  	eret
> >  ENDPROC(__fpsimd_guest_restore)
> > +
> > +/*
> > + * When using the extended idmap, we don't have a trampoline page we can use
> > + * while we switch pages tables during __kvm_hyp_reset. Accessing the idmap
> > + * directly would be ideal, but if we're using the extended idmap then the
> > + * idmap is located above HYP_PAGE_OFFSET, and the address will be masked by
> > + * kvm_call_hyp using kern_hyp_va.
> > + *
> > + * x0: HYP boot pgd
> > + * x1: HYP phys_idmap_start
> > + */
> > +ENTRY(__extended_idmap_trampoline)
> > +	mov	x4, x1
> > +	adr_l	x3, __kvm_hyp_reset
> > +
> > +	/* insert __kvm_hyp_reset()s offset into phys_idmap_start */
> > +	bfi	x4, x3, #0, #PAGE_SHIFT
> > +	br	x4
> > +ENDPROC(__extended_idmap_trampoline)
> > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> > index 4062e6dd4cc1..b1ad730e1567 100644
> > --- a/arch/arm64/kvm/reset.c
> > +++ b/arch/arm64/kvm/reset.c
> > @@ -135,12 +135,28 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> >  
> >  extern char __hyp_idmap_text_start[];
> >  
> > -phys_addr_t kvm_hyp_reset_entry(void)
> > +unsigned long kvm_hyp_reset_entry(void)
> >  {
> > -	unsigned long offset;
> > -
> > -	offset = (unsigned long)__kvm_hyp_reset
> > -		 - ((unsigned long)__hyp_idmap_text_start & PAGE_MASK);
> > -
> > -	return TRAMPOLINE_VA + offset;
> > +	if (!__kvm_cpu_uses_extended_idmap()) {
> > +		unsigned long offset;
> > +
> > +		/*
> > +		 * Find the address of __kvm_hyp_reset() in the trampoline page.
> > +		 * This is present in the running page tables, and the boot page
> > +		 * tables, so we call the code here to start the trampoline
> > +		 * dance in reverse.
> > +		 */
> > +		offset = (unsigned long)__kvm_hyp_reset
> > +			 - ((unsigned long)__hyp_idmap_text_start & PAGE_MASK);
> > +
> > +		return TRAMPOLINE_VA + offset;
> > +	} else {
> > +		/*
> > +		 * KVM is running with merged page tables, which don't have the
> > +		 * trampoline page mapped. We know the idmap is still mapped,
> > +		 * but can't be called into directly. Use
> > +		 * __extended_idmap_trampoline to do the call.
> > +		 */
> > +		return (unsigned long)kvm_ksym_ref(__extended_idmap_trampoline);
> > +	}
> >  }
> 
> This looks correct, and gives me yet another incentive to revisit this
> code with a view of keeping the idmap at all times in the EL2 page
> tables. This should ensure that (1) the merged page tables become the
> only configuration, and (2) that we get rid off of the potential TLB
> conflict when swapping TTBR0_EL2 at boot time (intermediate level
> caching). In the meantime:
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
thanks!  Will, should this go via the kvmarm tree or the arm64 tree?

-Christoffer
