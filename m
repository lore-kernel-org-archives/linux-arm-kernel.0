From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Oct 2012 09:59:28 +0100
Subject: [Linaro-mm-sig] [RFC 0/2] DMA-mapping & IOMMU - physically
 contiguous allocations
In-Reply-To: <20121016090434.7d5e088152a3e0b0606903c8@nvidia.com>
References: <1350309832-18461-1-git-send-email-m.szyprowski@samsung.com>
 <CAAQKjZMYFNMEnb2ue2aR+6AEbOixnQFyggbXrThBCW5VOznePg@mail.gmail.com>
 <20121016090434.7d5e088152a3e0b0606903c8@nvidia.com>
Message-ID: <20121016085928.GV21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 09:04:34AM +0300, Hiroshi Doyu wrote:
> In addition to those contiguous/discontiguous page allocation, is
> there any way to _import_ anonymous pages allocated by a process to be
> used in dma-mapping API later?
> 
> I'm considering the following scenario, an user process allocates a
> buffer by malloc() in advance, and then it asks some driver to convert
> that buffer into IOMMU'able/DMA'able ones later. In this case, pages
> are discouguous and even they may not be yet allocated at
> malloc()/mmap().

That situation is covered.  It's the streaming API you're wanting for that.
dma_map_sg() - but you may need additional cache handling via
flush_dcache_page() to ensure that your code is safe for all CPU cache
architectures.

Remember that pages allocated into userspace will be cacheable, so a cache
flush is required before they can be DMA'd.  Hence the streaming API.
