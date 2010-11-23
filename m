From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 23 Nov 2010 06:33:24 -0800
Subject: [PATCH 3/3] msm: iommu: Rework clock logic and add IOMMU bus
	clock control
In-Reply-To: <4CEB2FAC.8040305@codeaurora.org>
References: <1290222154-11096-1-git-send-email-stepanm@codeaurora.org>
	<1290222154-11096-4-git-send-email-stepanm@codeaurora.org>
	<1290469909.4258.34.camel@m0nster>  <4CEB2FAC.8040305@codeaurora.org>
Message-ID: <1290522804.9053.14.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-22 at 19:06 -0800, Stepan Moskovchenko wrote:
> On 11/22/2010 3:51 PM, Daniel Walker wrote:
> > On Fri, 2010-11-19 at 19:02 -0800, Stepan Moskovchenko wrote:
> >> Clean up the clock control code in the probe calls, and add
> >> support for controlling the clock for the IOMMU bus
> >> interconnect. With the (proper) clock driver in place, the
> >> clock control logic in the probe function can be made much
> >> cleaner since it does not have to deal with the placeholder
> >> driver anymore.
> >>
> >> Change-Id: I1040bc4e18f4ab4b7cc0dd5fe667f9df83b9f1f5
> > You need to remove this Change-Id ..
> Fixed in v2.
> 
> >
> >> +		pr_err("Could not request memory region: start=%p, len=%d\n",
> >> +							(void *) r->start, len);(void *) r->start, len);
> > You usually just tab over till you get to the " like this,
> >
> > pr_err("Could not request memory region: start=%p, len=%d\n",
> > 	(void *) r->start, len);
> Fixed in v2.
> 
> >>   	drv = platform_get_drvdata(pdev);
> >>   	if (drv) {
> >> -		memset(drv, 0, sizeof(struct msm_iommu_drvdata));
> >> +		if (drv->clk)
> >> +			clk_put(drv->clk);
> >> +		clk_put(drv->pclk);
> >> +		memset(drv, 0, sizeof(*drv));
> > Do you really need the memset ?
> I guess not.. it seemed like good practice to poison the memory in case 
> someone else had a stale reference to it. I guess I can remove them.

The memory allocator already has a poison debugging option. If you
suspect memory issues you can always turn that on.

> >> +	if (ret)
> >> +		goto fail;
> >> +
> >> +	if (drvdata->clk) {
> >> +		ret = clk_enable(drvdata->clk);
> >> +		if (ret) {
> >> +			clk_disable(drvdata->pclk);
> >> +			goto fail;
> >> +		}
> >> +	}
> > You did this in a prior patch also, you could combine them into a single
> > helper function. Maybe do the same for the disable side too.
> That was in a different file (where it gets used much more extensively 
> than just in the one case here). I would rather not make a bunch of my 
> internal stuff visible to the global namespace if I can help it, and 
> it's a trivial enough operation to enable two clocks.

I was meaning making it a static inline inside a header.. You wouldn't
want this to be a global function. If you can it's usually a good idea
to combine code that's similar, that way there's only one place to make
modifications.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
