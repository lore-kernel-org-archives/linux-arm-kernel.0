From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 23 Apr 2013 16:02:52 -0700
Subject: [PATCH v3 31/32] arm64: KVM: userspace API documentation
In-Reply-To: <1365437854-30214-32-git-send-email-marc.zyngier@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-32-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130423230252.GO20569@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 05:17:33PM +0100, Marc Zyngier wrote:
> Unsurprisingly, the arm64 userspace API is extremely similar to
> the 32bit one, the only significant difference being the ONE_REG
> register mapping.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/virtual/kvm/api.txt | 55 +++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 119358d..7c3385e 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -280,7 +280,7 @@ kvm_run' (see below).
>  4.11 KVM_GET_REGS
>  
>  Capability: basic
> -Architectures: all except ARM
> +Architectures: all except ARM, arm64
>  Type: vcpu ioctl
>  Parameters: struct kvm_regs (out)
>  Returns: 0 on success, -1 on error
> @@ -301,7 +301,7 @@ struct kvm_regs {
>  4.12 KVM_SET_REGS
>  
>  Capability: basic
> -Architectures: all except ARM
> +Architectures: all except ARM, arm64
>  Type: vcpu ioctl
>  Parameters: struct kvm_regs (in)
>  Returns: 0 on success, -1 on error
> @@ -587,7 +587,7 @@ struct kvm_fpu {
>  4.24 KVM_CREATE_IRQCHIP
>  
>  Capability: KVM_CAP_IRQCHIP
> -Architectures: x86, ia64, ARM
> +Architectures: x86, ia64, ARM, arm64
>  Type: vm ioctl
>  Parameters: none
>  Returns: 0 on success, -1 on error
> @@ -595,14 +595,14 @@ Returns: 0 on success, -1 on error
>  Creates an interrupt controller model in the kernel.  On x86, creates a virtual
>  ioapic, a virtual PIC (two PICs, nested), and sets up future vcpus to have a
>  local APIC.  IRQ routing for GSIs 0-15 is set to both PIC and IOAPIC; GSI 16-23
> -only go to the IOAPIC.  On ia64, a IOSAPIC is created. On ARM, a GIC is
> +only go to the IOAPIC.  On ia64, a IOSAPIC is created. On ARM/arm64, a GIC is
>  created.
>  
>  
>  4.25 KVM_IRQ_LINE
>  
>  Capability: KVM_CAP_IRQCHIP
> -Architectures: x86, ia64, arm
> +Architectures: x86, ia64, arm, arm64
>  Type: vm ioctl
>  Parameters: struct kvm_irq_level
>  Returns: 0 on success, -1 on error
> @@ -612,9 +612,10 @@ On some architectures it is required that an interrupt controller model has
>  been previously created with KVM_CREATE_IRQCHIP.  Note that edge-triggered
>  interrupts require the level to be set to 1 and then back to 0.
>  
> -ARM can signal an interrupt either at the CPU level, or at the in-kernel irqchip
> -(GIC), and for in-kernel irqchip can tell the GIC to use PPIs designated for
> -specific cpus.  The irq field is interpreted like this:
> +ARM/arm64 can signal an interrupt either at the CPU level, or at the
> +in-kernel irqchip (GIC), and for in-kernel irqchip can tell the GIC to
> +use PPIs designated for specific cpus.  The irq field is interpreted
> +like this:
>  
>   ?bits:  | 31 ... 24 | 23  ... 16 | 15    ...    0 |
>    field: | irq_type  | vcpu_index |     irq_id     |
> @@ -1802,6 +1803,19 @@ ARM 32-bit VFP control registers have the following id bit patterns:
>  ARM 64-bit FP registers have the following id bit patterns:
>    0x4002 0000 0012 0 <regno:12>
>  
> +
> +arm64 registers are mapped using the lower 32 bits. The upper 16 of
> +that is the register group type, or coprocessor number:
> +
> +arm64 core/FP-SIMD registers have the following id bit patterns:
> +  0x6002 0000 0010 <index into the kvm_regs struct:16>
> +
> +arm64 CCSIDR registers are demultiplexed by CSSELR value:
> +  0x6002 0000 0011 00 <csselr:8>
> +
> +arm64 system registers have the following id bit patterns:
> +  0x6002 0000 0013 <op0:2> <op1:3> <crn:4> <crm:4> <op2:3>
> +

I think these size encodings are 4 bits off, and not accurate for for
the core registers, which have variable sizes, which should be indicated
here (unless you decide for a separate category as per my other
comment).

>  4.69 KVM_GET_ONE_REG
>  
>  Capability: KVM_CAP_ONE_REG
> @@ -2165,7 +2179,7 @@ valid entries found.
>  4.77 KVM_ARM_VCPU_INIT
>  
>  Capability: basic
> -Architectures: arm
> +Architectures: arm, arm64
>  Type: vcpu ioctl
>  Parameters: struct struct kvm_vcpu_init (in)
>  Returns: 0 on success; -1 on error
> @@ -2184,12 +2198,14 @@ should be created before this ioctl is invoked.
>  Possible features:
>  	- KVM_ARM_VCPU_POWER_OFF: Starts the CPU in a power-off state.
>  	  Depends on KVM_CAP_ARM_PSCI.
> +	- KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
> +	  Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
>  
>  
>  4.78 KVM_GET_REG_LIST
>  
>  Capability: basic
> -Architectures: arm
> +Architectures: arm, arm64
>  Type: vcpu ioctl
>  Parameters: struct kvm_reg_list (in/out)
>  Returns: 0 on success; -1 on error
> @@ -2209,7 +2225,7 @@ KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
>  4.80 KVM_ARM_SET_DEVICE_ADDR
>  
>  Capability: KVM_CAP_ARM_SET_DEVICE_ADDR
> -Architectures: arm
> +Architectures: arm, arm64
>  Type: vm ioctl
>  Parameters: struct kvm_arm_device_address (in)
>  Returns: 0 on success, -1 on error
> @@ -2230,18 +2246,19 @@ can access emulated or directly exposed devices, which the host kernel needs
>  to know about. The id field is an architecture specific identifier for a
>  specific device.
>  
> -ARM divides the id field into two parts, a device id and an address type id
> -specific to the individual device.
> +ARM/arm64 divides the id field into two parts, a device id and an
> +address type id specific to the individual device.
>  
>   ?bits:  | 63        ...       32 | 31    ...    16 | 15    ...    0 |
>    field: |        0x00000000      |     device id   |  addr type id  |
>  
> -ARM currently only require this when using the in-kernel GIC support for the
> -hardware VGIC features, using KVM_ARM_DEVICE_VGIC_V2 as the device id.  When
> -setting the base address for the guest's mapping of the VGIC virtual CPU
> -and distributor interface, the ioctl must be called after calling
> -KVM_CREATE_IRQCHIP, but before calling KVM_RUN on any of the VCPUs.  Calling
> -this ioctl twice for any of the base addresses will return -EEXIST.
> +ARM/arm64 currently only require this when using the in-kernel GIC
> +support for the hardware VGIC features, using KVM_ARM_DEVICE_VGIC_V2
> +as the device id.  When setting the base address for the guest's
> +mapping of the VGIC virtual CPU and distributor interface, the ioctl
> +must be called after calling KVM_CREATE_IRQCHIP, but before calling
> +KVM_RUN on any of the VCPUs.  Calling this ioctl twice for any of the
> +base addresses will return -EEXIST.
>  
>  
>  5. The kvm_run structure
> -- 
> 1.8.1.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
