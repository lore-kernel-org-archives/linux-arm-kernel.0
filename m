From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 13 Jul 2010 12:01:45 +0200
Subject: [PATCH] ARM: S5PV210: allow clk to use clksrc as parents
In-Reply-To: <00e501cb2242$eee8a100$ccb9e300$%kim@samsung.com>
References: <1278395553-9228-1-git-send-email-myungjoo.ham@samsung.com>
	<027d01cb1f51$99a74780$ccf5d680$%kim@samsung.com>
	<AANLkTimvA_gSxZsrkEWZMLRFl82MsW5tV9g4trFmaMIr@mail.gmail.com>
	<038201cb2169$c92ccbf0$5b8663d0$%kim@samsung.com>
	<AANLkTilbDABhIIIWCtiHLsvQtss8A99XYWyCy0MkihD3@mail.gmail.com>
	<039a01cb2180$d36679b0$7a336d10$%kim@samsung.com>
	<AANLkTikf5-KdGju_IcYg8t5ZV3iIzOhr4VdSa104ZZHH@mail.gmail.com>
	<00e501cb2242$eee8a100$ccb9e300$%kim@samsung.com>
Message-ID: <006101cb2272$6a54f580$3efee080$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, July 13, 2010 6:22 AM Kukjin Kim wrote:

> MyungJoo Ham wrote:
>  (snip)
> > > Please refer to below diagram.
> > >
> > > ------------------------------------
> > >           dsys bus
> > > ----------------+-------------------
> > >                |
> > >                |1.clk 'lcd'
> > >                |
> > >            +---+-----------+
> > >            |   | FIMD block|
> > >            | +-+           |
> > >            | |             |
> > >            | | |\          |
> > >            | +-|m|         |
> > > 2.SCLK_FIMD |   |u|----+    |
> > > ------------+---|x|    |    |
> > >            |   |/     |    |
> > >            |          |    |
> > >            +----------+----+
> > >                       |
> > > inside of SoC          |
> > > -----------------------+--------------------------
> > > outside of SoC         |
> > >                       | 3.clk?
> > >                       |
> > >               +--------------+
> > >               | LCD module   |
> > >               +--------------+
> > >
> > > In clock.c the clk 'lcd' means #1 in above diagram.
> > > So you mean clk 'lcd' is #3', maybe confused :-(
> > >
> >
> > Uh.. yes, I meant #3 by the clk LCD.
> >
> > This CLK_GATE_IP - FIMD gates both ACLK_FIMD and SCLK_FIMD at the same
> > time; thus, this should be over the MUX of SCLK_FIMD, I thought. (User
> > Manual: Clock Controler - Clock Gating Control Register
> > (CLK_GATE_IP1)) If we should have a struct clk that represents
> > ACLK_FIMD, the clock representing ACLK_FIMD should not directly
> > control CLK_GATE_IP1 as CLK_GATE_IP1 gates SCLK_FIMD as well if the
> > User Manual is correct.
> >
> > If we really need to represent ACLK_FIMD separately, why don't we
> > create "aclk_fimd" and let "fimd" or "lcd" become a struct clksrc_clk
> > that chooses between aclk_fimd and sclk_fimd? How about this? (and
> > other similar clocks)
> >
> > Anyway, with this feature, we may now think about calling
> > "clk_disable(parent)" when a clk is doing
> > "clk_set_parent(another_parent)" if the clk is "clk_enable"d. I'd be
> > happy to hear any suggestions and comments on this.
> 
> Basically, each clock which is used in each device driver such as lcd
> module clock, camera module clock should be controlled in its device
> driver.
> 
> Let's say, in the case of camera module clock, FIMC IP has a specific
> divider which is used clock dividing for camera module clock. And the
> divider which is in FIMC IP has own rate for camera module at that time. So
> cannot/no need to define it in the common clock part such as clock.c.
> 
> In other words, can't implement set_rate() or get_rate() for camera module
> clock in the common clock part, because FIMC IP block has own specific
> divider for it.

Well, this 'problem' occurs at least in the following IP blocks: FIMD, FIMC
and SDHCI. It looks that some common solution is required for these drivers.
In all these 3 IPs the clock we are considering is an 'external' clock - it
is wired out of the IP block to its external peripheral device (lcd display,
camera sensor or mmc/sd card).

In the current drivers that are in mainline, only SDHCI driver changes the
parent clock source and/or the rate. FIMD (s3c-fb) is hardcoded to use host
bus (dsys) clock only (what is a limitation that might be an issue in some
cases).

We can notice that the code for selecting the parent clock in sdhci-s3c is
a bit messy. The parent clock names are passed in platform data, which in
turn need to be defined separately for each SoC type.

IMHO it should be possible to create a some kind of virtual clock, lets name 
it 'ext_hsmmc' (or 'external_hsmmc'). All it's parents should be properly
defined in the clock api. In this case methods like set_rate should check all
possible sources and select the one that gives the closest result, enabling
and disabling relevant parents. This virtual clock might need to have some
additional rate related ops (like get_min and get_max) and some function for
the driver to get the calculated divider and/or parent index (the driver
needs to write these to its registers, which clock api cannot access
directly).

This way we would get 2 clocks:
- a general 'hsmmc', which can be used for enabling and disabling the IP (dsys
  sourced)
- special 'external_hsmmc', which is used for controlling the clk signal
outgoing
  from SDHCI block.

The driver will need to get and enable these 2 clocks, but I don't think it is a
big overhead. Most of the code that is related to 'external' clock should be
there
already and will be simplified with this approach.

What do you think about such solution?

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
