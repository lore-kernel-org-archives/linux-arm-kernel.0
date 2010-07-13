From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 Jul 2010 13:21:54 +0900
Subject: [PATCH] ARM: S5PV210: allow clk to use clksrc as parents
In-Reply-To: <AANLkTikf5-KdGju_IcYg8t5ZV3iIzOhr4VdSa104ZZHH@mail.gmail.com>
References: <1278395553-9228-1-git-send-email-myungjoo.ham@samsung.com>
	<027d01cb1f51$99a74780$ccf5d680$%kim@samsung.com>
	<AANLkTimvA_gSxZsrkEWZMLRFl82MsW5tV9g4trFmaMIr@mail.gmail.com>
	<038201cb2169$c92ccbf0$5b8663d0$%kim@samsung.com>
	<AANLkTilbDABhIIIWCtiHLsvQtss8A99XYWyCy0MkihD3@mail.gmail.com>
	<039a01cb2180$d36679b0$7a336d10$%kim@samsung.com>
	<AANLkTikf5-KdGju_IcYg8t5ZV3iIzOhr4VdSa104ZZHH@mail.gmail.com>
Message-ID: <00e501cb2242$eee8a100$ccb9e300$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 

 (snip)

> >>
> > Please refer to below diagram.
> >
> > ------------------------------------
> >           dsys bus
> > ----------------+-------------------
> >                |
> >                |1.clk 'lcd'
> >                |
> >            +---+-----------+
> >            |   | FIMD block|
> >            | +-+           |
> >            | |             |
> >            | | |\          |
> >            | +-|m|         |
> > 2.SCLK_FIMD |   |u|----+    |
> > ------------+---|x|    |    |
> >            |   |/     |    |
> >            |          |    |
> >            +----------+----+
> >                       |
> > inside of SoC          |
> > -----------------------+--------------------------
> > outside of SoC         |
> >                       | 3.clk?
> >                       |
> >               +--------------+
> >               | LCD module   |
> >               +--------------+
> >
> > In clock.c the clk 'lcd' means #1 in above diagram.
> > So you mean clk 'lcd' is #3', maybe confused :-(
> >
> 
> Uh.. yes, I meant #3 by the clk LCD.
> 
> This CLK_GATE_IP - FIMD gates both ACLK_FIMD and SCLK_FIMD at the same
> time; thus, this should be over the MUX of SCLK_FIMD, I thought. (User
> Manual: Clock Controler - Clock Gating Control Register
> (CLK_GATE_IP1)) If we should have a struct clk that represents
> ACLK_FIMD, the clock representing ACLK_FIMD should not directly
> control CLK_GATE_IP1 as CLK_GATE_IP1 gates SCLK_FIMD as well if the
> User Manual is correct.
> 
> If we really need to represent ACLK_FIMD separately, why don't we
> create "aclk_fimd" and let "fimd" or "lcd" become a struct clksrc_clk
> that chooses between aclk_fimd and sclk_fimd? How about this? (and
> other similar clocks)
> 
> Anyway, with this feature, we may now think about calling
> "clk_disable(parent)" when a clk is doing
> "clk_set_parent(another_parent)" if the clk is "clk_enable"d. I'd be
> happy to hear any suggestions and comments on this.

Basically, each clock which is used in each device driver such as lcd
module clock, camemra module clock should be controlled in its device
driver.

Let's say, in the case of camera module clock, FIMC IP has a specific
divider which is used clock dividing for camera module clock. And the
divider which is in FIMC IP has own rate for camera module at that time. So
cannot/no need to define it in the common clock part such as clock.c.

In other words, can't implement set_rate() or get_rate() for camera module
clock in the common clock part, because FIMC IP block has own specific
divider for it.

> 
> E.g.,
> 
> struct clk *a = clk_get("A");
> clk_set_parent(a, clk_A);
> clk_enable(a);
> some ops with a;
> /* we need another clock speed with different source */
> clk_set_parent(a, clk_B);
> some ops with b;
> 
> In this example, we, at least, need to enable clk_B when
> clk_set_parent is called and we'd better clk_disable(clk_A) if
> clk_enable(clk_A) is called at clk_enable(a);
> 
> 

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

(snip)
