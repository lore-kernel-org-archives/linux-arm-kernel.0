From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 15 May 2015 15:44:23 +0100
Subject: [PATCH v4 03/12] KVM: arm64: guest debug, define API headers
In-Reply-To: <1431700035-23479-4-git-send-email-alex.bennee@linaro.org>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
 <1431700035-23479-4-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150515144423.GA23652@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 03:27:06PM +0100, Alex Benn?e wrote:
> This commit defines the API headers for guest debugging. There are two
> architecture specific debug structures:
> 
>   - kvm_guest_debug_arch, allows us to pass in HW debug registers
>   - kvm_debug_exit_arch, signals exception and possible faulting address
> 
> The type of debugging being used is controlled by the architecture
> specific control bits of the kvm_guest_debug->control flags in the ioctl
> structure.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> ---
> v2
>    - expose hsr and pc directly to user-space
> v3
>    - s/control/controlled/ in commit message
>    - add v8 to ARM ARM comment (ARM Architecture Reference Manual)
>    - add rb tag
>    - rm pc, add far
>    - re-word comments on alignment
>    - rename KVM_ARM_NDBG_REGS -> KVM_ARM_MAX_DBG_REGS
> v4
>    - now uses common HW/SW BP define
>    - add a-b-tag
>    - use u32 for control regs
> 
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index d268320..8796610 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -100,10 +100,28 @@ struct kvm_sregs {
>  struct kvm_fpu {
>  };
>  
> +/*
> + * See v8 ARM ARM D7.3: Debug Registers
> + *
> + * The control registers are architecturally defined as 32 bits but are
> + * stored as 64 bit values alongside the value registers. This is done

Stale comment? They're stored as __u32 below.

It's possible that the registers could grow in future as happened in the
case of CLIDR_EL1, so it might be worth treating system registers
generally as u64 values.

Mark.

> + * to keep the copying of these values into the vcpu context simple as
> + * everything is 64 bit aligned (see DBGBCR0_EL1 onwards in kvm_asm.h).
> + *
> + * The architectural limit is 16 debug registers of each type although
> + * in practice there are usually less (see ID_AA64DFR0_EL1).
> + */
> +#define KVM_ARM_MAX_DBG_REGS 16
>  struct kvm_guest_debug_arch {
> +	__u32 dbg_bcr[KVM_ARM_MAX_DBG_REGS];
> +	__u64 dbg_bvr[KVM_ARM_MAX_DBG_REGS];
> +	__u32 dbg_wcr[KVM_ARM_MAX_DBG_REGS];
> +	__u64 dbg_wvr[KVM_ARM_MAX_DBG_REGS];
>  };
>  
>  struct kvm_debug_exit_arch {
> +	__u32 hsr;
> +	__u64 far;
>  };
>  
>  struct kvm_sync_regs {
> -- 
> 2.3.5
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
