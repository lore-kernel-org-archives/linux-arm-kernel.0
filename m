From: arnd@linaro.org (Arnd Bergmann)
Date: Tue, 10 Jan 2017 12:01:05 +0100
Subject: NVMe vs DMA addressing limitations
In-Reply-To: <c4fd007c-3f07-fc2a-8cbb-7152f578609d@cogentembedded.com>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170110070719.GA17208@lst.de>
 <c4fd007c-3f07-fc2a-8cbb-7152f578609d@cogentembedded.com>
Message-ID: <4137257.d2v87kqLLv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 10, 2017 10:31:47 AM CET Nikita Yushchenko wrote:
> Christoph, thanks for clear input.
> 
> Arnd, I think that given this discussion, best short-term solution is
> indeed the patch I've submitted yesterday. That is, your version +
> coherent mask support.  With that, set_dma_mask(DMA_BIT_MASK(64)) will
> succeed and hardware with work with swiotlb.

Ok, good.

> Possible next step is to teach swiotlb to dynamically allocate bounce
> buffers within entire arm64's ZONE_DMA.

That seems reasonable, yes. We probably have to do both, as there are
cases where a device has dma_mask smaller than ZONE_DMA but the swiotlb
bounce area is low enough to work anyway.

Another workaround me might need is to limit amount of concurrent DMA
in the NVMe driver based on some platform quirk. The way that NVMe works,
it can have very large amounts of data that is concurrently mapped into
the device. SWIOTLB is one case where this currently fails, but another
example would be old PowerPC servers that have a 256MB window of virtual
I/O addresses per VM guest in their IOMMU. Those will likely fail the same
way that your does.

> Also there is some hope that R-Car *can* iommu-translate addresses that
> PCIe module issues to system bus.  Although previous attempts to make
> that working failed. Additional research is needed here.

Does this IOMMU support remapping data within a virtual machine? I believe
there are some that only do one of the two -- either you can have guest
machines with DMA access to their low memory, or you can remap data on
the fly in the host.

	Arnd
