From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 05 Jul 2010 14:20:13 +0100
Subject: [RFC PATCH 0/3] Ordered I/O accessors
Message-ID: <20100705130010.5157.32032.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Starting with Linux 2.6.33, the DMA coherent buffers are mapped as
Normal Non-cacheable (rather than Strongly Ordered) to comply with the
ARM architecture requirements (mainly ARMv7). The implications are that
Normal Non-cacheable memory accesses are no longer ordered with Device
memory accesses (note that ARMv7 doesn't guarantee this even if using
Strongly Ordered for the coherent DMA buffers, though it worked in
practice).

This change introduced issues in drivers using dma_alloc_coherent()
without barriers (e.g. wmb) to ensure that writes to coherent DMA
buffers are visible (drained to RAM) to a device before starting a DMA
transfer.

Discussions on LKML (see links in the commit log for the last patch)
suggested that the I/O accessors must be ordered with coherent buffer
accesses by adding the necessary barriers to read*/write*() accessors.
The alternative is to add barriers to drivers, though many of them were
tested on x86 and not showing any issues.

Note that this series only adds barriers to deal with the common case of
DMA coherent buffers. Other non-standard use-cases must have add the
correct barriers in the driver.

I did some simple "dd oflag=direct" tests on a CF card (using the PATA
platform driver) and the time for writing 10MB increased from 6.6s to
6.7s. I personally don't consider this significant. Drivers can be
optimised to use the *_relaxed() accessors (though all the other
architectures need to support them).

Please report if you see any severe performance impact with these
patches.

Thanks.


Catalin Marinas (3):
      ARM: Introduce *_relaxed() I/O accessors
      ARM: Convert L2x0 to use the IO relaxed operations for cache sync
      ARM: Add barriers to the I/O accessors if ARM_DMA_MEM_BUFFERABLE


 arch/arm/include/asm/io.h |   39 +++++++++++++++++++++++++++------------
 arch/arm/mm/cache-l2x0.c  |    4 ++--
 2 files changed, 29 insertions(+), 14 deletions(-)

-- 
Catalin
