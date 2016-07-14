From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Jul 2016 07:53:08 +0100
Subject: [PATCH 2/5] remoteproc: core: Add rproc OF look-up functions
In-Reply-To: <20160713191134.GL23833@tuxbot>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
 <1462454983-13168-3-git-send-email-lee.jones@linaro.org>
 <20160713191134.GL23833@tuxbot>
Message-ID: <20160714065308.GA10504@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jul 2016, Bjorn Andersson wrote:

> On Thu 05 May 06:29 PDT 2016, Lee Jones wrote:
> 
> Lee,
> 
> I ran into this topic again while looking into some unrelated things.
> 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > +struct rproc *of_rproc_byindex(struct device_node *np, int index)
> > +{
> > +	struct rproc *rproc;
> > +	struct device_node *rproc_node;
> > +	struct platform_device *pdev;
> > +	struct klist_iter i;
> > +
> > +	if (index < 0)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	rproc_node = of_parse_phandle(np, "rprocs", index);
> > +	if (!rproc_node)
> 
> As I stated before I would like for you to use the existing rproc_list,
> as done in rproc_get_by_phandle() today.
> 
> But as you resend this patch, could you please make this check fallback
> to also checking for "ti,rproc", then simply drop the existing
> rproc_get_by_phandle() and change the call to
> of_rproc_byindex(dev->of_node, 0) in wkup_m3_ipc.c?
> 
> That way we're backwards compatible with the TI wakeup M3, without
> having to maintain the then non-standard generic rproc phandle resolver.

I started working on this yesterday.  Should be with you soon.

> > +		return ERR_PTR(-ENODEV);
> > +
> > +	pdev = of_find_device_by_node(rproc_node);
> > +	if (!pdev)
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	klist_iter_init(&rprocs, &i);
> > +	while ((rproc = next_rproc(&i)) != NULL)
> > +		if (rproc->dev.parent == &pdev->dev)
> > +			break;
> > +	klist_iter_exit(&i);
> > +
> > +	return rproc;
> > +}
> > +EXPORT_SYMBOL(of_rproc_byindex);
> 
> Regards,
> Bjorn

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
