From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 17 Sep 2015 11:17:04 +0100
Subject: [PATCH] arm64: expose kernel page size in Image header flags
In-Reply-To: <1442482345-7679-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1442482345-7679-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150917101704.GA12808@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 10:32:25AM +0100, Ard Biesheuvel wrote:
> In order for a bootloader to be able to decide whether a certain
> arm64 kernel image is compatible with the hardware it is running
> on, it needs to be able to find out for which page size the kernel
> was built. This is necessary, since the architecture does not
> mandate support for all page sizes it defines, and the kernel cannot
> boot to a state where it can print a diagnostic if it was built for
> a page size that is not supported by the hardware.
> 
> So assign two bits in the flags field of the Image header, and set
> them according to the build time page size. For backward compatibility,
> retain the 0b00 value as 'unspecified'.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This looks sane to me.

FWIW: Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  Documentation/arm64/booting.txt | 3 ++-
>  arch/arm64/kernel/image.h       | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index 1690350f16e7..46056e7d766e 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -104,7 +104,8 @@ Header notes:
>  - The flags field (introduced in v3.17) is a little-endian 64-bit field
>    composed as follows:
>    Bit 0: 	Kernel endianness.  1 if BE, 0 if LE.
> -  Bits 1-63:	Reserved.
> +  Bits 1-2:	Kernel page size.   0=unspecified, 1=4K, 2=16K, 3=64K
> +  Bits 3-63:	Reserved.
>  
>  - When image_size is zero, a bootloader should attempt to keep as much
>    memory as possible free for use by the kernel immediately after the
> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
> index 8fae0756e175..5def289bda84 100644
> --- a/arch/arm64/kernel/image.h
> +++ b/arch/arm64/kernel/image.h
> @@ -47,7 +47,9 @@
>  #define __HEAD_FLAG_BE	0
>  #endif
>  
> -#define __HEAD_FLAGS	(__HEAD_FLAG_BE << 0)
> +#define __HEAD_FLAG_PAGE_SIZE ((PAGE_SHIFT - 10) / 2)
> +
> +#define __HEAD_FLAGS	(__HEAD_FLAG_BE << 0) | (__HEAD_FLAG_PAGE_SIZE << 1)
>  
>  /*
>   * These will output as part of the Image header, which should be little-endian
> -- 
> 1.9.1
> 
