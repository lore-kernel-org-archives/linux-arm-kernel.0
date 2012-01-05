From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 5 Jan 2012 22:24:09 +0800
Subject: [PATCH 2/2] arm/imx6q: add cko1 clock
In-Reply-To: <20120105135311.GF1729@S2101-09.ap.freescale.net>
References: <1325733074-10749-1-git-send-email-richard.zhao@linaro.org>
 <1325733074-10749-2-git-send-email-richard.zhao@linaro.org>
 <20120105135311.GF1729@S2101-09.ap.freescale.net>
Message-ID: <20120105142409.GA26848@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 09:53:13PM +0800, Shawn Guo wrote:
> On Thu, Jan 05, 2012 at 11:11:14AM +0800, Richard Zhao wrote:
> > imx6q-sabrelite board use it as audio codec clock.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  arch/arm/mach-imx/clock-imx6q.c |   74 ++++++++++++++++++++++++++++++++++++++-
> >  1 files changed, 73 insertions(+), 1 deletions(-)
> > 
> It mostly looks good.  A couple of comments below though:
> 
> * Again, use "ARM: imx6q: ..." for patch subject in this case.
ok
> 
> * To reflect the CKO hardware hierarchy, we should probably have 3 clks
>   there, cko_clk, cko1_clk and cko2_clk, and have cko_clk be the parent
>   of the later two, as cko1_cko2_sel bit was designed for this.
The origin idea is to only add clocks I used. cko1_cko2_sel is default
zero, so I didn't add cko2. It's fine if you need all cko1/cko2.
> 
> [...]
> 
> > @@ -1680,7 +1734,7 @@ static int _clk_set_parent(struct clk *clk, struct clk *parent)
> >  			break;
> >  		i++;
> >  	}
> > -	if (!m->parents[i])
> > +	if (!m->parents[i] || m->parents[i] == &dummy_clk)
> 
> Is this change necessarily included in this patch?
Yes. cko clocks always may have many parents. Some of them we never use.
So there's a hole in the parents array.
For cko1, we don't have video_27M_clk_root.

Thanks
Richard
> 
> Regards,
> Shawn
> 
> >  		return -EINVAL;
> >  
> >  	val = readl_relaxed(m->reg);
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
