From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 18 Mar 2013 17:53:15 +0100
Subject: [PATCH v3 6/6] irqchip: s3c24xx: add s3c2450 interrupt definitions
In-Reply-To: <5147389B.5060105@gmail.com>
References: <201303171404.06146.heiko@sntech.de>
 <201303171409.07774.heiko@sntech.de> <5147389B.5060105@gmail.com>
Message-ID: <201303181753.16547.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Am Montag, 18. M?rz 2013, 16:54:03 schrieb Rob Herring:
> On 03/17/2013 08:09 AM, Heiko St?bner wrote:
> > The s3c2450 is special in that it shares the cpu identification with the
> > s3c2416 but provides more interrupts for its additional components.
> > 
> > It also shares the layout of the main interrupt register with the s3c2443
> > and therefore reuses this definition.
> > 
> > As no non-dt boards are present, the s3c2450 irqs will only be
> > accessible thru devicetree.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  drivers/irqchip/irq-s3c24xx.c |   62
> >  +++++++++++++++++++++++++++++++++++++++- 1 files changed, 60
> >  insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-s3c24xx.c
> > b/drivers/irqchip/irq-s3c24xx.c index 55cb363..7ddf8e8 100644
> > --- a/drivers/irqchip/irq-s3c24xx.c
> > +++ b/drivers/irqchip/irq-s3c24xx.c
> > @@ -852,6 +852,51 @@ static struct s3c_irq_data init_s3c2416_second[32] =
> > {
> > 
> >  	{ .type = S3C_IRQTYPE_EDGE }, /* I2S0 */
> >  
> >  };
> > 
> > +static struct s3c_irq_data init_s3c2450subint[32] = {
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-RX */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-TX */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-ERR */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 23 }, /* UART1-RX */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 23 }, /* UART1-TX */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 23 }, /* UART1-ERR */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-RX */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-TX */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 15 }, /* UART2-ERR */
> > +	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* TC */
> > +	{ .type = S3C_IRQTYPE_EDGE, .parent_irq = 31 }, /* ADC */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* CAM_C */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 6 }, /* CAM_P */
> > +	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
> > +	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 16 }, /* LCD2 */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 16 }, /* LCD3 */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 16 }, /* LCD4 */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA0 */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA1 */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA2 */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA3 */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA4 */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA5 */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-RX */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-TX */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-ERR */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* WDT */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* AC97 */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA6 */
> > +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA7 */
> 
> This all seems like information that should come from DT.

In the first iterations [0] of theis series it was done this way, but was 
suggested that these informations _might_ be implementation specific and not 
describing the hardware.

As I didn't get any "final" feedback on the matter, I tried it this way this 
time. Personally I also did like the previous variant better, as the driver 
could loose all the declaration stuff when platforms move to dt.

I would be glad for a hint if the first approach was the correct one.


[0] "irqchip: irq-s3c24xx: add devicetree support" from 2013-02-18, also with 
you in the recipient list

> 
> > +};
> > +
> > +static struct s3c_irq_data init_s3c2450second[32] = {
> > +	{ .type = S3C_IRQTYPE_EDGE }, /* 2D */
> > +	{ .type = S3C_IRQTYPE_EDGE }, /* IIC1 */
> > +	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
> > +	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
> > +	{ .type = S3C_IRQTYPE_EDGE }, /* PCM0 */
> > +	{ .type = S3C_IRQTYPE_EDGE }, /* PCM1 */
> > +	{ .type = S3C_IRQTYPE_EDGE }, /* I2S0 */
> > +	{ .type = S3C_IRQTYPE_EDGE }, /* I2S1 */
> > +};
> > +
> > 
> >  void __init s3c2416_init_irq(void)
> >  {
> >  
> >  	struct s3c_irq_intc *main_intc;
> > 
> > @@ -1024,7 +1069,7 @@ void __init s3c2442_init_irq(void)
> > 
> >  }
> >  #endif
> > 
> > -#ifdef CONFIG_CPU_S3C2443
> > +#if defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
> > 
> >  static struct s3c_irq_data init_s3c2443base[32] = {
> >  
> >  	{ .type = S3C_IRQTYPE_EINT, }, /* EINT0 */
> >  	{ .type = S3C_IRQTYPE_EINT, }, /* EINT1 */
> > 
> > @@ -1059,8 +1104,9 @@ static struct s3c_irq_data init_s3c2443base[32] = {
> > 
> >  	{ .type = S3C_IRQTYPE_EDGE, }, /* RTC */
> >  	{ .type = S3C_IRQTYPE_LEVEL, }, /* ADCPARENT */
> >  
> >  };
> > 
> > +#endif
> > 
> > -
> > +#ifdef CONFIG_CPU_S3C2443
> > 
> >  static struct s3c_irq_data init_s3c2443subint[32] = {
> >  
> >  	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-RX */
> >  	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-TX */
> > 
> > @@ -1172,6 +1218,17 @@ struct s3c24xx_irq_of_data s3c2416_irq_data = {
> > 
> >  	.irq_ctrl = s3c2416_ctrl,
> >  	.num_ctrl = ARRAY_SIZE(s3c2416_ctrl),
> >  
> >  };
> > 
> > +
> > +static struct s3c24xx_irq_of_ctrl s3c2450_ctrl[] = {
> > +	S3C24XX_IRQCTRL("intc", 0, init_s3c2443base, &main_intc, NULL),
> > +	S3C24XX_IRQCTRL("subintc", 0x18, init_s3c2450subint, NULL, 
&main_intc),
> > +	S3C24XX_IRQCTRL("intc2", 0x40, init_s3c2450second, &main_intc2, 
NULL),
> > +};
> > +
> > +static struct s3c24xx_irq_of_data s3c2450_irq_data = {
> > +	.irq_ctrl = s3c2450_ctrl,
> > +	.num_ctrl = ARRAY_SIZE(s3c2450_ctrl),
> > +};
> > 
> >  #endif
> >  
> >  #ifdef CONFIG_CPU_S3C2440
> > 
> > @@ -1219,6 +1276,7 @@ static const struct of_device_id intc_list[] = {
> > 
> >  #endif
> >  #ifdef CONFIG_CPU_S3C2416
> >  
> >  	{ .compatible = "samsung,s3c2416-irq", .data = &s3c2416_irq_data },
> > 
> > +	{ .compatible = "samsung,s3c2450-irq", .data = &s3c2450_irq_data },
> 
> Why are you not using IRQCHIP_OF_DECLARE?

As you can see in patch 5/6 the driver itself is using irqchip_declare, which 
I seem to have forgotten here. This matching table is simply meant to help the 
common init function to select the correct mapping table.

All this stuff can of course go away if the correct way is to gather this 
information from dt.


Thanks
Heiko
