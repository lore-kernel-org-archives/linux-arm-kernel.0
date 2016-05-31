From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 May 2016 17:37:38 +0100
Subject: [PATCH 0/2] ARM: fix the pmd_mknotpresent definition
Message-ID: <1464712660-25177-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following discussions on the LKML few months ago:

http://lkml.iu.edu/hypermail/linux/kernel/1602.3/01844.html

we need to adjust the LPAE pmd_mknotpresent() so that it does not clash
with the pmd_none() definition (IOW, we should allow !pmd_none() &&
!pmd_present() after pmd_mknotpresent()). This requires that
pmd_present() checks the L_PMD_SECT_VALID bit instead of a non-zero
value (similar commit for arm64: 5bb1cc0ff9a6 "arm64: Ensure
pmd_present() returns false after pmd_mknotpresent()")

Steve Capper (1):
  ARM: mm: Fix definition of pmd_mknotpresent

Will Deacon (1):
  ARM: mm: ensure pmd_present only checks the valid bit

 arch/arm/include/asm/pgtable-2level.h | 1 +
 arch/arm/include/asm/pgtable-3level.h | 5 +++--
 arch/arm/include/asm/pgtable.h        | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)
