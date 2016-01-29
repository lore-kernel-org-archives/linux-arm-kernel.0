From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 29 Jan 2016 15:57:01 +0000
Subject: [PATCH v4 22/22] arm64: efi: invoke EFI_RNG_PROTOCOL to supply
 KASLR randomness
In-Reply-To: <1453828249-14467-23-git-send-email-ard.biesheuvel@linaro.org>
References: <1453828249-14467-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453828249-14467-23-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160129155701.GC2611@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jan, at 06:10:49PM, Ard Biesheuvel wrote:
> Since arm64 does not use a decompressor that supplies an execution
> environment where it is feasible to some extent to provide a source of
> randomness, the arm64 KASLR kernel depends on the bootloader to supply
> some random bits in the /chosen/kaslr-seed DT property upon kernel entry.
> 
> On UEFI systems, we can use the EFI_RNG_PROTOCOL, if supplied, to obtain
> some random bits. At the same time, use it to randomize the offset of the
> kernel Image in physical memory.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/Kconfig                        |  5 ++
>  drivers/firmware/efi/libstub/arm-stub.c   | 40 ++++++----
>  drivers/firmware/efi/libstub/arm64-stub.c | 78 ++++++++++++++------
>  drivers/firmware/efi/libstub/fdt.c        |  9 +++
>  4 files changed, 97 insertions(+), 35 deletions(-)
 
[...]

> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index cf7b7d46302a..04c9302b0ef1 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -147,6 +147,15 @@ efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
>  	if (status)
>  		goto fdt_set_fail;
>  
> +	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> +		status = efi_get_random_bytes(sys_table, sizeof(fdt_val64),
> +					      (u8 *)&fdt_val64);
> +		if (status == EFI_SUCCESS)
> +			status = fdt_setprop(fdt, node, "kaslr-seed",
> +					     &fdt_val64, sizeof(fdt_val64));
> +		else if (status != EFI_NOT_FOUND)
> +			goto fdt_set_fail;
> +	}
>  	return EFI_SUCCESS;
>  
>  fdt_set_fail:

I think you want to handle the case where fdt_setprop() fails. With
this new code you'll silently return EFI_SUCCESS even if you fail to
set "kaslr-seed".
