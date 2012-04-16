From: Hong.Xu@atmel.com (Xu, Hong)
Date: Mon, 16 Apr 2012 02:35:11 +0000
Subject: [PATCH 3/4] AT91: Add machine files for AT91SAM9N12 SoC
In-Reply-To: <4F8853EE.9000809@atmel.com>
References: <1334211996-31572-1-git-send-email-hong.xu@atmel.com>
 <1334211996-31572-4-git-send-email-hong.xu@atmel.com>
 <4F8853EE.9000809@atmel.com>
Message-ID: <A92DB5DF46DBC241980A99BFD8A00AEE0F62966C@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Nicolas Ferre [mailto:nicolas.ferre at atmel.com]
> Sent: Saturday, April 14, 2012 12:27 AM
> To: Xu, Hong
> Cc: plagnioj at jcrosoft.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 3/4] AT91: Add machine files for AT91SAM9N12 SoC
> 
> On 04/12/2012 08:26 AM, Hong Xu :
> > Signed-off-by: Hong Xu <hong.xu@atmel.com>
> > ---
> >  arch/arm/mach-at91/Kconfig       |    9 ++
> >  arch/arm/mach-at91/Makefile      |    1 +
> 
> An entry is missing in:
> arch/arm/mach-at91/Makefile.boot
> 

Ok, got it.

> >  arch/arm/mach-at91/at91sam9n12.c |  275
> ++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-at91/board-dt.c    |    1 +
> >  arch/arm/mach-at91/clock.c       |   15 ++-
> >  arch/arm/mach-at91/setup.c       |    6 +
> >  6 files changed, 302 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/arm/mach-at91/at91sam9n12.c
> >
[...]
> > diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
> > index c18d4d3..0a21555 100644
> > --- a/arch/arm/mach-at91/board-dt.c
> > +++ b/arch/arm/mach-at91/board-dt.c
> > @@ -51,6 +51,7 @@ static void __init at91_dt_device_init(void)
> >  static const char *at91_dt_board_compat[] __initdata = {
> >  	"atmel,at91sam9m10g45ek",
> >  	"atmel,at91sam9x5ek",
> > +	"atmel,at91sam9n12ek",
> 
> This chunck is not needed anymore: we will use the generic name
> "atmel,at91sam9"
> 
OK, I won't touch it.

BR,
Eric
> >  	"calao,usb-a9g20",
> >  	NULL
> >  };
> > diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
> > index a0f4d74..46130da 100644
> > --- a/arch/arm/mach-at91/clock.c
> > +++ b/arch/arm/mach-at91/clock.c
> > @@ -57,13 +57,15 @@ void __iomem *at91_pmc_base;
> >
> >  #define cpu_has_800M_plla()	(  cpu_is_at91sam9g20() \
> >  				|| cpu_is_at91sam9g45() \
> > -				|| cpu_is_at91sam9x5())
> > +				|| cpu_is_at91sam9x5() \
> > +				|| cpu_is_at91sam9n12())
> >
> >  #define cpu_has_300M_plla()	(cpu_is_at91sam9g10())
> >
> >  #define cpu_has_pllb()		(!(cpu_is_at91sam9rl() \
> >  				|| cpu_is_at91sam9g45() \
> > -				|| cpu_is_at91sam9x5()))
> > +				|| cpu_is_at91sam9x5() \
> > +				|| cpu_is_at91sam9n12()))
> >
> >  #define cpu_has_upll()		(cpu_is_at91sam9g45() \
> >  				|| cpu_is_at91sam9x5())
> > @@ -77,12 +79,15 @@ void __iomem *at91_pmc_base;
> >  				|| cpu_is_at91sam9x5()))
> >
> >  #define cpu_has_plladiv2()	(cpu_is_at91sam9g45() \
> > -				|| cpu_is_at91sam9x5())
> > +				|| cpu_is_at91sam9x5() \
> > +				|| cpu_is_at91sam9n12())
> >
> >  #define cpu_has_mdiv3()		(cpu_is_at91sam9g45() \
> > -				|| cpu_is_at91sam9x5())
> > +				|| cpu_is_at91sam9x5() \
> > +				|| cpu_is_at91sam9n12())
> >
> > -#define cpu_has_alt_prescaler()	(cpu_is_at91sam9x5())
> > +#define cpu_has_alt_prescaler()	(cpu_is_at91sam9x5() \
> > +				|| cpu_is_at91sam9n12())
> >
> >  static LIST_HEAD(clocks);
> >  static DEFINE_SPINLOCK(clk_lock);
> > diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> > index 97cc04d..34c9c27 100644
> > --- a/arch/arm/mach-at91/setup.c
> > +++ b/arch/arm/mach-at91/setup.c
> > @@ -142,6 +142,11 @@ static void __init soc_detect(u32 dbgu_base)
> >  		at91_soc_initdata.type = AT91_SOC_SAM9X5;
> >  		at91_boot_soc = at91sam9x5_soc;
> >  		break;
> > +
> > +	case ARCH_ID_AT91SAM9N12:
> > +		at91_soc_initdata.type = AT91_SOC_SAM9N12;
> > +		at91_boot_soc = at91sam9n12_soc;
> > +		break;
> >  	}
> >
> >  	/* at91sam9g10 */
> > @@ -209,6 +214,7 @@ static const char *soc_name[] = {
> >  	[AT91_SOC_SAM9G45]	= "at91sam9g45",
> >  	[AT91_SOC_SAM9RL]	= "at91sam9rl",
> >  	[AT91_SOC_SAM9X5]	= "at91sam9x5",
> > +	[AT91_SOC_SAM9N12]	= "at91sam9n12",
> >  	[AT91_SOC_NONE]		= "Unknown"
> >  };
> >
> 
> Except those little modifications, the 9n12 port seems neat. Thanks for
> doing it.
> 
> Best regards,
> --
> Nicolas Ferre
