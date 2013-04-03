From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 03 Apr 2013 12:59:13 -0700
Subject: [PATCH] ARM: mvebu: Use common of_clk_init() function
In-Reply-To: <20130403004332.8177.71536@quantum>
References: <20130402130236.683fa734@armhf> <20130403004332.8177.71536@quantum>
Message-ID: <20130403195913.3383.82857@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mike Turquette (2013-04-02 17:43:32)
> Quoting Jean-Francois Moine (2013-04-02 04:02:36)
> > The use common of_clk_init() function simplifies the clock initialization
> > and adds handling of the DT "fixed-clock".
> > 
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> 
> This is a nice change.  Taken into clk-next.
> 

When I applied this patch I modified the $SUBJECT line as:

clk: mvebu: Use common of_clk_init() function

Regards,
Mike

> Regards,
> Mike
> 
> > ---
> >  drivers/clk/mvebu/clk-cpu.c |   17 ++---------------
> >  drivers/clk/mvebu/clk-cpu.h |   22 ----------------------
> >  drivers/clk/mvebu/clk.c     |    6 +-----
> >  3 files changed, 3 insertions(+), 42 deletions(-)
> >  delete mode 100644 drivers/clk/mvebu/clk-cpu.h
> > 
> > diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
> > index 9dd2551..b0fbc07 100644
> > --- a/drivers/clk/mvebu/clk-cpu.c
> > +++ b/drivers/clk/mvebu/clk-cpu.c
> > @@ -16,7 +16,6 @@
> >  #include <linux/io.h>
> >  #include <linux/of.h>
> >  #include <linux/delay.h>
> > -#include "clk-cpu.h"
> >  
> >  #define SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET    0x0
> >  #define SYS_CTRL_CLK_DIVIDER_VALUE_OFFSET   0xC
> > @@ -173,17 +172,5 @@ clks_out:
> >         kfree(cpuclk);
> >  }
> >  
> > -static const __initconst struct of_device_id clk_cpu_match[] = {
> > -       {
> > -               .compatible = "marvell,armada-xp-cpu-clock",
> > -               .data = of_cpu_clk_setup,
> > -       },
> > -       {
> > -               /* sentinel */
> > -       },
> > -};
> > -
> > -void __init mvebu_cpu_clk_init(void)
> > -{
> > -       of_clk_init(clk_cpu_match);
> > -}
> > +CLK_OF_DECLARE(armada_xp_cpu_clock, "marvell,armada-xp-cpu-clock",
> > +                                        of_cpu_clk_setup);
> > diff --git a/drivers/clk/mvebu/clk-cpu.h b/drivers/clk/mvebu/clk-cpu.h
> > deleted file mode 100644
> > index 08e2aff..0000000
> > --- a/drivers/clk/mvebu/clk-cpu.h
> > +++ /dev/null
> > @@ -1,22 +0,0 @@
> > -/*
> > - * Marvell MVEBU CPU clock handling.
> > - *
> > - * Copyright (C) 2012 Marvell
> > - *
> > - * Gregory CLEMENT <gregory.clement@free-electrons.com>
> > - *
> > - * This file is licensed under the terms of the GNU General Public
> > - * License version 2.  This program is licensed "as is" without any
> > - * warranty of any kind, whether express or implied.
> > - */
> > -
> > -#ifndef __MVEBU_CLK_CPU_H
> > -#define __MVEBU_CLK_CPU_H
> > -
> > -#ifdef CONFIG_MVEBU_CLK_CPU
> > -void __init mvebu_cpu_clk_init(void);
> > -#else
> > -static inline void mvebu_cpu_clk_init(void) {}
> > -#endif
> > -
> > -#endif
> > diff --git a/drivers/clk/mvebu/clk.c b/drivers/clk/mvebu/clk.c
> > index 855681b..29f10fb 100644
> > --- a/drivers/clk/mvebu/clk.c
> > +++ b/drivers/clk/mvebu/clk.c
> > @@ -10,18 +10,14 @@
> >   * warranty of any kind, whether express or implied.
> >   */
> >  #include <linux/kernel.h>
> > -#include <linux/clk.h>
> >  #include <linux/clk-provider.h>
> > -#include <linux/of_address.h>
> > -#include <linux/clk/mvebu.h>
> >  #include <linux/of.h>
> >  #include "clk-core.h"
> > -#include "clk-cpu.h"
> >  #include "clk-gating-ctrl.h"
> >  
> >  void __init mvebu_clocks_init(void)
> >  {
> >         mvebu_core_clk_init();
> >         mvebu_gating_clk_init();
> > -       mvebu_cpu_clk_init();
> > +       of_clk_init(NULL);
> >  }
> > -- 
> > 1.7.10.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
