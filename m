From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Feb 2013 18:04:50 +0200
Subject: [RFC/NOT FOR MERGING 1/3] arm: omap: use generic implementation
 if !od
In-Reply-To: <871uch7g15.fsf@linaro.org>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <871uch7g15.fsf@linaro.org>
Message-ID: <20130215160450.GC20334@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Fri, Feb 15, 2013 at 07:28:22AM -0800, Kevin Hilman wrote:
> > @@ -796,13 +796,18 @@ static int __init omap_early_device_register(struct platform_device *pdev)
> >  static int _od_runtime_suspend(struct device *dev)
> >  {
> >  	struct platform_device *pdev = to_platform_device(dev);
> > +	struct omap_device *od = to_omap_device(pdev);
> >  	int ret;
> >  
> >  	ret = pm_generic_runtime_suspend(dev);
> >  
> > +	if (!od)
> > +		goto out;
> > +
> 
> Rather than adding a check for every function, I think you will get the
> effect by simply not hooking up the PM domain.
> 
> IOW, in omap_device_build_from_dt(), conditionalize:
> 
> 	pdev->dev.pm_domain = &omap_device_pm_domain;
> 
> then none of the callbacks will be called in the first place, so they
> won't need to be conditionalized.
> 
> Without a PM domain, they will fallback to the bus level hooks, which in
> this case will be the platform_bus hooks, which will just call the
> pm_generic functions.

good point, let's just sort out the other comments first though ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130215/b39b0723/attachment.sig>
