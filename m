From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Feb 2016 19:27:46 +0000
Subject: [PATCH] arm64/efi: Make strnlen() available to the EFI namespace
In-Reply-To: <1455563856-1553-1-git-send-email-thierry.reding@gmail.com>
References: <1455563856-1553-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20160215192746.GT6298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 08:17:36PM +0100, Thierry Reding wrote:
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
> @@ -96,6 +96,8 @@ __efistub_strcmp		= KALLSYMS_HIDE(__pi_strcmp);
>  __efistub_strncmp		= KALLSYMS_HIDE(__pi_strncmp);
>  __efistub___flush_dcache_area	= KALLSYMS_HIDE(__pi___flush_dcache_area);
>  
> +__efistub_strnlen		= KALLSYMS_HIDE(strnlen);

Shouldn't this refer to __pi_strnlen once we've established that our
strnlen implementation is position independent? It looks like it is, so
you just need to s/ENDPROC/ENDPIPROC/ over there to get the symbol
defined.

Will
