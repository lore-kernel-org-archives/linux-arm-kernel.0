From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 31 Aug 2017 16:46:32 +0100
Subject: [PATCH] arm64: efi: Don't include EFI fpsimd save/restore code in
 non-EFI kernels
In-Reply-To: <1504193606-14461-1-git-send-email-Dave.Martin@arm.com>
References: <1504193606-14461-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAKv+Gu-L0gWGc-EGviDhXimv8zm9hqLuiFjWE-e5__mQGTR+zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 August 2017 at 16:33, Dave Martin <Dave.Martin@arm.com> wrote:
> __efi_fpsimd_begin()/__efi_fpsimd_end() are for use when making EFI
> calls only, so using them in non-EFI kernels is not allowed.
>
> This patch compiles them out if CONFIG_EFI is not set.
>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I suppose we could also move these into arch/arm64/kernel/efi.c

> ---
>  arch/arm64/kernel/fpsimd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 3a68cf3..f444f37 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -321,6 +321,8 @@ void kernel_neon_end(void)
>  }
>  EXPORT_SYMBOL(kernel_neon_end);
>
> +#ifdef CONFIG_EFI
> +
>  static DEFINE_PER_CPU(struct fpsimd_state, efi_fpsimd_state);
>  static DEFINE_PER_CPU(bool, efi_fpsimd_state_used);
>
> @@ -370,6 +372,8 @@ void __efi_fpsimd_end(void)
>                 kernel_neon_end();
>  }
>
> +#endif /* CONFIG_EFI */
> +
>  #endif /* CONFIG_KERNEL_MODE_NEON */
>
>  #ifdef CONFIG_CPU_PM
> --
> 2.1.4
>
