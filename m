From: ada@thorsis.com (Alexander Dahl)
Date: Mon, 24 Jul 2017 11:12:18 +0200
Subject: [PATCH 2/7] memory: atmel-ebi: Simplify SMC config code
In-Reply-To: <20170302133013.4dee0b4a@bbrezillon>
References: <1487609701-10300-1-git-send-email-boris.brezillon@free-electrons.com>
 <16727676.CMj9rWYKWZ@ada> <20170302133013.4dee0b4a@bbrezillon>
Message-ID: <11729837.oM7xt5LlYB@ada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Boris,

while testing v4.13-rc2 on an at91sam9g20 baed platform I'm coming back 
to this topic. Meanwhile the whole new SMC and NAND below EBI stuff is 
in mainline, this TDF bug however is still in there. See below (all 
quoted code parts from v4.13-rc2):

Am Donnerstag, 2. M?rz 2017, 13:30:13 schrieb Boris Brezillon:
> Alexander Dahl <ada@thorsis.com> wrote:
> > #define ATMEL_SMC_MODE_TDF(x)           (((x) - 1) << 16)

[?]

> > The hardware manual (AT91SAM9G20) says values from 0 to 15 (4bit,
> > 0x0 to 0xF) are possible and I guess the goal is to set it to a
> > value corresponding to the value in ns from the dts or to 15 if
> > it's greater (or -EINVAL in the new version).
> > 
> > However how can one set it to zero? Put in zero to the div you get
> > zero for ncycles or val and that goes as x into (((x) - 1) << 16)
> > which results in 0xF ending up as TDF_CYCLES in the mode register,
> > right?
> 
> Indeed.
> 
> > I can of course set a slightly greater value, which ends up in a
> > calculated register value of zero, but that seems more a hack to me
> > and is not obvious if I just look at the DTS.
> 
> No, we should fix the bug.
> 
> > If I'm right this might be topic of another bugfix patch, or should
> > it be done right in a v2 of this one?
> 
> It should be done right in a v2. Something like:
> 
> 		if (ncycles < ATMEL_SMC_MODE_TDF_MIN)
> 			ncycles = ATMEL_SMC_MODE_TDF_MIN;
> 
> with
> 
> #define ATMEL_SMC_MODE_TDF_MIN 1

I checked the SAMA5D3x datasheet today and it has the same mode register 
layout regarding the TDF parts. So allowed are register values from 0 to 
15 ending up in 0 to 15 clock cycles of Data Float Time.

The code in include/linux/mfd/syscon/atmel-smc.h is this:

#define ATMEL_SMC_MODE_TDF_MASK			GENMASK(19, 16)
#define ATMEL_SMC_MODE_TDF(x)			(((x) - 1) << 16)
#define ATMEL_SMC_MODE_TDF_MAX			16
#define ATMEL_SMC_MODE_TDF_MIN			1
#define ATMEL_SMC_MODE_TDFMODE_OPTIMIZED	BIT(20)

This ATMEL_SMC_MODE_TDF() is used in drivers/memory/atmel-ebi.c to setup 
the external memory interface with timings from dts. A line there inside 
an ebi node may look like this (see for example 
arch/arm/boot/dts/sama5d3xcm.dtsi):

atmel,smc-tdf-ns = <0>;

The value is expected in nanoseconds and I would expect a direct mapping 
from 0ns to a register value of 0. This is not the case in code 
(drivers/memory/atmel-ebi.c):

		if (ncycles > ATMEL_SMC_MODE_TDF_MAX ||
		    ncycles < ATMEL_SMC_MODE_TDF_MIN) {
			ret = -EINVAL;
			goto out;
		}

ATMEL_SMC_MODE_TDF_MIN is 1, so a possible 0 value from dts is not 
allowed in here and atmel_ebi_xslate_smc_timings() fails. In fact to get 
a register value of 0 for 0 TDF clock cycles I would have to set e.g. 
8ns in dts. So this didn't make it in some v2 and is still broken.

I could fix this and provide a patch, but I'm not sure about the second 
place where ATMEL_SMC_MODE_TDF() is used which is the NAND driver in 
drivers/mtd/nand/atmel/nand-controller.c. I'm not familiar enough with 
NAND to judge if this "min = 1, max = 16, decrease by 1 for applying to 
register" approach is needed there. I would say no, because it also is a 
counterintuitive offset, but I would prefer a explanation why the code 
is like this, before touching and breaking anything. ;-)

Greets
Alex
