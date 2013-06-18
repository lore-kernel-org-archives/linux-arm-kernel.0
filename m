From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 18 Jun 2013 08:46:34 -0700
Subject: [PATCH 2/7] KVM: arm-vgic: Set base addr through device API
In-Reply-To: <C2CF6B47-18E3-456B-9BE4-0682A7DD0DE9@suse.de>
References: <1370926279-32532-1-git-send-email-christoffer.dall@linaro.org>
 <1370926279-32532-3-git-send-email-christoffer.dall@linaro.org>
 <C2CF6B47-18E3-456B-9BE4-0682A7DD0DE9@suse.de>
Message-ID: <20130618154634.GD3332@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 03:25:04PM +0200, Alexander Graf wrote:
> 
> 
> Am 11.06.2013 um 06:51 schrieb Christoffer Dall <christoffer.dall@linaro.org>:
> 
> > Support setting the distributor and cpu interface base addresses in the
> > VM physical address space through the KVM_{SET,GET}_DEVICE_ATTR API
> > in addition the ARM specific API.
> > 
> > This has the added benefit of being able to share more code in user
> > space and do things in a uniform maner.
> > 
> > Also deprecate the older API at the same time, but backwards
> > compatibility will be maintained.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> > Documentation/virtual/kvm/api.txt              |    5 +-
> > Documentation/virtual/kvm/devices/arm-vgic.txt |   11 +++
> > arch/arm/kvm/arm.c                             |    2 +-
> > include/kvm/arm_vgic.h                         |    2 +-
> > virt/kvm/arm/vgic.c                            |   90 ++++++++++++++++++++----
> > 5 files changed, 95 insertions(+), 15 deletions(-)
> > 
> > diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> > index 5f91eda..ea5ec4a 100644
> > --- a/Documentation/virtual/kvm/api.txt
> > +++ b/Documentation/virtual/kvm/api.txt
> > @@ -2305,7 +2305,7 @@ This ioctl returns the guest registers that are supported for the
> > KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
> > 
> > 
> > -4.80 KVM_ARM_SET_DEVICE_ADDR
> > +4.80 KVM_ARM_SET_DEVICE_ADDR (deprecated)
> > 
> > Capability: KVM_CAP_ARM_SET_DEVICE_ADDR
> > Architectures: arm
> > @@ -2342,6 +2342,9 @@ and distributor interface, the ioctl must be called after calling
> > KVM_CREATE_IRQCHIP, but before calling KVM_RUN on any of the VCPUs.  Calling
> > this ioctl twice for any of the base addresses will return -EEXIST.
> > 
> > +Note, this IOCTL is deprecated and the more flexible SET/GET_DEVICE_ATTR API
> > +should be used instead.
> > +
> > 4.82 KVM_PPC_RTAS_DEFINE_TOKEN
> > 
> > Capability: KVM_CAP_PPC_RTAS
> > diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
> > index 25fd2d9..ca83ad8 100644
> > --- a/Documentation/virtual/kvm/devices/arm-vgic.txt
> > +++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
> > @@ -8,3 +8,14 @@ Only one VGIC instance may be instantiated through either this API or the
> > legacy KVM_CREATE_IRQCHIP api.  The created VGIC will act as the VM interrupt
> > controller, requiring emulated user-space devices to inject interrupts to the
> > VGIC instead of directly to CPUs.
> > +
> > +Groups:
> 
> Ah, here they are :)
> 
> > +  KVM_DEV_ARM_VGIC_GRP_ADDR
> > +  Attributes:
> > +    KVM_VGIC_V2_ADDR_TYPE_DIST (rw, 64-bit)
> > +      Base address in the guest physical address space of the GIC distributor
> > +      register mappings.
> > +
> > +    KVM_VGIC_V2_ADDR_TYPE_CPU (rw, 64-bit)
> > +      Base address in the guest physical address space of the GIC virtual cpu
> > +      interface register mappings.
> 
> Is this per-cpu or per-vgic? Can different CPUs have their gic interface maps mapped at different offsets?
> 
This is per-vgic.

If the _CPU part is confusing, it means it's the address of the CPU
interface, as opposed to the Distributor interface.  Individual CPUs
calculate their specific offset from this base address based on a mask,
but the base is common for everyone (and banked depending on the
accessing CPU for a certain region).

-Christoffer
