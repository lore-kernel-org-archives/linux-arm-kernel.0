From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Nov 2012 15:59:25 +0100
Subject: [PATCH V6 0/5] SMP support for Armada XP
Message-ID: <1353509970-5237-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This version improves the commit logs and come with a better written
assembly code based on the comments of Will and Russell. I also
changed the ownership of the code, since I made many change since he
1st release.

The purpose of this patch set is to add the SMP support for the Armada
XP SoCs. Beside the SMP support itself brought by the last 3 patches,
this patch set also adds the support for the coherency fabric unit and
the power management service unit.

The coherency fabric is responsible for ensuring hardware coherency
between all CPUs and between CPUs and I/O masters. This unit is also
available for Armada 370 and will be used in an incoming patch set
for hardware I/O cache coherency.

The power management service unit is responsible for powering down and
waking up CPUs and other SOC units.

The original code is from Yehuda Yitschak, it was reworked by myself
and reviewed by Yehuda.

This patch set is based on the tag marvell-mvebu-clk-3.8 to ease the
incoming git pull.
The git branch called ArmadaXP-SMP-for-3.8-V6 is also available at
https://github.com/MISL-EBU-System-SW/mainline-public.git.

Changelog:
V5->V6:
- Used 'bl' instead of 'mov lr,pc' and then 'b'
- Added a 'dsb' at the end ll_set_cpu_coherent
- Changed the ownership of the patches due to all the change done
  since the 1st version
- Improved all the commit logs

v4->V5:
- Rebased on to marvell-mvebu-clk-3.8
- Fixed bug in coherency_ll.S, use r2 instead of r4 as it can lead to
  unexpected crash if r4 is not restored properly.
- Fixed typo and improve assembly code in coherency_ll.S
- Use for_each_node_by_type instead of a while loop and
  of_find_node_by_type

V3->V4:
- Rebased on to v3.7-rc6
- the function to setup the coherency of the CPU is now share between
  SMP and coherency part and no more duplicate. Most of the code of
  headsmp.S have been moved in coherency_ll.S and the redundant code
  have been deleted from coherency.c.
- Fixed cosmetic inconsistency in code added to proc-v7, only macros
  are used and no more immediate values.
- Added reviewed-by and acked-by for the patch 4.

V2 -> V3:
- Rebased on to v3.7-rc5
- removed the unnecessary used of __iomem flag for a pointer to a
  function. the second parameter of armada_xp_boot_cpu is now just a
  void *.
- removed the dsb() call in armada_xp_boot_cpu(), as the following
  writel calls dsb if needed.
- Change the PJ4B mask for proc_info in arch/arm/mm/proc-v7.S to be
  less restrictive, the last 4 bits contain revision information
- Merge the multiple 'or' instruction in a single instruction in
  __v7_pj4b_setup

V1 -> V2:
- Rebased on to v3.7-rc3
- Fixed typos found by Alexandre Belloni
- Added clk_prepare_enable() before getting rate clk in
  set_secondary_cpus_clock()
- Add explanation in the binding documentation about the per-CPU
  interrupt registers: the address of the virtual register must be
  used.
- Removed the armada_xp prefix in the coherency.c file to be more
  compliant with the name convention of the other files.
- Coherency_init is now called from armada_370_xp_dt_init() and is no
  more an early_init() call. As the device tree is not available from
  an early_init(), it was useless to call coherency_init() so
  early. The need to be able to call some function very early during
  the boot were already resolved by using the hard code address of the
  register.


Gregory CLEMENT (5):
  arm: mvebu: Add support for coherency fabric in mach-mvebu
  arm: mvebu: Add initial support for power managmement service unit
  arm: mvebu: Add IPI support via doorbells
  arm: mm: Add support for PJ4B cpu and init routines
  arm: mvebu: Add SMP support for Armada XP

 .../devicetree/bindings/arm/armada-370-xp-mpic.txt |   12 +-
 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |   20 ++++
 .../devicetree/bindings/arm/coherency-fabric.txt   |   16 +++
 arch/arm/boot/dts/armada-370-xp.dtsi               |    5 +
 arch/arm/boot/dts/armada-xp.dtsi                   |    8 +-
 arch/arm/configs/mvebu_defconfig                   |    3 +
 arch/arm/mach-mvebu/Kconfig                        |    3 +-
 arch/arm/mach-mvebu/Makefile                       |    4 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |    3 +
 arch/arm/mach-mvebu/armada-370-xp.h                |    7 ++
 arch/arm/mach-mvebu/coherency.c                    |   82 +++++++++++++
 arch/arm/mach-mvebu/coherency.h                    |   24 ++++
 arch/arm/mach-mvebu/coherency_ll.S                 |   49 ++++++++
 arch/arm/mach-mvebu/common.h                       |    5 +
 arch/arm/mach-mvebu/headsmp.S                      |   49 ++++++++
 arch/arm/mach-mvebu/hotplug.c                      |   30 +++++
 arch/arm/mach-mvebu/irq-armada-370-xp.c            |   92 ++++++++++++++-
 arch/arm/mach-mvebu/platsmp.c                      |  122 ++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.c                         |   75 ++++++++++++
 arch/arm/mach-mvebu/pmsu.h                         |   16 +++
 arch/arm/mm/Kconfig                                |    4 +
 arch/arm/mm/proc-v7.S                              |   66 +++++++++++
 22 files changed, 683 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/coherency-fabric.txt
 create mode 100644 arch/arm/mach-mvebu/coherency.c
 create mode 100644 arch/arm/mach-mvebu/coherency.h
 create mode 100644 arch/arm/mach-mvebu/coherency_ll.S
 create mode 100644 arch/arm/mach-mvebu/headsmp.S
 create mode 100644 arch/arm/mach-mvebu/hotplug.c
 create mode 100644 arch/arm/mach-mvebu/platsmp.c
 create mode 100644 arch/arm/mach-mvebu/pmsu.c
 create mode 100644 arch/arm/mach-mvebu/pmsu.h

-- 
1.7.9.5
