From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 25 Nov 2014 11:41:29 +0100
Subject: [PATCH v4 15/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <5473562E.7060303@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-16-git-send-email-andre.przywara@arm.com>
 <20141123143841.GB3401@cbox> <5473562E.7060303@arm.com>
Message-ID: <20141125104129.GC31297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Mon, Nov 24, 2014 at 04:00:46PM +0000, Andre Przywara wrote:

[...]

> >> +
> >> +/*
> >> + * As this implementation does not provide compatibility
> >> + * with GICv2 (ARE==1), we report zero CPUs in bits [5..7].
> >> + * Also LPIs and MBIs are not supported, so we set the respective bits to 0.
> >> + * Also we report at most 2**10=1024 interrupt IDs (to match 1024 SPIs).
> >> + */
> >> +#define INTERRUPT_ID_BITS 10
> >> +static bool handle_mmio_typer(struct kvm_vcpu *vcpu,
> >> +                           struct kvm_exit_mmio *mmio, phys_addr_t offset)
> >> +{
> >> +     u32 reg;
> >> +
> >> +     /* we report at most 1024 IRQs via this interface */
> > 
> > hmmm, do we need to repeat ourselves here?
> 
> Actually ... not.
> To avoid confusion, I will probably just drop this comment.
> 
> > I get a bit confused by both the comment above and here, as to *why* we
> > are reporting this value?  And what is the bit about 'this interface'?
> 
> With this interface I meant the number of SPIs which is communicated
> here in a GICv2 compatible way (ITLinesNumber). Looking forward to LPI
> support I didn't want to use the term IRQ without some confinement.
> 
> > Is there another interface.
> 
> IDbits, but admittedly this isn't clear from the comment.
> Not sure if that justifies more comments before we add ITS support, though.
> 
> > Perhaps what you're trying to get at here are the semantic differences
> > between ITLinesNumber and IDbits and how that helps a reader understand
> > the code.
> 
> I can add a better comment.
> 

I think you just need to clarify the comment above the function or let
the code speak for itself.

> >> +     reg = (min(vcpu->kvm->arch.vgic.nr_irqs, 1024) >> 5) - 1;
> >> +
> >> +     reg |= (INTERRUPT_ID_BITS - 1) << 19;
> >> +
> >> +     vgic_reg_access(mmio, &reg, offset,
> >> +                     ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
> >> +
> >> +     return false;
> >> +}
> >> +


[...]

> >> + * Store the original MPIDR value in an extra array to support read-as-written.
> >> + * Unallocated MPIDRs are translated to a special value and caught
> >> + * before any array accesses.
> > 
> > We may have covered this already, but why can't we restore the original
> > MPIDR based on the the irq_spi_cpu array?
> > 
> > Is that because we loose information about 'which' unallocated MPIDR was
> > written?
> 
> Yes.
> 
> > If that's the case, it seems weird that we go through the
> > trouble but we anyway throw away the aff3 field...?
> 
> Not supporting the aff3 field saves us from caring about atomicity on
> GICD_IROUTER accesses (where aff3 is in the upper word of this 64-bit
> register).
> Not supporting Aff3 is an architectural option in the GICv3, so this
> seems like a viable solution.
> I had some code to support "real" 64-bit accesses, which would allow
> Aff3 support, but have to fight this through Marc first sometimes in the
> future again ;-)
> 

didn't realize it was an architecturally allowed option to not support
Aff3, in that case it's not worth the bother at this point.

> >> + */
> >> +static bool handle_mmio_route_reg(struct kvm_vcpu *vcpu,
> >> +                               struct kvm_exit_mmio *mmio,
> >> +                               phys_addr_t offset)
> >> +{
> >> +     struct kvm *kvm = vcpu->kvm;
> >> +     struct vgic_dist *dist = &kvm->arch.vgic;
> >> +     int spi;
> >> +     u32 reg;
> >> +     int vcpu_id;
> >> +     unsigned long *bmap, mpidr;
> >> +
> >> +     /*
> >> +      * The upper 32 bits of each 64 bit register are zero,
> >> +      * as we don't support Aff3.
> >> +      */
> >> +     if ((offset & 4)) {
> >> +             vgic_reg_access(mmio, NULL, offset,
> >> +                             ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
> >> +             return false;
> >> +     }
> >> +
> >> +     /* This region only covers SPIs, so no handling of private IRQs here. */
> >> +     spi = offset / 8;
> > 
> > that's not how I read the spec, it says that GICD_IROUTER0 to
> > GICD_IROUTER1 are not implemented (because they are SGIs and PPIs), and
> > I read the 'SPI ID m' as the lowest numbered SPI ID being 32, thus you
> > should do:
> > 
> > spi = offset / 8 - VGIC_NR_PRIVATE_IRQS;
> 
> Well, below I changed the description of the IROUTER range to:

oh, now it's finally coming back together for me, I think I
misunderstodd your point from last rounds of review because I didn't
realize that GICD_IROUTER was defined as 0x6000 (which I actually think
is a bit backwards, but this is not the place or time).

> +     {
> +             .base           = GICD_IROUTER + 0x100,
> +             .len            = 0x1edc,

in that case, len should be 0x1ee0:

 $ printf '0x%x\n' $(( (0x7fd8 + 8) - 0x6100 ))

> +             .bits_per_irq   = 64,
> +             .handle_mmio    = handle_mmio_route_reg,
> +     },
> 
> This was due to a comment on v3 by you, where you correctly stated the
> difference in the spec's description between IROUTER and the other
> registers regarding the private IRQ handling (not implemented/reserved
> vs. RAZ/WI).
> 
> So the offset in this function is relative to 0x6100 and thus depicts
> directly the SPI number.
> 

got it now, yes, the code is correct.

[...]

> >> +
> >> +/*
> >> + * This function splits accesses between the distributor and the two
> >> + * redistributor parts (private/SPI). As each redistributor is accessible
> >> + * from any CPU, we have to determine the affected VCPU by taking the faulting
> >> + * address into account. We then pass this VCPU to the handler function via
> >> + * the private parameter.
> >> + */
> >> +#define SGI_BASE_OFFSET SZ_64K
> >> +static bool vgic_v3_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >> +                             struct kvm_exit_mmio *mmio)
> >> +{
> >> +     struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> >> +     unsigned long dbase = dist->vgic_dist_base;
> >> +     unsigned long rdbase = dist->vgic_redist_base;
> >> +     int nrcpus = atomic_read(&vcpu->kvm->online_vcpus);
> >> +     int vcpu_id;
> >> +     const struct kvm_mmio_range *mmio_range;
> >> +
> >> +     if (is_in_range(mmio->phys_addr, mmio->len, dbase, GIC_V3_DIST_SIZE)) {
> >> +             return vgic_handle_mmio_range(vcpu, run, mmio,
> >> +                                           vgic_v3_dist_ranges, dbase);
> >> +     }
> >> +
> >> +     if (!is_in_range(mmio->phys_addr, mmio->len, rdbase,
> >> +         GIC_V3_REDIST_SIZE * nrcpus))
> >> +             return false;
> > 
> > Did you think more about the contiguous allocation issue here or can you
> > give me a pointer to the requirement in the spec?
> 
> 5.4.1 Re-Distributor Addressing
> 

Section 5.4.1 talks about the pages within a single re-distributor having
to be contiguous, not all the re-deistributor regions having to be

contiguous, right?

> >> +
> >> +static int vgic_v3_init(struct kvm *kvm, const struct vgic_params *params)
> >> +{
> >> +     struct vgic_dist *dist = &kvm->arch.vgic;
> >> +     int ret, i;
> >> +     u32 mpidr;
> >> +
> >> +     if (IS_VGIC_ADDR_UNDEF(dist->vgic_dist_base) ||
> >> +         IS_VGIC_ADDR_UNDEF(dist->vgic_redist_base)) {
> >> +             kvm_err("Need to set vgic distributor addresses first\n");
> >> +             return -ENXIO;
> >> +     }
> >> +
> >> +     /*
> >> +      * FIXME: this should be moved to init_maps time, and may bite
> >> +      * us when adding save/restore. Add a per-emulation hook?
> >> +      */
> > 
> > progress on this fixme?
> 
> Progress supplies the ISS, but not this piece of code (read: none) ;-)
> I am more in favour of a follow-up patch on this one ...

hmmm, I'm not a fan of merging code with this kind of a comment in it,
because it looks scary, and I dont' really understand the problem from
just reading the comment, so something needs to be done here.

Thanks,

-Christoffer
