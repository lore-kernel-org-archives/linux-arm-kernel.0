From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 23 Jan 2015 11:11:23 +0100
Subject: [PATCH v2] ARM: at91: fix PM initialization for newer SoCs
In-Reply-To: <D0221EB9-B6B3-4860-83D6-427E3C718193@jcrosoft.com>
References: <1421942584-2364-1-git-send-email-nicolas.ferre@atmel.com>
 <1421942867-11309-1-git-send-email-nicolas.ferre@atmel.com>
 <D0221EB9-B6B3-4860-83D6-427E3C718193@jcrosoft.com>
Message-ID: <20150123101123.GF19922@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/2015 at 15:50:13 +0800, Jean-Christophe PLAGNIOL-VILLARD wrote :
> 
> > On Jan 23, 2015, at 12:07 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > 
> > Newer SoCs: at91sam9x5, at91sam9n12, sama5d3 and sama5d4 embed a DDR controller
> > and have a different PMC status register layout than the at91sam9g45. Create
> > another at91_sam9x5_pm_init() function to match this compatibility.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > ---
> > arch/arm/mach-at91/board-dt-sam9.c  | 20 ++++++++++++++++++++
> > arch/arm/mach-at91/board-dt-sama5.c |  2 +-
> > arch/arm/mach-at91/generic.h        |  2 ++
> > arch/arm/mach-at91/pm.c             |  7 +++++++
> > 4 files changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-at91/board-dt-sam9.c b/arch/arm/mach-at91/board-dt-sam9.c
> > index 0fe1ced608c5..c8252ddac6f0 100644
> > --- a/arch/arm/mach-at91/board-dt-sam9.c
> > +++ b/arch/arm/mach-at91/board-dt-sam9.c
> > @@ -61,3 +61,23 @@ DT_MACHINE_START(at91sam9g45_dt, "Atmel AT91SAM9G45")
> > 	.init_machine	= sam9g45_dt_device_init,
> > 	.dt_compat	= at91_9g45_board_compat,
> > MACHINE_END
> > +
> > +static void __init sam9x5_dt_device_init(void)
> > +{
> > +	at91_sam9x5_pm_init();
> > +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +}
> > +
> > +static const char *at91_9x5_board_compat[] __initconst = {
> > +	"atmel,at91sam9x5",
> > +	"atmel,at91sam9n12",
> > +	NULL
> > +};
> > +
> > +DT_MACHINE_START(at91sam9x5_dt, "Atmel AT91SAM9?)
> sam9? sam9x5
> > +	/* Maintainer: Atmel */
> > +	.map_io		= at91_map_io,
> > +	.init_early	= at91_dt_initialize,
> > +	.init_machine	= sam9x5_dt_device_init,
> > +	.dt_compat	= at91_9x5_board_compat,
> > +MACHINE_END
> 
> why a second START instead of a pdata?
> 
> and create a second dt compatible
> e


The real solution to that is to match the pmc compatible in pm.c


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
