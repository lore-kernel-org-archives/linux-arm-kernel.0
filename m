From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 18 Jan 2010 18:26:10 +0100
Subject: [PATCH] regulator: mc13783: consider Power Gates as digital
	regulators.
In-Reply-To: <20100118163212.GA32045@rakim.wolfsonmicro.main>
References: <1263830523.3632.22.camel@realization>
	<20100118163212.GA32045@rakim.wolfsonmicro.main>
Message-ID: <1263835570.3632.33.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On lun, 2010-01-18 at 16:32 +0000, Mark Brown wrote:
> On Mon, Jan 18, 2010 at 05:02:03PM +0100, Alberto Panizzo wrote:
> 
> > +int mc13783_state_powermisc_pwgt;
> > +int mc13783_reg_rmw_powermisc(struct mc13783 *mc13783, u32 mask, u32 val)
> 
> You're missing some statics here and some whitespace to separate the
> function from the variable.

Ok, mc13783_state_powermisc_pwgt will be static (and u32..)

> 
> > +	/* Update the stored state for Power Gates.
> > +	 * As from specs the meaning is inverted (0: en, 1: dis) */
> > +	if (mask & MC13783_REG_POWERMISC_PWGTSPI_M)
> > +		mc13783_state_powermisc_pwgt =
> > +			(mc13783_state_powermisc_pwgt & ~mask) |
> > +			((val ^ mask) & MC13783_REG_POWERMISC_PWGTSPI_M);
> 
> Could this code be written in a clearer fashion?  The bit manipluation
> isn't entirely obvious, especially given the multiple masks in use...

Something like this?
        if (mask & MC13783_REG_POWERMISC_PWGTSPI_M) {
                u32 new_state = (val & MC13783_REG_POWERMISC_PWGTSPI_M) ^ mask;

                mc13783_state_powermisc_pwgt =
                        (mc13783_state_powermisc_pwgt & ~mask) | new_state;
        }

I use the EXOR with one to negate bits.
The state stored in mc13783_state_powermisc_pwgt would be what the next 
functions write.

> 
> > +	ret = mc13783_reg_read(mc13783, MC13783_REG_POWERMISC, &valread);
> > +	if (ret)
> > +		return ret;
> > +
> > +	valread = (valread & ~mask) | val;
> > +
> > +	/* Re propose the stored state for Power Gates */
> > +	valread = (valread & ~MC13783_REG_POWERMISC_PWGTSPI_M) |
> > +						mc13783_state_powermisc_pwgt;
> 
> ...and this further mainpulation.

What is obscure in this? it is the same operation as the previous
MC13783_REG_POWERMISC_PWGTSPI_M is the mask for PWGT1 and 2 bits and in 
mc13783_state_powermisc_pwgt there is the stored state for those two
bits.
