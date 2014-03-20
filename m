From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Mar 2014 02:52:31 +0900
Subject: [PATCH v2 1/6] serial: s3c: Fix build of header without
 serial_core.h preinclusion
In-Reply-To: <1395162964-5916-1-git-send-email-t.figa@samsung.com>
References: <1395162964-5916-1-git-send-email-t.figa@samsung.com>
Message-ID: <532B2ADF.1000207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/14 02:15, Tomasz Figa wrote:
> From: Mark Brown<broonie@linaro.org>
>
> serial_s3c.h uses upf_t which is defined in serial_core.h but does not
> include that itself meaning that users which include serial_s3c.h by
> itself don't build.
>
Oops yeah, When we replace inclusion of <plat/regs-serial.h> with 
serial_s3c.h, maybe we missed inclusion of serial_core.h in the 
following files:

arch/arm/include/debug/samsung.S
arch/arm/mach-s3c24xx/include/mach/debug-macro.S
arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
arch/arm/mach-s3c24xx/mach-vr1000.c
arch/arm/mach-s3c24xx/sleep-s3c2410.S
arch/arm/mach-s3c24xx/sleep.S
arch/arm/mach-s3c64xx/include/mach/debug-macro.S
arch/arm/mach-s5p64x0/include/mach/debug-macro.S
arch/arm/mach-s5pc100/include/mach/debug-macro.S
arch/arm/mach-s5pv210/include/mach/debug-macro.S

So, this fix looks good to me. BTW, we need to cleanup inclusion of 
serial_core.h later because it is useless with this.

Applied, thanks.
- Kukjin

> Signed-off-by: Mark Brown<broonie@linaro.org>
> [t.figa: Moved inclusion under #ifndef __ASSEMBLY__ to fix mach-exynos.]
> Signed-off-by: Tomasz Figa<t.figa@samsung.com>
> ---
>   include/linux/serial_s3c.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
> index 907d9d1..e6fc956 100644
> --- a/include/linux/serial_s3c.h
> +++ b/include/linux/serial_s3c.h
> @@ -233,6 +233,8 @@
>
>   #ifndef __ASSEMBLY__
>
> +#include<linux/serial_core.h>
> +
>   /* configuration structure for per-machine configurations for the
>    * serial port
>    *
