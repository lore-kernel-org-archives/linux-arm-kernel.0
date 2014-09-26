From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Sep 2014 09:57:14 +0800
Subject: [PATCH v3] ARM: ls1021a: add gating clocks to IP blocks.
In-Reply-To: <e44a1930e8de43ec8beb6e60fa9c1e9e@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1411476275-9164-1-git-send-email-Li.Xiubo@freescale.com>
 <20140925085403.GG6405@dragon>
 <e44a1930e8de43ec8beb6e60fa9c1e9e@BY2PR0301MB0613.namprd03.prod.outlook.com>
Message-ID: <20140926015713.GG21077@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 05:22:29PM +0800, Xiubo Li-B47053 wrote:
...
> > > +	clks[LS1021A_CLK_FLEXTIMER1_EN] = ls1021a_clk_gate("flextimer1_en",
> > > +						"dummy", DCFG_CCSR_DEVDISR5,
> > > +						ls1021a_clk_shift(31));
> > 
> > So "dummy" and ls1021a_clk_shift() are two common things for every
> > single call of ls1021a_clk_gate().  Can we handle them in
> > ls1021a_clk_gate() wrapper, so that we can make these calls a bit
> > shorter?
> > 
> 
> There one gate has one parent.

Ah, yes.  I missed that.

> If the 'big-endian' will as default, I think ls1021a_clk_gate() could be handled
> In ls1021a_clk_gate() wrapper to simplify the code.

Yes, that's what I meant.

...

> > > +static inline struct clk *ls1021a_clk_gate(const char *name, const char
> > *parent,
> > > +		void __iomem *reg, u8 shift)
> > > +{
> > > +	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT |
> > 
> > As the parent of the clocks registered by this function is "dummy" from
> > what I see, what is the point of setting flag CLK_SET_RATE_PARENT then?
> > 
> > > +			CLK_IGNORE_UNUSED, reg,	shift,
> > 
> > Why flag CLK_IGNORE_UNUSED?
> > 
> 
> As the SoC reference manual all the IP blocks will be enabled when powered up.
> But the Linux OS will disable all the IP blocks' clocks as default without this.
> 
> For now, this gate driver will only used for PM support of some IP blocks. For the
> Others needed to be enabled as default.

Ok, got it. I'm fine with the flag then, and we can remove it after all
those client devices manage their clocks well.

Shawn
