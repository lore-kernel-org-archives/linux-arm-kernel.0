From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Jul 2018 09:52:04 +0100
Subject: [PATCH v3 9/9] KVM: arm/arm64: vgic: Update documentation of the
 GICv2 device
In-Reply-To: <1531587940-2490-10-git-send-email-christoffer.dall@arm.com>
References: <1531587940-2490-1-git-send-email-christoffer.dall@arm.com>
 <1531587940-2490-10-git-send-email-christoffer.dall@arm.com>
Message-ID: <a5324e35-53b4-b5b4-84a2-1e0a89b244e7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/07/18 18:05, Christoffer Dall wrote:
> Update the documentation to reflect the ordering requirements of
> restoring GICv2 distributor registers and remove outdated limitations in
> the documentation while we're at it.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  Documentation/virtual/kvm/devices/arm-vgic.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/devices/arm-vgic.txt b/Documentation/virtual/kvm/devices/arm-vgic.txt
> index b3ce126..c9a6393 100644
> --- a/Documentation/virtual/kvm/devices/arm-vgic.txt
> +++ b/Documentation/virtual/kvm/devices/arm-vgic.txt
> @@ -49,9 +49,12 @@ Groups:
>      index is specified with the vcpu_index field.  Note that most distributor
>      fields are not banked, but return the same value regardless of the
>      vcpu_index used to access the register.
> -  Limitations:
> -    - Priorities are not implemented, and registers are RAZ/WI
> -    - Currently only implemented for KVM_DEV_TYPE_ARM_VGIC_V2.
> +
> +    GICD_IIDR.Revision is updated when the KVM implementation of an emulated
> +    GICv2 is changed.  Userspace should read GICD_IIDR from KVM and write back
> +    the read value to confirm its expected behavior is aligned with the KVM
> +    implementation.  To properly restore the interrupt group configuration,
> +    GICD_IIDR should be written before any other registers.

I'd like to make it crystal clear that writing to IIDR doesn't allow to
select a behaviour, and is merely a confirmation that host and guest do
agree on either revision 0 (no write) or revision n (n being read and
written back).

Also, on ordering: does the write to IIDR have to happen before any
write to other distributor registers? Or to any GIC register? I think
you mean the former, but I wonder if we shouldn't mandate the latter,
just to be sure...

>    Errors:
>      -ENXIO: Getting or setting this register is not yet supported
>      -EBUSY: One or more VCPUs are running
> @@ -94,9 +97,6 @@ Groups:
>      use the lower 5 bits to communicate with the KVM device and must shift the
>      value left by 3 places to obtain the actual priority mask level.
>  
> -  Limitations:
> -    - Priorities are not implemented, and registers are RAZ/WI
> -    - Currently only implemented for KVM_DEV_TYPE_ARM_VGIC_V2.
>    Errors:
>      -ENXIO: Getting or setting this register is not yet supported
>      -EBUSY: One or more VCPUs are running
> 

Finally, do we want to to extend the same requirements to GICv3, for the
sake of uniformity?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
