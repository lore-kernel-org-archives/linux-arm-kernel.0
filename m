From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Jan 2015 12:50:52 +0000
Subject: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
 into arch_setup_dma_ops
In-Reply-To: <20150119124305.GC7312@ulmo.nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <2804479.ZFl06ysk3j@avalon> <54BB58AA.5070407@nvidia.com>
 <5043167.LEiljZnGai@avalon> <20150119124305.GC7312@ulmo.nvidia.com>
Message-ID: <20150119125051.GI32131@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 12:43:06PM +0000, Thierry Reding wrote:
> On Sun, Jan 18, 2015 at 01:18:51PM +0200, Laurent Pinchart wrote:
> > On Sunday 18 January 2015 15:54:34 Alexandre Courbot wrote:
> > > On 01/16/2015 08:18 AM, Laurent Pinchart wrote:
> [...]
> > > > The second way is to implement a mechanism to let drivers signal that they
> > > > want to handle DMA mappings themselves. As the mappings need in the
> > > > general case to be created before the probe function  is called
> > > 
> > > Sorry for being ignorant here, but why is that?
> > 
> > Because a driver can call the DMA mapping API in its probe function, to 
> > allocate DMA coherent memory for instance. We need to ensure that the DMA 
> > mapping IOMMU has set up the required IOMMU ops by that time. As explained 
> > above I don't like the idea of sprinkling explicit calls to initialize IOMMU 
> > support in the vast majority of drivers, especially when they shouldn't be 
> > IOMMU-aware, so we then need to initialize everything that is needed before 
> > the first call to the DMA mapping API.
> 
> The original patch that Hiroshi posted based on my comments was to have
> the driver core call iommu_attach(), which would then set up everything
> needed right before calling into the driver's ->probe(). This works
> quite nicely because by definition the driver can't allocate any DMA
> before ->probe(). And, like you said, this allows deferred probe to be
> used.
> 
> To me it's so obviously the right solution that I remain flabbergasted
> with how much resistance it's received (or how much it's being ignored).

Have you considered reposting the patches based on what we currently have
(which has the advantage of identifying a specific IOMMU instance)?

Will
