From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 8 Mar 2013 17:52:32 +0100
Subject: [PATCH 4/4] ARM: at91: introduce SAMA5 support
In-Reply-To: <CAGhQ9VxXf5mrdZwCe1rqqDg-h_oeLfqs4fdw-m3h6P-QSBdn_Q@mail.gmail.com>
References: <1362755638-20092-1-git-send-email-ludovic.desroches@atmel.com>
 <1362755638-20092-5-git-send-email-ludovic.desroches@atmel.com>
 <CAGhQ9VxXf5mrdZwCe1rqqDg-h_oeLfqs4fdw-m3h6P-QSBdn_Q@mail.gmail.com>
Message-ID: <20130308165232.GE2553@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

On Fri, Mar 08, 2013 at 05:40:27PM +0100, Joachim Eastwood wrote:
> On 8 March 2013 16:13,  <ludovic.desroches@atmel.com> wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >
> > This patch introduces the SAMA5 support. It also updates the PMC driver to
> > manage clock division which is a requirement since some peripherals can't work
> > at the bus frequency on SAMA5.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > ---
> >  arch/arm/boot/dts/Makefile                 |    5 +
> >  arch/arm/boot/dts/sama5d3.dtsi             | 1031 ++++++++++++++++++++++++++++
> >  arch/arm/boot/dts/sama5d31ek.dts           |   51 ++
> >  arch/arm/boot/dts/sama5d33ek.dts           |   44 ++
> >  arch/arm/boot/dts/sama5d34ek.dts           |   61 ++
> >  arch/arm/boot/dts/sama5d35ek.dts           |   56 ++
> >  arch/arm/boot/dts/sama5d3xcm.dtsi          |   91 +++
> >  arch/arm/boot/dts/sama5d3xdm.dtsi          |   42 ++
> >  arch/arm/boot/dts/sama5d3xmb.dtsi          |  166 +++++
> >  arch/arm/configs/sama5_defconfig           |  181 +++++
> >  arch/arm/mach-at91/Kconfig                 |   34 +
> >  arch/arm/mach-at91/Makefile                |    4 +
> >  arch/arm/mach-at91/board-dt-sama5.c        |   86 +++
> >  arch/arm/mach-at91/clock.c                 |  109 ++-
> >  arch/arm/mach-at91/clock.h                 |    2 +
> >  arch/arm/mach-at91/include/mach/at91_pmc.h |   18 +-
> >  arch/arm/mach-at91/include/mach/cpu.h      |   20 +
> >  arch/arm/mach-at91/include/mach/sama5d3.h  |   73 ++
> >  arch/arm/mach-at91/sama5d3.c               |  377 ++++++++++
> >  arch/arm/mach-at91/setup.c                 |   27 +
> >  arch/arm/mach-at91/soc.h                   |    5 +
> >  21 files changed, 2454 insertions(+), 29 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/sama5d3.dtsi
> >  create mode 100644 arch/arm/boot/dts/sama5d31ek.dts
> >  create mode 100644 arch/arm/boot/dts/sama5d33ek.dts
> >  create mode 100644 arch/arm/boot/dts/sama5d34ek.dts
> >  create mode 100644 arch/arm/boot/dts/sama5d35ek.dts
> >  create mode 100644 arch/arm/boot/dts/sama5d3xcm.dtsi
> >  create mode 100644 arch/arm/boot/dts/sama5d3xdm.dtsi
> >  create mode 100644 arch/arm/boot/dts/sama5d3xmb.dtsi
> >  create mode 100644 arch/arm/configs/sama5_defconfig
> >  create mode 100644 arch/arm/mach-at91/board-dt-sama5.c
> >  create mode 100644 arch/arm/mach-at91/include/mach/sama5d3.h
> >  create mode 100644 arch/arm/mach-at91/sama5d3.c
> 
> <snip>
> 
> > --- a/arch/arm/mach-at91/Kconfig
> > +++ b/arch/arm/mach-at91/Kconfig
> > @@ -29,6 +29,14 @@ config SOC_AT91SAM9
> >         select MULTI_IRQ_HANDLER
> >         select SPARSE_IRQ
> >
> > +config SOC_SAMA5
> > +       bool
> > +       select AT91_SAM9_TIME
> > +       select CPU_V7
> > +       select GENERIC_CLOCKEVENTS
> > +       select MULTI_IRQ_HANDLER
> > +       select SPARSE_IRQ
> > +
> >  menu "Atmel AT91 System-on-Chip"
> >
> >  choice
> > @@ -41,10 +49,28 @@ config SOC_SAM_V4_V5
> >           Select this if you are using one of Atmel's AT91SAM9, AT91RM9200
> >           or AT91X40 SoC.
> >
> > +config SOC_SAM_V7
> > +       bool "Cortex A5"
> > +       help
> > +         Select this if you are using one of Atmel's SAMA5D3 SoC.
> > +
> >  endchoice
> >
> >  comment "Atmel AT91 Processor"
> >
> > +if SOC_SAM_V7
> > +config SOC_SAMA5D3
> > +       bool "SAMA5D3 family"
> > +       depends on SOC_SAM_V7
> > +       select SOC_SAMA5
> > +       select HAVE_FB_ATMEL
> > +       select HAVE_NET_MACB
> 
> Remove HAVE_NET_MACB. It doesn't exist elsewhere in the kernel now.
>

Good point, thx.
 
> > +       select HAVE_AT91_DBGU1
> > +       help
> > +         Select this if you are using one of Atmel's SAMA5D3 family SoC.
> > +         This support covers SAMA5D31, SAMA5D33, SAMA5D34, SAMA5D35.
> > +endif
> > +
> 
> <snip>
> 
> > diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
> > new file mode 100644
> > index 0000000..705305e
> > --- /dev/null
> > +++ b/arch/arm/mach-at91/board-dt-sama5.c
> > @@ -0,0 +1,86 @@
> > +/*
> > + *  Setup code for SAMA5 Evaluation Kits with Device Tree support
> > + *
> > + *  Copyright (C) 2013 Atmel,
> > + *                2013 Ludovic Desroches <ludovic.desroches@atmel.com>
> > + *
> > + * Licensed under GPLv2 or later.
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/gpio.h>
> > +#include <linux/micrel_phy.h>
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/phy.h>
> > +
> > +#include <asm/setup.h>
> > +#include <asm/irq.h>
> > +#include <asm/mach/arch.h>
> > +#include <asm/mach/map.h>
> > +#include <asm/mach/irq.h>
> > +
> > +#include "at91_aic.h"
> > +#include "generic.h"
> > +
> > +
> > +static const struct of_device_id irq_of_match[] __initconst = {
> > +
> > +       { .compatible = "atmel,sama5d3-aic", .data = at91_aic5_of_init },
> > +       { /*sentinel*/ }
> > +};
> > +
> > +static void __init at91_dt_init_irq(void)
> > +{
> > +       of_irq_init(irq_of_match);
> > +}
> > +
> > +static int ksz9021rn_phy_fixup(struct phy_device *phy)
> > +{
> > +       int value;
> > +
> > +#define GMII_RCCPSR    260
> > +#define GMII_RRDPSR    261
> > +#define GMII_ERCR      11
> > +#define GMII_ERDWR     12
> > +
> > +       /* Set delay values */
> > +       value = GMII_RCCPSR | 0x8000;
> > +       phy_write(phy, GMII_ERCR, value);
> > +       value = 0xF2F4;
> > +       phy_write(phy, GMII_ERDWR, value);
> > +       value = GMII_RRDPSR | 0x8000;
> > +       phy_write(phy, GMII_ERCR, value);
> > +       value = 0x2222;
> > +       phy_write(phy, GMII_ERDWR, value);
> > +
> > +       return 0;
> > +}
> > +
> > +static void __init sama5_dt_device_init(void)
> > +{
> > +       if (of_machine_is_compatible("atmel,sama5d3xcm"))
> > +               phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
> > +                       ksz9021rn_phy_fixup);
> > +
> > +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> > +}
> > +
> > +static const char *sama5_dt_board_compat[] __initdata = {
> > +       "atmel,sama5",
> > +       NULL
> > +};
> > +
> > +DT_MACHINE_START(sama5_dt, "Atmel SAMA5 (Device Tree)")
> > +       /* Maintainer: Atmel */
> > +       .init_time      = at91sam926x_pit_init,
> > +       .map_io         = at91_map_io,
> > +       .handle_irq     = at91_aic5_handle_irq,
> > +       .init_early     = at91_dt_initialize,
> > +       .init_irq       = at91_dt_init_irq,
> > +       .init_machine   = sama5_dt_device_init,
> > +       .dt_compat      = sama5_dt_board_compat,
> > +MACHINE_END
> 
> Do we really need board-dt-sama5.c?
> Now that we have both irqchip_init and clocksource_of_init it
> shouldn't be necessary with more than one board-dt.c.
>

At the beginning, I had the same point of view but we have a new
architecture, we can't build a single kernel image for both AT91SAM9 and
SAMA5. So why not splitting it?

Regards

Ludovic
