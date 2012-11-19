From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Nov 2012 16:58:56 +0100
Subject: [PATCH 1/2] clk: mvebu: armada 370/XP add clock gating control
 provider for DT
In-Reply-To: <20121119164611.2e754b64@skate>
References: <1353014906-31566-6-git-send-email-andrew@lunn.ch>
 <1353088920-17458-1-git-send-email-gregory.clement@free-electrons.com>
 <1353088920-17458-2-git-send-email-gregory.clement@free-electrons.com>
 <20121117082602.GF24569@lunn.ch>
 <50A75BB4.4070003@free-electrons.com>
 <20121117135435.GA13479@lunn.ch> <20121119164611.2e754b64@skate>
Message-ID: <20121119155856.GL10259@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 04:46:11PM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Sat, 17 Nov 2012 14:54:35 +0100, Andrew Lunn wrote:
> > > > What is the ddr clock for? Does bad things happen if you turn it off?
> > > > Kirkwood has a similar clock, dunit, which i decided not to export,
> > > > since when you turn it off, the whole SoC locks up.
> > > 
> > > Well of course if you code run in DDR then it could be a problem. But
> > > I think it could be useful to turn it off when going to suspend, it
> > > the DDR can do self-refresh. In this case it should be possible to run
> > > the code from SRAM or L2 Cache.
> > 
> > O.K. Just watch out for the lateinit call in the clock framework.
> 
> I don't think there is a problem with the dramclk and the lateinit call
> of the clock framework. The dramclk is a fixed factor clock, and the
> fixed factor clock driver does not implement the ->disable() operation.
> And therefore, the clk_disable_unused() code executed as the lateinit
> call will not be able to disable it:
> 
> 	if (__clk_is_enabled(clk) && clk->ops->disable)
> 		clk->ops->disable(clk->hw);
> 
> So I think we're quite safe with fixed rate clocks and fixed factor
> clocks in that no-one can disable them :-)

Hi Thomas

I don't think we are taking about the same clock. I mean the gate
clock:

28   ddr     DDR Cntrl

not the core clock.

    Andrew
