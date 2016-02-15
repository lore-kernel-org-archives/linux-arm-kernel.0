From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 15 Feb 2016 20:23:22 +0100
Subject: [PATCH] arm64/efi: Make strnlen() available to the EFI namespace
In-Reply-To: <1455563856-1553-1-git-send-email-thierry.reding@gmail.com>
References: <1455563856-1553-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <CAKv+Gu86oyHJcBhkjouLQk8FMR=0obrPpwnYvXMFSJkOa3c2pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On 15 February 2016 at 20:17, Thierry Reding <thierry.reding@gmail.com> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Changes introduced in the upstream version of libfdt pulled in by commit
> 91feabc2e224 ("scripts/dtc: Update to upstream commit b06e55c88b9b") use
> the strnlen() function, which isn't currently available to the EFI name-
> space. Add it to the EFI namespace to avoid a linker error.
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm64/kernel/image.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
> index c9c62cab25a4..8a1978f4a555 100644
> --- a/arch/arm64/kernel/image.h
> +++ b/arch/arm64/kernel/image.h
> @@ -96,6 +96,8 @@ __efistub_strcmp              = KALLSYMS_HIDE(__pi_strcmp);
>  __efistub_strncmp              = KALLSYMS_HIDE(__pi_strncmp);
>  __efistub___flush_dcache_area  = KALLSYMS_HIDE(__pi___flush_dcache_area);
>
> +__efistub_strnlen              = KALLSYMS_HIDE(strnlen);
> +

To align with the existing code, we should use __pi_strnlen here, and
declare the asm version of strnlen with ENDPIPROC()

Thanks,
Ard.


>  #ifdef CONFIG_KASAN
>  __efistub___memcpy             = KALLSYMS_HIDE(__pi_memcpy);
>  __efistub___memmove            = KALLSYMS_HIDE(__pi_memmove);
> --
> 2.7.1
>
