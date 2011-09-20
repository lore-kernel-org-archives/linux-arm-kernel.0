From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 20 Sep 2011 14:05:09 +0100
Subject: [PATCH] gpio/mxc: make it work with imx6q
In-Reply-To: <1316423432-18333-1-git-send-email-shawn.guo@linaro.org>
References: <1316423432-18333-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110920130508.GE2962@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Sep 19, 2011 at 05:10:32PM +0800, Shawn Guo wrote:
> The imx6q is a Cortex-A9 Quad Core SoC, which has GIC as the primary
> interrupt controller.  GIC requires gpio irq handler to signal EOI,
> otherwise system will hang whenever there is a gpio irq triggered.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/gpio/gpio-mxc.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index 4340aca..00b4c9c 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -233,6 +233,9 @@ static void mx3_gpio_irq_handler(u32 irq, struct irq_desc *desc)
>  	u32 irq_stat;
>  	struct mxc_gpio_port *port = irq_get_handler_data(irq);
>  
> +	if (desc->irq_data.chip->irq_eoi)
> +		desc->irq_data.chip->irq_eoi(&desc->irq_data);
> +
>  	irq_stat = readl(port->base + GPIO_ISR) & readl(port->base + GPIO_IMR);
>  
>  	mxc_gpio_irq_handler(port, irq_stat);
> -- 
> 1.7.4.1

Could this make use of the chained_irq_enter/chained_irq_exit functions 
added in 10a8c38 (ARM: 6806/1: irq: introduce entry and exit functions 
for chained handlers)?

Jamie
