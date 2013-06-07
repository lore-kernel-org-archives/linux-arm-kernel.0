From: jonathan.austin@arm.com (Jonathan Austin)
Date: Sat, 08 Jun 2013 00:51:35 +0100
Subject: [GIT PULL] nommu-fixes, r7 and MPU support for 3.11
In-Reply-To: <51B232CA.9060700@arm.com>
References: <51B232CA.9060700@arm.com>
Message-ID: <51B27207.8060208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Resending as I had non-public git url in previous version, sorry)
Hi Russell,

Please could you pull the following changes for 3.11?

This includes the following series sent earlier to the list:
 - nommu-fixes
 - R7 Support 
 - MPU support

I've left out the ARCH_MULTIPLATFORM/!MMU stuff that Arnd and I were
discussing today until we've reached a conclusion/that's had some more
review.

This is rebased (and re-tested) on your devel-stable branch because
otherwise there were going to be conflicts with Uwe's V7M work now that
you've merged that. I've included the fix for limiting MPU to CPU_V7.

Thanks,
Jonny
-----8<-----

The following changes since commit 78ecad0183bd7e49131da2b5aa82bee017db1cf0:

  Merge tag '3.10-rc2-psci-ops-11-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen into devel-stable (2013-05-22 10:53:20 +0100)

are available in the git repository at:


  git://linux-arm.org/linux-ja.git ja-nommu-for-rmk

for you to fetch changes up to 99ec449dfcd323266fa0f3d9bf1d671755d0d784:

  ARM: mpu: Ensure that MPU depends on CPU_V7 (2013-06-07 19:13:33 +0100)

----------------------------------------------------------------
Jonathan Austin (14):
      ARM: nommu: Don't build smp_tlb.c for !CONFIG_MMU
      ARM: nommu: add stub local_flush_bp_all() for !CONFIG_MMUU
      ARM: select CPU_CPU15_MMU/MPU appropriately
      ARM: add Cortex-R7 Processor Info
      ARM: vexpress: Add Cortex-R Series UART, selectable via DEBUG_LL
      ARM: mpu: add PMSA related registers and bitfields to existing headers
      ARM: mpu: add header for MPU register layouts and region data
      ARM: mpu: add early bring-up code for the ARMv7 PMSA-compliant MPU
      ARM: mpu: add MPU probe and initialisation functions in C
      ARM: mpu: Complete initialisation of the MPU after reaching the C-world
      ARM: mpu: add MPU initialisation for secondary cores
      ARM: mpu: Allow enabling of the MPU via kconfig
      ARM: mpu: protect the vectors page with an MPU region
      ARM: mpu: Ensure that MPU depends on CPU_V7

Will Deacon (5):
      ARM: nommu: add entry point for secondary CPUs to head-nommu.S
      ARM: nommu: define dummy TLB operations for nommu configurations
      ARM: nommu: provide dummy cpu_switch_mm implementation
      ARM: nommu: do not initialise page tables in secondary_data structure
      ARM: suspend: fix CPU suspend code for !CONFIG_MMU configurations

 arch/arm/Kconfig                  |    5 +-
 arch/arm/Kconfig-nommu            |   12 ++
 arch/arm/Kconfig.debug            |   10 +-
 arch/arm/include/asm/cp15.h       |    5 +
 arch/arm/include/asm/cputype.h    |    1 +
 arch/arm/include/asm/mpu.h        |   76 +++++++++++
 arch/arm/include/asm/proc-fns.h   |    4 +
 arch/arm/include/asm/smp.h        |    5 +-
 arch/arm/include/asm/smp_plat.h   |    4 +
 arch/arm/include/asm/tlbflush.h   |   25 +++-
 arch/arm/include/debug/vexpress.S |   10 ++
 arch/arm/kernel/Makefile          |    5 +-
 arch/arm/kernel/head-nommu.S      |  160 ++++++++++++++++++++++-
 arch/arm/kernel/signal.c          |    9 +-
 arch/arm/kernel/smp.c             |   10 +-
 arch/arm/kernel/suspend.c         |   64 +++++----
 arch/arm/mm/Kconfig               |    3 +-
 arch/arm/mm/nommu.c               |  257 ++++++++++++++++++++++++++++++++++++-
 arch/arm/mm/proc-v6.S             |    6 +-
 arch/arm/mm/proc-v7.S             |   27 +++-
 20 files changed, 647 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm/include/asm/mpu.h
