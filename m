From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Apr 2011 16:28:39 +0200
Subject: [PATCH 2/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <20110419135003.GR2192@amd.com>
References: <1303118804-5575-1-git-send-email-m.szyprowski@samsung.com>
	<201104191449.50824.arnd@arndb.de> <20110419135003.GR2192@amd.com>
Message-ID: <201104191628.39446.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 April 2011, Roedel, Joerg wrote:
> On Tue, Apr 19, 2011 at 08:49:50AM -0400, Arnd Bergmann wrote:
> > > Ok, it looks I don't fully get how this iommu.h should be used. It looks
> > > that there can be only one instance of iommu ops registered in the system,
> > > so only one iommu driver can be activated. You are right that the iommu
> > > driver has to be registered on first probe().
> > 
> > That is a limitation of the current implementation. We might want to
> > change that anyway, e.g. to handle the mali IOMMU along with yours.
> > I believe the reason for allowing only one IOMMU type so far has been
> > that nobody required more than one. As I mentioned, the IOMMU API is
> > rather new and has not been ported to much variety of hardware, unlike
> > the dma-mapping API, which does support multiple different IOMMUs
> > in a single system.
> 
> The current IOMMU-API interface is very simple. It delegates the
> selection of the particular IOMMU device to the IOMMU driver. Handle
> this selection above the IOMMU driver is a complex thing to do. We will
> need some kind of generic IOMMU support in the device-core and
> attach IOMMUs to device sub-trees.
> 
> A simpler and less intrusive solution is to implement some wrapper code
> which dispatches the IOMMU-API calls to the IOMMU driver implementation
> required for that device.

Right. We already do that for the dma-mapping API on some architectures,
and I suppose we can consolidate the mechanism here, possibly into
something that ends up in the common struct device rather than in
the archdata.

> > > I think it might be beneficial to describe a bit more our hardware 
> > > (Exynos4 platform). There are a number of multimedia blocks. Each has it's
> > > own IOMMU controller. Each IOMMU controller has his own set of hardware
> > > registers and irq. There is also a GPU unit (Mali) which has it's own
> > > IOMMU hardware, incompatible with the SYSMMU, so right now it is ignored.
> > > 
> > > The multimedia blocks are modeled as platform devices and are independent
> > > of platform type (same multimedia blocks can be found on other Samsung
> > > machines, like for example s5pv210/s5pc110), see arch/arm/plat-s5p/dev-*.c
> > > and arch/arm/plat-samsung/dev-*.c.
> 
> Question: Does every platform device has a different type of IOMMU? Or
> are the IOMMUs on all of these platform devices similar enough to be
> handled by a single driver?

As Marek explained in the thread before you got on Cc, they are all the
same, except for the graphics core (Mali) that has a different one but
currently disables that.

> > > For the drivers the most important are the following functions:
> > > iommu_{attach,detach}_device(struct iommu_domain *domain, struct device *dev);
> 
> Right, and each driver can allocate its own domains.

For the cases that use the normal dma-mapping API, I guess there only
needs to be one domain to cover the kernel, which can then be hidden
in the driver provides the dma_map_ops based on an iommu_ops.

> > It's not quite how the domains are meant to be used. In the AMD IOMMU
> > that the API is based on, any number of devices can share one domain,
> > and devices might be able to have mappings in multiple domains.
> 
> Yes, any number of devices can be assigned to one domain, but each
> device only belongs to one domain at each point in time. But it is
> possible to detach a device from one domain and attach it to another.

I was thinking of the SR-IOV case, where a single hardware device is
represented as multiple logical devices. As far as I understand, each
logical devices can only belong to one domain, but they don't all have to
be the same.

	Arnd
