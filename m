From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Mar 2012 10:02:42 -0500
Subject: [PATCH 07/10] ARM: ux500: Provide local timer support for Device
 Tree
In-Reply-To: <1331730306-11461-8-git-send-email-lee.jones@linaro.org>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
 <1331730306-11461-8-git-send-email-lee.jones@linaro.org>
Message-ID: <4F60B312.8070900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2012 08:05 AM, Lee Jones wrote:
> This enables local timer (AKA: private timer) support for
> all u8500 based hardware using DT.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/db8500.dtsi    |    6 ++++++
>  arch/arm/mach-ux500/localtimer.c |   18 +++++++++++++++++-
>  2 files changed, 23 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
> index cce5df8..35d0146 100644
> --- a/arch/arm/boot/dts/db8500.dtsi
> +++ b/arch/arm/boot/dts/db8500.dtsi
> @@ -34,6 +34,12 @@
>  			interrupts = <7>;
>  		};
>  
> +		timer at a0410600 {
> +			compatible = "arm,smp-twd";
> +			reg = <0xa0410600 0x20>;
> +			interrupts = <1 13 0x304>;
> +		};
> +
>  		rtc at 80154000 {
>  			compatible = "stericsson,db8500-rtc";
>  			reg = <0x80154000 0x1000>;
> diff --git a/arch/arm/mach-ux500/localtimer.c b/arch/arm/mach-ux500/localtimer.c
> index 5ba1133..295e580 100644
> --- a/arch/arm/mach-ux500/localtimer.c
> +++ b/arch/arm/mach-ux500/localtimer.c
> @@ -14,6 +14,10 @@
>  #include <linux/smp.h>
>  #include <linux/clockchips.h>
>  
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
>  #include <asm/irq.h>
>  #include <asm/smp_twd.h>
>  #include <asm/localtimer.h>
> @@ -23,7 +27,19 @@
>   */
>  int __cpuinit local_timer_setup(struct clock_event_device *evt)
>  {
> -	evt->irq = IRQ_LOCALTIMER;
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
> +	if (np) {
> +		if (!twd_base) {
> +			twd_base = of_iomap(np, 0);
> +			WARN_ON(!twd_base);
> +		}
> +		evt->irq = irq_of_parse_and_map(np, 0);
> +	}
> +	else
> +		evt->irq = IRQ_LOCALTIMER;
> +
>  	twd_timer_setup(evt);
>  	return 0;
>  }

FYI, this will probably collide with Marc Z's local timer changes queued
up for 3.4.

Rob
