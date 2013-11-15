From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 15 Nov 2013 11:43:08 +0100
Subject: [PATCH v3 3/3] ARM: at91/rtc: disable interrupts at shutdown
In-Reply-To: <1381917376-21107-4-git-send-email-jhovold@gmail.com>
References: <1363025279-17615-1-git-send-email-jhovold@gmail.com>
 <1381917376-21107-1-git-send-email-jhovold@gmail.com>
 <1381917376-21107-4-git-send-email-jhovold@gmail.com>
Message-ID: <5285FABC.2080005@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/2013 11:56, Johan Hovold :
> Make sure RTC-interrupts are disabled at shutdown.
>
> As the RTC is generally powered by backup power (VDDBU), its interrupts
> are not disabled on wake-up, user, watchdog or software reset. This
> could cause troubles on other systems (e.g. older kernels) if an
> interrupt occurs before a handler has been installed at next boot.
>
> Let us be well-behaved and disable them on clean shutdowns at least (as
> do the RTT-based rtc-at91sam9 driver).
>
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thank you Johan.

Andrew, could you add this patch to your rtc queue or should I re-send it ?

Best regards,

> ---
>   drivers/rtc/rtc-at91rm9200.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> index 7418926..ea088e9 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -442,6 +442,14 @@ static int __exit at91_rtc_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> +static void at91_rtc_shutdown(struct platform_device *pdev)
> +{
> +	/* Disable all interrupts */
> +	at91_rtc_write(AT91_RTC_IDR, AT91_RTC_ACKUPD | AT91_RTC_ALARM |
> +					AT91_RTC_SECEV | AT91_RTC_TIMEV |
> +					AT91_RTC_CALEV);
> +}
> +
>   #ifdef CONFIG_PM_SLEEP
>
>   /* AT91RM9200 RTC Power management control */
> @@ -480,6 +488,7 @@ static SIMPLE_DEV_PM_OPS(at91_rtc_pm_ops, at91_rtc_suspend, at91_rtc_resume);
>
>   static struct platform_driver at91_rtc_driver = {
>   	.remove		= __exit_p(at91_rtc_remove),
> +	.shutdown	= at91_rtc_shutdown,
>   	.driver		= {
>   		.name	= "at91_rtc",
>   		.owner	= THIS_MODULE,
>


-- 
Nicolas Ferre
