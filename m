From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 21 Jan 2015 17:02:06 +0200
Subject: [RFC PATCH v4 0/8] Introduce automatic DMA configuration for
 IOMMU masters
In-Reply-To: <20150121144835.GK4549@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
 <12178745.U2ZdLpocXO@avalon> <20150121144835.GK4549@arm.com>
Message-ID: <5599950.ffjJapmhpz@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wednesday 21 January 2015 14:48:35 Will Deacon wrote:
> On Tue, Jan 20, 2015 at 04:56:03PM +0000, Laurent Pinchart wrote:
> > On Monday 19 January 2015 16:06:20 Will Deacon wrote:
> > > On Fri, Nov 14, 2014 at 08:01:56PM +0000, Arnd Bergmann wrote:
> > > > On Friday 14 November 2014 19:27:54 Will Deacon wrote:
> > > > > > At the moment, iommu_ops is a structure that can get used for any
> > > > > > number of iommus of the same type, but by putting per-device
> > > > > > private data into the same structure you have to duplicate it per
> > > > > > instance.
> > > > > 
> > > > > I'm not sure I agree -- the pgsize_bitmap, for example, could vary
> > > > > between different implementations of the same IOMMU. I think we
> > > > > already have this in Juno (some SMMUs can only do 64k pages, whilst
> > > > > others can do 4k and 64k).
> > > > 
> > > > Ah, I hadn't noticed that, it should be in the 'struct iommu' then of
> > > > course, not in iommu_ops.
> > > 
> > > Now that of_iommu_get_ops has its own list of iommu_ops, we can actually
> > > just move pgsize_bitmap into the iommu_domain, which I think makes a lot
> > > more sense anyway.
> > 
> > The code looks good to me, but what does it have to do with
> > of_iommu_get_ops() having its own list of iommu_ops ?
> 
> So, the initial patches for of_iommu_configure/of_xlate made use of a void
> *priv field in struct iommu_ops (which actually made it to mainline but
> isn't used). This was replaced by the list maintained by of_iommu_get_ops,
> but the discussion highlighted that iommu_ops is not per-IOMMU instance and
> therefore shouldn't contain the pgsize_bitmap, which can (and does) vary
> between different IOMMU instances in a running system.
> 
> This patch is an effort to move the pgsize_bitmap field out of iommu_ops
> (leaving that structure to contain only function pointers) and into
> iommu_domain, where I think it makes more sense.

OK, that's what I had understood. Thanks for the clarification. I was just 
puzzled by what I thought you meant was a dependency on of_iommu_get_ops().

> > > diff below seems to do the trick. The next step would be postponing the
> > > pgsize_bitmap initialisation until device attach for the ARM SMMU, since
> > > it's at that point that we know the active page table format (and
> > > therefore the supported page sizes).

-- 
Regards,

Laurent Pinchart
