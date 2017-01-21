From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 17:00:09 -0800
Subject: [PATCH v2 04/12] driver: clk: imx: Add clock driver for imx6sll
In-Reply-To: <AM3PR04MB53027B627AE8CEC6D7D0D1B87780@AM3PR04MB530.eurprd04.prod.outlook.com>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-5-git-send-email-ping.bai@nxp.com>
 <20170110003753.GM17126@codeaurora.org>
 <AM3PR04MB5307CB38AA904535AF8D80D87670@AM3PR04MB530.eurprd04.prod.outlook.com>
 <20170112220536.GP17126@codeaurora.org>
 <AM3PR04MB53027B627AE8CEC6D7D0D1B87780@AM3PR04MB530.eurprd04.prod.outlook.com>
Message-ID: <20170121010009.GC8801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13, Jacky Bai wrote:
> > >
> > > The reason why we enable these two clks here is in below commit commit
> > > a5120e89e7e187a91852896f586876c7a2030804
> > > Author: Peter Chen <peter.chen@freescale.com>
> > > Date:   Fri Jan 18 10:38:05 2013 +0800
> > >       ARM i.MX6: change mxs usbphy clock usage
> > >
> > 
> > So can we mark these clks with CLK_IS_CRITICAL flag then instead?
> > Or are they disabled out of the bootloader?
> > 
> 
> Sure, using 'CLK_IS_CRITICAL'  should be ok for clks_init_on clocks.  But for  USBPHY*_GATE, it is
> only enabled when CONIG_USB_MXC_PHY is true.  And another concern is if we need to add CLK_IS_CRITICAL
> flag to clks_init_on clocks, we may need to add new wrapper function to register these critical clock. It is not very good.

Ok so set the critical flag when CONFIG_USB_MXC_PHY is enabled?
That isn't too hard to do.

> 
>  > >
> > > > > +	}
> > > > > +
> > > > > +	/* Lower the AHB clock rate before changing the clock source. */
> > > > > +	clk_set_rate(clks[IMX6SLL_CLK_AHB], 99000000);
> > > > > +
> > > > > +	/* Change periph_pre clock to pll2_bus to adjust AXI rate to 264MHz */
> > > > > +	clk_set_parent(clks[IMX6SLL_CLK_PERIPH_CLK2_SEL],
> > > > clks[IMX6SLL_CLK_PLL3_USB_OTG]);
> > > > > +	clk_set_parent(clks[IMX6SLL_CLK_PERIPH],
> > > > clks[IMX6SLL_CLK_PERIPH_CLK2]);
> > > > > +	clk_set_parent(clks[IMX6SLL_CLK_PERIPH_PRE],
> > > > clks[IMX6SLL_CLK_PLL2_BUS]);
> > > > > +	clk_set_parent(clks[IMX6SLL_CLK_PERIPH],
> > > > > +clks[IMX6SLL_CLK_PERIPH_PRE]);
> > > > > +
> > > > > +	clk_set_rate(clks[IMX6SLL_CLK_AHB], 132000000);
> > > >
> > > > assigned-clocks for rates now? Or perhaps we shouldn't be exposing
> > > > these as clks if they have some sort of complicated rate sequence
> > > > switch that we can't guarantee with the clk_ops we have today.
> > >
> > > These clks will be used by some peripherals, so we need to expose these
> > clocks.
> > > And the above parent and rate swith sequence is not very easy to be
> > > handled in assigned-clocks, So we leave it in this place.
> > >
> > 
> > How do we guarantee that the rate switch doesn't happen later on, requiring
> > this coordinated sequence of clk operations?
> > 
> 
> This clock sequence is used for increasing the AXI and AHB bus clock rate. In normal
> use, it is very rarely that we need to change them again. If we really need to change
> AXI and AHB bus clock later, a similar sequence must be used to do this.
> 

Ok. It feels unsafe, so please make sure no child clocks have the
CLK_SET_RATE_PARENT flag set so we can't randomly change the rate
of this clk outside of this init code.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
