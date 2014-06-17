From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 16 Jun 2014 18:39:20 -0700
Subject: [PATCHv3 0/5] Atomic pool for arm64
Message-ID: <1402969165-7526-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is a series to add a pool for atomic allocations for arm64. It was
previously suggested to try and share more code with arm. I did some
refactoring to have arm use genalloc and pull out some of the remapping
code. The end result is a negative diffstat overall for arm dma-mapping.c.

There still might be some room for more refactoring of atomic functions into
common dma-mapping.c and integration with dma-coherent.c but there should
be less overlap now.

Reviews and testing welcome.

Thanks,
Laura

v3: Now a patch series due to refactoring of arm code. arm and arm64 now both
use genalloc for atomic pool management. genalloc extensions added.
DMA remapping code factored out as well.

v2: Various bug fixes pointed out by David and Ritesh (CMA dependency, swapping
coherent, noncoherent). I'm still not sure how to address the devicetree
suggestion by Will [1][2]. I added the devicetree mailing list this time around
to get more input on this.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249180.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/249528.html


Laura Abbott (5):
  lib/genalloc.c: Add power aligned algorithm
  lib/genalloc.c: Add genpool range check function
  common: dma-mapping: Introduce common remapping functions
  arm: use genalloc for the atomic pool
  arm64: Add atomic pool for non-coherent and CMA allocaitons.

 arch/arm/Kconfig                         |   1 +
 arch/arm/mm/dma-mapping.c                | 200 ++++++++-----------------------
 arch/arm64/Kconfig                       |   1 +
 arch/arm64/mm/dma-mapping.c              | 154 +++++++++++++++++++++---
 drivers/base/dma-mapping.c               |  66 ++++++++++
 include/asm-generic/dma-mapping-common.h |   9 ++
 include/linux/genalloc.h                 |   7 ++
 lib/genalloc.c                           |  50 ++++++++
 8 files changed, 323 insertions(+), 165 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
