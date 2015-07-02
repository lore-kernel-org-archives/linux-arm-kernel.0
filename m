From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 02 Jul 2015 10:26:29 +0300
Subject: [PATCH 1/7] KVM: api: add kvm_irq_routing_extended_msi
In-Reply-To: <1435592237-17924-2-git-send-email-eric.auger@linaro.org>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
 <1435592237-17924-2-git-send-email-eric.auger@linaro.org>
Message-ID: <011f01d0b498$6a17aeb0$3e470c10$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> -----Original Message-----
> From: kvm-owner at vger.kernel.org [mailto:kvm-owner at vger.kernel.org] On Behalf Of Eric Auger
> Sent: Monday, June 29, 2015 6:37 PM
> To: eric.auger at st.com; eric.auger at linaro.org; linux-arm-kernel at lists.infradead.org;
> marc.zyngier at arm.com; christoffer.dall at linaro.org; andre.przywara at arm.com;
> kvmarm at lists.cs.columbia.edu; kvm at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org; patches at linaro.org; p.fedin at samsung.com; pbonzini at redhat.com
> Subject: [PATCH 1/7] KVM: api: add kvm_irq_routing_extended_msi
> 
> On ARM, the MSI msg (address and data) comes along with
> out-of-band device ID information. The device ID encodes the device
> that composes the MSI msg. Let's create a new routing entry type,
> dubbed KVM_IRQ_ROUTING_EXTENDED_MSI and use the __u32 pad space
> to convey the device ID.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> 
> RFC -> PATCH
> - remove kvm_irq_routing_extended_msi and use union instead
> ---
>  Documentation/virtual/kvm/api.txt | 9 ++++++++-
>  include/uapi/linux/kvm.h          | 6 +++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index d20fd94..6426ae9 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -1414,7 +1414,10 @@ struct kvm_irq_routing_entry {
>  	__u32 gsi;
>  	__u32 type;
>  	__u32 flags;
> -	__u32 pad;
> +	union {
> +		__u32 pad;
> +		__u32 devid;
> +	};
>  	union {
>  		struct kvm_irq_routing_irqchip irqchip;
>  		struct kvm_irq_routing_msi msi;

 devid is actually a part of MSI bunch. Shouldn't it be a part of struct kvm_irq_routing_msi then?
It also has reserved pad.

> @@ -1427,6 +1430,10 @@ struct kvm_irq_routing_entry {
>  #define KVM_IRQ_ROUTING_IRQCHIP 1
>  #define KVM_IRQ_ROUTING_MSI 2
>  #define KVM_IRQ_ROUTING_S390_ADAPTER 3
> +#define KVM_IRQ_ROUTING_EXTENDED_MSI 4
> +
> +In case of KVM_IRQ_ROUTING_EXTENDED_MSI routing type, devid is used to convey
> +the device ID.
> 
>  No flags are specified so far, the corresponding field must be set to zero.

What if we use KVM_MSI_VALID_DEVID flag instead of new KVM_IRQ_ROUTING_EXTENDED_MSI definition? I
believe this would make an API more consistent and introduce less new definitions.

> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 2a23705..8484681 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -841,12 +841,16 @@ struct kvm_irq_routing_s390_adapter {
>  #define KVM_IRQ_ROUTING_IRQCHIP 1
>  #define KVM_IRQ_ROUTING_MSI 2
>  #define KVM_IRQ_ROUTING_S390_ADAPTER 3
> +#define KVM_IRQ_ROUTING_EXTENDED_MSI 4
> 
>  struct kvm_irq_routing_entry {
>  	__u32 gsi;
>  	__u32 type;
>  	__u32 flags;
> -	__u32 pad;
> +	union {
> +		__u32 pad;
> +		__u32 devid;
> +	};
>  	union {
>  		struct kvm_irq_routing_irqchip irqchip;
>  		struct kvm_irq_routing_msi msi;
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
