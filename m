From: christoffer.dall@arm.com (Christoffer Dall)
Date: Thu, 19 Jul 2018 22:57:39 +0200
Subject: [PATCH v4 10/10] KVM: arm/arm64: vgic: Update documentation of
 the GIC devices wrt IIDR
In-Reply-To: <20180719170830.cjrob66sjz522d33@kamzik.brq.redhat.com>
References: <1531746387-7033-1-git-send-email-christoffer.dall@arm.com>
 <1531746387-7033-11-git-send-email-christoffer.dall@arm.com>
 <20180719170830.cjrob66sjz522d33@kamzik.brq.redhat.com>
Message-ID: <20180719205739.GB6399@C02W217FHV2R.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 07:08:30PM +0200, Andrew Jones wrote:
> On Mon, Jul 16, 2018 at 03:06:27PM +0200, Christoffer Dall wrote:
> > Update the documentation to reflect the ordering requirements of
> > restoring the GICD_IIDR register before any other registers and the
> > effects this has on restoring the interrupt groups for an emulated GICv2
> > insttance.
> 
> instance
> 
> > 
> > Also remove some outdated limitations in the documentation while we're
> > at it.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> > ---
> >  Documentation/virtual/kvm/devices/arm-vgic-v3.txt |  8 ++++++++
> >  Documentation/virtual/kvm/devices/arm-vgic.txt    | 15 +++++++++------
> >  2 files changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> > index 2408ab7..eba20ae 100644
> > --- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> > +++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> > @@ -100,6 +100,14 @@ Groups:
> >      Note that distributor fields are not banked, but return the same value
> >      regardless of the mpidr used to access the register.
> >  
> > +    GICD_IIDR.Revision is updated when the KVM implementation is changed in a
> > +    way directly observable by the guest or userspace.  Userspace should read
> > +    GICD_IIDR from KVM and write back the read value to confirm its expected
> > +    behavior is aligned with the KVM implementation.  Userspace should set
> > +    GICD_IIDR before setting any other registers.  to ensure the expected
> 
>  s/. //
> 
> > +    behavior.
> > +
> > +
> >      The GICD_STATUSR and GICR_STATUSR registers are architecturally defined such
> >      that a write of a clear bit has no effect, whereas a write with a set bit
> >      clears that value.  To allow userspace to freely set the values of these two
> > diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
> > index b3ce126..4ff7635 100644
> > --- a/Documentation/virtual/kvm/devices/arm-vgic.txt
> > +++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
> > @@ -49,9 +49,15 @@ Groups:
> >      index is specified with the vcpu_index field.  Note that most distributor
> >      fields are not banked, but return the same value regardless of the
> >      vcpu_index used to access the register.
> > -  Limitations:
> > -    - Priorities are not implemented, and registers are RAZ/WI
> > -    - Currently only implemented for KVM_DEV_TYPE_ARM_VGIC_V2.
> > +
> > +    GICD_IIDR.Revision is updated when the KVM implementation of an emulated
> > +    GICv2 is changed in a way directly observable by the guest or userspace.
> > +    Userspace should read GICD_IIDR from KVM and write back the read value to
> > +    confirm its expected behavior is aligned with the KVM implementation.
> > +    Userspace should set GICD_IIDR before setting any other registers (both
> > +    KVM_DEV_ARM_VGIC_GRP_DIST_REGS and KVM_DEV_ARM_VGIC_GRP_CPU_REGS) to ensure
> > +    the expected behavior.  Unless GICD_IIDR has been set from userspace, writes
> > +    to the interrupt group registers (GICD_IGROUPR) are ignored.
> >    Errors:
> >      -ENXIO: Getting or setting this register is not yet supported
> >      -EBUSY: One or more VCPUs are running
> > @@ -94,9 +100,6 @@ Groups:
> >      use the lower 5 bits to communicate with the KVM device and must shift the
> >      value left by 3 places to obtain the actual priority mask level.
> >  
> > -  Limitations:
> > -    - Priorities are not implemented, and registers are RAZ/WI
> > -    - Currently only implemented for KVM_DEV_TYPE_ARM_VGIC_V2.
> >    Errors:
> >      -ENXIO: Getting or setting this register is not yet supported
> >      -EBUSY: One or more VCPUs are running
> > -- 
> > 2.7.4
> >
> 
> Otherwise
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks.  I'm hoping that Marc won't mind fixing this up when applying
the patches.

-Christoffer
