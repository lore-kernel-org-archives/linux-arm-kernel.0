From: mporter@ti.com (Matt Porter)
Date: Thu, 4 Oct 2012 12:35:46 -0400
Subject: [PATCH v3 5/6] ARM: davinci: Add support for PRUSS on DA850
In-Reply-To: <506D7F95.2030401@ti.com>
References: <1349276133-26408-1-git-send-email-mporter@ti.com>
 <1349276133-26408-6-git-send-email-mporter@ti.com>
 <506D7F95.2030401@ti.com>
Message-ID: <20121004163546.GK11149@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2012 at 05:52:45PM +0530, Sekhar Nori wrote:
> On 10/3/2012 8:25 PM, Matt Porter wrote:
> > +static struct clk pruss_clk = {
> > +	.name		= "pruss",
> > +	.parent		= &pll0_sysclk2,
> > +	.lpsc		= DA8XX_LPSC0_PRUSS,
> > +};
> > +
> >  static struct clk uart0_clk = {
> >  	.name		= "uart0",
> >  	.parent		= &pll0_sysclk2,
> > @@ -378,6 +384,7 @@ static struct clk_lookup da850_clks[] = {
> >  	CLK(NULL,		"tptc1",	&tptc1_clk),
> >  	CLK(NULL,		"tpcc1",	&tpcc1_clk),
> >  	CLK(NULL,		"tptc2",	&tptc2_clk),
> > +	CLK(NULL,		"pruss",	&pruss_clk),
> 
> This is actually incorrect since we should use device name rather than
> con_id for matching the clock. If there is just one clock that the
> driver needs, connection id should be NULL. Looking at the driver now,
> the clk_get() call seems to pass a valid device pointer. So, I wonder
> how you are able to look up the clock even with a NULL device name.

I doublechecked the clk_get() find implentation to confirm that I indeed
did get lucky here. Since pruss has only one instance and the clk_find()
implementation looks for the best found match, it's able to find the
clock just by the con_id, though it's not the "best possible" match in
the find implementation...it's the "best found" match.. As you noted,
this is incorrect though for a clock expected to be used from a driver
context so I will address this in the update.

-Matt
