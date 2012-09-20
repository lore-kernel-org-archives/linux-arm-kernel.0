From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Sep 2012 16:56:41 +0100
Subject: [PATCH 0/4] Fix PROT_NONE page permissions when !CPU_USE_DOMAINS
Message-ID: <1348156605-30398-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

After laughing at Ben H during LPC when it emerged that the PPC PROT_NONE
protection bits don't prevent kernel access to the protected pages, I
looked at the ARM code and, to my dismay, found that we have the same
problem when not using domains.

This patch series addresses the issue with the following points worth
noting:

	- We use the last available software bit (11) for 2-level PTEs.
	  Whilst this is somewhat of a pity, I can't think of a better
	  reason to allocate it than to fix an outstanding bug.

	- There is a horrible bug where the protection map values are
	  currently truncated with LPAE -- that is also fixed in this
	  series.

	- We add a new L_PTE_VALID bit to allow for present, faulting
	  pages in LPAE (where the software bits overlap with the
	  hardware bits).

Taken against -rc6 and tested for both 2 and 3 levels of page table with
a simple application reading an mprotect(PROT_NONE) region over a pipe.

All comments welcome,

Will


Will Deacon (4):
  ARM: mm: use pteval_t to represent page protection values
  ARM: mm: don't use the access flag permissions mechanism for classic
    MMU
  ARM: mm: introduce L_PTE_VALID for page table entries
  ARM: mm: introduce present, faulting entries for PAGE_NONE

 arch/arm/include/asm/pgtable-2level.h |    2 ++
 arch/arm/include/asm/pgtable-3level.h |    4 +++-
 arch/arm/include/asm/pgtable.h        |   10 ++++------
 arch/arm/mm/mmu.c                     |    2 +-
 arch/arm/mm/proc-macros.S             |    4 ++++
 arch/arm/mm/proc-v7-2level.S          |   10 +++++++---
 arch/arm/mm/proc-v7-3level.S          |    5 ++++-
 7 files changed, 25 insertions(+), 12 deletions(-)

-- 
1.7.4.1
