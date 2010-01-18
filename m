From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 18 Jan 2010 18:50:04 +0100
Subject: [PATCH] regulator: mc13783: consider Power Gates as digital
	regulators.
In-Reply-To: <20100118172002.GB6889@rakim.wolfsonmicro.main>
References: <1263830523.3632.22.camel@realization>
	<20100118163212.GA32045@rakim.wolfsonmicro.main>
	<1263834473.3632.31.camel@realization>
	<20100118172002.GB6889@rakim.wolfsonmicro.main>
Message-ID: <1263837004.3632.52.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On lun, 2010-01-18 at 17:20 +0000, Mark Brown wrote:
> On Mon, Jan 18, 2010 at 06:07:53PM +0100, Alberto Panizzo wrote:
> 
> > Something like this?
> > 	if (mask & MC13783_REG_POWERMISC_PWGTSPI_M) {
> > 		u32 new_state = (val & MC13783_REG_POWERMISC_PWGTSPI_M) ^ mask;
> > 
> > 		mc13783_state_powermisc_pwgt =
> > 			(mc13783_state_powermisc_pwgt & ~mask) | new_state;
> > 	}
> 
> Yes, that's clearer.
> 
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	valread = (valread & ~mask) | val;
> > > > +
> > > > +	/* Re propose the stored state for Power Gates */
> > > > +	valread = (valread & ~MC13783_REG_POWERMISC_PWGTSPI_M) |
> > > > +						mc13783_state_powermisc_pwgt;
> > > 
> > > ...and this further mainpulation.
> 
> > What is obscure in this? it is the same operation as the previous
> > MC13783_REG_POWERMISC_PWGTSPI_M is the mask for PWGT1 and 2 bits and in 
> > mc13783_state_powermisc_pwgt there is the stored state for those two bits.
> 
> Part of it is the fact that the first bit was almost completely opaque
> but even so it would be less surprising if you first worked out the
> value you wanted to set, then did whatever manipulation was required to
> translate into the format that actually gets written.

Maybe I not deep explained what's going on..
In POWERMISC register there are other controls bits than PWGTxEN that follow
the convention of 1= enable 0= disable and for those bits read and write value
are consistent: what is written could be read.

So, for all these bits the way to manipulate is the normal:
	valread = (valread & ~mask) | val;

where the mask can indicate the manipulation of not only one bit.
As "mask" could contain manipulation of PWGTxEN bits, what I do is to overwrite
those with the previously updated value:
	valread = (valread & ~MC13783_REG_POWERMISC_PWGTSPI_M) |
						mc13783_state_powermisc_pwgt;

mc13783_state_powermisc_pwgt is maintained to be 0 in bits other than 
MC13783_REG_POWERMISC_PWGTSPI_M mask.
I got me much clear?
I misunderstood the question?

Sorry my English please.. :)
Thanks!

Alberto.
