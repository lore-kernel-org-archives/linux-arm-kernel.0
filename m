From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 24 Nov 2014 10:39:01 +0100
Subject: [PATCH v4 19/19] arm/arm64: KVM: allow userland to request a
 virtual GICv3
In-Reply-To: <1415959683-26027-20-git-send-email-andre.przywara@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <1415959683-26027-20-git-send-email-andre.przywara@arm.com>
Message-ID: <20141124093901.GF3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 10:08:03AM +0000, Andre Przywara wrote:
> With all of the GICv3 code in place now we allow userland to ask the
> kernel for using a virtual GICv3 in the guest.
> Also we provide the necessary support for guests setting the memory
> addresses for the virtual distributor and redistributors.
> This requires some userland code to make use of that feature and
> explicitly ask for a virtual GICv3.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Changelog v3...v4:
> - refine commit message
> - add documentation of new GICv3 KVM device
> 
>  Documentation/virtual/kvm/devices/arm-vgic.txt |   21 +++++++++--
>  arch/arm64/include/uapi/asm/kvm.h              |    7 ++++
>  include/kvm/arm_vgic.h                         |    4 +--
>  virt/kvm/arm/vgic-v3-emul.c                    |    3 ++
>  virt/kvm/arm/vgic.c                            |   46 +++++++++++++++++-------
>  5 files changed, 64 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
> index df8b0c7..67e4c3e 100644
> --- a/Documentation/virtual/kvm/devices/arm-vgic.txt
> +++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
> @@ -3,22 +3,37 @@ ARM Virtual Generic Interrupt Controller (VGIC)
>  
>  Device types supported:
>    KVM_DEV_TYPE_ARM_VGIC_V2     ARM Generic Interrupt Controller v2.0
> +  KVM_DEV_TYPE_ARM_VGIC_V3     ARM Generic Interrupt Controller v3.0
>  
>  Only one VGIC instance may be instantiated through either this API or the
>  legacy KVM_CREATE_IRQCHIP api.  The created VGIC will act as the VM interrupt
>  controller, requiring emulated user-space devices to inject interrupts to the
>  VGIC instead of directly to CPUs.

I would add a newline here.

> +Creating a guest GICv3 device requires a host GICv3 as well.
> +GICv3 implementations with hardware compatibility support allow a guest GICv2
> +as well.
>  
>  Groups:
>    KVM_DEV_ARM_VGIC_GRP_ADDR
>    Attributes:
>      KVM_VGIC_V2_ADDR_TYPE_DIST (rw, 64-bit)
>        Base address in the guest physical address space of the GIC distributor
> -      register mappings.
> +      register mappings. Only valid if a guest GICv2 has been instantiated.
>  
only valid for KVM_DEV_TYPE_ARM_VGIC_V2.

>      KVM_VGIC_V2_ADDR_TYPE_CPU (rw, 64-bit)
>        Base address in the guest physical address space of the GIC virtual cpu
> -      interface register mappings.
> +      interface register mappings. Only valid if a guest GICv2 has been
> +      instantiated.

same as above.

> +
> +    KVM_VGIC_V3_ADDR_TYPE_DIST (rw, 64-bit)
> +      Base address in the guest physical address space of the GICv3 distributor
> +      register mappings. Only valid if a guest GICv3 has been instantiated.

only valid for KVM_DEV_TYPE_ARM_VGIC_V3.  Are there not any alignment
restrictions here?

> +
> +    KVM_VGIC_V3_ADDR_TYPE_REDIST (rw, 64-bit)
> +      Base address in the guest physical address space of the GICv3
> +      redistributor register mappings. Only valid if a guest GICv3 has been
> +      instantiated.
> +

same as above

So this region's size is automatically just contiguously increased
depending on the number of the VCPUS created?

How are we ensuring this doesn't conflict with any other potential
mappings (memregions) in the guest physical address space?

>  
>    KVM_DEV_ARM_VGIC_GRP_DIST_REGS
>    Attributes:
> @@ -36,6 +51,7 @@ Groups:
>      the register.
>    Limitations:
>      - Priorities are not implemented, and registers are RAZ/WI
> +    - Currently only implemented for GICv2.

Currently only implemented for KVM_DEV_TYPE_ARM_VGIC_V2?  Or does this
not work for KVM_DEV_TYPE_ARM_VGIC_V2 on GICv3 hardware?

>    Errors:
>      -ENODEV: Getting or setting this register is not yet supported
>      -EBUSY: One or more VCPUs are running
> @@ -68,6 +84,7 @@ Groups:
>  
>    Limitations:
>      - Priorities are not implemented, and registers are RAZ/WI
> +    - Currently only implemented for GICv2.

same as above.

>    Errors:
>      -ENODEV: Getting or setting this register is not yet supported
>      -EBUSY: One or more VCPUs are running


Thanks,
-Christoffer
