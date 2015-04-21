From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 Apr 2015 16:27:47 +0200
Subject: [PATCH v4 09/11] ARM: imx: add imx7d clk tree support
In-Reply-To: <CAHrpEqSuJbAEBDBfVMXdFk-p-xwtwfmHbSw3OsN-2sa9fNmA=A@mail.gmail.com>
References: <1429563933-3129-1-git-send-email-Frank.Li@freescale.com>
 <1429563933-3129-10-git-send-email-Frank.Li@freescale.com>
 <20150421102255.GW6325@pengutronix.de>
 <CAHrpEqSuJbAEBDBfVMXdFk-p-xwtwfmHbSw3OsN-2sa9fNmA=A@mail.gmail.com>
Message-ID: <20150421142747.GD6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 09:15:36AM -0500, Zhi Li wrote:
> On Tue, Apr 21, 2015 at 5:22 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Tue, Apr 21, 2015 at 05:05:31AM +0800, Frank.Li at freescale.com wrote:
> >> From: Frank Li <Frank.Li@freescale.com>
> >>
> >> Add i.MX7D clk tree support.
> >>
> >> +
> >> +     clk_register_clkdev(clks[IMX7D_GPT1_ROOT_CLK], "ipg", "imx-gpt.0");
> >> +     clk_register_clkdev(clks[IMX7D_GPT_3M_CLK], "gpt_3m", "imx-gpt.0");
> 
> This patch just list all clock root in RM.

Maybe, still the two lines above are unused. The timer code only does a
of_clk_get_by_name which will never return the clocks you register
above.

> all clock refine have to wait for Dong Aisheng's RFC clock framework
> change's patch.
> 
> >
> > What are these good for? These shouldn't be here.
> >
> >> +
> >> +     for (i = 0; i < IMX7D_END_CLK; i++)
> >> +             clk_prepare_enable(clks[i]);
> >
> > Hey, no. You enable *all* clocks here which is certainly wrong. They
> > will never be turned off.
> 
> Yes. This patches's purpose is bring up mx7.
> Because imx7 clock design change,  Dong Aisheng send out RFC patch to
> change a little bit framework.
> After that,  we can enable only necessary clock here. Otherwise system
> will halt and block the other part
> upstream.

If that's the case you should state that in the commit message, add a
comment to the code that it needs fixing once Dongs patch is in and
provide a reference to the patch you need.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
