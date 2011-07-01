From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Jul 2011 22:38:47 +0200
Subject: [PATCH 1/8] at91: introduce commom AT91_BASE_SYS
In-Reply-To: <20110701172514.GG14408@game.jcrosoft.org>
References: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
	<201107011746.57026.arnd@arndb.de>
	<20110701172514.GG14408@game.jcrosoft.org>
Message-ID: <201107012238.47355.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 July 2011 19:25:14 Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:46 Fri 01 Jul     , Arnd Bergmann wrote:
> > As a general comment, please start with a cover-letter (the PATCH 0/8)
> > email that describes the overall intention of the series and holds
> > the combined diffstat.
>
> this detect dynamicly the soc and factorize the init of AT91 in one place
> as all the soc have the same init
> 
> this patch series is just a first step as switch to the CLKDEV

Ok, thanks for the explanation.

> On 17:46 Fri 01 Jul     , Arnd Bergmann wrote:
> > 
> > I think it would be easier to turn this around and have a very short
> > function here:
> > 
> > void __init at91_map_io(void)
> > {
> > 	/* Map peripherals */
> > 	iotable_init(&at91_io_desc, 1);
> > }
> > 
> > and then change each of the soc specific functions into
> > 
> > 
> > -void __init at91cap9_map_io(void)
> > +static void __init at91cap9_map_io(void)
> >  {
> > -       /* Map peripherals */
> > -       iotable_init(at91cap9_io_desc, ARRAY_SIZE(at91cap9_io_desc));
> > +	at91_boot_soc = at91cap9_soc;
> > +	at91_map_io();
> > +       iotable_init(at91cap9_sram_desc, ARRAY_SIZE(at91cap9_sram_desc));
> >  }
> > 
> > This would keep the per-soc code local and still consolidate the
> > common code without introducing (IMHO ugly) cpu_is_at91...() checks.
> we detect it this is the whole idea
> 
> so not this way is the oposit of the whole idea

I wouldn't say the whole idea. An major part of your patches is to use the
fact that you know the SoC, which is definitely useful. The change I mentioned
above would only provide a simpler way to get to that information, based
on the fact that you already know the specific board.

What is the advantage that you see of using the CPU register over a pointer
from the machine_desc?

Obviously, it doesn't matter much any more once you do the conversion to
device tree an end up with a of match table like

struct of_device_id at91_match_table[] = {
	{ .compatible = "atmel,at91cap9",  .data = &at91cap9_soc, },
	{ .compatible = "atmel,at91rm9200, .data = &at91rm9200_soc, },
	...
};

	Arnd
