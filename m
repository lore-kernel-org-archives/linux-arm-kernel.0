From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Dec 2014 18:20:50 +0100
Subject: [PATCH 0/6] ARM: mvebu: mvebu-mbus and I/O coherency fixes
In-Reply-To: <20141230162716.GC24811@lunn.ch>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141230162716.GC24811@lunn.ch>
Message-ID: <20141230182050.0550ccdc@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Tue, 30 Dec 2014 17:27:16 +0100, Andrew Lunn wrote:

> [PATCH 1/6] dt: bindings: update mvebu-mbus DT binding with new
> branch dt for next merge window, since it is not strictly a fix.

Right.

> [PATCH 2/6] bus: mvebu-mbus: fix support of MBus window 13
> branch fixes for next -rc

Correct.

> [PATCH 3/6] ARM: mvebu: fix compatible strings of MBus on Armada 375 and Armada 38x
> branch fixes for next -rc

Correct, since this is needed for PATCH 2/6 to work properly.

> [PATCH 4/6] bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window
> branch drivers for next merge window. I assume it is only a run time dependency for the
> mv_cesa patches?

Indeed, next merge window is good enough for this one: the mv_cesa
patches have not even been posted yet. I'm not sure whether the mv_cesa
stuff will be ready for 3.20, or 3.21 anyway. But having for sure this
mvebu-mbus improvement already scheduled for 3.20 means one less
dependency to handle when we'll submit the mv_cesa patches.

> [PATCH 5/6] bus: mvebu-mbus: use automatic I/O synchronization barriers
> branch fixes for next -rc

Right.

> [PATCH 6/6] ARM: mvebu: use arm_coherent_dma_ops
> Here i'm unsure. Is this a fix, or a cleanup?

It's a fix, because it is what brings this part of the cover letter:

    * It allows to switch to use the existing arm_coherent_dma_ops
      instead of mvebu specific DMA operations. arm_coherent_dma_ops
      make sure that DMA coherent mappings are mapped cacheable (which
      is possible in a cache-coherent platform), which is a necessary
      to make sure that both CPU-side and device-side accesses are
      done in a cacheable way. Without this, CPU-side accesses to DMA
      coherent mappings were made uncached, while device-side accesses
      were made in a cacheable way, leading to potentially
      unpredictable behavior.

Which is really a fix. So it should go in 3.19-rc.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
