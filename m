From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Mar 2016 09:47:13 +0100
Subject: [PATCH] arm64: KVM: Turn kvm_ksym_ref into a NOP on VHE
In-Reply-To: <1458321959-11728-1-git-send-email-marc.zyngier@arm.com>
References: <1458321959-11728-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAKv+Gu_at5LXa5jxpM7h=ntxdJNNqmbtVE-bWn3SicMMMuT6Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2016 at 18:25, Marc Zyngier <marc.zyngier@arm.com> wrote:
> When running with VHE, there is no need to translate kernel pointers
> to the EL2 memory space, since we're already there (and we have a much
> saner memory map to start with).
>
> Unfortunately, kvm_ksym_ref is getting in the way, and the first
> call into the "hypervisor" section is going to end up in fireworks,
> since we're now branching into nowhereland. Meh.
>
> A potential solution is to test if VHE is engaged or not, and only
> perform the translation in the negative case. With this in place,
> VHE is able to run again.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

I think you need the & when initializing val, otherwise, it will
silently refer to the value rather than the address of a void* symbol
if we ever end up using this macro on one.

That was the whoie point of the opaque struct type in the original
patch that introduced this macro, to disallow references lacking the
&, but unfortunately, that was incompatible with the other VHE
changes.

With that fixed

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/include/asm/kvm_asm.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 226f49d..282f907 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -26,7 +26,13 @@
>  #define KVM_ARM64_DEBUG_DIRTY_SHIFT    0
>  #define KVM_ARM64_DEBUG_DIRTY          (1 << KVM_ARM64_DEBUG_DIRTY_SHIFT)
>
> -#define kvm_ksym_ref(sym)              phys_to_virt((u64)&sym - kimage_voffset)
> +#define kvm_ksym_ref(sym)                                              \
> +       ({                                                              \
> +               void *val = sym;                                        \
> +               if (!is_kernel_in_hyp_mode())                           \
> +                       val = phys_to_virt((u64)&sym - kimage_voffset); \
> +               val;                                                    \
> +        })
>
>  #ifndef __ASSEMBLY__
>  struct kvm;
> --
> 2.1.4
>
