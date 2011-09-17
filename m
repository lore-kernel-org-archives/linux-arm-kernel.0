From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Sep 2011 17:27:01 +0100
Subject: [PATCH v2 1/2] OMAP: omap_device: Add
	omap_device_[alloc|delete] for DT integration
In-Reply-To: <20110917160514.GU3523@ponder.secretlab.ca>
References: <1316184199-12599-1-git-send-email-b-cousson@ti.com>
	<1316184199-12599-2-git-send-email-b-cousson@ti.com>
	<20110917160514.GU3523@ponder.secretlab.ca>
Message-ID: <20110917162701.GB16591@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2011 at 10:05:14AM -0600, Grant Likely wrote:
> > +static struct omap_device *omap_device_alloc(struct platform_device *pdev,
> > +					struct omap_hwmod **ohs, int oh_cnt,
> > +					struct omap_device_pm_latency *pm_lats,
> > +					int pm_lats_cnt)
> > +{
> > +	int ret = -ENOMEM;
> > +	struct omap_device *od;
> > +	struct resource *res = NULL;
> > +	int i, res_count;
> > +	struct omap_hwmod **hwmods;
> > +
> > +	od = kzalloc(sizeof(struct omap_device), GFP_KERNEL);
> 
> possible enhancement:  devm_kzalloc() perhaps?  Would simplify the cleanup
> paths.

Are you sure about that - have you thought about the lifetime issues?
devm_*() lifetime is supposed to be from driver binding to driver
unbinding.

The lifetime of 'omap_device' appears to be from device creation to
device destruction, which is different from what devm_*() gives you.

So, using devm_*() will result in the 'omap_device' being destroyed
when a driver is unbound - and presumably an oops if its attempted to
be re-bound later (because the 'omap_device' structure will have been
freed.)
