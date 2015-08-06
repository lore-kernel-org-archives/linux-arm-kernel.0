From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 06 Aug 2015 01:05:27 -0700
Subject: [PATCH v4 1/2] drivers: watchdog: add a driver to support SAMA5D4
 watchdog timer
In-Reply-To: <1438837170-4518-2-git-send-email-wenyou.yang@atmel.com>
References: <1438837170-4518-1-git-send-email-wenyou.yang@atmel.com>
 <1438837170-4518-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <55C31547.2040207@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2015 09:59 PM, Wenyou Yang wrote:
>>From SAMA5D4, the watchdog timer is upgrated with a new feature,
> which is describled as in the datasheet, "WDT_MR can be written
> until a LOCKMR command is issued in WDT_CR".
> That is to say, as long as the bootstrap and u-boot don't issue
> a LOCKMR command, WDT_MR can be written more than once in the driver.
>
> So the SAMA5D4 watchdog driver's implementation is different from
> the at91sam9260 watchdog driver implemented in file at91sam9_wdt.c.
> The user application open the device file to enable the watchdog timer
> hardware, and close to disable it, and set the watchdog timer timeout
> by seting WDV and WDD fields of WDT_MR register, and ping the watchdog
> by issuing WDRSTT command to WDT_CR register with hard-coded key.
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
[ ... ]
> +
> +/* minimum and maximum watchdog timeout, in seconds */
> +#define	MIN_WDT_TIMEOUT		1
> +#define	MAX_WDT_TIMEOUT		16
> +#define	WDT_DEFAULT_TIMEOUT	MAX_WDT_TIMEOUT
> +
> +#define	WDT_SEC2TICKS(s)	((s) ? (((s) << 8) - 1) : 0)
> +

Why did you replace the spaces after #define with tabs ?
I understand this is done in the at91.h file, but that is bad enough,
it doesn't add any value, and I don't see a reason to do it here.

> +
> +	if ((wdt->config & AT91_WDT_WDFIEN) && irq) {
> +		ret = devm_request_irq(&pdev->dev, irq, sama5d4_wdt_irq_handler,
> +				       0, pdev->name, pdev);

I just realized - this interrupt is registered with flags set to 0,
while in the at91sam driver the flags are "IRQF_SHARED | IRQF_IRQPOLL |
IRQF_NO_SUSPEND". Is this different with the new SOC ?

Thanks,
Guenter
