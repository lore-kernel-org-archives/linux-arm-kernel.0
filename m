From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 21 May 2010 14:02:44 +0200
Subject: [PATCH 1/5] i.MX27: add suspend to RAM support
In-Reply-To: <1274440363-435-1-git-send-email-eric@eukrea.com>
References: <1274440363-435-1-git-send-email-eric@eukrea.com>
Message-ID: <19446.30308.103514.313301@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Eric B?nard writes:
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/mach-mx2/Makefile   |    2 +-
>  arch/arm/mach-mx2/pm-imx27.c |   46 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-mx2/pm-imx27.c
> 
> diff --git a/arch/arm/mach-mx2/Makefile b/arch/arm/mach-mx2/Makefile
> index e3254fa..27d496c 100644
> --- a/arch/arm/mach-mx2/Makefile
> +++ b/arch/arm/mach-mx2/Makefile
> @@ -8,7 +8,7 @@ obj-y	:=  devices.o serial.o
>  
>  obj-$(CONFIG_MACH_MX21) += clock_imx21.o mm-imx21.o
>  
> -obj-$(CONFIG_MACH_MX27) += cpu_imx27.o
> +obj-$(CONFIG_MACH_MX27) += cpu_imx27.o pm-imx27.o
>  obj-$(CONFIG_MACH_MX27) += clock_imx27.o mm-imx27.o
>  
>  obj-$(CONFIG_MACH_MX21ADS) += mach-mx21ads.o
> diff --git a/arch/arm/mach-mx2/pm-imx27.c b/arch/arm/mach-mx2/pm-imx27.c
> new file mode 100644
> index 0000000..a82fb6d
> --- /dev/null
> +++ b/arch/arm/mach-mx2/pm-imx27.c
> @@ -0,0 +1,46 @@
> +/*
> + * i.MX27 Power Management Routines
> + *
> + * Based on Freescale's BSP
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/suspend.h>
> +#include <asm/io.h>
> +#include <mach/system.h>
> +#include <mach/mx27.h>
> +
> +static int mx27_suspend_enter(suspend_state_t state)
> +{
> +	u32 cscr;
> +	switch (state) {
> +	case PM_SUSPEND_MEM:
> +		/* Clear MPEN and SPEN to disable MPLL/SPLL */
> +		cscr = __raw_readl(MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR));
> +		cscr &= 0xFFFFFFFC;
> +		__raw_writel(cscr, MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR));
> +		/* Executes WFI */
> +		arch_idle();
> +		break;
> +
> +	default:
> +		return -1;
>
an errno value would be more appropriate here.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
