From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu,  2 Feb 2017 15:45:10 +0100
Subject: [PATCH 00/13] ARM: at91; pm: cleanup
Message-ID: <20170202144523.11706-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following patch set is a cleanup of the AT91 PM code.

The main feautres is that it is now using a struct to pass arguments
between the C and the assembly code, allowing for more than 4 variables
to be passed.
It also removes instructions so it is actually faster.

The standby path is also faster now because it is only handled using C,
removing the need for a few comparisons before enabling DRAM self
refresh. This also allows to always propose standby, even when the sram
allocation failed.

Finally, the PM initialization functions are merge, removing the need
for separate paths on at91sam9*

Alexandre Belloni (13):
  ARM: at91: pm: cleanup headers
  ARM: at91: pm: move at91_ramc_read/write to pm.c
  ARM: at91: pm: Move global variables into at91_pm_data
  ARM: at91: pm: use struct at91_pm_data in pm_suspend.S
  ARM: at91: pm: use struct members directly
  ARM: at91: pm: simplify at91rm9200_standby
  ARM: at91: pm: Workaround DDRSDRC self-refresh bug with LPDDR1
    memories.
  ARM: at91: pm: tie the memory controller type to the ramc id
  ARM: at91: pm: tie the USB clock mask to the pmc
  ARM: at91: pm: merge all at91sam9*_pm_init
  ARM: at91: pm: remove at91_pm_set_standby
  ARM: at91: pm: use C functions for standby
  ARM: at91: pm: Allow PM even if SRAM allocation failed

 arch/arm/mach-at91/Makefile          |  33 ++++++
 arch/arm/mach-at91/at91sam9.c        |  45 +-------
 arch/arm/mach-at91/generic.h         |   8 +-
 arch/arm/mach-at91/pm.c              | 212 +++++++++++++++++------------------
 arch/arm/mach-at91/pm.h              |  27 ++---
 arch/arm/mach-at91/pm_data-offsets.c |  12 ++
 arch/arm/mach-at91/pm_suspend.S      |  55 ++-------
 7 files changed, 176 insertions(+), 216 deletions(-)
 create mode 100644 arch/arm/mach-at91/pm_data-offsets.c

-- 
2.11.0
