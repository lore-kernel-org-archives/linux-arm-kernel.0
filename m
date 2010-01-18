From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 18 Jan 2010 17:37:23 +0000
Subject: [PATCH] regulator: mc13783: consider Power Gates as digital
	regulators.
In-Reply-To: <1263835570.3632.33.camel@realization>
References: <1263830523.3632.22.camel@realization>
	<20100118163212.GA32045@rakim.wolfsonmicro.main>
	<1263835570.3632.33.camel@realization>
Message-ID: <20100118173722.GA12689@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As I just wrote...

On Mon, Jan 18, 2010 at 06:07:53PM +0100, Alberto Panizzo wrote:

> Something like this?
> 	if (mask & MC13783_REG_POWERMISC_PWGTSPI_M) {
> 		u32 new_state = (val & MC13783_REG_POWERMISC_PWGTSPI_M) ^ mask;
> 
> 		mc13783_state_powermisc_pwgt =
> 			(mc13783_state_powermisc_pwgt & ~mask) | new_state;
> 	}

Yes, that's clearer.

> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	valread = (valread & ~mask) | val;
> > > +
> > > +	/* Re propose the stored state for Power Gates */
> > > +	valread = (valread & ~MC13783_REG_POWERMISC_PWGTSPI_M) |
> > > +						mc13783_state_powermisc_pwgt;
> > 
> > ...and this further mainpulation.

> What is obscure in this? it is the same operation as the previous
> MC13783_REG_POWERMISC_PWGTSPI_M is the mask for PWGT1 and 2 bits and in 
> mc13783_state_powermisc_pwgt there is the stored state for those two bits.

Part of it is the fact that the first bit was almost completely opaque
but even so it would be less surprising if you first worked out the
value you wanted to set, then did whatever manipulation was required to
translate into the format that actually gets written.
