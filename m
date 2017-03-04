From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 4 Mar 2017 07:06:26 -0800
Subject: [PATCH 3/4] watchodg: sama5d4: simplify probe
In-Reply-To: <20170302173114.28508-4-alexandre.belloni@free-electrons.com>
References: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
 <20170302173114.28508-4-alexandre.belloni@free-electrons.com>
Message-ID: <126269ed-7b78-2885-7120-e57e2e40c14b@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2017 09:31 AM, Alexandre Belloni wrote:
> Because the only way to use the driver is to have a device tree enabling
> it, pdev->dev.of_node will never be NULL. Remove the unnecessary check.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sama5d4_wdt.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index 362fd229786d..d710014f3b7d 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -228,15 +228,13 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>
>  	wdt->reg_base = regs;
>
> -	if (pdev->dev.of_node) {
> -		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> -		if (!irq)
> -			dev_warn(&pdev->dev, "failed to get IRQ from DT\n");
> +	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	if (!irq)
> +		dev_warn(&pdev->dev, "failed to get IRQ from DT\n");
>
> -		ret = of_sama5d4_wdt_init(pdev->dev.of_node, wdt);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = of_sama5d4_wdt_init(pdev->dev.of_node, wdt);
> +	if (ret)
> +		return ret;
>
>  	if ((wdt->mr & AT91_WDT_WDFIEN) && irq) {
>  		ret = devm_request_irq(&pdev->dev, irq, sama5d4_wdt_irq_handler,
>
