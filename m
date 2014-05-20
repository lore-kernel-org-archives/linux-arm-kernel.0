From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 20 May 2014 15:01:53 +0100
Subject: [PATCH v9 14/14] virt: arm: support hip04 gic
In-Reply-To: <CAD6h2NQyG1GSneWMpHmYxD-dPS7w9w2fe8vDdj-f834T2yqn1w@mail.gmail.com>
References: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
 <1400591427-21922-15-git-send-email-haojian.zhuang@linaro.org>
 <20140520134441.GK5292@lvm>
 <CAD6h2NQyG1GSneWMpHmYxD-dPS7w9w2fe8vDdj-f834T2yqn1w@mail.gmail.com>
Message-ID: <20140520140153.GL5292@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 09:52:53PM +0800, Haojian Zhuang wrote:
> On 20 May 2014 21:44, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Tue, May 20, 2014 at 09:10:27PM +0800, Haojian Zhuang wrote:

[...]

> >> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> >> index 47b2983..4c0c1e9 100644
> >> --- a/virt/kvm/arm/vgic.c
> >> +++ b/virt/kvm/arm/vgic.c
> >> @@ -76,6 +76,8 @@
> >>  #define IMPLEMENTER_ARM              0x43b
> >>  #define GICC_ARCH_VERSION_V2 0x2
> >>
> >> +#define vgic_nr_lr(vcpu)     (vcpu->hw_cfg & HWCFG_NR_LR_MASK)
> >> +
> >>  /* Physical address of vgic virtual cpu interface */
> >>  static phys_addr_t vgic_vcpu_base;
> >>
> >> @@ -97,7 +99,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
> >>  static void vgic_update_state(struct kvm *kvm);
> >>  static void vgic_kick_vcpus(struct kvm *kvm);
> >>  static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
> >> -static u32 vgic_nr_lr;
> >> +static u32 vgic_hw_cfg;
> >>
> >>  static unsigned int vgic_maint_irq;
> >>
> >> @@ -624,9 +626,9 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
> >>       struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> >>       int vcpu_id = vcpu->vcpu_id;
> >>       int i, irq, source_cpu;
> >> -     u32 *lr;
> >> +     u32 *lr, nr_lr = vgic_nr_lr(vgic_cpu);
> >
> > This is static for any system post-boot, right?  Can't we set this
> > global variable once like we did before instead of having to define
> > these extra variables and do the bit manipulation all over the place?
> >
> > -Christoffer
> 
> I tried to define a global gich_apr variable before. But Marc didn't agree on
> that. He suggested to use vgic_cpu_nr_lr to save both GICH_APR offset
> and nr_lr.
> 
> Adding gich_apr variable should be the simpler implementation.
> 
You're talking about storing this information on the vgic_cpu struct,
which is accessed on every world-switch patch.  There, you don't want
two memory accesses.

Here, on the other hand, you're in host kernel land, and you can do your
bit-shuffling once, and always access a single static variable like we
did before, which will simplify the C-code.

Makes sense?

-Christoffer
