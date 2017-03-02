From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 2 Mar 2017 13:30:13 +0100
Subject: [PATCH 2/7] memory: atmel-ebi: Simplify SMC config code
In-Reply-To: <16727676.CMj9rWYKWZ@ada>
References: <1487609701-10300-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487609701-10300-3-git-send-email-boris.brezillon@free-electrons.com>
 <16727676.CMj9rWYKWZ@ada>
Message-ID: <20170302133013.4dee0b4a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Thu, 02 Mar 2017 13:02:16 +0100
Alexander Dahl <ada@thorsis.com> wrote:

> Hei hei,
> 
> With 
> 
> #define ATMEL_SMC_MODE_TDF(x)           (((x) - 1) << 16)
> 
> from include/linux/mfd/syscon/atmel-smc.h you added this:
> 
> > +	ret = of_property_read_u32(np, "atmel,smc-tdf-ns", &val);
> > +	if (!ret) {
> > +		required = true;
> > +		ncycles = DIV_ROUND_UP(val, clk_period_ns);
> > +		if (ncycles > ATMEL_SMC_MODE_TDF_MAX) {
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}  
> 
> [?]
> 
> > +		smcconf->mode |= ATMEL_SMC_MODE_TDF(ncycles);
> > +	}  
> 
> This was the same algorithm at some other location in atmel-ebi.c 
> before:
> 
> 	#define AT91_SMC_TDF_(x)		((((x) - 1) << 16) & AT91_SMC_TDF)
> 
> 	val = DIV_ROUND_UP(timings->tdf_ns, clk_rate);
> 	if (val > AT91_SMC_TDF_MAX)
> 		val = AT91_SMC_TDF_MAX;
> 	regmap_fields_write(fields->mode, conf->cs,
> 			    config->mode | AT91_SMC_TDF_(val));
> 
> The hardware manual (AT91SAM9G20) says values from 0 to 15 (4bit, 0x0 to 
> 0xF) are possible and I guess the goal is to set it to a value 
> corresponding to the value in ns from the dts or to 15 if it's greater 
> (or -EINVAL in the new version).
> 
> However how can one set it to zero? Put in zero to the div you get zero 
> for ncycles or val and that goes as x into (((x) - 1) << 16) which 
> results in 0xF ending up as TDF_CYCLES in the mode register, right?

Indeed.

> 
> I can of course set a slightly greater value, which ends up in a 
> calculated register value of zero, but that seems more a hack to me and 
> is not obvious if I just look at the DTS.

No, we should fix the bug.

> 
> If I'm right this might be topic of another bugfix patch, or should it 
> be done right in a v2 of this one?

It should be done right in a v2. Something like:

		if (ncycles < ATMEL_SMC_MODE_TDF_MIN)
			ncycles = ATMEL_SMC_MODE_TDF_MIN;

with

#define ATMEL_SMC_MODE_TDF_MIN 1

I don't think we need to backport the fix, since no-one uses this driver
yet.

Thanks for this report.

Boris
