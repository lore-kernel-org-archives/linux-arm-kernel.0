From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Jul 2015 12:49:30 +0100
Subject: [PATCH] arm64/Documentation: clarify wording regarding memory
 below the Image
In-Reply-To: <1438169439-15216-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1438169439-15216-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150729114930.GL15213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 12:30:39PM +0100, Ard Biesheuvel wrote:
> Clarify that the memory below the start of the image but inside the
> region covered by the linear mapping has no special significance to
> the kernel, and may be used by the firmware provided that it is marked
> as reserved.
> 
> Also, fix up some whitespace errors.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  Documentation/arm64/booting.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index 1690350f16e7..7d9d3c2286b2 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -81,7 +81,7 @@ The decompressed kernel image contains a 64-byte header as follows:
>    u64 res3	= 0;		/* reserved */
>    u64 res4	= 0;		/* reserved */
>    u32 magic	= 0x644d5241;	/* Magic number, little endian, "ARM\x64" */
> -  u32 res5;      		/* reserved (used for PE COFF offset) */
> +  u32 res5;			/* reserved (used for PE COFF offset) */
>  
>  
>  Header notes:
> @@ -103,7 +103,7 @@ Header notes:
>  
>  - The flags field (introduced in v3.17) is a little-endian 64-bit field
>    composed as follows:
> -  Bit 0: 	Kernel endianness.  1 if BE, 0 if LE.
> +  Bit 0:	Kernel endianness.  1 if BE, 0 if LE.
>    Bits 1-63:	Reserved.
>  
>  - When image_size is zero, a bootloader should attempt to keep as much
> @@ -115,11 +115,14 @@ The Image must be placed text_offset bytes from a 2MB aligned base
>  address near the start of usable system RAM and called there. Memory
>  below that base address is currently unusable by Linux, and therefore it
>  is strongly recommended that this location is the start of system RAM.
> +The region between the 2 MB aligned base address and the start of the
> +image has no special significance to the kernel, and may be used for
> +other purposes.

This is true since commit bd00cd5f8c8c3c28 ("arm64: place initial page
tables above the kernel") in v3.16, but people were using the region
before then anyway, so I don't know if that deserves a note. Arguably
that patch was a bug fix.

Perhaps prefix this with "Since v3.16"?

>  At least image_size bytes from the start of the image must be free for
>  use by the kernel.
>  
> -Any memory described to the kernel (even that below the 2MB aligned base
> -address) which is not marked as reserved from the kernel e.g. with a
> +Any memory described to the kernel (even that below the start of the
> +image) which is not marked as reserved from the kernel (e.g., with a
>  memreserve region in the device tree) will be considered as available to
>  the kernel.

Looks good to me. With or without the v3.16 note:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
