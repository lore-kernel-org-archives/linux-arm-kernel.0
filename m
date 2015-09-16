From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed, 16 Sep 2015 14:02:59 -0500
Subject: [PATCH 0/7] arm64: Use contigous PTE bit for the kernel linear mapping
Message-ID: <1442430186-9083-1-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running 64k pages it became apparent that it was possible that the
kernel could create more TLB pressure in certain circumstances when
compared to the 4k page kernel. This is due to the fact that large
portions of the 4k kernel can be mapped with 2M blocks.
While the larger block size for 64k pages is 512M, it 
frequently won't be used for assorted reasons.

ARMv8 has a contiguous PTE bit that allows the TLBs to map a range larger
than a single PTE if the range is physically contiguous. So its
a good idea to use this where appropriate for the kernel mapping.

This patch adds the definitions for the contiguous bit, updates the kernel
page range dump to understand them (and block translations),
and updates the code in mmu.c to use the contiguous bit where appropriate
for the kernel linear mapping.

Jeremy Linton (7):
  arm64: Add contiguous page flag shifts and constants
  arm64: Shorten lines which exceed 80 characters
  arm64: PTE/PMD contiguous bit definition
  arm64: Macros to check/set/unset the contiguous bit
  arm64: Default kernel pages should be contiguous
  arm64: Make the kernel page dump utility aware of the CONT bit
  arm64: Mark kernel page ranges contiguous

 arch/arm64/include/asm/page.h          |  8 +++-
 arch/arm64/include/asm/pgtable-hwdef.h | 25 ++++++++----
 arch/arm64/include/asm/pgtable.h       | 13 +++++++
 arch/arm64/mm/dump.c                   | 18 ++++++++-
 arch/arm64/mm/mmu.c                    | 70 ++++++++++++++++++++++++++++++----
 5 files changed, 116 insertions(+), 18 deletions(-)

-- 
2.4.3
