From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2011 21:29:16 +0200
Subject: [RFC] ARM DMA mapping TODO, v1
Message-ID: <201104212129.17013.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think the recent discussions on linaro-mm-sig and the BoF last week
at ELC have been quite productive, and at least my understanding
of the missing pieces has improved quite a bit. This is a list of
things that I think need to be done in the kernel. Please complain
if any of these still seem controversial:

1. Fix the arm version of dma_alloc_coherent. It's in use today and
   is broken on modern CPUs because it results in both cached and
   uncached mappings. Rebecca suggested different approaches how to
   get there.

2. Implement dma_alloc_noncoherent on ARM. Marek pointed out
   that this is needed, and it currently is not implemented, with
   an outdated comment explaining why it used to not be possible
   to do it.

3. Convert ARM to use asm-generic/dma-mapping-common.h. We need
   both IOMMU and direct mapped DMA on some machines.

4. Implement an architecture independent version of dma_map_ops
   based on the iommu.h API. As Joerg mentioned, this has been
   missing for some time, and it would be better to do it once
   than for each IOMMU separately. This is probably a lot of work.

5. Find a way to define per-device IOMMUs, if that is not actually
   possible already. We had conflicting statements for this.

6. Implement iommu_ops for each of the ARM platforms that has
   an IOMMU. Needs some modifications for MSM and a rewrite for
   OMAP. Implementation for Samsung is under work.

7. Extend the dma_map_ops to have a way for mapping a buffer
   from dma_alloc_{non,}coherent into user space. We have not
   discussed that yet, but after thinking this for some time, I
   believe this would be the right approach to map buffers into
   user space from code that doesn't care about the underlying
   hardware.

After all these are in place, building anything on top of
dma_alloc_{non,}coherent should be much easier. The question
of passing buffers between V4L and DRM is still completely
unsolved as far as I can tell, but that discussion might become
more focused if we can agree on the above points and assume
that it will be done.

I expect that I will have to update the list above as people
point out mistakes in my assumptions.

	Arnd
