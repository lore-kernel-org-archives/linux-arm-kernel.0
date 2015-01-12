From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 12 Jan 2015 18:08:16 +0100
Subject: [PATCH v6 15/20] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <54B39A8B.1010505@arm.com>
References: <1420804478-17354-1-git-send-email-andre.przywara@arm.com>
 <1420804478-17354-16-git-send-email-andre.przywara@arm.com>
 <20150111151507.GC21444@cbox> <54B39A8B.1010505@arm.com>
Message-ID: <20150112170816.GK3868@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 09:57:31AM +0000, Andre Przywara wrote:

[...]

> >> +static int vgic_v3_map_resources(struct kvm *kvm,
> >> +                              const struct vgic_params *params)
> >> +{
> >> +     int ret = 0;
> >> +     struct vgic_dist *dist = &kvm->arch.vgic;
> >> +
> >> +     if (!irqchip_in_kernel(kvm))
> >> +             return 0;
> >> +
> >> +     mutex_lock(&kvm->lock);
> >> +
> >> +     if (vgic_ready(kvm))
> >> +             goto out;
> >> +
> >> +     if (IS_VGIC_ADDR_UNDEF(dist->vgic_dist_base) ||
> >> +         IS_VGIC_ADDR_UNDEF(dist->vgic_redist_base)) {
> >> +             kvm_err("Need to set vgic distributor addresses first\n");
> >> +             return -ENXIO;
> > 
> > you're not returning to userspace iwth a mutex held...
> 
> Good catch. Will fix that.
> 
> >> +     }
> >> +
> >> +     /*
> >> +      * Initialize the vgic if this hasn't already been done on demand by
> >> +      * accessing the vgic state from userspace.
> >> +      */
> >> +     ret = vgic_init(kvm);
> >> +     if (ret) {
> >> +             kvm_err("Unable to allocate maps\n");
> >> +             goto out;
> >> +     }
> > 
> > I don't think we should allow automatic vgic_init from userspace
> > anymore, but require userspace to manually initialize the vgic when
> > using a GICv3.
> > 
> > In fact, I think we need to change all the places that do the on-demand
> > vgic init to error out somehow, if you're using anything else than a
> > gicv2.
> 
> Ah yes, I think we didn't discuss this before. I know that the intention
> was to make the explicit vgic init mandatory for GICv3, but to me it
> looks like we need extra code to support this, so I refrained from
> adding that right now.
> Why do we require the vgic init call in the first place? Is that just to
> make this whole VGIC init sequence more clearer and get rid of the
> cumbersome automatic init's all over the place? So basically to fix a
> design decision that we cannot undo anymore for vGICv2?
>

Yes, the auto-init keeps breaking on us and it's generally quite messy.

If you introduce that functionality for GICv3 as well, it becomes ABI
that we need to maintain forever, so I'd like that we address it now.

One option is to rename all the auto vgic_init calls to vgic_init_auto
and check if a GICv2 was created in there and error out in that case,
that should make the changes in connection with this series a simple
mechanical patch.

-Christoffer
