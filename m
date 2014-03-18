From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 18 Mar 2014 18:30:47 +0100
Subject: [PATCH 1/2] serial: s3c: Fix build of header without serial_core.h
 preinclusion
In-Reply-To: <1395143803-2032-1-git-send-email-broonie@kernel.org>
References: <1395143803-2032-1-git-send-email-broonie@kernel.org>
Message-ID: <532882C7.8060701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 18.03.2014 12:56, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>
> serial_s3c.h uses upf_t which is defined in serial_core.h but does not
> include that itself meaning that users which include serial_s3c.h by
> itself don't build.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>
> This is needed together with patch 2 to fix build failures in -next, I
> didn't have the time/enthusiasm to isolate the issue.
>
>   include/linux/serial_s3c.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
> index 907d9d1d56cf..44e4a6b92ddb 100644
> --- a/include/linux/serial_s3c.h
> +++ b/include/linux/serial_s3c.h
> @@ -29,6 +29,8 @@
>   #ifndef __ASM_ARM_REGS_SERIAL_H
>   #define __ASM_ARM_REGS_SERIAL_H
>
> +#include <linux/serial_core.h>
> +
>   #define S3C2410_URXH	  (0x24)
>   #define S3C2410_UTXH	  (0x20)
>   #define S3C2410_ULCON	  (0x00)
>

Thanks for fixing this up. However due to this header ending up being 
included by arch/arm/kernel/debug.S, this breaks mach-exynos. I have 
fixed this up by moving the inclusion down the file, under #ifndef 
__ASSEMBLY__ and posted next version along with other fixups.

Best regards,
Tomasz
