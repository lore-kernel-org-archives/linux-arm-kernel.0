From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Dec 2009 19:35:25 +0000
Subject: [PATCH 4/4] MXC: imx31pdk: Trying to enabling regulators on
	mc13783
In-Reply-To: <1260473248.2141.75.camel@climbing-alby>
References: <1260470224.2141.37.camel@climbing-alby>
	<1260470547.2141.42.camel@climbing-alby>
	<1260470743.2141.45.camel@climbing-alby>
	<1260471013.2141.49.camel@climbing-alby>
	<1260471404.2141.56.camel@climbing-alby>
	<20091210191017.GB22554@sirena.org.uk>
	<1260473248.2141.75.camel@climbing-alby>
Message-ID: <20091210193524.GA4223@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2009 at 08:27:28PM +0100, Alberto Panizzo wrote:
> Il giorno gio, 10/12/2009 alle 19.10 +0000, Mark Brown ha scritto:
> > On Thu, Dec 10, 2009 at 07:56:44PM +0100, Alberto Panizzo wrote:

> > > +#define mV_to_uV(mV) (mV * 1000)

> > Define this somewhere global, it's generally useful.

> Yes, maybe in include/linux/mfd/mc13783.h 

It's not exactly Atlas-specific either, though?

> > > +static struct regulator_consumer_supply gpo_consumers[] = {
> > > +	{
> > > +		.supply = "REGU_GPO1",
> > > +	}

> > What's this supply for?  Normally a supply should be specific to a
> > device.

> Right, it is just a tentative to reproduce the freescale working code.

I suspect the Freescale code isn't mainlinable as-is; I would suggest
removing the consumer until there is an actual consumer which can make
use of this to be on the safe side.

> > > +static struct regulator_init_data violo_init = {
> > > +	.constraints = {
> > > +		.min_uV = mV_to_uV(1200), /* mc13783 allows min of 1200. */
> > > +		.max_uV = mV_to_uV(1800), /* mc13783 allows max of 1800. */

> > The constraints would normally be derived from the board - if none of
> > them want to adjust the voltage then there should be at most one voltage
> > specified (the voltage the system should use).

> Ok, the definitive patch will embrace those. Could you suggest something
> on the main problem? 

> This patch is a try, not the really, I decided to post this series because
> I've tried all my options but the system freezes when a mc 13783 GPOn output
> is enabled..

I'd suggest looking at the other supplies and seeing if they behave
themselves while that comes up, and also looking at the devices that are
connected to that supply and seeing what they might do when power is
applied.
