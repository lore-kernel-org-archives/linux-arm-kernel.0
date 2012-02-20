From: rmallon@gmail.com (Ryan Mallon)
Date: Mon, 20 Feb 2012 11:32:43 +1100
Subject: [PATCH 11/18] ARM: at91/rtc-at91sam9: each SoC can select the
 RTT device to use
In-Reply-To: <9d1120bd8f1cf0615ff5044745b00fd3988397a7.1329500622.git.nicolas.ferre@atmel.com>
References: <1329501010-30468-1-git-send-email-nicolas.ferre@atmel.com>
 <9d1120bd8f1cf0615ff5044745b00fd3988397a7.1329500622.git.nicolas.ferre@atmel.com>
Message-ID: <4F4194AB.40403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/02/12 04:50, Nicolas Ferre wrote:

> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> For the RTT as RTC driver rtc-at91sam9, the platform_device structure
> is filled during SoC initialization. This will allow to convert this
> RTC driver as a standard platform driver.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/mach-at91/at91sam9260_devices.c |   11 +++++
>  arch/arm/mach-at91/at91sam9261_devices.c |   10 +++++
>  arch/arm/mach-at91/at91sam9263_devices.c |   25 ++++++++++++
>  arch/arm/mach-at91/at91sam9g45_devices.c |   10 +++++
>  arch/arm/mach-at91/at91sam9rl_devices.c  |   10 +++++
>  drivers/rtc/rtc-at91sam9.c               |   61 ++++-------------------------
>  6 files changed, 75 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> index b93a337..2071017 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> @@ -728,8 +728,19 @@ static struct platform_device at91sam9260_rtt_device = {
>  	.num_resources	= ARRAY_SIZE(rtt_resources),
>  };
>  
> +
> +#if IS_ENABLED(CONFIG_RTC_DRV_AT91SAM9)
> +static void __init at91_add_device_rtt_rtc(void)
> +{
> +	at91sam9260_rtt_device.name = "rtc-at91sam9";
> +}


Nitpickish: This function doesn't _add_ anything. It would probably be
better called at91_init_device_rtt_rtc. Same goes for the other "add"
functions in this patch.

> +#else
> +static void __init at91_add_device_rtt_rtc(void) {}
> +#endif
> +
>  static void __init at91_add_device_rtt(void)
>  {
> +	at91_add_device_rtt_rtc();
>  	platform_device_register(&at91sam9260_rtt_device);
>  }


Does this work by setting the rtt device name iff
CONFIG_RTC_DRV_AT91SAM9 is set? If so, it seems a bit ugly. Why bother
doing the platform_device_register at all if you know it isn't going to
do anything? Shouldn't the at91sam9260_rrt_device struct declaration and
the platform_device_register all be conditional on CONFIG_RTC_DRV_AT91SAM9?

~Ryan
