From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 14 Nov 2016 16:31:50 +0100
Subject: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
 callback
In-Reply-To: <634ac375-3507-6926-164f-e67f7c798c98@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
 <1478258646-3117-9-git-send-email-eric.auger@redhat.com>
 <20161110154606.GH2078@8bytes.org>
 <04ed9694-707d-260b-70c6-f367d292ceca@redhat.com>
 <20161110161331.GJ2078@8bytes.org>
 <f4537e43-0237-e478-eacd-b107458628b8@redhat.com>
 <20161111114223.GP2078@8bytes.org>
 <79da09b8-ac1e-cebf-5393-7d67f002b3e3@redhat.com>
 <20161111162211.GU2078@8bytes.org>
 <634ac375-3507-6926-164f-e67f7c798c98@redhat.com>
Message-ID: <20161114153149.GY2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Fri, Nov 11, 2016 at 05:45:19PM +0100, Auger Eric wrote:
> On 11/11/2016 17:22, Joerg Roedel wrote:
> > So I think we need a way to tell userspace about the reserved regions
> > (per iommu-group) so that userspace knows where it can not map anything,

> Current plan is to expose that info through an iommu-group sysfs
> attribute, as you and Robin advised.

Great.

> > and VFIO can enforce that. But the right struct here is not an
> > iova-allocator rb-tree, a ordered linked list should be sufficient.
> I plan a linked list to store the reserved regions (P2P regions, MSI
> region, ...). get_dma_regions is called with a list local to a function
> for that. Might be needed to move that list head in the iommu_group to
> avoid calling the get_dm_regions again in the attribute show function?

You can re-use the get_dm_regions() call-back available in the iommu-ops
already. Just rename it and add a flag to it which tells the iommu-core
whether that region needs to be mapped or not.

> But to allocate the IOVAs within the MSI reserved region, I understand
> you don't want us to use the iova.c allocator, is that correct? We need
> an allocator though, even a very basic one based on bitmap or whatever.
> There potentially have several different physical MSI frame pages to map.

I don't get this, what do you need and address-allocator for?



	Joerg
