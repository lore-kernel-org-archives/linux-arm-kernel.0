From: tushar.n.dave@oracle.com (tndave)
Date: Wed, 21 Jun 2017 12:24:28 -0700
Subject: clean up and modularize arch dma_mapping interface V2
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Message-ID: <162d7932-5766-4c29-5471-07d1b699190a@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/16/2017 11:10 AM, Christoph Hellwig wrote:
> Hi all,
> 
> for a while we have a generic implementation of the dma mapping routines
> that call into per-arch or per-device operations.  But right now there
> still are various bits in the interfaces where don't clearly operate
> on these ops.  This series tries to clean up a lot of those (but not all
> yet, but the series is big enough).  It gets rid of the DMA_ERROR_CODE
> way of signaling failures of the mapping routines from the
> implementations to the generic code (and cleans up various drivers that
> were incorrectly using it), and gets rid of the ->set_dma_mask routine
> in favor of relying on the ->dma_capable method that can be used in
> the same way, but which requires less code duplication.
Chris,

Thanks for doing this.
So archs can still have their own definition for dma_set_mask() if 
HAVE_ARCH_DMA_SET_MASK is y?
(and similarly for dma_set_coherent_mask() when 
CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK is y)
Any plan to change these?

I'm in a process of making some changes to SPARC iommu so it would be 
good to know. Thanks.

-Tushar

> 
> I've got a good number of reviews last time, but a few are still missing.
> I'd love to not have to re-spam everyone with this patchbomb, so early
> ACKs (or complaints) are welcome.
> 
> I plan to create a new dma-mapping tree to collect all this work.
> Any volunteers for co-maintainers, especially from the iommu gang?
> 
> The whole series is also available in git:
> 
>      git://git.infradead.org/users/hch/misc.git dma-map
> 
> Gitweb:
> 
>      http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-map
> 
> Changes since V1:
>   - remove two lines of code from arm dmabounce
>   - a few commit message tweaks
>   - lots of ACKs
> 
