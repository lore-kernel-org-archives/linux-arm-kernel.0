From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 26 Nov 2015 10:47:11 +0000
Subject: [PATCH v3 13/13] ARM: add UEFI stub support
In-Reply-To: <1448269593-20758-14-git-send-email-ard.biesheuvel@linaro.org>
References: <1448269593-20758-1-git-send-email-ard.biesheuvel@linaro.org>
 <1448269593-20758-14-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151126104711.GH2765@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Nov, at 10:06:33AM, Ard Biesheuvel wrote:
> From: Roy Franz <roy.franz@linaro.org>
> 
> This patch adds EFI stub support for the ARM Linux kernel.
> 
> The EFI stub operates similarly to the x86 and arm64 stubs: it is a
> shim between the EFI firmware and the normal zImage entry point, and
> sets up the environment that the zImage is expecting. This includes
> optionally loading the initrd and device tree from the system partition
> based on the kernel command line.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/Kconfig                          |  19 +++
>  arch/arm/boot/compressed/Makefile         |   4 +-
>  arch/arm/boot/compressed/efi-header.S     | 130 ++++++++++++++++++++
>  arch/arm/boot/compressed/head.S           |  54 +++++++-
>  arch/arm/boot/compressed/vmlinux.lds.S    |   7 ++
>  arch/arm/include/asm/efi.h                |  23 ++++
>  drivers/firmware/efi/libstub/Makefile     |   9 ++
>  drivers/firmware/efi/libstub/arm-stub.c   |   4 +-
>  drivers/firmware/efi/libstub/arm32-stub.c |  85 +++++++++++++
>  9 files changed, 331 insertions(+), 4 deletions(-)

[...]

> +
> +	/*
> +	 * Relocate the zImage, if required. ARM doesn't have a
> +	 * preferred address, so we set it to 0, as we want to allocate
> +	 * as low in memory as possible.
> +	 */
> +	*image_size = image->image_size;
> +	status = efi_relocate_kernel(sys_table, image_addr, *image_size,
> +				     *image_size, 0, 0);
> +	if (status != EFI_SUCCESS) {
> +		pr_efi_err(sys_table, "Failed to relocate kernel.\n");
> +		efi_free(sys_table, *reserve_size, *reserve_addr);
> +		*reserve_size = 0;
> +		return status;
> +	}

If efi_relocate_kernel() successfully allocates memory at address 0x0,
is that going to cause issues with NULL pointer checking?
