From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Tue,  3 Jun 2014 10:11:55 +0900
Subject: [RFC PATCH 0/3] CMA: generalize CMA reserved area management code
Message-ID: <1401757919-30018-1-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, there are two users on CMA functionality, one is the DMA
subsystem and the other is the kvm on powerpc. They have their own code
to manage CMA reserved area even if they looks really similar.
>From my guess, it is caused by some needs on bitmap management. Kvm side
wants to maintain bitmap not for 1 page, but for more size. Eventually it
use bitmap where one bit represents 64 pages.

When I implement CMA related patches, I should change those two places
to apply my change and it seem to be painful to me. I want to change
this situation and reduce future code management overhead through
this patch.

This change could also help developer who want to use CMA in their
new feature development, since they can use CMA easily without
copying & pasting this reserved area management code.

Now, we are in merge window, so this is not for merging. I'd like to
listen opinion from people who related to this stuff before actually
trying to merge this patchset. If all agree with this change, I will
resend it after rc1.

Thanks.

Joonsoo Kim (3):
  CMA: generalize CMA reserved area management functionality
  DMA, CMA: use general CMA reserved area management framework
  PPC, KVM, CMA: use general CMA reserved area management framework

 arch/powerpc/kvm/book3s_hv_builtin.c |   17 +-
 arch/powerpc/kvm/book3s_hv_cma.c     |  240 -------------------------
 arch/powerpc/kvm/book3s_hv_cma.h     |   27 ---
 drivers/base/Kconfig                 |   10 --
 drivers/base/dma-contiguous.c        |  230 ++----------------------
 include/linux/cma.h                  |   28 +++
 include/linux/dma-contiguous.h       |    7 +-
 mm/Kconfig                           |   11 ++
 mm/Makefile                          |    1 +
 mm/cma.c                             |  329 ++++++++++++++++++++++++++++++++++
 10 files changed, 396 insertions(+), 504 deletions(-)
 delete mode 100644 arch/powerpc/kvm/book3s_hv_cma.c
 delete mode 100644 arch/powerpc/kvm/book3s_hv_cma.h
 create mode 100644 include/linux/cma.h
 create mode 100644 mm/cma.c

-- 
1.7.9.5
