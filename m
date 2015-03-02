From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 02 Mar 2015 06:10:38 -0800
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <1425287898-15093-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <54F46F5E.3020707@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2015 01:18 AM, Boris Brezillon wrote:
> The watchdog interrupt (only used when activating software watchdog)
> shouldn't be suspended when entering suspend mode, because it is shared
> with a timer device (which request the line with IRQF_NO_SUSPEND) and once
> the watchdog "Mode Register" has been written, it cannot be changed (which
> means we cannot disable the watchdog interrupt when entering suspend).
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/at91sam9_wdt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 6df9405..1443b3c 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -208,7 +208,8 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
>
>   	if ((tmp & AT91_WDT_WDFIEN) && wdt->irq) {
>   		err = request_irq(wdt->irq, wdt_interrupt,
> -				  IRQF_SHARED | IRQF_IRQPOLL,
> +				  IRQF_SHARED | IRQF_IRQPOLL |
> +				  IRQF_NO_SUSPEND,
>   				  pdev->name, wdt);
>   		if (err)
>   			return err;
>
