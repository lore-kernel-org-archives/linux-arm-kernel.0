From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Jan 2017 11:53:05 +0000
Subject: [PATCH v2 2/2] arm64: efi: add vmlinux debug link to the Image
 binary
In-Reply-To: <1485340759-28975-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1485340759-28975-1-git-send-email-ard.biesheuvel@linaro.org>
 <1485340759-28975-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170125115305.GA29027@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 10:39:19AM +0000, Ard Biesheuvel wrote:
> When building with debugging symbols, take the absolute path to the
> vmlinux binary and add it to the special PE/COFF debug table entry.
> 
> These entries are used internally by EDK2 based* debug builds of UEFI
> to populate the DebugImageInfo table, which can be used by debuggers
> as well as by the OS itself to retrieve information about all loaded
> PE/COFF executables. This is highly useful for source level debugging
> of the UEFI stub.

Does that mean EFI_IMAGE_DEBUG_DIRECTORY_ENTRY and friends are
EDK2-specific?

Or just that the way EDK2 happens to use those is EDK2-specific?

> * for AArch64, this probably means all of them
> 
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/Makefile |  4 +++
>  arch/arm64/kernel/head.S   | 34 +++++++++++++++++++-
>  arch/arm64/kernel/image.h  |  3 ++
>  3 files changed, 40 insertions(+), 1 deletion(-)

> +efi_debug_table:
> +	// EFI_IMAGE_DEBUG_DIRECTORY_ENTRY
> +	.long	0			// Characteristics
> +	.long	0			// TimeDateStamp
> +	.short	0			// MajorVersion
> +	.short	0			// MinorVersion
> +	.long	2			// Type == EFI_IMAGE_DEBUG_TYPE_CODEVIEW

> +ENTRY(efi_debug_entry)
> +	// EFI_IMAGE_DEBUG_CODEVIEW_NB10_ENTRY
> +	.long	0x3031424E		// Signature

Certainly not a blocker for this, but this reminds me that it would be
nice to de-magic the EFI constants used by the stub.

I took a stab a while back [1], for the existing definitions, but that
fell by the wayside.

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git efi-stub/definitions
