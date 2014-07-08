From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 Jul 2014 22:48:15 +0900
Subject: [PATCH 4/6] ARM: SAMSUNG: Restore Samsung PM Debug functionality
In-Reply-To: <1403618235-19353-5-git-send-email-t.figa@samsung.com>
References: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
 <1403618235-19353-5-git-send-email-t.figa@samsung.com>
Message-ID: <033901cf9ab3$44c469a0$ce4d3ce0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Due to recently merged patches and previous merge conflicts, the Samsung
> PM Debug functionality no longer can be enabled. This patch fixes
> incorrect dependency of SAMSUNG_PM_DEBUG on an integer symbol and adds
> missing header inclusion.
> 
Yes, you're right and it should be fixed...but I have comments...

> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/plat-samsung/Kconfig    | 8 +++++++-
>  arch/arm/plat-samsung/pm-debug.c | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 301b892..483c959 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -412,9 +412,14 @@ config S5P_DEV_MFC
> 
>  comment "Power management"
> 
> +config HAVE_SAMSUNG_PM_DEBUG
> +	bool
> +	help
> +	  Allow compilation of Samsung PM debugging code.
> +
>  config SAMSUNG_PM_DEBUG
>  	bool "S3C2410 PM Suspend debug"
> -	depends on PM && DEBUG_KERNEL && DEBUG_S3C_UART
> +	depends on PM && DEBUG_KERNEL && HAVE_SAMSUNG_PM_DEBUG
>  	help
>  	  Say Y here if you want verbose debugging from the PM Suspend and
>  	  Resume code. See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
> @@ -484,6 +489,7 @@ config S5P_SLEEP
> 
>  config DEBUG_S3C_UART
>  	depends on PLAT_SAMSUNG
> +	select HAVE_SAMSUNG_PM_DEBUG

Hmm...

The DEBUG_S3C_UART will be '0' when we select DEBUG_S3C_UART0, then the
HAVE_SAMSUNG_PM_DEBUG will not be selected so SAMSUNG_PM_DEBUG is also...

>  	int
>  	default "0" if DEBUG_S3C_UART0
>  	default "1" if DEBUG_S3C_UART1
> diff --git a/arch/arm/plat-samsung/pm-debug.c b/arch/arm/plat-samsung/pm-debug.c
> index 8f19f66..3960960 100644
> --- a/arch/arm/plat-samsung/pm-debug.c
> +++ b/arch/arm/plat-samsung/pm-debug.c
> @@ -14,6 +14,7 @@
>   */
> 
>  #include <linux/serial_core.h>
> +#include <linux/serial_s3c.h>

Yeah, this is required then we don't need inclusion <linux/serial_core.h> here.

>  #include <linux/io.h>
> 
>  #include <asm/mach/map.h>
> --
> 1.9.3
