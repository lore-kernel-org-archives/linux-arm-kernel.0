From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 20 Jul 2012 13:17:00 +0200
Subject: [PATCHv3] I2C: MV64XXX: Add Device Tree support
In-Reply-To: <20120720103513.GA5971@pengutronix.de>
References: <1342430205-13702-1-git-send-email-andrew@lunn.ch>
 <1342430205-13702-2-git-send-email-andrew@lunn.ch>
 <20120720103513.GA5971@pengutronix.de>
Message-ID: <20120720111700.GA14580@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 12:35:13PM +0200, Wolfram Sang wrote:
> Hi Andrew,
> 
> On Mon, Jul 16, 2012 at 11:16:45AM +0200, Andrew Lunn wrote:
> > Extends the driver to get properties from device tree. Rather than
> > pass the N & M factors in DT, use the more standard clock-frequency
> > property. Calculate N & M at run time. In order to do this, we need to
> 
> Thanks.
> 
> > know tclk. So the driver uses clk_get() etc in order to get the clock
> > and clk_get_rate() to determine the tclk rate. Not all platforms
> > however have CLK, so some #ifdefery is needed to ensure the driver
> > still compiles when CLK is not available.
> > 
> > Also extend the kirkwood DT support to supply the needed properties. A
> > default clock-frequency is 400KHz, which some platforms might need to
> > override to 100KHz if they have devices which do not support fast
> > mode.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
> 
> Has Sebastian acked THIS patch? Didn't saw such a mail? If it was a
> previous patch which he acked, I'd like it to be resent, since the
> divider calculation is new.

Yes and the version that came after it, fixing the timeout code, which
at your request i will rip out. It has also been tested by a couple of
other people on different kirkwood boards.

> > v2: Removed duplicate interrupt in DT.
> > v3: Use clock-frequency property, instead of explicit n & m baud factors.
> > 
> > i2c fix.
> > ---
> >  Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   21 +++-
> >  arch/arm/boot/dts/kirkwood.dtsi                    |   11 ++
> >  arch/arm/mach-kirkwood/board-dt.c                  |    2 +
> >  arch/arm/mach-kirkwood/common.c                    |    2 +
> >  arch/arm/plat-orion/common.c                       |    1 +
> >  drivers/i2c/busses/i2c-mv64xxx.c                   |  107 +++++++++++++++++++-
> 
> As said in another mail, please split up arch/arm and i2c-stuff.

Sure, no problem. 

> 
> > +Required properties :
> > +
> > + - reg             : Offset and length of the register set for the device
> > + - compatible      : Should be "marvell,mv64xxx-i2c"
> > + - interrupts      : Te interrupt number
> > + - clock-frequency : Desired I2C bus clock frequency in Hz.
> > + - timeout-ms      : How long to wait for a transaction to complete
> 
> If you don't really need "timeout-ms", I'd ask you to drop it.

I can hard code it to 1 second. This should have no impact on any
plat-orion boards, since they all use 1 second.

> > +#ifdef CONFIG_OF
> 
> Hooray, we have one big CONFIG_OF block, so we could move other stuff
> here? See below.
> 
> > +static int __devinit
> > +calc_freq(const int tclk, const int n, const int m)
> > +{
> > +	return tclk / (10 * (m + 1) * (2 << n));
> > +}
> > +
> > +static bool __devinit
> > +find_baud_factors(const int req_freq, const int tclk, int *best_n, int *best_m)
> > +{
> > +	int freq, delta, best_delta = INT_MAX;
> > +	int m, n;
> > +
> > +	for (n = 0; n <= 7; n++)
> > +		for (m = 0; m <= 15; m++) {
> > +			freq = calc_freq(tclk, n, m);
> > +			delta = req_freq - freq;
> > +			if (delta >= 0 && delta < best_delta) {
> > +				*best_m = m;
> > +				*best_n = n;
> > +				best_delta = delta;
> > +			}
> > +			if (best_delta == 0)
> > +				return true;
> > +		}
> > +	if (best_delta == INT_MAX)
> > +		return false;
> > +	return true;
> > +}
> > +#endif
> >  static int __devinit
> >  mv64xxx_i2c_probe(struct platform_device *pd)
> >  {
> > @@ -528,7 +564,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
> >  	struct mv64xxx_i2c_pdata	*pdata = pd->dev.platform_data;
> >  	int	rc;
> >  
> > -	if ((pd->id != 0) || !pdata)
> > +	if ((!pdata && !pd->dev.of_node) || (pdata && (pd->id != 0)))
> >  		return -ENODEV;
> 
> (extra points if you rebase your patch on top of this patch
> d61a9095155e832287552a9e565b8756ee293c46 from my next tree:
> git://git.pengutronix.de/git/wsa/linux.git i2c-embedded/for-next)

Yes, i know of this patch from Florian Fainelli. I was planning on
warning you about the merge conflict, but maybe i will try for the
rebase.

> >  	drv_data = kzalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
> > @@ -546,19 +582,64 @@ mv64xxx_i2c_probe(struct platform_device *pd)
> >  	init_waitqueue_head(&drv_data->waitq);
> >  	spin_lock_init(&drv_data->lock);
> >  
> > -	drv_data->freq_m = pdata->freq_m;
> > -	drv_data->freq_n = pdata->freq_n;
> > -	drv_data->irq = platform_get_irq(pd, 0);
> > +#if defined(CONFIG_HAVE_CLK)
> > +	/* Not all platforms have a clk */
> > +	drv_data->clk = clk_get(&pd->dev, NULL);
> > +	if (!IS_ERR(drv_data->clk)) {
> > +		clk_prepare(drv_data->clk);
> > +		clk_enable(drv_data->clk);
> > +	}
> 
> Call this code only when CONFIG_OF?

Nope. There are lots of kirkwood boards who need to turn this clock
on, but are not yet converted to DT. I suspect Dove is similar. I also
don't particularly like all this #ifdefery, but there is not much i
can do about it :-(

> 
> > +#endif
> > +	if (pdata) {
> > +		drv_data->freq_m = pdata->freq_m;
> > +		drv_data->freq_n = pdata->freq_n;
> > +		drv_data->irq = platform_get_irq(pd, 0);
> > +	}
> > +#ifdef CONFIG_OF
> > +	if (pd->dev.of_node) {
> 
> Move this stuff into a seperate function and put it into the big
> CONFIG_OF block? That should make the code a lot more readable?

O.K.
 
> > +		int bus_freq;
> > +		int tclk;
> > +		/* CLK is mandatory when using DT to describe the i2c
> > +		 * bus. We need to know tclk in order to calculate bus
> > +		 * clock factors. */
> > +#if defined(CONFIG_HAVE_CLK)
> > +		if (IS_ERR(drv_data->clk)) {
> > +			rc = -ENODEV;
> > +			goto exit_unmap_regs;
> > +		}
> > +		tclk = clk_get_rate(drv_data->clk);
> > +		of_property_read_u32(pd->dev.of_node, "clock-frequency",
> > +				     &bus_freq);
> > +		if (!find_baud_factors(bus_freq, tclk,
> > +				       &drv_data->freq_n, &drv_data->freq_m)) {
> > +			rc = -EINVAL;
> > +			goto exit_unmap_regs;
> > +		}
> > +		drv_data->irq = irq_of_parse_and_map(pd->dev.of_node, 0);
> > +#else
> > +		/* Have OF but no CLK */
> > +		rc = -ENODEV;
> > +		goto exit_unmap_regs;
> > +#endif
> > +	}
> > +#endif
> >  	if (drv_data->irq < 0) {
> >  		rc = -ENXIO;
> >  		goto exit_unmap_regs;
> >  	}
> > +
> >  	drv_data->adapter.dev.parent = &pd->dev;
> >  	drv_data->adapter.algo = &mv64xxx_i2c_algo;
> >  	drv_data->adapter.owner = THIS_MODULE;
> >  	drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
> > -	drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
> > +	if (pd->dev.of_node)
> > +		drv_data->adapter.timeout = msecs_to_jiffies(
> > +			of_property_read_u32(pd->dev.of_node, "timeout-ms",
> > +					     &drv_data->freq_n));
> > +	else
> > +		drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
> 
> This should also go into the new function.

Actually, its totally broken, and is what i will replace with a hard
coded value...

      Andrew
