From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri,  2 Oct 2015 15:47:38 -0500
Subject: [PATCHv2 0/7] arm64: Use contiguous PTE bit for the kernel linear
 mapping
Message-ID: <1443818865-19846-1-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from V1:

This version is similar to the previous versions with the addition of
contpte/nocontpte kernel parameters for enabling/disabling the functionality.
I defaulted it to contpte, but will change it to nocontpte if someone feels
strongly about that. I considered making the default a kconfig option, but
decided against it to avoid adding clutter for what should eventually be a
fairly normal piece of functionality. I also used the early_param_on_off()
macro, which is a small and concise piece of code, but varies a little from
the more common parameter=value kernel parameters. 

Also, continuing thanks to Steve Capper who has been religiously testing these patch sets,
and found a bug in the previous implementation.

Finally, I removed the formatting change per Catalin.

Original Description:

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
  arm64: PTE/PMD contiguous bit definition
  arm64: Macros to check/set/unset the contiguous bit
  arm64: Default kernel pages should be contiguous
  arm64: Make the kernel page dump utility aware of the CONT bit
  arm64: Mark kernel page ranges contiguous
  Document the use of the arm64 contpte/nonconpte flags.

 Documentation/kernel-parameters.txt    |  4 ++
 arch/arm64/include/asm/page.h          |  8 +++-
 arch/arm64/include/asm/pgtable-hwdef.h |  9 ++++
 arch/arm64/include/asm/pgtable.h       | 13 ++++++
 arch/arm64/mm/dump.c                   | 18 +++++++-
 arch/arm64/mm/mmu.c                    | 81 ++++++++++++++++++++++++++++++----
 6 files changed, 122 insertions(+), 11 deletions(-)

-- 
2.4.3
