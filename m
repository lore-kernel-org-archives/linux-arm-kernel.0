From: cdall@kernel.org (Christoffer Dall)
Date: Sun, 3 Dec 2017 21:38:02 +0100
Subject: [PATCH 37/37] KVM: arm/arm64: Avoid VGICv3 save/restore on VHE
 with no IRQs
In-Reply-To: <20171130183330.x7jc6m2yffcxcvkz@yury-thinkpad>
References: <20171012104141.26902-1-christoffer.dall@linaro.org>
 <20171012104141.26902-38-christoffer.dall@linaro.org>
 <20171130183330.x7jc6m2yffcxcvkz@yury-thinkpad>
Message-ID: <20171203203802.GC32397@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

On Thu, Nov 30, 2017 at 09:33:30PM +0300, Yury Norov wrote:
> On Thu, Oct 12, 2017 at 12:41:41PM +0200, Christoffer Dall wrote:
> > We can finally get completely rid of any calls to the VGICv3
> > save/restore functions when the AP lists are empty on VHE systems.  This
> > requires carefully factoring out trap configuration from saving and
> > restoring state, and carefully choosing what to do on the VHE and
> > non-VHE path.
> > 
> > One of the challenges is that we cannot save/restore the VMCR lazily
> > because we can only write the VMCR when ICC_SRE_EL1.SRE is cleared when
> > emulating a GICv2-on-GICv3, since otherwise all Group-0 interrupts end
> > up being delivered as FIQ.
> > 
> > To solve this problem, and still provide fast performance in the fast
> > path of exiting a VM when no interrupts are pending (which also
> > optimized the latency for actually delivering virtual interrupts coming
> > from physical interrupts), we orchestrate a dance of only doing the
> > activate/deactivate traps in vgic load/put for VHE systems (which can
> > have ICC_SRE_EL1.SRE cleared when running in the host), and doing the
> > configuration on every round-trip on non-VHE systems.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  arch/arm/include/asm/kvm_hyp.h   |   2 +
> >  arch/arm/kvm/hyp/switch.c        |   8 ++-
> >  arch/arm64/include/asm/kvm_hyp.h |   2 +
> >  arch/arm64/kvm/hyp/switch.c      |   8 ++-
> >  virt/kvm/arm/hyp/vgic-v3-sr.c    | 116 +++++++++++++++++++++++++--------------
> >  virt/kvm/arm/vgic/vgic-v3.c      |   6 ++
> >  virt/kvm/arm/vgic/vgic.c         |   7 +--
> >  7 files changed, 101 insertions(+), 48 deletions(-)
> 
> [...]
> 
> > diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
> > index ed5da75..34d71d2 100644
> > --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
> > +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
> > @@ -208,15 +208,15 @@ void __hyp_text __vgic_v3_save_state(struct kvm_vcpu *vcpu)
> >  {
> >  	struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
> >  	u64 used_lrs = vcpu->arch.vgic_cpu.used_lrs;
> > -	u64 val;
> >  
> >  	/*
> >  	 * Make sure stores to the GIC via the memory mapped interface
> > -	 * are now visible to the system register interface.
> > +	 * are now visible to the system register interface when reading the
> > +	 * LRs, and when reading back the VMCR on non-VHE systems.
> >  	 */
> > -	if (!cpu_if->vgic_sre) {
> > -		dsb(st);
> > -		cpu_if->vgic_vmcr = read_gicreg(ICH_VMCR_EL2);
> > +	if (used_lrs || !has_vhe()) {
> > +		if (!cpu_if->vgic_sre)
> > +			dsb(st);
> >  	}
> 
> Nit:
> 	if ((used_lrs || !has_vhe()) && !cpu_if->vgic_sre)
> 		dsb(st);
> 

I don't think that's easier to read and I'm not paying for vertical
space, so I'm going to keep it as is.

Thanks,
-Christoffer
