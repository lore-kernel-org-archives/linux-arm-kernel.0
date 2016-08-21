From: rui.zhang@intel.com (Zhang Rui)
Date: Sun, 21 Aug 2016 21:37:29 +0800
Subject: [PATCH V3 2/5] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <87inuwd1p4.fsf@eliezer.anholt.net>
References: <1463495753-967-1-git-send-email-kernel@martin.sperl.org>
 <1463495753-967-3-git-send-email-kernel@martin.sperl.org>
 <87mvn6qa2x.fsf@eliezer.anholt.net> <87r39lvs4v.fsf@eliezer.anholt.net>
 <1471591694.2691.39.camel@intel.com> <87inuwd1p4.fsf@eliezer.anholt.net>
Message-ID: <1471786649.2188.4.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?, 2016-08-19 at 11:59 -0700, Eric Anholt wrote:
> Zhang Rui <rui.zhang@intel.com> writes:
> 
> > 
> > On ?, 2016-08-18 at 11:39 -0700, Eric Anholt wrote:
> > > 
> > > Eric Anholt <eric@anholt.net> writes:
> > > 
> > > > 
> > > > 
> > > > kernel at martin.sperl.org writes:
> > > > 
> > > > > 
> > > > > 
> > > > > From: Martin Sperl <kernel@martin.sperl.org>
> > > > > 
> > > > > Add basic thermal driver for bcm2835 SOC.
> > > > > 
> > > > > This driver currently relies on the firmware setting up the
> > > > > tsense HW block and does not set it up itself.
> > > > > 
> > > > > Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> > > > > 
> > > > > ChangeLog:
> > > > > ?V1 -> V2: added specific settings depending on compatiblity
> > > > > 	???added trip point based on register
> > > > > 	???setting up ctrl-register if HW is not enabled by
> > > > > firmware
> > > > > 	?????as per recommendation of Eric (untested)
> > > > > 	???check that clock frequency is in range
> > > > > 	?????(1.9 - 5MHz - as per comment in clk-bcm2835.c)
> > > > > ---
> > > > > 
> > > > > diff --git a/drivers/thermal/bcm/Makefile
> > > > > b/drivers/thermal/bcm/Makefile
> > > > > new file mode 100644
> > > > > index 0000000..13456d2
> > > > > --- /dev/null
> > > > > +++ b/drivers/thermal/bcm/Makefile
> > > > > @@ -0,0 +1 @@
> > > > > +obj-$(CONFIG_BCM2835_THERMAL)		:=
> > > > > bcm2835_thermal.o
> > > > > diff --git a/drivers/thermal/bcm/bcm2835_thermal.c
> > > > > b/drivers/thermal/bcm/bcm2835_thermal.c
> > > > > new file mode 100644
> > > > > index 0000000..73138cb
> > > > > --- /dev/null
> > > > > +++ b/drivers/thermal/bcm/bcm2835_thermal.c
> > > > > 
> > > > > +static const struct of_device_id
> > > > > bcm2835_thermal_of_match_table[];
> > > > > +static int bcm2835_thermal_probe(struct platform_device
> > > > > *pdev)
> > > > > +{
> > > > > 
> > > > > +	/* enable clock and check rate */
> > > > > +	clk_prepare_enable(data->clk);
> > > > > +	rate = clk_get_rate(data->clk);
> > > > > +	if ((rate < 1920000) || (rate > 5000000)) {
> > > > > +		dev_warn(&pdev->dev,
> > > > > +			?"Clock %pCn is running at %pCr Hz,
> > > > > which is outside the recommended range of 1.9 to 5.0 MHz\n",
> > > > > +			?data->clk, data->clk);
> > > > > +	}
> > > > > +
> > > > > +	/* register it */
> > > > > +	tz = thermal_zone_device_register("bcm2835_thermal",
> > > > > +					??1, 0, data,
> > > > > +					??&bcm2835_thermal_o
> > > > > ps,
> > > > > +					??NULL, 0, 0);
> > > > I notice that the polling_delay is set to 0, but we're not
> > > > using
> > > > interrupts to trigger the trip.??Is it valid to expose a trip
> > > > without a
> > > > polling_delay or interrupts???Should passive_delay be set as
> > > > well?
> > > > 
> > > > This is up to the thermal maintainers.??As far as I'm
> > > > concerned,
> > > > it's:
> > > > 
> > > > Acked-by: Eric Anholt <eric@anholt.net>
> > > > 
> > > > One it lands I'll pull the defconfig and DT bits.
> > > Ping on this question to thermal maintainers.??I'd still love to
> > > see
> > > this driver land.
> > hmmm, how is this driver supposed to work?
> > With this patch set, I think the only benefit is that we can get
> > the
> > temperature and trip point information via thermal sysfs interface,
> > but
> > kernel thermal control is a no-op here, right?
> Yeah.??It seems useful to be able to get the information.??Once we
> land
> this, I hope someone can add interrupt support so that there are
> actual
> trip points.

sounds reasonable to me.
Another question, why you need a separate directory for a single
file,?bcm2835_thermal.c?

thanks,
rui
