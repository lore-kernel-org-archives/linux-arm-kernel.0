From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 Aug 2016 19:04:56 +0200
Subject: [PATCH 5/5] misc: sram: add Atmel securam support
In-Reply-To: <1472661937.9330.8.camel@pengutronix.de>
References: <20160831161108.8780-1-alexandre.belloni@free-electrons.com>
 <20160831161108.8780-6-alexandre.belloni@free-electrons.com>
 <1472661937.9330.8.camel@pengutronix.de>
Message-ID: <20160831170456.c7rm3h7kpqor5evg@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/08/2016 at 18:45:37 +0200, Philipp Zabel wrote :
> Hi Alexandre,
> 
> Am Mittwoch, den 31.08.2016, 18:11 +0200 schrieb Alexandre Belloni:
> > The Atmel secure SRAM is connected to a security module and may be erased
> > automatically under certain conditions. For that reason, it is necessary to
> > wait for the security module to flag that SRAM accesses are allowed before
> > accessing it.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >  drivers/misc/sram.c | 52 +++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 45 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> > index f84b53d6ce50..8d411c64d07f 100644
> > --- a/drivers/misc/sram.c
> > +++ b/drivers/misc/sram.c
> > @@ -19,12 +19,16 @@
> >   */
> >  
> >  #include <linux/clk.h>
> > +#include <linux/delay.h>
> >  #include <linux/genalloc.h>
> >  #include <linux/io.h>
> >  #include <linux/list_sort.h>
> >  #include <linux/of_address.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> >  #include <linux/slab.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <soc/at91/atmel-secumod.h>
> >  
> >  #define SRAM_GRANULARITY	32
> >  
> > @@ -334,12 +338,43 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
> >  	return ret;
> >  }
> >  
> > +static int atmel_securam_wait(void)
> > +{
> > +	struct regmap *regmap;
> > +	unsigned long timeout = jiffies + HZ;
> 
> Can this really take up to a second?
> 

Well, probably not but it can take some time. My understanding is that
it can take up to almost half a second (4096 bytes at 8kHz). But quite
frankly, by the time linux is starting, the delay has probably already
expired so the while loop is unlikely to run.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
