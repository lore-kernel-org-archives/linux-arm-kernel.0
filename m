From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 11 Jul 2018 14:48:29 +0800
Subject: [PATCH v7 1/4] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
In-Reply-To: <20180710164952.23736-2-james.morse@arm.com>
References: <20180710164952.23736-1-james.morse@arm.com>
 <20180710164952.23736-2-james.morse@arm.com>
Message-ID: <b0eb95f3-7905-8aab-f816-529c17f07e04@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, James,

[...]
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index d10944e619d3..e3940f8715a5 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -835,11 +835,13 @@ struct kvm_clock_data {
>  
>  Capability: KVM_CAP_VCPU_EVENTS
>  Extended by: KVM_CAP_INTR_SHADOW
> -Architectures: x86
> -Type: vm ioctl
> +Architectures: x86, arm64

   In my previous patch, I only add the arm64 support, now you add patches to support arm32 platform,
   so you can add "ARM" to the Architectures, for example: "Architectures: x86, ARM, arm64"

> +Type: vcpu ioctl
>  Parameters: struct kvm_vcpu_event (out)
>  Returns: 0 on success, -1 on error
>  
> +X86:
> +
>  Gets currently pending exceptions, interrupts, and NMIs as well as related
>  states of the vcpu.
>  
> @@ -881,15 +883,32 @@ Only two fields are defined in the flags field:
>  - KVM_VCPUEVENT_VALID_SMM may be set in the flags field to signal that
>    smi contains a valid state.
>  
> +ARM64:

  "ARM, ARM64:" or "arm/arm64:"

> +
> +Gets currently pending SError exceptions as well as related states of the vcpu.
> +
> +struct kvm_vcpu_events {
> +	struct {
> +		__u8 serror_pending;
> +		__u8 serror_has_esr;
> +		/* Align it to 8 bytes */
> +		__u8 pad[6];
> +		__u64 serror_esr;
> +	} exception;
> +	__u32 reserved[12];
> +};
> +
>  4.32 KVM_SET_VCPU_EVENTS
>  
>  Capability: KVM_CAP_VCPU_EVENTS
>  Extended by: KVM_CAP_INTR_SHADOW
> -Architectures: x86
> -Type: vm ioctl
> +Architectures: x86, arm64

+Architectures: x86, ARM, arm64

> +Type: vcpu ioctl
>  Parameters: struct kvm_vcpu_event (in)
>  Returns: 0 on success, -1 on error
>  
> +X86:
> +
>  Set pending exceptions, interrupts, and NMIs as well as related states of the
>  vcpu.
>  
> @@ -910,6 +929,12 @@ shall be written into the VCPU.
>  
>  KVM_VCPUEVENT_VALID_SMM can only be set if KVM_CAP_X86_SMM is available.
>  
> +ARM64:

"ARM, ARM64:" or "arm/arm64:"

> +
> +Set pending SError exceptions as well as related states of the vcpu.
[...]
