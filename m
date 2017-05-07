From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 7 May 2017 17:19:02 +0200
Subject: [PATCH v7 16/24] KVM: arm64: vgic-its:
 KVM_DEV_ARM_ITS_SAVE/RESTORE_TABLES
In-Reply-To: <87efw0ixli.fsf@on-the-bus.cambridge.arm.com>
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-17-git-send-email-eric.auger@redhat.com>
 <87lgq8kej5.fsf@on-the-bus.cambridge.arm.com>
 <87efw0ixli.fsf@on-the-bus.cambridge.arm.com>
Message-ID: <20170507151902.GA8519@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 07, 2017 at 02:51:37PM +0100, Marc Zyngier wrote:
> On Sun, May 07 2017 at  2:00:30 pm BST, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On Sat, May 06 2017 at  4:24:35 pm BST, Eric Auger <eric.auger@redhat.com> wrote:
> >> Introduce new attributes in KVM_DEV_ARM_VGIC_GRP_CTRL group:
> >> - KVM_DEV_ARM_ITS_SAVE_TABLES: saves the ITS tables into guest RAM
> >> - KVM_DEV_ARM_ITS_RESTORE_TABLES: restores them into VGIC internal
> >>   structures.
> >>
> >> We hold the vcpus lock during the save and restore to make
> >> sure no vcpu is running.
> >>
> >> At this stage the functionality is not yet implemented. Only
> >> the skeleton is put in place.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> ---
> >> v6 -> v7:
> >> - also hold the its_lock on save and restore
> >>
> >> v5 -> v6:
> >> - remove the pending table sync from the ITS table restore
> >>
> >> v4 -> v5:
> >> - use KVM_DEV_ARM_ITS_SAVE_TABLES and KVM_DEV_ARM_ITS_RESTORE_TABLES
> >> - rename *flush* into *save*
> >> - call its_sync_lpi_pending_table at the end of restore
> >> - use abi framework
> >>
> >> v3 -> v4:
> >> - pass kvm struct handle to vgic_its_flush/restore_pending_tables
> >> - take the kvm lock and vcpu locks
> >> - ABI revision check
> >> - check attr->attr is null
> >>
> >> v1 -> v2:
> >> - remove useless kvm parameter
> >> ---
> >>  arch/arm/include/uapi/asm/kvm.h   |   4 +-
> >>  arch/arm64/include/uapi/asm/kvm.h |   4 +-
> >>  virt/kvm/arm/vgic/vgic-its.c      | 107 ++++++++++++++++++++++++++++++++++++--
> >>  3 files changed, 109 insertions(+), 6 deletions(-)
> >>
> >
> > [...]
> >
> >> @@ -1718,7 +1777,37 @@ static int vgic_its_save_tables_v0(struct vgic_its *its)
> >>   */
> >>  static int vgic_its_restore_tables_v0(struct vgic_its *its)
> >>  {
> >> -	return -ENXIO;
> >> +	struct kvm *kvm = its->dev->kvm;
> >> +	int ret;
> >> +
> >> +	mutex_lock(&kvm->lock);
> >> +	mutex_lock(&its->its_lock);
> >> +
> >> +	if (!lock_all_vcpus(kvm)) {
> >> +		mutex_unlock(&its->its_lock);
> >> +		mutex_unlock(&kvm->lock);
> >> +		return -EBUSY;
> >> +	}
> >> +
> >> +	ret = vgic_its_restore_collection_table(its);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	ret = vgic_its_restore_device_tables(its);
> >> +
> >> +out:
> >> +	unlock_all_vcpus(kvm);
> >> +	mutex_unlock(&its->its_lock);
> >> +	mutex_unlock(&kvm->lock);
> >> +
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/*
> >> +	 * On restore path, MSI injections can happen before the
> >> +	 * first VCPU run so let's complete the GIC init here.
> >> +	 */
> >> +	return kvm_vgic_map_resources(its->dev->kvm);
> >
> > This one is still a rather sore spot, but I've lost track of what we can
> > do about it. Until now, this would only happen on first run. But it
> > looks like QEMU and KVM have different views of what "runable" is.
> >
> > I'm not sure there is a good way to solve this, unfortunately. From a
> > device PoV, everything is ready and the fact that nothing is clocking
> > the CPUs is very much irrelevant. I'm almost tempted to say that the
> > map_resource() call in kvm_vcpu_first_run_init shouldn't be there, and
> > that we're missing a synchronization point with userspace that would say
> > "system is entierely configured", triggering the iodev registration.
> >
> > Oh well. At that point, and short of having something better to offer:
> >
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> >
> > 	M.
> 
> Actually, there is a rather big problem here. This function is called on
> a per-ITS basis. But once we have run map_resources *once*, any other
> call becomes ineffective (vgic_ready() returns true). What happens to
> the other ITSs? Can they still be successfully restored? Don't they
> end-up with the same "blind spot" you've tried to close?
> 
I really think the only proper solution to this is to have map_resources
do nothing at all on GICv3, and register the iodevs when the base
addresses are set, and all that map_resources end up doing is to
actually map stuff for GICv2 in the guest address space (the virtual CPU
interface).

That way the initialization is tied to the data that makes the
initialization possible, we don't need another sync point, it becomes
ITS-specific, and migration should work.  Take two? :)

-Christoffer
