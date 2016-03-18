From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 18 Mar 2016 11:37:02 +0000
Subject: [PATCH 6/8] efi/arm*: libstub: wire up GOP handling into the ARM
 UEFI stub
In-Reply-To: <1457588408-19309-7-git-send-email-ard.biesheuvel@linaro.org>
References: <1457588408-19309-1-git-send-email-ard.biesheuvel@linaro.org>
 <1457588408-19309-7-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160318113702.GQ2619@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Mar, at 12:40:06PM, Ard Biesheuvel wrote:
> This enables the EFI stub side of handling the EFI Graphics Output
> Protocol. It involves invoking the generic GOP code to discover the GOP
> handle that also drives the console, and using its metadata to populate
> the screen_info structure.
> 
> For arm64, the stub and the kernel proper live in the same executable, so
> we can simply access screen_info directly.
> 
> For ARM, we need to allocate a struct screen_info in the stub, and install
> it as a configuration table so that the core kernel can go and fetch it to
> copy its contents into the real screen_info structure.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/include/asm/efi.h                | 12 +++++++
>  arch/arm/kernel/setup.c                   |  3 +-
>  arch/arm64/include/asm/efi.h              |  3 ++
>  arch/arm64/kernel/efi.c                   |  3 ++
>  arch/arm64/kernel/image.h                 |  1 +
>  drivers/firmware/efi/libstub/arm-stub.c   | 23 ++++++++++++
>  drivers/firmware/efi/libstub/arm32-stub.c | 38 ++++++++++++++++++++
>  7 files changed, 82 insertions(+), 1 deletion(-)
 
I'd really like to see the ARM and arm64-specific parts split into
separate patches, and then the ARM part merged with patch 8.

The main reason I'm being so strict about this is because the ARM use
of InstallConfigurationTable() should be a shining example of how to
use that scheme for any future developers.

So that if someone wants to use it to pass other data we can say:
"Look at how we did it for ARM and screen_info. Use that as your
template." 

Of course, if we do get more users we need to think about providing a
real API around InstallConfigurationTable(), but that's for
future-Matt and future-Ard to worry about.

> diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
> index daebcfe6c35a..6329b5be1eca 100644
> --- a/arch/arm/include/asm/efi.h
> +++ b/arch/arm/include/asm/efi.h
> @@ -63,6 +63,18 @@ void efi_virtmap_unload(void);
>  #define __efi_call_early(f, ...)	f(__VA_ARGS__)
>  #define efi_is_64bit()			(0)
>  
> +struct screen_info *alloc_screen_info(efi_system_table_t *sys_table_arg);
> +void free_screen_info(efi_system_table_t *sys_table, struct screen_info *si);
> +
> +/*
> + * This GUID is used to pass to the kernel proper the struct screen_info
> + * structure that was populated by the stub based on the GOP protocol instance
> + * associated with ConOut
> + */
> +#define LINUX_ARM32_SCREEN_INFO_TABLE_GUID \
> +	EFI_GUID(0xe03fc20a, 0x85dc, 0x406e, \
> +		 0xb9, 0xe, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
> +
>  /*
>   * A reasonable upper bound for the uncompressed kernel size is 32 MBytes,
>   * so we will reserve that amount of memory. We have no easy way to tell what

This should go into include/linux/efi.h. We already have precedent for
Linux-specific GUIDs there. See LINUX_EFI_CRASH_GUID.
