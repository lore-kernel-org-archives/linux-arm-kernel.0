From: jonmason@broadcom.com (Jon Mason)
Date: Mon, 12 Oct 2015 13:48:53 -0400
Subject: [PATCH 05/10] clk: iproc: Add PLL base write function
In-Reply-To: <20151010002106.GZ26883@codeaurora.org>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
 <1443826665-17570-6-git-send-email-jonmason@broadcom.com>
 <20151010002106.GZ26883@codeaurora.org>
Message-ID: <20151012174853.GD20867@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 05:21:06PM -0700, Stephen Boyd wrote:
> On 10/02, Jon Mason wrote:
> > diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
> > index e029ab3..a4602aa 100644
> > --- a/drivers/clk/bcm/clk-iproc-pll.c
> > +++ b/drivers/clk/bcm/clk-iproc-pll.c
> > @@ -137,6 +137,18 @@ static int pll_wait_for_lock(struct iproc_pll *pll)
> >  	return -EIO;
> >  }
> >  
> > +static void iproc_pll_write(struct iproc_pll *pll, void __iomem *base,
> > +			    u32 offset, u32 val)
> > +{
> > +	const struct iproc_pll_ctrl *ctrl = pll->ctrl;
> > +
> > +	writel(val, base + offset);
> > +
> > +	if (unlikely(ctrl->flags & IPROC_CLK_NEEDS_READ_BACK &&
> > +		     base == pll->pll_base))
> > +		val = readl(base + offset);
> 
> Is there any point to assign val here?

It is a flush.  The val assignment could be excluded (and thus made
const) if so desired.

Thanks,
Jon

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
