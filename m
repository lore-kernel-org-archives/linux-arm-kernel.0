From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 10 Jan 2013 19:32:37 +0100
Subject: [PATCH v5 1/4] iommu/shmobile: Add iommu driver for Renesas
 IPMMU modules
In-Reply-To: <1586668.MmWlG9A4gq@avalon>
References: <1356434355-3279-1-git-send-email-hdk@igel.co.jp>
 <1356434355-3279-2-git-send-email-hdk@igel.co.jp>
 <1586668.MmWlG9A4gq@avalon>
Message-ID: <20130110183236.GG25591@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 07, 2013 at 07:11:58PM +0100, Laurent Pinchart wrote:
> > +		l2index = (iova >> 12) & 0xff;
> > +		spin_lock(&sh_domain->map_lock);
> > +		ret = l2alloc(sh_domain, l1index);
> 
> l2alloc calls dma_pool_alloc(GFP_KERNEL), that not safe in a non-sleepable 
> context. Do we need a spinlock here, or could a mutex do ?

iommu_map should work in any context, so a mutex will not work. Also the
memory allocations in that path should be GFP_ATOMIC instead of
GFP_KERNEL.

Other than that this driver looks good from an IOMMU-API perspective.
Please Cc me on future versions of this patch-set directly.

Thanks,

	Joerg
