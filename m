From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed,  9 Dec 2015 17:26:55 +0000
Subject: [PATCH 0/2] arm64: Non-racy PTE setting in the presence of HW AF/DBM
Message-ID: <1449682017-23729-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series addresses a potentially racy default implementation of
ptep_set_access_flags() when hardware update of the access or dirty
states is enabled. The first patch is some clean-up in set_pte_at() to
improve the information reporting and replace BUG with WARN. The second
patch contains the arm64-specific ptep_set_access_flags()
implementation.

Possible racy scenarios are described in patch 2. I think this series
could be simplified on the following assumptions:

a) if the CPUs do not support HW AF/DBM or it is disabled, no other
   agent in the system will perform such updates

b) if one CPU supports HW AF/DBM, all of them must do (don't mix such
   features)

Point (a) means that the current code works fine and BUG_ON() is not
necessary.

Point (b) however requires a ptep_set_access_flags() similar to the x86
one, i.e. only do the setting if (changed && dirty), otherwise let the
hardware handle the updates.

Anyway, while patch 2 is still debatable, I'd like to merge the first
patch in 4.4 to avoid an unnecessary BUG_ON on hardware that doesn't
even do DBM.

Catalin


Catalin Marinas (2):
  arm64: Improve error reporting on set_pte_at() checks
  arm64: Implement ptep_set_access_flags() for hardware AF/DBM

 arch/arm64/include/asm/pgtable.h | 16 ++++++++---
 arch/arm64/mm/fault.c            | 57 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 4 deletions(-)
