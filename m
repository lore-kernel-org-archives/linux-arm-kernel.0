From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 15:02:44 +0000
Subject: [PATCH v4 10/14] KVM: ARM: User space API for getting/setting
 co-proc registers
In-Reply-To: <20121110154321.2836.75612.stgit@chazy-air>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154321.2836.75612.stgit@chazy-air>
Message-ID: <20121119150244.GC3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 03:43:21PM +0000, Christoffer Dall wrote:
> The following three ioctls are implemented:
>  -  KVM_GET_REG_LIST
>  -  KVM_GET_ONE_REG
>  -  KVM_SET_ONE_REG

[...]

> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 845ceda..9671cd2 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -1798,6 +1798,11 @@ is the register group type, or coprocessor number:
>  ARM core registers have the following id bit patterns:
>    0x4002 0000 0010 <index into the kvm_regs struct:16>
> 
> +ARM 32-bit CP15 registers have the following id bit patterns:
> +  0x4002 0000 000F <zero:1> <crn:4> <crm:4> <opc1:4> <opc2:3>
> +
> +ARM 64-bit CP15 registers have the following id bit patterns:
> +  0x4003 0000 000F <zero:1> <zero:4> <crm:4> <opc1:4> <zero:3>
> 
> 
>  4.69 KVM_GET_ONE_REG
> @@ -2139,6 +2144,45 @@ This ioctl returns the guest registers that are supported for the
>  KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
> 
> 
> +4.77 KVM_ARM_VCPU_INIT
> +
> +Capability: basic
> +Architectures: arm
> +Type: vcpu ioctl
> +Parameters: struct struct kvm_vcpu_init (in)
> +Returns: 0 on success; -1 on error
> +Errors:
> +  EINVAL:    the target is unknown, or the combination of features is invalid.
> +  ENOENT:    a features bit specified is unknown.
> +
> +This tells KVM what type of CPU to present to the guest, and what
> +optional features it should have.  This will cause a reset of the cpu
> +registers to their initial values.  If this is not called, KVM_RUN will
> +return ENOEXEC for that vcpu.
> +
> +Note that because some registers reflect machine topology, all vcpus
> +should be created before this ioctl is invoked.
> +
> +4.78 KVM_GET_REG_LIST
> +
> +Capability: basic
> +Architectures: arm
> +Type: vcpu ioctl
> +Parameters: struct kvm_reg_list (in/out)
> +Returns: 0 on success; -1 on error
> +Errors:
> +  E2BIG:     the reg index list is too big to fit in the array specified by
> +             the user (the number required will be written into n).
> +
> +struct kvm_reg_list {
> +       __u64 n; /* number of registers in reg[] */
> +       __u64 reg[0];
> +};
> +
> +This ioctl returns the guest registers that are supported for the
> +KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
> +
> +

You already added this hunk earlier (and looking at the final result,
you do end up wih two entries for 4.77 and 4.78).

Will
