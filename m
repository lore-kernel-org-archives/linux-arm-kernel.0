From: james.morse@arm.com (James Morse)
Date: Tue, 10 Jul 2018 18:57:31 +0100
Subject: [PATCH v3.1 2/4] efi/arm: preserve early mapping of UEFI memory
 map longer for BGRT
In-Reply-To: <20180709234229.20181-3-takahiro.akashi@linaro.org>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180709234229.20181-3-takahiro.akashi@linaro.org>
Message-ID: <93c42065-bece-a4c7-ed99-5e98f91315a6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 10/07/18 00:42, AKASHI Takahiro wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> The BGRT code validates the contents of the table against the UEFI
> memory map, and so it expects it to be mapped when the code runs.
> 
> On ARM, this is currently not the case, since we tear down the early
> mapping after efi_init() completes, and only create the permanent
> mapping in arm_enable_runtime_services(), which executes as an early
> initcall, but still leaves a window where the UEFI memory map is not
> mapped.
> 
> So move the call to efi_memmap_unmap() from efi_init() to
> arm_enable_runtime_services().

I don't have a machine that generates a BGRT, but I can see that efi_mem_type()
call in efi_bgrt_init() would cause the same problems we have with kexec and acpi.


> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index b5214c143fee..388a929baf95 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -259,7 +259,6 @@ void __init efi_init(void)
>  
>  	reserve_regions();
>  	efi_esrt_init();
> -	efi_memmap_unmap();
>  
>  	memblock_reserve(params.mmap & PAGE_MASK,
>  			 PAGE_ALIGN(params.mmap_size +
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 5889cbea60b8..59a8c0ec94d5 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -115,6 +115,8 @@ static int __init arm_enable_runtime_services(void)
>  		return 0;
>  	}
>  
> +	efi_memmap_unmap();

This can get called twice if uefi_init() fails after setting the EFI_BOOT flag,
but this can only happen if the system table signature is wrong, (or we're out
of memory really early).

I think this is harmless as we end up passing NULL to early_memunmap() which
WARN()s and returns as its outside the fixmap range. Its just more noise on
systems with a corrupt efi system table.

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
