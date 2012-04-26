From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Apr 2012 10:04:41 +0200
Subject: [PATCH 33/33] ARM: i.MX6: implement clocks using common clock
 framework
In-Reply-To: <20120426071413.GH3852@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <1335367703-19929-34-git-send-email-s.hauer@pengutronix.de>
 <20120426024837.GD28063@b20223-02.ap.freescale.net>
 <20120426064150.GE3852@pengutronix.de>
 <20120426065701.GH28063@b20223-02.ap.freescale.net>
 <20120426071413.GH3852@pengutronix.de>
Message-ID: <20120426080441.GY20478@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 09:14:13AM +0200, Sascha Hauer wrote:
> On Thu, Apr 26, 2012 at 02:57:02PM +0800, Richard Zhao wrote:
> > On Thu, Apr 26, 2012 at 08:41:50AM +0200, Sascha Hauer wrote:
> > > On Thu, Apr 26, 2012 at 10:48:38AM +0800, Richard Zhao wrote:
> > > > The below code is removed from mx6q_clocks_init implicitly.
> > > > Why? If it's reasonable, it needs to be on a separate patch too.
> > > > 
> > > > clk_set_rate(&usdhc1_clk, 49500000);
> > > > clk_set_rate(&usdhc2_clk, 49500000);
> > > > clk_set_rate(&usdhc3_clk, 49500000);
> > > > clk_set_rate(&usdhc4_clk, 49500000);
> > > 
> > > Can't say anything to these, probably Shawn has simply lost them while
> > > porting.
> > > 
> > > > 
> > > > clk_set_parent(&cko1_clk, &ahb_clk);
> > > 
> > > Why this? The cko pin has different usecases on each board, mostly I
> > > think for debugging. We shouldn't touch it here.
> > clko1's used by audio codec on many boards.
> > Do you/Shawn think I can add board specific code here with
> > of_machine_is_compatible? I need to add audio codec clkdev. Other places
> > can not get clk pointers.
> 
> Agreed that we need something to adjust/reparent this clock, but adding
> board specific code to this file is not the right thing to do.

BTW I generally wonder how a board (or SoC code) can reparent clocks if
needed. At the moment we need

	clk_get_sys(mux);
	clk_get_sys(new_parent);
	clk_set_parent(mux, new_parent);

The above needs error checking and we need a clkdev for all clocks we want
to reparent + a clkdev for all possible parents.

All this together makes reparenting in practice quite cumbersome. I have
the hope that future additions to the clock framework will make this
easier.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
