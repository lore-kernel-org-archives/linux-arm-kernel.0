From: steve.capper@arm.com (Steve Capper)
Date: Wed, 15 Jan 2014 14:07:11 +0000
Subject: [PATCH 0/2] Introduce PTE_WRITE for arm64
Message-ID: <1389794833-7505-1-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for a separate PTE_WRITE bit, allowing one to
distinguish between writable clean ptes and read only ptes. At the
moment we have the following bit encodings:

                                PTE_DIRTY       PTE_RDONLY
!pte_dirty && !pte_write        0               1
!pte_dirty && pte_write         0               1
pte_dirty && !pte_write         1               1
pte_dirty && pte_write          1               0

One reason we need to add the distinction is to fix a problem with huge
pages, described here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/215155.html

The patch in the link above attempts to address this issue by bypassing
set_pte_at in the huge page code, but it was decided that the lack of
distinction between writable clean ptes and read only ptes should be
addressed instead as it could likely lead to other issues that we've
not yet seen.

The first patch in the series expands out PTE_BIT_FUNC to make life
much easier for cscope and tags users. Whilst the second patch actually
introduces PTE_WRITE.

LPAE on ARM is also affected by this issue and will need a similar
patch.
 
Steve Capper (2):
  arm64: mm: Remove PTE_BIT_FUNC macro
  arm64: mm: Introduce PTE_WRITE

 arch/arm64/include/asm/pgtable.h | 93 +++++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 30 deletions(-)

-- 
1.8.1.4
