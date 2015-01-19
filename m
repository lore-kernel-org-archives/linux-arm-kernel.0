From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Jan 2015 18:02:59 +0100
Subject: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops into
 arch_setup_dma_ops
In-Reply-To: <20150119162111.GA7751@ulmo.nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <2253719.6TRpaaEdiI@wuerfel> <20150119162111.GA7751@ulmo.nvidia.com>
Message-ID: <14678444.nef4iEKbzI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 January 2015 17:21:14 Thierry Reding wrote:
> On Mon, Jan 19, 2015 at 04:52:41PM +0100, Arnd Bergmann wrote:
> > On Monday 19 January 2015 13:36:24 Thierry Reding wrote:
> > > On Fri, Jan 16, 2015 at 01:18:21AM +0200, Laurent Pinchart wrote:
> > > > On Thursday 15 January 2015 11:12:17 Will Deacon wrote:
> > > > > On Thu, Jan 15, 2015 at 08:28:44AM +0000, Thierry Reding wrote:
> > > > > > On Wed, Jan 14, 2015 at 10:46:10AM +0000, Will Deacon wrote:
> > > > > > > On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrote:
> > > > > > [...]
> > > > > > 
> > > > > >>> 2) Say you want to use the IOMMU API in your driver, and have an iommu
> > > > > >>> property in your device's DT node. If by chance your IOMMU is
> > > > > >>> registered early, you will already have a mapping automatically
> > > > > >>> created even before your probe function is called. Can this be
> > > > > >>> avoided? Is it even safe?
> > > > > >> 
> > > > > >> Currently, I think you have to either teardown the ops manually or
> > > > > >> return an error from of_xlate. Thierry was also looking at this sort of
> > > > > >> thing, so it might be worth talking to him.
> > > > > > 
> > > > > > I already explained in earlier threads why I think this is a bad idea.
> > > > > > It's completely unnatural for any driver to manually tear down something
> > > > > > that it didn't want set up in the first place. It also means that you
> > > > > > have to carefully audit any users of these IOMMU APIs to make sure that
> > > > > > they do tear down. That doesn't sound like a good incremental approach,
> > > > > > as evidenced by the breakage that Alex and Heiko have encountered.
> > > > > 
> > > > > Well, perhaps we hide that behind a get_iommu API or something. We *do*
> > > > > need this manual teardown step to support things like VFIO, so it makes
> > > > > sense to reuse it for other users too imo.
> > > > > 
> > > > > > The solution for me has been to completely side-step the issue and not
> > > > > > register the IOMMU with the new mechanism at all. That is, there's no
> > > > > > .of_xlate() implementation, which means that the ARM DMA API glue won't
> > > > > > try to be smart and use the IOMMU in ways it's not meant to be used.
> > > > 
> > > > That will break when someone will want to use the same IOMMU type for devices 
> > > > that use the DMA mapping API to hide the IOMMU. That might not be the case for 
> > > > your IOMMU today, but it's pretty fragile, we need to fix it.
> > > 
> > > No, there's absolutely no issue here. It simply means that you can't do
> > > this on Tegra. So far I'm not sure I even see an advantage in using the
> > > IOMMU for devices that don't care about it anyway. Consider the example
> > > of the SD/MMC or HDA. They typically allocate fairly small buffers, the
> > > order of a single page typically. They can simply use memory handed out
> > > by the CMA.
> > > 
> > > So as long as we don't add a .of_xlate() implementation or instantiate
> > > via the IOMMU_OF_DECLARE() mechanism we simply don't support IOMMU-over-
> > > DMA on Tegra.
> > 
> > It breaks as soon as you have a system with memory above the 4GB boundary,
> > which is the whole point of iommus for most users.
> 
> Why does it break? The IOMMU API simply gets a list of pages and gets
> the physical addresses from those pages when it maps them to the IO
> virtual addresses. How is .of_xlate() or of_iommu_configure() related?

Because almost no drivers use the IOMMU API, and they expect the dma-mapping
API to do the right thing independent of the hardware configuration.

> > CMA does not work for streaming mappings, only for the coherent API.
> 
> Why not? And if it doesn't I'm not sure we currently care on Tegra since
> we've gotten away with using CMA just fine so far.

CMA is used as the backing for the dma_alloc_* API. It's impossible to
use it for streaming data that originates from arbitrary page cache
pages, like a send() operation on a user space network socket, or
writing to disk.

	Arnd
