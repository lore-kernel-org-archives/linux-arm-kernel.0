From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 23 Mar 2017 02:33:06 +0800
Subject: [PATCH 1/8] soc: imx: gpc: fix gpc clk get error handling
In-Reply-To: <20170320080523.GG3443@dragon>
References: <1489990547-1510-1-git-send-email-aisheng.dong@nxp.com>
 <1489990547-1510-2-git-send-email-aisheng.dong@nxp.com>
 <20170320080523.GG3443@dragon>
Message-ID: <20170322183306.GA16264@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 04:05:24PM +0800, Shawn Guo wrote:
> On Mon, Mar 20, 2017 at 02:15:40PM +0800, Dong Aisheng wrote:
> > diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> > index 1e9b3b8..c9bfdfd 100644
> > --- a/drivers/soc/imx/gpc.c
> > +++ b/drivers/soc/imx/gpc.c
> > @@ -143,7 +143,7 @@ static int imx_pgc_get_clocks(struct device *dev, struct imx_pm_domain *domain)
> >  	return 0;
> >  
> >  clk_err:
> > -	for (; i >= 0; i--)
> > +	while (i--)
> >  		clk_put(domain->clk[i]);
> 
> Will clk[0] be put then?
> 

Yes, it is a bit tricky:
See as follows:
while (i--)	<== (i = 1)
	clk_put(domain->clk[i]);	<=== (i = 0)

This code actually is used before until the commit below:
721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
So i did not change it.

Regards
Dong Aisheng

> Shawn
> 
> >  
> >  	return ret;
