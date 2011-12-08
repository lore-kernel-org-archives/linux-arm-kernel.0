From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 8 Dec 2011 10:29:14 +0000
Subject: [PATCH] arm,davinci: configure davinci aemif chipselects
 through OF
In-Reply-To: <4EE07E27.8090602@denx.de>
References: <1322991679-20947-1-git-send-email-hs@denx.de>
 <DF0F476B391FA8409C78302C7BA518B603EFB2@DBDE01.ent.ti.com>
 <4EE06B79.7070804@denx.de>
 <DF0F476B391FA8409C78302C7BA518B6040A03@DBDE01.ent.ti.com>
 <4EE07E27.8090602@denx.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6040CBB@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Thu, Dec 08, 2011 at 14:36:47, Heiko Schocher wrote:

> >>>> diff --git a/arch/arm/mach-davinci/aemif.c b/arch/arm/mach-davinci/aemif.c
> >>>> index 1ce70a9..12c559f 100644
> >>>> --- a/arch/arm/mach-davinci/aemif.c
> >>>> +++ b/arch/arm/mach-davinci/aemif.c
> >>>> @@ -13,12 +13,14 @@
> >>>>  #include <linux/err.h>
> >>>>  #include <linux/clk.h>
> >>>>  #include <linux/module.h>
> >>>> +#include <linux/of.h>
> >>>> +#include <linux/of_address.h>
> >>>>  #include <linux/time.h>
> >>>>  
> >>>>  #include <mach/aemif.h>
> >>>>  
> >>>>  /* Timing value configuration */
> >>>> -
> >>>> +#define ASIZE(x)	(x)
> >>>>  #define TA(x)		((x) << 2)
> >>>>  #define RHOLD(x)	((x) << 4)
> >>>>  #define RSTROBE(x)	((x) << 7)
> >>>> @@ -26,7 +28,10 @@
> >>>>  #define WHOLD(x)	((x) << 17)
> >>>>  #define WSTROBE(x)	((x) << 20)
> >>>>  #define WSETUP(x)	((x) << 26)
> >>>> +#define EW(x)		((x) << 30)
> >>>> +#define SS(x)		((x) << 31)
> >>> You are adding support for additional configuration
> >>> parameters which should be done in a separate patch.
> >> Hmm.. they are only used in the OF case ... is this split
> >> really needed?
> > 
> > But they should also be useful in the non-OF case, no?
> > Why restrict their usage to the OF case?
> 
> I thought there is no need, because nobody needed this yet ...
> Ok, I change this too, so I have to fix this files:

True, no one configured these so far (relied on the defaults).

Also, they probably did not get added into the timing API since
they are not really timing parameters. Its better to add a separate 
configuration API for these.

It will be better to move the driver outside of arch/arm/
before adding new features. I don't know if there is a place
defined yet for "memory interface" drivers, so, drivers/misc/
may be the place.

I have added Greg and Arnd for their opinion in this.

Greg, Arnd,

Brief background:

DaVinci AEMIF is an async memory interface peripheral implemented
in arch/arm/mach-davinci/aemif.c. It helps interface to NAND, NOR
and other asynchronous memories. Currently it just provides an API
for timing value configuration. The API is invoked by the MTD NAND
driver.

Specification here: http://www.ti.com/lit/ug/sprue20c/sprue20c.pdf

We are looking at a place for this outside of architecture code.

> 
> $ grep -lr davinci_aemif_timing .
> ./arch/arm/mach-davinci/board-dm644x-evm.c
> ./arch/arm/mach-davinci/board-dm646x-evm.c
> ./arch/arm/mach-davinci/board-da850-evm.c
> ./arch/arm/mach-davinci/include/mach/aemif.h
> ./arch/arm/mach-davinci/include/mach/nand.h
> ./arch/arm/mach-davinci/board-da830-evm.c
> ./drivers/mtd/nand/davinci_nand.c
> 
> I do not know the values for this boards for the new parameters.
> How to proceed? Do you know this values? Or is it Ok, if I add in

If we add a new API, there won't be a need to touch existing
board code.

> arch/arm/mach-davinci/include/mach/aemif.h
> a "#define AEMIF_VALUE_NOT USED 0xff" and if the new value is set to
> this I don't change this setting in the register?
> 
> bye,
> Heiko

Thanks,
Sekhar
