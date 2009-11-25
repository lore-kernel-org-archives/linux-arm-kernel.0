From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 14:04:35 +0100
Subject: [PATCH 13/17] ARM: pxa/raumfeld: add Marvell Libertas via SDIO
In-Reply-To: <20091125114946.GB3175@sirena.org.uk>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-14-git-send-email-daniel@caiaq.de>
	<20091125114946.GB3175@sirena.org.uk>
Message-ID: <20091125130435.GD14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 11:49:47AM +0000, Mark Brown wrote:
> On Wed, Nov 25, 2009 at 11:42:27AM +0100, Daniel Mack wrote:
> 
> > +#include <linux/regulator/consumer.h>
> 
> The regulator consumer stuff here feels like it'd be better put into the
> driver itself since it doesn't seem to be specific to the machine -
> other machines could use the same glue with different machine setup.

AH, the pxamci driver already does that. So I'll just name the supply
'vmmc' and that's it. Will test that soon.

> > +static void raumfeld_mci_setpower(struct device *dev, unsigned int on)
> > +{
> > +	int ret = 0;
> > +	struct regulator *regulator = regulator_get(dev, "vcc_wifi");
> 
> Don't do this, take one reference to the regulaor at startup and then
> use that throughout the lifetime of the sysetm.  If you don't do that
> then the API may decide that the regulator is idle and disable it for
> you.
> 
> I suspect that supply name might want to be just plain "vcc" unless the
> chip really does have a single supply labelled as vcc_wifi - the name
> should ideally match that used in the datasheet.
> 
> > +
> > +	/* bring up V6 for SDIO/WLAN */
> > +	if (IS_ERR(regulator)) {
> > +		printk(KERN_ERR "%s(): unable to get regulator. err = %ld\n",
> > +			__func__, PTR_ERR(regulator));
> > +		return;
> > +	}
> > +
> > +	if (on && !regulator_is_enabled(regulator)) {
> > +		ret = regulator_enable(regulator);
> 
> Nack, if you're doing regulator_get() you should never need to check
> regulator_is_enabled() since you can't know if something else is
> incrementing or decrementing the reference count independantly of you.
> Either use regulator_get_exclusive() (at which point you own the
> regulator) or keep track of the on/off switch yourself.

The issue I was facing here was that the mmc power enable callback was
called more than once with the same value for 'on', so the calls were
not balanced and the regulator driver bailed.

Anyway, that will all go away when letting the driver do the regultar
calls. Thanks for explaining that.

Daniel
