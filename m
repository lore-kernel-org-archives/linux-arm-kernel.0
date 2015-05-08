From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 May 2015 11:28:44 +0200
Subject: [PATCH v3 03/12] KVM: arm64: guest debug, define API headers
In-Reply-To: <1430929407-3487-4-git-send-email-alex.bennee@linaro.org>
References: <1430929407-3487-1-git-send-email-alex.bennee@linaro.org>
 <1430929407-3487-4-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150508092844.GC24744@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 05:23:18PM +0100, Alex Benn?e wrote:
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
> 
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index d268320..04957d7 100644
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
> + * to keep the copying of these values into the vcpu context simple as
> + * everything is 64 bit aligned (see DBGBCR0_EL1 onwards in kvm_asm.h).
> + *
> + * The architectural limit is 16 debug registers of each type although
> + * in practice there are usually less (see ID_AA64DFR0_EL1).
> + */
> +#define KVM_ARM_MAX_DBG_REGS 16
>  struct kvm_guest_debug_arch {
> +	__u64 dbg_bcr[KVM_ARM_MAX_DBG_REGS];
> +	__u64 dbg_bvr[KVM_ARM_MAX_DBG_REGS];
> +	__u64 dbg_wcr[KVM_ARM_MAX_DBG_REGS];
> +	__u64 dbg_wvr[KVM_ARM_MAX_DBG_REGS];
>  };
>  
>  struct kvm_debug_exit_arch {
> +	__u32 hsr;
> +	__u64 far;
>  };
>  
>  struct kvm_sync_regs {
> @@ -216,4 +234,11 @@ struct kvm_arch_memory_slot {
>  
>  #endif
>  
> +/*
> + * Architecture related debug defines - upper 16 bits of

"Architecture specific debug control flags" seems more accurate.

> + * kvm_guest_debug->control
> + */
> +#define KVM_GUESTDBG_USE_SW_BP	        __KVM_GUESTDBG_USE_SW_BP
> +#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
> +
>  #endif /* __ARM_KVM_H__ */
> -- 
> 2.3.5
> 

Otherwise:
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Thanks,
-Christoffer
