From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 11 Mar 2013 13:35:33 +0100
Subject: [PATCH 4/4] ARM: at91: introduce SAMA5 support
In-Reply-To: <CAGhQ9Vzjhg+js-yQ_E3dLRi7Cc6ZCSiRVhVp_hAtiXob+EKxdg@mail.gmail.com>
References: <1362755638-20092-1-git-send-email-ludovic.desroches@atmel.com>
 <1362755638-20092-5-git-send-email-ludovic.desroches@atmel.com>
 <CAGhQ9VxXf5mrdZwCe1rqqDg-h_oeLfqs4fdw-m3h6P-QSBdn_Q@mail.gmail.com>
 <513a1756.e94aec0a.1f22.6694SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAGhQ9VzY2UKZgxkbY-eO3j2R89W0phERDgpTAFh1Vy+bC0amWA@mail.gmail.com>
 <20130308185625.GF4590@game.jcrosoft.org>
 <CAGhQ9Vzjhg+js-yQ_E3dLRi7Cc6ZCSiRVhVp_hAtiXob+EKxdg@mail.gmail.com>
Message-ID: <20130311123533.GA2001@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:27 Fri 08 Mar     , Joachim Eastwood wrote:
> On 8 March 2013 19:56, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > On 18:18 Fri 08 Mar     , Joachim Eastwood wrote:
> >> On 8 March 2013 17:52, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> 
> <snip>
> 
> >> >>
> >> >> > diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
> >> >> > new file mode 100644
> >> >> > index 0000000..705305e
> >> >> > --- /dev/null
> >> >> > +++ b/arch/arm/mach-at91/board-dt-sama5.c
> >> >> > @@ -0,0 +1,86 @@
> >> >> > +/*
> >> >> > + *  Setup code for SAMA5 Evaluation Kits with Device Tree support
> >> >> > + *
> >> >> > + *  Copyright (C) 2013 Atmel,
> >> >> > + *                2013 Ludovic Desroches <ludovic.desroches@atmel.com>
> >> >> > + *
> >> >> > + * Licensed under GPLv2 or later.
> >> >> > + */
> >> >> > +
> >> >> > +#include <linux/types.h>
> >> >> > +#include <linux/init.h>
> >> >> > +#include <linux/module.h>
> >> >> > +#include <linux/gpio.h>
> >> >> > +#include <linux/micrel_phy.h>
> >> >> > +#include <linux/of.h>
> >> >> > +#include <linux/of_irq.h>
> >> >> > +#include <linux/of_platform.h>
> >> >> > +#include <linux/phy.h>
> >> >> > +
> >> >> > +#include <asm/setup.h>
> >> >> > +#include <asm/irq.h>
> >> >> > +#include <asm/mach/arch.h>
> >> >> > +#include <asm/mach/map.h>
> >> >> > +#include <asm/mach/irq.h>
> >> >> > +
> >> >> > +#include "at91_aic.h"
> >> >> > +#include "generic.h"
> >> >> > +
> >> >> > +
> >> >> > +static const struct of_device_id irq_of_match[] __initconst = {
> >> >> > +
> >> >> > +       { .compatible = "atmel,sama5d3-aic", .data = at91_aic5_of_init },
> >> >> > +       { /*sentinel*/ }
> >> >> > +};
> >> >> > +
> >> >> > +static void __init at91_dt_init_irq(void)
> >> >> > +{
> >> >> > +       of_irq_init(irq_of_match);
> >> >> > +}
> >> >> > +
> >> >> > +static int ksz9021rn_phy_fixup(struct phy_device *phy)
> >> >> > +{
> >> >> > +       int value;
> >> >> > +
> >> >> > +#define GMII_RCCPSR    260
> >> >> > +#define GMII_RRDPSR    261
> >> >> > +#define GMII_ERCR      11
> >> >> > +#define GMII_ERDWR     12
> >> >> > +
> >> >> > +       /* Set delay values */
> >> >> > +       value = GMII_RCCPSR | 0x8000;
> >> >> > +       phy_write(phy, GMII_ERCR, value);
> >> >> > +       value = 0xF2F4;
> >> >> > +       phy_write(phy, GMII_ERDWR, value);
> >> >> > +       value = GMII_RRDPSR | 0x8000;
> >> >> > +       phy_write(phy, GMII_ERCR, value);
> >> >> > +       value = 0x2222;
> >> >> > +       phy_write(phy, GMII_ERDWR, value);
> >> >> > +
> >> >> > +       return 0;
> >> >> > +}
> >> >> > +
> >> >> > +static void __init sama5_dt_device_init(void)
> >> >> > +{
> >> >> > +       if (of_machine_is_compatible("atmel,sama5d3xcm"))
> >> >> > +               phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
> >> >> > +                       ksz9021rn_phy_fixup);
> >> >> > +
> >> >> > +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> >> >> > +}
> >> >> > +
> >> >> > +static const char *sama5_dt_board_compat[] __initdata = {
> >> >> > +       "atmel,sama5",
> >> >> > +       NULL
> >> >> > +};
> >> >> > +
> >> >> > +DT_MACHINE_START(sama5_dt, "Atmel SAMA5 (Device Tree)")
> >> >> > +       /* Maintainer: Atmel */
> >> >> > +       .init_time      = at91sam926x_pit_init,
> >> >> > +       .map_io         = at91_map_io,
> >> >> > +       .handle_irq     = at91_aic5_handle_irq,
> >> >> > +       .init_early     = at91_dt_initialize,
> >> >> > +       .init_irq       = at91_dt_init_irq,
> >> >> > +       .init_machine   = sama5_dt_device_init,
> >> >> > +       .dt_compat      = sama5_dt_board_compat,
> >> >> > +MACHINE_END
> >> >>
> >> >> Do we really need board-dt-sama5.c?
> >> >> Now that we have both irqchip_init and clocksource_of_init it
> >> >> shouldn't be necessary with more than one board-dt.c.
> >> >>
> >> >
> >> > At the beginning, I had the same point of view but we have a new
> >> > architecture, we can't build a single kernel image for both AT91SAM9 and
> >> > SAMA5. So why not splitting it?
> >>
> >> It does add more lines to mach-at91 and I don't see a reason to have
> >> two near identical board-dt files. board-dt could be used for SAMA5
> >> even without irqchip_init and clocksource_of_init so what's the point
> >> in splitting it?
> >>
> >> When the at91 clocksource and irqchip driver are converted/moved we
> >> could support all AT91 SoC from RM9200 to SAMA5 in one board-dt. I
> >> don't see the reason for 3 board-dt files or even 2.
> >>
> >> That we can't build a kernel that supports both ARMv4-5 and ARMv7
> >> doesn't make a difference.
> > my answer is no I do not want to if compatible_is on the c code so no
> > different files
> 
> But you have this already on the above code:
> >> >> > +       if (of_machine_is_compatible("atmel,sama5d3xcm"))
> 
> I don't see the point to have different board-dt files.
> If a board turns out to need lots of specific C code to work I think
> it's fine to have it in its own board file. But right now you are just
> duplicating code unnecessary.
sorry my mind is made NACK

I do want one file per core rm9200/sama9 sama5

no compatible_is and mutilple MACHINE_xx in the same file

Best Regards,
J.
> regards
> Joachim Eastwood
