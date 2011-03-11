From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 11 Mar 2011 22:39:03 +0100
Subject: [PATCH 5/8] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <1299839023-16601-5-git-send-email-anarsoul@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<1299839023-16601-5-git-send-email-anarsoul@gmail.com>
Message-ID: <201103112239.03751.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 March 2011 11:23:40 Vasily Khoruzhick wrote:
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

This looks bogus to me as you cannot power down the thing. Besides, where do you 
resume to from this so-called "powerdown" ? Since the bootloader will consider 
it as a legitimate deepsleep resume.

> ---
>  arch/arm/mach-pxa/z2.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index aec87f7..f1bb98a 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -42,6 +42,7 @@
>  #include <plat/pxa27x_keypad.h>
>  #include <mach/pxa27x-udc.h>
>  #include <mach/ohci.h>
> +#include <mach/pm.h>
> 
>  #include "generic.h"
>  #include "devices.h"
> @@ -705,6 +706,16 @@ static struct pxaohci_platform_data
> z2_ohci_platform_data = { .power_budget	= 500,
>  };
> 
> +#ifdef CONFIG_PM
> +static void z2_power_off(void)
> +{
> +	local_irq_disable();
> +	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP);
> +}
> +#else
> +#define z2_power_off   NULL
> +#endif
> +
>  /*************************************************************************
> ***** * Machine init
>  
> **************************************************************************
> ****/ @@ -727,6 +738,8 @@ static void __init z2_init(void)
>  	z2_leds_init();
>  	z2_keys_init();
>  	z2_pmic_init();
> +
> +	pm_power_off = z2_power_off;
>  }
> 
>  MACHINE_START(ZIPIT2, "Zipit Z2")
