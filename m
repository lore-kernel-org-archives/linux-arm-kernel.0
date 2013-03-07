From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 7 Mar 2013 09:19:08 +0100
Subject: [PATCH 4/9] MXS/i.MX28: there is more than one way to clock
 the RTC
In-Reply-To: <20130307064824.GD5372@S2101-09.ap.freescale.net>
References: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
 <1362405948-12992-5-git-send-email-s.trumtrar@pengutronix.de>
 <20130307064824.GD5372@S2101-09.ap.freescale.net>
Message-ID: <20130307081908.GB3571@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn!

On Thu, Mar 07, 2013 at 02:48:26PM +0800, Shawn Guo wrote:
> On Mon, Mar 04, 2013 at 03:05:43PM +0100, Steffen Trumtrar wrote:
> > From: Juergen Beisert <jbe@pengutronix.de>
> > 
> > Reflect the possibilities via device tree and configure the RTC correctly
> > 
> > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx28.dtsi |    2 ++
> >  drivers/rtc/rtc-stmp3xxx.c   |   76 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 78 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > index dcd0844..d89af79 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -818,6 +818,8 @@
> >  				compatible = "fsl,imx28-rtc", "fsl,stmp3xxx-rtc";
> >  				reg = <0x80056000 0x2000>;
> >  				interrupts = <29>;
> > +				clocks = <&clks 65>, <&clks 40> ;
> > +				clock-names = "32k", "24m";
> 
> The changes should be in some mxs/arch patch.
> 
> >  			};
> >  
> >  			i2c0: i2c at 80058000 {
> > diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
> > index 7311292..fb4b823 100644
> > --- a/drivers/rtc/rtc-stmp3xxx.c
> > +++ b/drivers/rtc/rtc-stmp3xxx.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/module.h>
> >  #include <linux/io.h>
> >  #include <linux/init.h>
> > +#include <linux/clk.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/rtc.h>
> > @@ -176,11 +177,55 @@ static irqreturn_t stmp3xxx_rtc_interrupt(int irq, void *dev_id)
> >  	return IRQ_NONE;
> >  }
> >  
> > +/*
> > + * To keep the energy consumption low, keep only
> > + * the really used oscillator running when the power is down
> > + */
> > +static void stmp3xxx_alarm_keep_oscillator(const struct stmp3xxx_rtc_data *rtc_data)
> > +{
> > +	switch (rtc_data->clk_src) {
> > +	case MXS_OSC_24M:
> > +		/* keep the 24 MHz oscillator running even in power down */
> > +		writel(STMP3XXX_RTC_PERSISTENT0_XTAL32_FREQ | /* 24 MHz / 750 */
> > +			STMP3XXX_RTC_PERSISTENT0_XTAL24MHZ_PWRUP,
> > +			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_SET);
> > +		writel(STMP3XXX_RTC_PERSISTENT0_XTAL32KHZ_PWRUP |
> > +			STMP3XXX_RTC_PERSISTENT0_CLOCKSOURCE,
> > +			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
> > +		break;
> > +	case MXS_OSC_32K:
> > +		/* keep the 32 kHz oscillator running even in power down */
> > +		writel(STMP3XXX_RTC_PERSISTENT0_XTAL32_FREQ | /* 32 kHz */
> > +			STMP3XXX_RTC_PERSISTENT0_XTAL32KHZ_PWRUP |
> > +			STMP3XXX_RTC_PERSISTENT0_CLOCKSOURCE,
> > +			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_SET);
> > +		writel(STMP3XXX_RTC_PERSISTENT0_XTAL24MHZ_PWRUP,
> > +			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
> > +		break;
> > +	case MXS_OSC_32K768:
> > +		/* keep the 32 kHz oscillator running even in power down */
> > +		writel(STMP3XXX_RTC_PERSISTENT0_XTAL32KHZ_PWRUP |
> > +			STMP3XXX_RTC_PERSISTENT0_CLOCKSOURCE,
> > +			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_SET);
> > +		writel(STMP3XXX_RTC_PERSISTENT0_XTAL32_FREQ | /* 32.768 kHz */
> > +			STMP3XXX_RTC_PERSISTENT0_XTAL24MHZ_PWRUP,
> > +			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
> > +		break;
> > +	case MXS_UNKNOWN:
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> >  static int stmp3xxx_alarm_irq_enable(struct device *dev, unsigned int enabled)
> >  {
> >  	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
> >  
> > +	stmp3xxx_alarm_keep_oscillator(rtc_data);
> > +
> >  	if (enabled) {
> > +		writel(STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE, /* to be able to sleep */
> > +			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
> >  		writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
> >  				STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN,
> >  				rtc_data->io + STMP3XXX_RTC_PERSISTENT0_SET);
> > @@ -248,6 +293,8 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
> >  {
> >  	struct stmp3xxx_rtc_data *rtc_data;
> >  	struct resource *r;
> > +	struct clk *clk;
> > +	unsigned long rate;
> >  	int err;
> >  
> >  	rtc_data = kzalloc(sizeof *rtc_data, GFP_KERNEL);
> > @@ -280,6 +327,35 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
> >  	platform_set_drvdata(pdev, rtc_data);
> >  
> >  	mxs_reset_block(rtc_data->io);
> > +
> > +	/*
> > +	 * configure the RTC to provide the correct time
> > +	 */
> > +	clk = clk_get(&pdev->dev, "32k");
> 
> devm_clk_get
> 
> Shawn
> 
> > +	if (IS_ERR(clk)) {
> > +		/* just a fall back */
> > +		dev_warn(&pdev->dev, "RTC's input clock undefined\n");
> > +		rtc_data->clk_src = MXS_OSC_24M;
> > +	} else {
> > +		rate = clk_get_rate(clk);
> > +		if (rate == 0) {
> > +			/* no dedicated external crystal */
> > +			rtc_data->clk_src = MXS_OSC_24M;
> > +			dev_info(&pdev->dev, "Using 24 MHz as RTC's clock\n");
> > +		} else if (rate == 32000) {
> > +			rtc_data->clk_src = MXS_OSC_32K;
> > +			dev_info(&pdev->dev, "Using 32.0 kHz as RTC's clock\n");
> > +		} else if (rate == 32768) {
> > +			rtc_data->clk_src = MXS_OSC_32K768;
> > +			dev_info(&pdev->dev, "Using 32.768 kHz as RTC's clock\n");
> > +		} else
> > +			dev_warn(&pdev->dev,
> > +				"Cannot init the RTC's clock source\n");
> > +	}
> > +
> > +	/* basically configure the RTC's input clock */
> > +	stmp3xxx_alarm_keep_oscillator(rtc_data);
> > +
> >  	writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
> >  			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
> >  			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
> > -- 
> > 1.7.10.4
> > 
> 
> 

I can agree to all your comments to this patch and the others in this series
and will take care of all of them.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
