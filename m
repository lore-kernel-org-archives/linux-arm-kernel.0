From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 10 Dec 2009 20:27:28 +0100
Subject: [PATCH 4/4] MXC: imx31pdk: Trying to enabling regulators on
	mc13783
In-Reply-To: <20091210191017.GB22554@sirena.org.uk>
References: <1260470224.2141.37.camel@climbing-alby>
	<1260470547.2141.42.camel@climbing-alby>
	<1260470743.2141.45.camel@climbing-alby>
	<1260471013.2141.49.camel@climbing-alby>
	<1260471404.2141.56.camel@climbing-alby>
	<20091210191017.GB22554@sirena.org.uk>
Message-ID: <1260473248.2141.75.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il giorno gio, 10/12/2009 alle 19.10 +0000, Mark Brown ha scritto:
> On Thu, Dec 10, 2009 at 07:56:44PM +0100, Alberto Panizzo wrote:
> 
> > +/* MC13783 */
> > +#define mV_to_uV(mV) (mV * 1000)
> 
> Define this somewhere global, it's generally useful.

Yes, maybe in include/linux/mfd/mc13783.h 

> 
> > +
> > +static struct regulator_consumer_supply gpo_consumers[] = {
> > +	{
> > +		.supply = "REGU_GPO1",
> > +	}
> 
> What's this supply for?  Normally a supply should be specific to a
> device.

Right, it is just a tentative to reproduce the freescale working code.

> 
> > +static struct regulator_init_data gpo1_init = {
> > +	.constraints = {
> > +		.boot_on = 1, /* Enable it! */
> 
> I suspect you'll want always_on there - otherwise the regulator might
> get switched off underneath you if the regulator core changes to make
> regulator_has_full_constraints() the default.
> 
> > +static struct regulator_init_data violo_init = {
> > +	.constraints = {
> > +		.min_uV = mV_to_uV(1200), /* mc13783 allows min of 1200. */
> > +		.max_uV = mV_to_uV(1800), /* mc13783 allows max of 1800. */
> 
> The constraints would normally be derived from the board - if none of
> them want to adjust the voltage then there should be at most one voltage
> specified (the voltage the system should use).

Ok, the definitive patch will embrace those. Could you suggest something
on the main problem? 

This patch is a try, not the really, I decided to post this series because
I've tried all my options but the system freezes when a mc 13783 GPOn output
is enabled..
