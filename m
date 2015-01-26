From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Jan 2015 11:09:58 +0000
Subject: [PATCH v5 11/18] iommu: exynos: remove useless device_add/remove
 callbacks
In-Reply-To: <20150126110059.GC30345@8bytes.org>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
 <1422028288-891-12-git-send-email-m.szyprowski@samsung.com>
 <2829552.kzfCU5HyxQ@avalon> <20150126110059.GC30345@8bytes.org>
Message-ID: <20150126110958.GD15598@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 11:00:59AM +0000, Joerg Roedel wrote:
> On Sun, Jan 25, 2015 at 05:38:22PM +0200, Laurent Pinchart wrote:
> > IOMMU groups still seem a bit unclear to me. Will Deacon has nicely explained 
> > what they represent in
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310816.html.
> > The IOMMU core doesn't make groups 
> > mandatory, but requires them in some code paths.
> > 
> > For example the coldplug device add function add_iommu_group() called for all 
> > devices already registered when bus_set_iommu() is called will try to warn of 
> > devices added multiple times with a WARN_ON(dev->iommu_group). Another example 
> > is the iommu_bus_notifier() function which will call the remove_device() 
> > operation only when dev->iommu_group isn't NULL.
> > 
> > I'm thus unsure whether groups should be made mandatory, or whether the IOMMU 
> > core should be fixed to make them really optional (or, third option, whether 
> > there's something I haven't understood properly).
> 
> My plan is to make IOMMU groups mandatory. I am currently preparing and
> RFC patch-set to introduce default-domains (which will be per group). So
> when all IOMMU drivers are converted to make use of default domains the
> iommu groups will be mandatory.

That makes sense to me, too. I think we should also consider extending the
generic IOMMU device-tree binding to describe groups so that they can be
instantiated by core code, without each driver having to work things out
for itself.

Will
