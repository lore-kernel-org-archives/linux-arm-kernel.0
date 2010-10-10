From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 10 Oct 2010 09:38:29 +0200
Subject: [PATCH 01/13] ARM: pxa: Introduce pxa[23]xx_map_io
In-Reply-To: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
References: <1286663971-15634-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <4CB16D75.7030707@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi Marek,

On 10/10/10 00:39, Marek Vasut wrote:
> This patch introduces pxa2xx_map_io() and pxa3xx_map_io() to distinguish between
> PXA2xx and PXA3xx memory mapping.
>
> Also, fixup for platforms broken after introducing pxa2xx_map_io() and
> pxa3xx_map_io() is included.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
> index 1cd99cb..3fa9c02 100644
> --- a/arch/arm/mach-pxa/spitz.c
> +++ b/arch/arm/mach-pxa/spitz.c
> @@ -27,6 +27,7 @@
>  #include <linux/mtd/sharpsl.h>
>  #include <linux/input/matrix_keypad.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/io.h>
>  
>  #include <asm/setup.h>
>  #include <asm/mach-types.h>
> @@ -44,6 +45,7 @@
>  #include <mach/pxa2xx_spi.h>
>  #include <mach/spitz.h>
>  #include <mach/sharpsl_pm.h>
> +#include <mach/pxa-smemc.h>
>  
>  #include <plat/i2c.h>
>  
> @@ -930,8 +932,8 @@ static void spitz_poweroff(void)
>  static void spitz_restart(char mode, const char *cmd)
>  {
>  	/* Bootloader magic for a reboot */
> -	if ((MSC0 & 0xffff0000) == 0x7ff00000)
> -		MSC0 = (MSC0 & 0xffff) | 0x7ee00000;
> +	if ((__raw_readl(MSC0) & 0xffff0000) == 0x7ff00000)
> +		__raw_writel((__raw_readl(MSC0) & 0xffff) | 0x7ee00000, MSC0);

I believe, this is not related to the subject...

-- 
Regards,
Igor.
