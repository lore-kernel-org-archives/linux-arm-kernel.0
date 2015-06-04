From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 4 Jun 2015 14:02:12 -0700
Subject: [PATCH 0/5] Add Mediatek MT8173 subsystem clocks support
In-Reply-To: <20150529062345.GY6325@pengutronix.de>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <20150528132452.GI26575@pengutronix.de>
 <1432867649.15597.46.camel@mtksdaap41>
 <20150529062345.GY6325@pengutronix.de>
Message-ID: <20150604210212.GM676@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29, Sascha Hauer wrote:
> On Fri, May 29, 2015 at 10:47:29AM +0800, James Liao wrote:
> > Hi Sascha,
> > 
> > > And really the driver matching "mediatek,mt8173-vencsys" should register
> > > the necessary clocks and reset lines and call of_platform_populate on
> > > the subnodes. The driver should also be a real driver, not something
> > > matched by CLK_OF_DECLARE. The "mediatek,mt8173-vencsys" driver now has
> > > the possibility to manage the toplevel vencsys unit, do runtime pm, turn
> > > the whole thing off and on. Using CCF for abstracting these clocks may
> > > be the right thing, but I believe that we should keep the code for the
> > > toplevel vencsys register space together in a single file and not put
> > > the clk bits in drivers/clk/mediatek/mt8173.c, the reset bits in
> > > drivers/reset/ and the remaining misc stuff in drivers/soc/mediatek/.
> > > 
> > > So I think we should have a drivers/soc/mediatek/mtk-vencsys.c which
> > > is a regular driver, calls clk_register() for its clocks, calls
> > > reset_controller_register() for the reset bits, provides plain functions
> > > for the remaining bits which are not handled by any Linux framework.
> > > Finally of_platform_populate will register the child devices.
> > > 
> > > I showed this using the vencsys example, but it's the same for vdecsys,
> > > vencltsys, imgsys and mmsys.
> > 
> > So you agree to manage these subsystem clocks in CCF, but they should be
> > provided by their own (globalcon) drivers, right?
> 
> Yes. I previously got the impression that the subsystem clocks are not
> directly associated to the larbs, but needed to be handled by the larb
> code due to some side effect. Now that I saw that the larbs are directly
> in the subsystem register space it all makes sense.
> 
> Note that the way Mediatek SoCs are designed around sub modules is bit
> unusual and does not fit very well in the Linux directory structure.
> Normally SoCs have a single clocks controller which controls all clocks
> in the SoC. Then you often have a reset controller providing reset lines
> in the SoC. In this case it's clear that the clk driver goes to
> drivers/clk/, the reset controller driver to drivers/reset/. Mediatek
> SoCs instead have several blocks, each with its own clock and reset
> controller. Splitting each block up into parts in drivers/clk/ and
> drivers/reset/ leads to quite a code fragmentation.
> This is my opinion, it would be great to hear something from others.
> Matthias? I'd like to avoid running into a direction that is not
> acceptable in the end.

We already have drivers registering clocks and resets under
drivers/clk, so it's not unheard of. An alternative solution is
to make child devices for the clock part and the reset part at
runtime in the toplevel driver for the vencsys device (don't do
any sort of DT description for this) and use regmap to mediate
the register accesses and locking. That way we can put the clk
driver in drivers/clk/, the reset driver in drivers/reset, etc.
so that logically related code is grouped.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
