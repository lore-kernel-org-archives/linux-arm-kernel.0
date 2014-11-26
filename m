From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Nov 2014 11:37:23 +0000
Subject: [RFC PATCH v4 6/8] dma-mapping: set dma segment properties in
 of_dma_configure
In-Reply-To: <54747EA0.1020001@arm.com>
References: <1415991397-9618-1-git-send-email-will.deacon@arm.com>
 <1415991397-9618-7-git-send-email-will.deacon@arm.com>
 <54747EA0.1020001@arm.com>
Message-ID: <20141126113723.GC14866@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 01:05:36PM +0000, Robin Murphy wrote:
> On 14/11/14 18:56, Will Deacon wrote:
> > of_dma_configure determines the size of the DMA range for a device by
> > either parsing the dma-ranges property or inspecting the coherent DMA
> > mask. This same information can be used to initialise the max segment
> > size and boundary_mask to a default value.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Sadly, NAK on this one. After a thorough investigation and testing, 
> generic code really shouldn't be touching dma_parms like this, and I 
> have some corrupted files on my USB filesystem to prove it ;) It seems 
> it's a bad idea to effectively change the default segment size 
> universally unless you really want to go through the entire block layer 
> (and who-knows-what-else) to find and fix everything that relies on it 
> being 64k.
> 
> Simply dropping this patch and letting the existing defaults in 
> dma_set_max_seg_size and dma_get_seg_boundary stand seems like the 
> correct action.
> 
> 
> Marek, I believe you may have some use case for this - if so, as I 
> understand it your individual drivers should be setting up their own 
> dma_parms directly, to tell the IOMMU they can handle it merging 
> scatterlists into arbitrarily long segments, without affecting the other 
> drivers that assume they'll never see >64k segments and go wrong if they 
> do (including the generic USB stack, apparently).

Ok, I'll drop this patch from the series for the time being. It's certainly
not a crucial part of the patchset and filesystem corruption is always bad.

Will
