From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Oct 2015 18:27:56 +0100
Subject: [PATCHv3 09/11] arm64: Add page size to the kernel image header
In-Reply-To: <1444821634-1689-10-git-send-email-suzuki.poulose@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151014172756.GJ5041@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 12:20:32PM +0100, Suzuki K. Poulose wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> This patch adds the page size to the arm64 kernel image header
> so that one can infer the PAGESIZE used by the kernel. This will
> be helpful to diagnose failures to boot the kernel with page size
> not supported by the CPU.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  Documentation/arm64/booting.txt |    7 ++++++-
>  arch/arm64/kernel/image.h       |    5 ++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index 7d9d3c2..aaf6d77 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -104,7 +104,12 @@ Header notes:
>  - The flags field (introduced in v3.17) is a little-endian 64-bit field
>    composed as follows:
>    Bit 0:	Kernel endianness.  1 if BE, 0 if LE.
> -  Bits 1-63:	Reserved.
> +  Bit 1-2:	Kernel Page size.
> +			0 - Unspecified.
> +			1 - 4K
> +			2 - 16K
> +			3 - 64K
> +  Bits 3-63:	Reserved.
>  
>  - When image_size is zero, a bootloader should attempt to keep as much
>    memory as possible free for use by the kernel immediately after the
> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
> index 6eb8fee..e45759e 100644
> --- a/arch/arm64/kernel/image.h
> +++ b/arch/arm64/kernel/image.h
> @@ -47,7 +47,10 @@
>  #define __HEAD_FLAG_BE	0
>  #endif
>  
> -#define __HEAD_FLAGS	(__HEAD_FLAG_BE << 0)
> +#define __HEAD_FLAG_PAGE_SIZE ((PAGE_SHIFT - 10) / 2)
> +
> +#define __HEAD_FLAGS	(__HEAD_FLAG_BE << 0) |		\
> +			(__HEAD_FLAG_PAGE_SIZE << 1)

I'd prefer that we also had brackets around the whole of the
__HEAD_FLAGS value, so we don't get caught out later on by some
unexpected expansion (though we are safe currently).

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
