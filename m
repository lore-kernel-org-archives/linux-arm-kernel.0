From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Dec 2014 22:58:47 +0100
Subject: [Linaro-mm-sig] [PATCH v3 18/19] iommu: exynos: init from
 dt-specific callback instead of initcall
In-Reply-To: <3147207.bM49L5sBIQ@avalon>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <2560037.PCKFDiopkL@wuerfel> <3147207.bM49L5sBIQ@avalon>
Message-ID: <2127001.foickmBNkZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 December 2014 18:02:51 Laurent Pinchart wrote:
> On Wednesday 17 December 2014 16:41:33 Arnd Bergmann wrote:
> > On Wednesday 17 December 2014 16:39:02 Laurent Pinchart wrote:
> > > On Wednesday 17 December 2014 15:27:36 Arnd Bergmann wrote:
> > > > On Wednesday 17 December 2014 01:24:42 Laurent Pinchart wrote:
> > > > > If we forbid the IOMMU driver from being compiled as a module can't we
> > > > > just rely on deferred probing ? The bus master driver will just be
> > > > > reprobed after the IOMMU gets probed, like for other devices.
> > > > > 
> > > > > This could fail in case the IOMMU device permanently fails to probe.
> > > > > There
> > > > > would be something very wrong in the system in that case, Enabling the
> > > > > bus
> > > > > masters totally transparently without IOMMU support could not be such
> > > > > a
> > > > > good idea.
> > > > 
> > > > I believe in the majority of cases today, the IOMMU is entirely
> > > > optional.
> > > > There are valid reasons for not including the IOMMU driver in the
> > > > kernel,
> > > > e.g. when you know that all the machines with that driver can DMA to
> > > > all of their RAM and you want to avoid the overhead of IOTLB misses.
> > > 
> > > Should that really be controlled by compiling the IOMMU driver out,
> > > wouldn't it be better to disable the IOMMU devices in DT in that case ?
> > 
> > It's a policy decision that should only depend on the user. Modifying the
> > DT is wrong here IMHO because the device is still connected to the IOMMU
> > in hardware and we should correctly represent that.
> 
> I was thinking about setting status = "disabled" on the IOMMU nodes, not 
> removing the IOMMU references in the bus master nodes.

But that still requires a modification of the DT. The hardware is the
same, so I don't see why we should update the dtb based on kernel
configuration.

	Arnd
