From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 8 May 2015 11:23:46 +0200
Subject: [PATCH v3 02/12] KVM: define common __KVM_GUESTDBG_USE_SW/HW_BP
 values
In-Reply-To: <1430929407-3487-3-git-send-email-alex.bennee@linaro.org>
References: <1430929407-3487-1-git-send-email-alex.bennee@linaro.org>
 <1430929407-3487-3-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150508092346.GB24744@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 05:23:17PM +0100, Alex Benn?e wrote:
> Currently x86, powerpc and soon arm64 use the same two architecture
> specific bits for guest debug support for software and hardware
> breakpoints. This makes the shared values explicit while leaving the
> gate open for another architecture to use some other value if they
> really really want to.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> 
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index ab4d473..1731569 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -310,8 +310,8 @@ struct kvm_guest_debug_arch {
>   * and upper 16 bits are architecture specific. Architecture specific defines
>   * that ioctl is for setting hardware breakpoint or software breakpoint.
>   */
> -#define KVM_GUESTDBG_USE_SW_BP		0x00010000
> -#define KVM_GUESTDBG_USE_HW_BP		0x00020000
> +#define KVM_GUESTDBG_USE_SW_BP		__KVM_GUESTDBG_USE_SW_BP
> +#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
>  
>  /* definition of registers in kvm_run */
>  struct kvm_sync_regs {
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index d7dcef5..1438202 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -250,8 +250,8 @@ struct kvm_debug_exit_arch {
>  	__u64 dr7;
>  };
>  
> -#define KVM_GUESTDBG_USE_SW_BP		0x00010000
> -#define KVM_GUESTDBG_USE_HW_BP		0x00020000
> +#define KVM_GUESTDBG_USE_SW_BP		__KVM_GUESTDBG_USE_SW_BP
> +#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
>  #define KVM_GUESTDBG_INJECT_DB		0x00040000
>  #define KVM_GUESTDBG_INJECT_BP		0x00080000
>  
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 70ac641..3b6252e 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -570,8 +570,16 @@ struct kvm_s390_irq_state {
>  
>  /* for KVM_SET_GUEST_DEBUG */
>  
> -#define KVM_GUESTDBG_ENABLE		0x00000001
> -#define KVM_GUESTDBG_SINGLESTEP		0x00000002
> +#define KVM_GUESTDBG_ENABLE		(1 << 0)
> +#define KVM_GUESTDBG_SINGLESTEP	(1 << 1)
> +
> +/*
> + * Architecture specific stuff uses the top 16 bits of the field,

s/stuff/<something more specific>/

> + * however there is some shared commonality for the common cases
> + */
> +#define __KVM_GUESTDBG_USE_SW_BP	(1 << 16)
> +#define __KVM_GUESTDBG_USE_HW_BP	(1 << 17)
> +
>  
>  struct kvm_guest_debug {
>  	__u32 control;

We sort of left this discussion hanging with me expressing slight
concern about the usefulness about these defines.

Paolo, what are your thoughts?

-Christoffer
