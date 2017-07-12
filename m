From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 12 Jul 2017 14:12:20 +0000
Subject: [PATCH 2/2] gpio: gpio-vf610: add imx7ulp support
In-Reply-To: <e15b08d4857d5498b70a57f8022b5ba5@agner.ch>
References: <1494829706-5661-1-git-send-email-aisheng.dong@nxp.com>
 <1494829706-5661-3-git-send-email-aisheng.dong@nxp.com>
 <690d43f0314da9d340065b551700d6b7@agner.ch>
 <AM3PR04MB3067C3AFBD7285A5CC24B6780DA0@AM3PR04MB306.eurprd04.prod.outlook.com>
 <e15b08d4857d5498b70a57f8022b5ba5@agner.ch>
Message-ID: <AM3PR04MB3066E8D18C14661F2107CBE80AF0@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

> -----Original Message-----
> From: Stefan Agner [mailto:stefan at agner.ch]
> Sent: Saturday, July 01, 2017 5:54 AM
> To: A.s. Dong
> Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linus.walleij at linaro.org; shawnguo at kernel.org; Jacky Bai; Andy Duan;
> kernel at pengutronix.de; Alexandre Courbot; Peter Chen; LW at KARO-
> electronics.de
> Subject: Re: [PATCH 2/2] gpio: gpio-vf610: add imx7ulp support
> 
> On 2017-06-21 06:30, A.s. Dong wrote:
> > Hi Stefan,
> >
> >> -----Original Message-----
> >> From: Stefan Agner [mailto:stefan at agner.ch]
> >> Sent: Tuesday, May 16, 2017 1:59 AM
> >> To: A.S. Dong
> >> Cc: linux-gpio at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> >> linus.walleij at linaro.org; shawnguo at kernel.org; Jacky Bai; Andy Duan;
> >> kernel at pengutronix.de; Alexandre Courbot; Peter Chen
> >> Subject: Re: [PATCH 2/2] gpio: gpio-vf610: add imx7ulp support
> >>
> >> On 2017-05-14 23:28, Dong Aisheng wrote:
> >> > The Rapid General-Purpose Input and Output with 2 Ports (RGPIO2P)
> >> > on MX7ULP is similar to GPIO on Vibrid. But unlike Vibrid, the
> >> > RGPIO2P has an extra Port Data Direction Register (PDDR) used to
> >> > configure the individual port pins for input or output.
> >> >
> >> > We introduce a FSL_GPIO_HAVE_PDDR with fsl_gpio_soc_data data to
> >> > distinguish this differences. And we support getting the output
> >> > status by checking the GPIO direction in PDDR.
> >> >
> >> > Cc: Linus Walleij <linus.walleij@linaro.org>
> >> > Cc: Alexandre Courbot <gnurou@gmail.com>
> >> > Cc: Shawn Guo <shawnguo@kernel.org>
> >> > Cc: Stefan Agner <stefan@agner.ch>
> >> > Cc: Fugang Duan <fugang.duan@nxp.com>
> >> > Cc: Peter Chen <peter.chen@nxp.com>
> >> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> >> > ---
> >> >  drivers/gpio/gpio-vf610.c | 49
> >> > ++++++++++++++++++++++++++++++++++++++++++++---
> >> >  1 file changed, 46 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> >> > index 521fbe3..a439d27 100644
> >> > --- a/drivers/gpio/gpio-vf610.c
> >> > +++ b/drivers/gpio/gpio-vf610.c
> >> > @@ -30,10 +30,15 @@
> >> >
> >> >  #define VF610_GPIO_PER_PORT		32
> >> >
> >> > +struct fsl_gpio_soc_data {
> >> > +	u32 flags;
> >> > +};
> >> > +
> >> >  struct vf610_gpio_port {
> >> >  	struct gpio_chip gc;
> >> >  	void __iomem *base;
> >> >  	void __iomem *gpio_base;
> >> > +	const struct fsl_gpio_soc_data *sdata;
> >> >  	u8 irqc[VF610_GPIO_PER_PORT];
> >> >  	int irq;
> >> >  };
> >> > @@ -43,6 +48,7 @@ struct vf610_gpio_port {
> >> >  #define GPIO_PCOR		0x08
> >> >  #define GPIO_PTOR		0x0c
> >> >  #define GPIO_PDIR		0x10
> >> > +#define GPIO_PDDR		0x14
> >> >
> >> >  #define PORT_PCR(n)		((n) * 0x4)
> >> >  #define PORT_PCR_IRQC_OFFSET	16
> >> > @@ -59,10 +65,18 @@ struct vf610_gpio_port {
> >> >  #define PORT_INT_EITHER_EDGE	0xb
> >> >  #define PORT_INT_LOGIC_ONE	0xc
> >> >
> >> > +/* SoC has a Port Data Direction Register (PDDR) */
> >> > +#define FSL_GPIO_HAVE_PDDR	BIT(0)
> >> > +
> >> >  static struct irq_chip vf610_gpio_irq_chip;
> >> >
> >> > +static const struct fsl_gpio_soc_data imx_data = {
> >> > +	.flags = FSL_GPIO_HAVE_PDDR,
> >> > +};
> >> > +
> >> >  static const struct of_device_id vf610_gpio_dt_ids[] = {
> >> > -	{ .compatible = "fsl,vf610-gpio" },
> >> > +	{ .compatible = "fsl,vf610-gpio",	.data = NULL, },
> >> > +	{ .compatible = "fsl,imx7ulp-gpio",	.data = &imx_data, },
> >> >  	{ /* sentinel */ }
> >> >  };
> >> >
> >> > @@ -79,8 +93,18 @@ static inline u32 vf610_gpio_readl(void __iomem
> >> > *reg)  static int vf610_gpio_get(struct gpio_chip *gc, unsigned int
> >> > gpio)  {
> >> >  	struct vf610_gpio_port *port = gpiochip_get_data(gc);
> >> > -
> >> > -	return !!(vf610_gpio_readl(port->gpio_base + GPIO_PDIR) &
> BIT(gpio));
> >> > +	unsigned long mask = BIT(gpio);
> >> > +	void __iomem *addr;
> >> > +
> >> > +	if (port->sdata && port->sdata->flags & FSL_GPIO_HAVE_PDDR) {
> >> > +		mask &= vf610_gpio_readl(port->gpio_base + GPIO_PDDR);
> >> > +		addr = mask ? port->gpio_base + GPIO_PDOR :
> >> > +			      port->gpio_base + GPIO_PDIR;
> >> > +		return !!(vf610_gpio_readl(addr) & BIT(gpio));
> 
> I still feel it would be better to read back the actual value on the
> wire...
> 
> But this would require to enable the input buffer in
> imx7ulp_pmx_gpio_set_direction.
> 
> Lothar was with me in this discussion:
> https://patchwork.kernel.org/patch/9726163/
> 
> Or is there really a technical limitation on i.MX7ULP?
> 

No actually technical limitation, just different from Vybrid,
MX7ULP has a GPIO_PDDR register to distinguish the input and output,
We want to disable the input logic for output case to save power.

> We could also change it later, especially if the pinctrl changes already
> got merged anyway.
> 
> From a Vybrid perspective:
> Acked-by: Stefan Agner <stefan@agner.ch>
> 

Thanks.

Regards
Dong Aisheng
