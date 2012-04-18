From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 18 Apr 2012 08:44:48 +0200
Subject: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
In-Reply-To: <20120418054140.GA17506@avionic-0098.adnet.avionic-design.de>
References: <201204161534.20089.arnd@arndb.de><20120418081746.995724e27bdc726049cd4965@nvidia.com><20120418054140.GA17506@avionic-0098.adnet.avionic-design.de>
Message-ID: <20120418.094448.2234414220947028341.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Wed, 18 Apr 2012 07:41:40 +0200
Message-ID: <20120418054140.GA17506@avionic-0098.adnet.avionic-design.de>

> * PGP Signed by an unknown key
> 
> * Hiroshi Doyu wrote:
> > On Mon, 16 Apr 2012 17:34:19 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > > On Monday 16 April 2012, Hiroshi Doyu wrote:
> > > > What about using "dma-window" property to specify IOVA range in dtsi as below?
> > > > 
> > > > arch/powerpc/platforms/cell/iommu.c:
> > > > 
> > > > 698 static int __init cell_iommu_get_window(struct device_node *np,
> > > > 699                                          unsigned long *base,
> > > > 700                                          unsigned long *size)
> > > > 701 {
> > > > 702         const void *dma_window;
> > > > 703         unsigned long index;
> > > > 704
> > > > 705         /* Use ibm,dma-window if available, else, hard code ! */
> > > > 706         dma_window = of_get_property(np, "ibm,dma-window", NULL);
> > > > 707         if (dma_window == NULL) {          ^^^^^^^^^^^^^^
> > > > 708                 *base = 0;
> > > > 709                 *size = 0x80000000u;
> > > > 710                 return -ENODEV;
> > > > 711         }
> > > > 712
> > > > 713         of_parse_dma_window(np, dma_window, &index, base, size);
> > > > 714         return 0;
> > > > 715 }
> > > > 
> > > 
> > > Yes, that's the right way to do it, but I would use the more generic
> > > "dma-window" name rather than "ibm,dma-window", which was originally
> > > introduced for pseries and for some reason copied into the cell qs2x
> > > firmware.
> > 
> > Which name is better, "dma-window" or "iova-window"?
> > Considering DMA IOMMU mapping API, "dma-window" may sound appropriate to me.
> 
> But the window isn't necessarily used for DMA transfers. I was going to
> propose "aperture", but that doesn't seem quite right since it is a very
> GART-specific term. "iova-window" sounds like the best fit for what it
> really is.

If we can consider IOMMU as one of the implementation of DMA(Direct
Memory Access), the prefix "dma-(window)" may make sense here. Then,
we don't have to introduce a new concept "IO virtual address(iova)" in
addition to the existing "bus address"(?)

Anyway, either name would be ok for me;)
