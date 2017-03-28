From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 28 Mar 2017 13:19:27 +0200
Subject: [PATCH v2 00/11] ARM: at91: pm: cleanup
Message-ID: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v2 of the at91 PM cleanup.

The main goal is to use a struct to pass arguments between the C and the
assembly part. This is required to add further functionalities (coming in a
later series).

A bit of refactorization also allows to remove a some initialization in
at91sam9.c

Changes in v2:
 - rebased on top of v4.11-rc4 because of a dependency on a fix
 - added a patch to correct a typo
 - due to an errata on sama5d4, I've left out the following patches for now:
   ARM: at91: pm: use struct members directly
   ARM: at91: pm: use C functions for standby
   ARM: at91: pm: Allow PM even if SRAM allocation failed
   I'll get back to those later.
 - in preparation of the sama5d4 workaround, renamed standby to idle as the
   standby functions are actually used for cpuidle but not standby


Alexandre Belloni (11):
  ARM: at91: pm: Cleanup headers
  ARM: at91: pm: Move at91_ramc_read/write to pm.c
  ARM: at91: pm: Move global variables into at91_pm_data
  ARM: at91: pm: Use struct at91_pm_data in pm_suspend.S
  ARM: at91: pm: Simplify at91rm9200_standby
  ARM: at91: pm: Workaround DDRSDRC self-refresh bug with LPDDR1
    memories.
  ARM: at91: pm: Tie the memory controller type to the ramc id
  ARM: at91: pm: Tie the USB clock mask to the pmc
  ARM: at91: pm: Merge all at91sam9*_pm_init
  ARM: at91: pm: Remove at91_pm_set_standby
  ARM: at91: pm: correct typo

 arch/arm/mach-at91/Makefile          |  33 ++++++
 arch/arm/mach-at91/at91sam9.c        |  45 +-------
 arch/arm/mach-at91/generic.h         |   8 +-
 arch/arm/mach-at91/pm.c              | 199 +++++++++++++++++------------------
 arch/arm/mach-at91/pm.h              |  24 ++---
 arch/arm/mach-at91/pm_data-offsets.c |  13 +++
 arch/arm/mach-at91/pm_suspend.S      |  31 +++---
 7 files changed, 172 insertions(+), 181 deletions(-)
 create mode 100644 arch/arm/mach-at91/pm_data-offsets.c

-- 
2.11.0
