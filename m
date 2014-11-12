From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 12 Nov 2014 12:39:05 +0000
Subject: [PATCH v3 16/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation / PART 2
In-Reply-To: <20141107143040.GR16132@cbox>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-17-git-send-email-andre.przywara@arm.com>
 <20141107143040.GR16132@cbox>
Message-ID: <546354E9.3000108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hej Christoffer,

the promised part 2 of the reply:

On 07/11/14 14:30, Christoffer Dall wrote:
> On Fri, Oct 31, 2014 at 05:26:51PM +0000, Andre Przywara wrote:
>> With everything separated and prepared, we implement a model of a
>> GICv3 distributor and redistributors by using the existing framework
>> to provide handler functions for each register group.

[...]

>> +
>> +static const struct mmio_range vgic_dist_ranges[] = {

[...]

>> +     /* the next three blocks are RES0 if ARE=1 */
> 
> probably nicer to just have a comment for each register where this
> applies.

Done.

> 
>> +     {
>> +             .base           = GICD_SGIR,
>> +             .len            = 4,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {
>> +             .base           = GICD_CPENDSGIR,
>> +             .len            = 0x10,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {
>> +             .base           = GICD_SPENDSGIR,
>> +             .len            = 0x10,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {
>> +             .base           = GICD_IROUTER,
>> +             .len            = 0x2000,
> 
> shouldn't this be 0x1ee0?

The limit of 0x7FD8 in the spec seems to come from 1020 - 32 SPIs.
However all the other registers always claim 1024 IRQs supported (with
non-implemented SPIs being RAZ/WI anyway).
So I wonder if this is just a inconsistency in the spec.
Marc, can you comment?

And we cover the 32 private IRQs also with this function (spec demands
RES0 for those), this is handled in handle_mmio_route_reg().

So I tend to leave this at 8KB, as this is what the spec talks about in
section 5.3.4.

>> +             .bits_per_irq   = 64,
>> +             .handle_mmio    = handle_mmio_route_reg,
>> +     },
>> +     {
>> +             .base           = GICD_IDREGS,
>> +             .len            = 0x30,
>> +             .bits_per_irq   = 0,
>> +             .handle_mmio    = handle_mmio_idregs,
>> +     },
>> +     {},
>> +};
>> +
>> +static bool handle_mmio_set_enable_reg_redist(struct kvm_vcpu *vcpu,
>> +                                           struct kvm_exit_mmio *mmio,
>> +                                           phys_addr_t offset,
>> +                                           void *private)
>> +{
>> +     struct kvm_vcpu *target_redist_vcpu = private;
>> +
>> +     return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
>> +                                   target_redist_vcpu->vcpu_id,
>> +                                   ACCESS_WRITE_SETBIT);
>> +}
>> +
>> +static bool handle_mmio_clear_enable_reg_redist(struct kvm_vcpu *vcpu,
>> +                                             struct kvm_exit_mmio *mmio,
>> +                                             phys_addr_t offset,
>> +                                             void *private)
>> +{
>> +     struct kvm_vcpu *target_redist_vcpu = private;
>> +
>> +     return vgic_handle_enable_reg(vcpu->kvm, mmio, offset,
>> +                                   target_redist_vcpu->vcpu_id,
>> +                                   ACCESS_WRITE_CLEARBIT);
>> +}
>> +
>> +static bool handle_mmio_set_pending_reg_redist(struct kvm_vcpu *vcpu,
>> +                                            struct kvm_exit_mmio *mmio,
>> +                                            phys_addr_t offset,
>> +                                            void *private)
>> +{
>> +     struct kvm_vcpu *target_redist_vcpu = private;
>> +
>> +     return vgic_handle_set_pending_reg(vcpu->kvm, mmio, offset,
>> +                                        target_redist_vcpu->vcpu_id);
>> +}
>> +
>> +static bool handle_mmio_clear_pending_reg_redist(struct kvm_vcpu *vcpu,
>> +                                              struct kvm_exit_mmio *mmio,
>> +                                              phys_addr_t offset,
>> +                                              void *private)
>> +{
>> +     struct kvm_vcpu *target_redist_vcpu = private;
>> +
>> +     return vgic_handle_clear_pending_reg(vcpu->kvm, mmio, offset,
>> +                                          target_redist_vcpu->vcpu_id);
>> +}
>> +
>> +static bool handle_mmio_priority_reg_redist(struct kvm_vcpu *vcpu,
>> +                                         struct kvm_exit_mmio *mmio,
>> +                                         phys_addr_t offset,
>> +                                         void *private)
>> +{
>> +     struct kvm_vcpu *target_redist_vcpu = private;
>> +     u32 *reg;
>> +
>> +     reg = vgic_bytemap_get_reg(&vcpu->kvm->arch.vgic.irq_priority,
>> +                                target_redist_vcpu->vcpu_id, offset);
>> +     vgic_reg_access(mmio, reg, offset,
>> +                     ACCESS_READ_VALUE | ACCESS_WRITE_VALUE);
>> +     return false;
>> +}
>> +
>> +static bool handle_mmio_cfg_reg_redist(struct kvm_vcpu *vcpu,
>> +                                    struct kvm_exit_mmio *mmio,
>> +                                    phys_addr_t offset,
>> +                                    void *private)
>> +{
>> +     u32 *reg = vgic_bitmap_get_reg(&vcpu->kvm->arch.vgic.irq_cfg,
>> +                                    *(int *)private, offset >> 1);
>> +
>> +     return vgic_handle_cfg_reg(reg, mmio, offset);
>> +}
>> +
>> +static const struct mmio_range vgic_redist_sgi_ranges[] = {
>> +     {
>> +             .base           = GICR_IGROUPR0,
>> +             .len            = 4,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_raz_wi,
> 
> shouldn't these RAO/WI instead?

Mmmh, looks like it. I added a simple handle_mmio_rao_wi()
implementation for this.

>> +     },
>> +     {
>> +             .base           = GICR_ISENABLER0,
>> +             .len            = 4,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_set_enable_reg_redist,
>> +     },
>> +     {
>> +             .base           = GICR_ICENABLER0,
>> +             .len            = 4,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_clear_enable_reg_redist,
>> +     },
>> +     {
>> +             .base           = GICR_ISPENDR0,
>> +             .len            = 4,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_set_pending_reg_redist,
>> +     },
>> +     {
>> +             .base           = GICR_ICPENDR0,
>> +             .len            = 4,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_clear_pending_reg_redist,
>> +     },
>> +     {
>> +             .base           = GICR_ISACTIVER0,
>> +             .len            = 4,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {
>> +             .base           = GICR_ICACTIVER0,
>> +             .len            = 4,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {
>> +             .base           = GICR_IPRIORITYR0,
>> +             .len            = 32,
>> +             .bits_per_irq   = 8,
>> +             .handle_mmio    = handle_mmio_priority_reg_redist,
>> +     },
>> +     {
>> +             .base           = GICR_ICFGR0,
>> +             .len            = 8,
>> +             .bits_per_irq   = 2,
>> +             .handle_mmio    = handle_mmio_cfg_reg_redist,
>> +     },
>> +     {
>> +             .base           = GICR_IGRPMODR0,
>> +             .len            = 4,
>> +             .bits_per_irq   = 1,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {
>> +             .base           = GICR_NSACR,
>> +             .len            = 4,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {},
>> +};
>> +
>> +static bool handle_mmio_misc_redist(struct kvm_vcpu *vcpu,
>> +                                 struct kvm_exit_mmio *mmio,
>> +                                 phys_addr_t offset, void *private)
>> +{
>> +     u32 reg;
>> +     u32 word_offset = offset & 3;
>> +     u64 mpidr;
>> +     struct kvm_vcpu *target_redist_vcpu = private;
>> +     int target_vcpu_id = target_redist_vcpu->vcpu_id;
>> +
>> +     switch (offset & ~3) {
>> +     case GICR_CTLR:
>> +             /* since we don't support LPIs, this register is zero for now */
>> +             vgic_reg_access(mmio, &reg, word_offset,
>> +                             ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
>> +             break;
>> +     case GICR_TYPER + 4:
>> +             mpidr = kvm_vcpu_get_mpidr(target_redist_vcpu);
>> +             reg = compress_mpidr(mpidr);
>> +
>> +             vgic_reg_access(mmio, &reg, word_offset,
>> +                             ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
>> +             break;
>> +     case GICR_TYPER:
>> +             reg = target_redist_vcpu->vcpu_id << 8;
>> +             if (target_vcpu_id == atomic_read(&vcpu->kvm->online_vcpus) - 1)
>> +                     reg |= GICR_TYPER_LAST;
>> +             vgic_reg_access(mmio, &reg, word_offset,
>> +                             ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
>> +             break;
>> +     case GICR_IIDR:
>> +             reg = (PRODUCT_ID_KVM << 24) | (IMPLEMENTER_ARM << 0);
>> +             vgic_reg_access(mmio, &reg, word_offset,
>> +                     ACCESS_READ_VALUE | ACCESS_WRITE_IGNORED);
>> +             break;
> 
> the fact that you could reuse handle_mmio_iidr directly here and that
> GICR_TYPER reads funny here, indicates to me that we should once again
> split this up into smaller functions.

Yeah, done that. Looks indeed better now.

>> +     default:
>> +             vgic_reg_access(mmio, NULL, word_offset,
>> +                             ACCESS_READ_RAZ | ACCESS_WRITE_IGNORED);
>> +             break;
>> +     }
>> +
>> +     return false;
>> +}
>> +
>> +static const struct mmio_range vgic_redist_ranges[] = {
>> +     {       /*
>> +              * handling CTLR, IIDR, TYPER and STATUSR
>> +              */
>> +             .base           = GICR_CTLR,
>> +             .len            = 20,
>> +             .bits_per_irq   = 0,
>> +             .handle_mmio    = handle_mmio_misc_redist,
>> +     },
>> +     {
>> +             .base           = GICR_WAKER,
>> +             .len            = 4,
>> +             .bits_per_irq   = 0,
>> +             .handle_mmio    = handle_mmio_raz_wi,
>> +     },
>> +     {
>> +             .base           = GICR_IDREGS,
>> +             .len            = 0x30,
>> +             .bits_per_irq   = 0,
>> +             .handle_mmio    = handle_mmio_idregs,
>> +     },
>> +     {},
>> +};
>> +
>> +/*
>> + * this is the stub handling both dist and redist MMIO exits for v3
>       This
> 
> Is this really a stub?
> 
> I would suggest spelling out distributor and re-distributor and GICv3.
> Full stop after GICv3.
> 
>> + * does some vcpu_id calculation on the redist MMIO to use a possibly
>> + * different VCPU than the current one
> 
> "some vcpu_id calculation" is not very helpful, either explain the magic
> sauce, or just say in which way a "different" VCPU is something we need
> to pay special attention to.
> 
> If I read the code correctly, the comment shoudl simply be:
> 
> The GICv3 spec allows any CPU to access any redistributor through the
> memory-mapped redistributor registers.  We can therefore determine which
> reditributor is being accesses by simply looking at the faulting IPA.
> 

Yeah, admittedly this comment was total crap. Changed it to something
closer to yours.

>> + */
>> +static bool vgic_v3_handle_mmio(struct kvm_vcpu *vcpu, struct kvm_run *run,
>> +                             struct kvm_exit_mmio *mmio)
>> +{
>> +     struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>> +     unsigned long dbase = dist->vgic_dist_base;
>> +     unsigned long rdbase = dist->vgic_redist_base;
> 
> I'm not crazy about these 'shortcuts', especially given that RD_base is
> the base of a specific redistributor, but ok.

Well, I change rdbase below, so at least this one has to stay as a variable.

>> +     int nrcpus = atomic_read(&vcpu->kvm->online_vcpus);
>> +     int vcpu_id;
>> +     struct kvm_vcpu *target_redist_vcpu;
>> +
>> +     if (is_in_range(mmio->phys_addr, mmio->len, dbase, GIC_V3_DIST_SIZE)) {
>> +             return vgic_handle_mmio_range(vcpu, run, mmio,
>> +                                           vgic_dist_ranges, dbase, NULL);
>> +     }
>> +
>> +     if (!is_in_range(mmio->phys_addr, mmio->len, rdbase,
>> +         GIC_V3_REDIST_SIZE * nrcpus))
>> +             return false;
> 
> so this implies that all redistributors will always be in contiguous IPA
> space, is this reasonable?

As far as I read the spec, this is mandated there. And as the "GIC
implementors" we define that anyway, right?

>> +
>> +     vcpu_id = (mmio->phys_addr - rdbase) / GIC_V3_REDIST_SIZE;
>> +     rdbase += (vcpu_id * GIC_V3_REDIST_SIZE);
>> +     target_redist_vcpu = kvm_get_vcpu(vcpu->kvm, vcpu_id);
> 
> redist_vcpu should be enough

fixed.

>> +
>> +     if (mmio->phys_addr >= rdbase + 0x10000)
>> +             return vgic_handle_mmio_range(vcpu, run, mmio,
>> +                                           vgic_redist_sgi_ranges,
>> +                                           rdbase + 0x10000,
>> +                                           target_redist_vcpu);
> 
> 0x10000 magic number used twice,  GICV3_REDIST_SGI_PAGE_OFFSET or
> something shorter.

Done that.

> perhaps it is nicer to just adjust rdbase and set a range variable above
> and only have a single call to vgic_handle_mmio_range().

Yup.

>> +
>> +     return vgic_handle_mmio_range(vcpu, run, mmio, vgic_redist_ranges,
>> +                                   rdbase, target_redist_vcpu);
>> +}
>> +
>> +static bool vgic_v3_queue_sgi(struct kvm_vcpu *vcpu, int irq)
>> +{
>> +     if (vgic_queue_irq(vcpu, 0, irq)) {
>> +             vgic_dist_irq_clear_pending(vcpu, irq);
>> +             vgic_cpu_irq_clear(vcpu, irq);
>> +             return true;
>> +     }
>> +
>> +     return false;
>> +}
>> +
>> +static int vgic_v3_init_maps(struct vgic_dist *dist)
>> +{
>> +     int nr_spis = dist->nr_irqs - VGIC_NR_PRIVATE_IRQS;
>> +
>> +     dist->irq_spi_mpidr = kcalloc(nr_spis, sizeof(dist->irq_spi_mpidr[0]),
>> +                                   GFP_KERNEL);
>> +
>> +     if (!dist->irq_spi_mpidr)
>> +             return -ENOMEM;
>> +
>> +     return 0;
>> +}
>> +
>> +static int vgic_v3_init(struct kvm *kvm, const struct vgic_params *params)
>> +{
>> +     struct vgic_dist *dist = &kvm->arch.vgic;
>> +     int ret, i;
>> +     u32 mpidr;
>> +
>> +     if (IS_VGIC_ADDR_UNDEF(dist->vgic_dist_base) ||
>> +         IS_VGIC_ADDR_UNDEF(dist->vgic_redist_base)) {
>> +             kvm_err("Need to set vgic distributor addresses first\n");
>> +             return -ENXIO;
>> +     }
>> +
>> +     /*
>> +      * FIXME: this should be moved to init_maps time, and may bite
>> +      * us when adding save/restore. Add a per-emulation hook?
>> +      */
> 
> What is the plan for this?  Can we move it into init_maps or does that
> require some more work?

This comment is from Marc, when he once rebased these patches on top of
his rebased and reworked vgic_dyn patches.
Looks like I have to take a closer look at this now ...

> Why can't we do what the gicv2 emulation does?
> 
> Not sure what the "Add a per-emulation hook?" question is asking...

The point is that this allocation is guest GIC model dependend.
Per-emulation hook means to differentiate between the possible guest
model code by using a function pointer.

>> +     ret = vgic_v3_init_maps(dist);
>> +     if (ret) {
>> +             kvm_err("Unable to allocate maps\n");
>> +             return ret;
>> +     }
>> +
>> +     mpidr = compress_mpidr(kvm_vcpu_get_mpidr(kvm_get_vcpu(kvm, 0)));
>> +     for (i = VGIC_NR_PRIVATE_IRQS; i < dist->nr_irqs; i++) {
>> +             dist->irq_spi_cpu[i - VGIC_NR_PRIVATE_IRQS] = 0;
>> +             dist->irq_spi_mpidr[i - VGIC_NR_PRIVATE_IRQS] = mpidr;
>> +             vgic_bitmap_set_irq_val(dist->irq_spi_target, 0, i, 1);
> 
> why do we need 3 different copies of the same value now?  ok, we had two
> before because of the bitmap "optimization" thingy, but now we have two
> other sets of state for the same thing...

Mmmh, we use irq_spi_cpu[] and irq_spi_target[] to be able to reuse the
existing code. irq_spi_mpidr[] is just there to allow read-as-written.

>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void vgic_v3_add_sgi_source(struct kvm_vcpu *vcpu, int irq, int source)
>> +{
> 
> can you put a one line comment here:
> 
> /* The GICv3 spec does away with keeping track of SGI sources */

Sure.

>> +}
>> +
>> +bool vgic_v3_init_emulation_ops(struct kvm *kvm, int type)
>> +{
>> +     struct vgic_dist *dist = &kvm->arch.vgic;
>> +
>> +     switch (type) {
>> +     case KVM_DEV_TYPE_ARM_VGIC_V3:
>> +             dist->vm_ops.handle_mmio = vgic_v3_handle_mmio;
>> +             dist->vm_ops.queue_sgi = vgic_v3_queue_sgi;
>> +             dist->vm_ops.add_sgi_source = vgic_v3_add_sgi_source;
>> +             dist->vm_ops.vgic_init = vgic_v3_init;
>> +             break;
>> +     default:
>> +             return false;
>> +     }
>> +     return true;
>> +}
>> +
>> +/*
>> + * triggered by a system register access trap, called from the sysregs
> 
>       Triggered
> 
>> + * handling code there.
> 
>                     ^^^ there, where, here, and everywhere ?
> 
>> + * The register contains the upper three affinity levels of the target
> 
>           ^^^ which register?  @reg ?
> 
>> + * processors as well as a bitmask of 16 Aff0 CPUs.
> 
> Does @reg follow the format from something in the spec?  That would be
> useful to know...
> 
>> + * Iterate over all VCPUs to check for matching ones or signal on
>> + * all-but-self if the mode bit is set.
> 
> an all-but-self IPI?  Is that the architectural term?  Otherwise I would
> suggest something like:  If not VCPUs are found which match reg (in some
> way), then send the IPI to all VCPUs in the VM, except the one
> performing the system register acces.

I totally reworked the comment. Admittedly this was more targeted to
Marc ;-)

>> + */
> 
> Also, please use the kdocs format here like the rest of the kvm/arm code.
> Begin sentences with upper-case, etc.:
> 
> /**
> * vgic_v3_dispatch_sgi - This function does something with SGIs
> * @vcpu: The vcpu pointer
> * @reg: Magic
> *
> * Some nicer version of what you have above.
> */
> 
>> +void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg)
>> +{
> 
> It's a bit hard to review this when I cannot see how it is called, I'm
> assuming that this is on writes to ICC_SGI1R_EL1 and reg is what the
> guest tried to write to that register.
> 
> I have a feeling that you may want to add this function in a separate patch.

I think I had it thay way before and there was some other issue with
this split-up. Will give it a try again.

>> +     struct kvm *kvm = vcpu->kvm;
>> +     struct kvm_vcpu *c_vcpu;
>> +     struct vgic_dist *dist = &kvm->arch.vgic;
>> +     u16 target_cpus;
>> +     u64 mpidr, mpidr_h, mpidr_l;
>> +     int sgi, mode, c, vcpu_id;
>> +     int updated = 0;
>> +
>> +     vcpu_id = vcpu->vcpu_id;
>> +
>> +     sgi = (reg >> 24) & 0xf;
>> +     mode = (reg >> 40) & 0x1;
> 
> perhaps we can call this 'targeted' or something to make it a bit more
> clear.

I use broadcast now, that is even more readable in the code below.

>> +     target_cpus = reg & 0xffff;
> 
> Can you add some defines for these magic shifts?  Are there not some
> already for the GICv3 host driver we can reuse?

No, the host driver uses magic shift values directly.
I added appropriate defines in arm-gic-v3.h and use them in both places
now. It is a bit messy though, since the names tend to get quite long
and I needed to define wrapper macros to make it not totally unreadable.

>> +     mpidr = ((reg >> 48) & 0xff) << MPIDR_LEVEL_SHIFT(3);
>> +     mpidr |= ((reg >> 32) & 0xff) << MPIDR_LEVEL_SHIFT(2);
>> +     mpidr |= ((reg >> 16) & 0xff) << MPIDR_LEVEL_SHIFT(1);
>> +     mpidr &= ~MPIDR_LEVEL_MASK;
> 
> (**) note the comment a few lines down.
> 
>> +
>> +     /*
>> +      * We take the dist lock here, because we come from the sysregs
>> +      * code path and not from MMIO (where this is already done)
> 
>                                         which already takes the lock).
> 
>> +      */
>> +     spin_lock(&dist->lock);
>> +     kvm_for_each_vcpu(c, c_vcpu, kvm) {
> 
> I think it would be helpful to document this loop, something like:
> 
> We loop through every possible vCPU and check if we need to send an SGI
> to that vCPU.  If targeting specific vCPUS, we check if the candidate
> vCPU is in the target list and if it is, we send an SGI and clear the
> bit in the target list.  When the target list is empty and we are
> targeting specific vCPUs, we are done.
> 
> Maybe too verbose, you can tweak it as you like.
> 
>> +             if (!mode && target_cpus == 0)
>> +                     break;
>> +             if (mode && c == vcpu_id)       /* not to myself */
>> +                     continue;
>> +             if (!mode) {
>> +                     mpidr_h = kvm_vcpu_get_mpidr(c_vcpu);
>> +                     mpidr_l = MPIDR_AFFINITY_LEVEL(mpidr_h, 0);
>> +                     mpidr_h &= ~MPIDR_LEVEL_MASK;
> 
> this is *really* confusing. _h and _l are high and low?
> 
> Can you factor this out into a static inline and get rid of that mpidr
> mask above (**) ?

So I reworked the whole function and commented it heavily. The algorithm
stays the same, but it much more readable, hopefully.

>> +                     if (mpidr != mpidr_h)
>> +                             continue;
>> +                     if (!(target_cpus & BIT(mpidr_l)))
>> +                             continue;
>> +                     target_cpus &= ~BIT(mpidr_l);
>> +             }
>> +             /* Flag the SGI as pending */
>> +             vgic_dist_irq_set_pending(c_vcpu, sgi);
>> +             updated = 1;
>> +             kvm_debug("SGI%d from CPU%d to CPU%d\n", sgi, vcpu_id, c);
>> +     }
>> +     if (updated)
>> +             vgic_update_state(vcpu->kvm);
>> +     spin_unlock(&dist->lock);
>> +     if (updated)
>> +             vgic_kick_vcpus(vcpu->kvm);
>> +}
>> +
>> +
>> +static int vgic_v3_get_attr(struct kvm_device *dev,
>> +                         struct kvm_device_attr *attr)
>> +{
>> +     int ret;
>> +
>> +     ret = vgic_get_common_attr(dev, attr);
> 
> So this means we can get the KVM_VGIC_V2_ADDR_TYPE_DIST and
> KVM_VGIC_V2_ADDR_TYPE_CPU from an emualted gicv3 without the GICv2
> backwards compatibility features?

Mmh, below has_attr() doesn't claim to support it. So accessing them
would break the KVM protocol?
Also, kvm_vgic_addr() explicitly tries to avoid this (check type_needed).
Feel free to correct if I am wrong on this ...

>> +     if (ret != -ENXIO)
>> +             return ret;
>> +
>> +     switch (attr->group) {
>> +     case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
>> +     case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
>> +             return -ENXIO;
>> +     }
>> +
>> +     return -ENXIO;
>> +}
>> +
>> +static int vgic_v3_set_attr(struct kvm_device *dev,
>> +                         struct kvm_device_attr *attr)
>> +{
>> +     int ret;
>> +
>> +     ret = vgic_set_common_attr(dev, attr);
> 
> same as above?
> 
>> +     if (ret != -ENXIO)
>> +             return ret;
>> +
>> +     switch (attr->group) {
>> +     case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
>> +     case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
>> +             return -ENXIO;
>> +     }
>> +
>> +     return -ENXIO;
>> +}
>> +
>> +static int vgic_v3_has_attr(struct kvm_device *dev,
>> +                         struct kvm_device_attr *attr)
>> +{
>> +     switch (attr->group) {
>> +     case KVM_DEV_ARM_VGIC_GRP_ADDR:
>> +             switch (attr->attr) {
>> +             case KVM_VGIC_V2_ADDR_TYPE_DIST:
>> +             case KVM_VGIC_V2_ADDR_TYPE_CPU:
>> +                     return -ENXIO;
>> +             }
>> +             break;
>> +     case KVM_DEV_ARM_VGIC_GRP_DIST_REGS:
>> +     case KVM_DEV_ARM_VGIC_GRP_CPU_REGS:
>> +             return -ENXIO;
>> +     case KVM_DEV_ARM_VGIC_GRP_NR_IRQS:
>> +             return 0;
>> +     }
>> +     return -ENXIO;
>> +}
>> +
>> +struct kvm_device_ops kvm_arm_vgic_v3_ops = {
>> +     .name = "kvm-arm-vgic-v3",
>> +     .create = vgic_create,
>> +     .destroy = vgic_destroy,
>> +     .set_attr = vgic_v3_set_attr,
>> +     .get_attr = vgic_v3_get_attr,
>> +     .has_attr = vgic_v3_has_attr,
> 
> nit: you could reorder set/get so they're set in the same order they
> appear in the code.

Why not...
Have you thought about an OCD treatment, btw? ;-)

>> +};
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index a54389b..2867269d 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -1228,7 +1228,7 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
>>       struct kvm_vcpu *vcpu;
>>       int edge_triggered, level_triggered;
>>       int enabled;
>> -     bool ret = true;
>> +     bool ret = true, can_inject = true;
>>
>>       spin_lock(&dist->lock);
>>
>> @@ -1243,6 +1243,11 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
>>
>>       if (irq_num >= VGIC_NR_PRIVATE_IRQS) {
>>               cpuid = dist->irq_spi_cpu[irq_num - VGIC_NR_PRIVATE_IRQS];
>> +             if (cpuid == VCPU_NOT_ALLOCATED) {
>> +                     /* Pretend we use CPU0, and prevent injection */
>> +                     cpuid = 0;
>> +                     can_inject = false;
>> +             }
>>               vcpu = kvm_get_vcpu(kvm, cpuid);
>>       }
>>
>> @@ -1264,7 +1269,7 @@ static bool vgic_update_irq_pending(struct kvm *kvm, int cpuid,
>>
>>       enabled = vgic_irq_is_enabled(vcpu, irq_num);
>>
>> -     if (!enabled) {
>> +     if (!enabled || !can_inject) {
> 
> don't you also need to handle the vgic_dist_irq_set_pending() call and
> its friends above?

Not sure I understand what you mean here.
can_inject is there to check accesses to the irq_spi_cpu[] array and
detect the "undefined CPU" special case caused by writing an unknown
MPIDR into the GICD_IROUTERn register.
AFAICT vgic_update_irq_pending() is the only function using this array,
right? Or have I got something wrong here?

>>               ret = false;
>>               goto out;
>>       }
>> @@ -1406,6 +1411,7 @@ void kvm_vgic_destroy(struct kvm *kvm)
>>       }
>>       kfree(dist->irq_sgi_sources);
>>       kfree(dist->irq_spi_cpu);
>> +     kfree(dist->irq_spi_mpidr);
>>       kfree(dist->irq_spi_target);
>>       kfree(dist->irq_pending_on_cpu);
>>       dist->irq_sgi_sources = NULL;
>> @@ -1581,6 +1587,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>>       kvm->arch.vgic.vctrl_base = vgic->vctrl_base;
>>       kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
>>       kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
>> +     kvm->arch.vgic.vgic_redist_base = VGIC_ADDR_UNDEF;
> 
> sure, we can write to the same memory twice, why not, it's fun.

It honours you that you remembered that this is defined as a union, but
I consider this an implementation detail (which may change in the
future) and the "casual" reader may not know this, so for the sake of
completeness let's initialize all to them. Either the compiler, the L1D
or the out-of-order engine in the CPU should drop this redundancy in
practise, hopefully.

>>
>>       if (!init_emulation_ops(kvm, type))
>>               ret = -ENODEV;
>> diff --git a/virt/kvm/arm/vgic.h b/virt/kvm/arm/vgic.h
>> index f52db4e..42c20c1 100644
>> --- a/virt/kvm/arm/vgic.h
>> +++ b/virt/kvm/arm/vgic.h
>> @@ -35,6 +35,8 @@
>>  #define ACCESS_WRITE_VALUE   (3 << 1)
>>  #define ACCESS_WRITE_MASK(x) ((x) & (3 << 1))
>>
>> +#define VCPU_NOT_ALLOCATED   ((u8)-1)
>> +
>>  unsigned long *vgic_bitmap_get_shared_map(struct vgic_bitmap *x);
>>
>>  void vgic_update_state(struct kvm *kvm);
>> @@ -121,5 +123,6 @@ int vgic_set_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr);
>>  int vgic_get_common_attr(struct kvm_device *dev, struct kvm_device_attr *attr);
>>
>>  bool vgic_v2_init_emulation_ops(struct kvm *kvm, int type);
>> +bool vgic_v3_init_emulation_ops(struct kvm *kvm, int type);
>>
>>  #endif
>> --
>> 1.7.9.5
>>

Puh, that's it. I'm on to merging the changes in the respective patches
and will send out a v4 ASAP.

Tak!
Andre.
