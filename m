From: ping.bai@nxp.com (Jacky Bai)
Date: Thu, 22 Feb 2018 09:52:06 +0000
Subject: [PATCH v3 1/4] driver: clk: imx: Add CLK_IS_CRITICAL flag for
 busy diviver and busy mux
In-Reply-To: <20180222094228.GK3217@dragon>
References: <1517968819-12869-1-git-send-email-ping.bai@nxp.com>
 <20180222094228.GK3217@dragon>
Message-ID: <HE1PR04MB31137D8726109678F9B98A9F87CD0@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Subject: Re: [PATCH v3 1/4] driver: clk: imx: Add CLK_IS_CRITICAL flag for busy
> diviver and busy mux
> 
> On Wed, Feb 07, 2018 at 10:00:16AM +0800, Bai Ping wrote:
> > The busy divider and busy mux is actually used by the system critical
> > clocks, so add 'CLK_IS_CRITICAL' to clocks registered with these two type.
> 
> Are there any real world issues you have seen with this CLK_IS_CRITICAL missing
> from these busy clocks?
> 

Previously in our clk driver, the always clocks is enabled by put them in clk_init_on array. So community suggest me to
Add 'CLK_IS_CRITICAL' flags to these clocks and remove the clk_init_on array. As the busy clock don't have CLK_IS_CRITICAL flag and
It seems all the busy clock are system critical, need to be enabled always, so we need to add this flag to the bus clocks if the clk_init_on array is
removed, otherwise, the bus clock will be disable in 'disable unused clk' stage if we don't enable it explicitly.

BR
Jacky Bai
> >
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> 
> s/diviver/divider in the patch subject.
> 
> Shawn
> 
> > ---
> >  drivers/clk/imx/clk-busy.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
> > index 6df3389..9903652 100644
> > --- a/drivers/clk/imx/clk-busy.c
> > +++ b/drivers/clk/imx/clk-busy.c
> > @@ -101,7 +101,7 @@ struct clk *imx_clk_busy_divider(const char *name,
> > const char *parent_name,
> >
> >  	init.name = name;
> >  	init.ops = &clk_busy_divider_ops;
> > -	init.flags = CLK_SET_RATE_PARENT;
> > +	init.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL;
> >  	init.parent_names = &parent_name;
> >  	init.num_parents = 1;
> >
> > @@ -175,7 +175,7 @@ struct clk *imx_clk_busy_mux(const char *name,
> > void __iomem *reg, u8 shift,
> >
> >  	init.name = name;
> >  	init.ops = &clk_busy_mux_ops;
> > -	init.flags = 0;
> > +	init.flags = CLK_IS_CRITICAL;
> >  	init.parent_names = parent_names;
> >  	init.num_parents = num_parents;
> >
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flist
> >
> s.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&data=02%7C01%7
> >
> Cping.bai%40nxp.com%7C6183140614624dfd492f08d579d89d58%7C686ea1d3
> bc2b4
> >
> c6fa92cd99c5c301635%7C0%7C0%7C636548893622897723&sdata=amVo6uZ6
> ra1o9XA
> > xHSRi9cOd%2BuRUV%2BIkrXSbBncE0lA%3D&reserved=0
