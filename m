From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 20 Dec 2012 13:49:09 +0100
Subject: [PATCH 3/3] ARM: AT91: IIO: fix missing Sample and Hold time
In-Reply-To: <50D2EEA0.8040807@free-electrons.com>
References: <20121219183236.GP23971@game.jcrosoft.org>
 <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com>
 <1355942232-26251-3-git-send-email-plagnioj@jcrosoft.com>
 <50D2EEA0.8040807@free-electrons.com>
Message-ID: <20121220124909.GR23971@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:55 Thu 20 Dec     , Maxime Ripard wrote:
> Hi,
> 
> Le 19/12/2012 19:37, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
> > On the at91_adc a minimal Sample and Hold Time is necessary for the ADC to
> > guarantee the best converted final value between two channels selection.
> > This time has to be programmed through the bitfield SHTIM in the
> > Mode Register ADC_MR.
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: linux-iio at vger.kernel.org
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >  Documentation/devicetree/bindings/arm/atmel-adc.txt |    1 +
> >  drivers/iio/adc/at91_adc.c                          |   15 ++++++++++++++-
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> > index efb6f02..dd2ca90 100644
> > --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
> > +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
> > @@ -26,6 +26,7 @@ Optional properties:
> >  		       atmel,adc-res-names property. If not specified, the highest
> >  		       resolution will be used.
> >    - atmel,atmel,adc-sleep-mode: Boolean to enable of sleep mode when no conversion
> > +  - atmel,adc-sample-hold-time: Sample and Hold Time
> 
> In which unit? nanoseconds? number of clock ticks?
> 
> >   
> >  Optional trigger Nodes:
> >    - Required properties:
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index c563488..9481375 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -52,6 +52,7 @@ struct at91_adc_state {
> >  	void __iomem		*reg_base;
> >  	struct at91_adc_reg_desc *registers;
> >  	u8			startup_time;
> > +	u8			sample_hold_time;
> >  	bool			sleep_mode;
> >  	struct iio_trigger	**trig;
> >  	struct at91_adc_trigger	*trigger_list;
> > @@ -465,6 +466,9 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
> >  	}
> >  	st->startup_time = prop;
> >  
> > +	prop = 0;
> > +	of_property_read_u32(node, "atmel,adc-sample-hold-time", &prop);
> > +	st->sample_hold_time = prop;
> >  
> >  	if (of_property_read_u32(node, "atmel,adc-vref", &prop)) {
> >  		dev_err(&idev->dev, "Missing adc-vref property in the DT.\n");
> > @@ -578,7 +582,7 @@ static const struct iio_info at91_adc_info = {
> >  
> >  static int __devinit at91_adc_probe(struct platform_device *pdev)
> >  {
> > -	unsigned int prsc, mstrclk, ticks, adc_clk;
> > +	unsigned int prsc, mstrclk, ticks, adc_clk, shtim;
> >  	int ret;
> >  	struct iio_dev *idev;
> >  	struct at91_adc_state *st;
> > @@ -691,12 +695,21 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
> >  	 */
> >  	ticks = round_up((st->startup_time * adc_clk /
> >  			  1000000) - 1, 8) / 8;
> > +	/*
> > +	 * a minimal Sample and Hold Time is necessary for the ADC to guarantee
> > +	 * the best converted final value between two channels selection
> > +	 * The formula thus is : Sample and Hold Time = (shtim + 1) / ADCClock
> > +	 */
> > +	shtim = round_up((st->sample_hold_time * adc_clk /
> > +			  1000000) - 1, 1);
> > +
> 
> Since, from all the datasheet I have (G20, G45 and X5), the minimum time
> is always 500ns, do we really need to add a dt property for that?
you must this is hardware specific it depend on the line capacity

Best Regards,
J.
