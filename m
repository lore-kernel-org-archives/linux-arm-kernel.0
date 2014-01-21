From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 21 Jan 2014 06:31:02 -0800
Subject: [PATCH v3 04/15] watchdog: orion: Handle IRQ
In-Reply-To: <1390310774-20781-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390310774-20781-5-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <52DE84A6.6090909@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2014 05:26 AM, Ezequiel Garcia wrote:
> DT-enabled where an irqchip driver for the brigde interrupt controller is
> available can handle the watchdog IRQ properly. Therefore, we request
> the interruption and add a dummy handler that merely calls panic().
>
> This is done in order to have an initial 'ack' of the interruption,
> which clears the watchdog state.
>
> Furthermore, since some platforms don't have such IRQ, this commit
> makes the interruption specification optional.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>   .../devicetree/bindings/watchdog/marvel.txt        |  2 ++
>   drivers/watchdog/orion_wdt.c                       | 22 +++++++++++++++++++++-
>   2 files changed, 23 insertions(+), 1 deletion(-)
>

[ ... ]

>   static int orion_wdt_probe(struct platform_device *pdev)
>   {
>   	struct resource *res;
> -	int ret;
> +	int ret, irq;
>
>   	clk = devm_clk_get(&pdev->dev, NULL);
>   	if (IS_ERR(clk)) {
> @@ -131,6 +138,19 @@ static int orion_wdt_probe(struct platform_device *pdev)
>   	if (!wdt_reg)
>   		return -ENOMEM;
>
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq > 0) {

0 is a valid interrupt number, and platform_get_irq returns an error code on errors.
Should be >= 0.

Guenter
