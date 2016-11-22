From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 09:25:57 +0000
Subject: [RFC PATCH 00/11] Allow NOMMU for MULTIPLATFORM
Message-ID: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

With transition to MULTIPLATFORM we lost capability to build NOMMU
configurations. Maybe not a big deal, but there is still interest in
building NOMMU configuration apart from M-class cores. Basically, I'm
talking about R-class cores which shares a lot with A-class except
MMU; there was little interest to run A-class with MMU disabled (or
1:1 MMU mapping) as well.  By now it is not even possible to build
such configurations without extra patches on top. Another aspect is
that some portion of NOMMU code have been (build) untested for a
while.  All these makes it even harder to involve more people in using
NOMMU and build community around that.

This series is trying to make it possible to build NOMMU
configurations. It is done in PATCH 11/11 which allows to select
ARCH_MULTIPLATFORM even for NOMMU. This is controlled with EXPERT
config option. All patches prior 11/11 is an attempt to fix build
failures for NOMMU case. I don't claim they are 100% correct, so I'm
open to suggestion how they can be done in a better way.

Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>

Vladimir Murzin (11):
  ARM: NOMMU: define stubs for fixup
  ARM: ep93xx: select ARM_PATCH_PHYS_VIRT for MMU builds only
  ARM: omap: do not select HIGHMEM explicitly
  PCI: tegra: limit to MMU build only
  ARM: move arm_heavy_mb to MMU/noMMU neutral place
  ARM: tlbflush: drop dependency on CONFIG_SMP
  ARM: sleep: allow it to be build for R-class
  ARM: NOMMU: define debug_ll_io_ini
  ARM: NOMMU: define SECTION_xxx macros
  ARM: NOMMU: define __arm_ioremap_exec and pci_ioremap functions
  ARM: Allow ARCH_MULTIPLATFORM to be selected for NOMMU

 arch/arm/Kconfig                     |    8 ++++----
 arch/arm/include/asm/fixmap.h        |    6 ++++++
 arch/arm/include/asm/mach/map.h      |    2 ++
 arch/arm/include/asm/pgtable-nommu.h |    5 +++++
 arch/arm/include/asm/tlbflush.h      |    2 +-
 arch/arm/kernel/sleep.S              |    4 ----
 arch/arm/mach-omap2/Kconfig          |    1 -
 arch/arm/mm/flush.c                  |   15 ---------------
 arch/arm/mm/iomap.c                  |   17 +++++++++++++++++
 arch/arm/mm/nommu.c                  |   35 ++++++++++++++++++++++++++++++++++
 drivers/pci/host/Kconfig             |    2 +-
 11 files changed, 71 insertions(+), 26 deletions(-)

-- 
1.7.9.5
