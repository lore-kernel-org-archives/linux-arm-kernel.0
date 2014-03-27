From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 27 Mar 2014 14:37:59 +0100
Subject: [PATCH 0/6] ARM: mvebu: prepare PMSU code for cpuidle and Armada
 375/38x SMP
Message-ID: <1395927485-11842-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The PMSU (Power Management Service Unit) code in
arch/arm/mach-mvebu/pmsu.c needs several changes and improvements to
properly support cpuidle on Armada 370/XP and SMP on Armada 375/38x.

The problem with the current implementations are:

 * The base address and length of the PMSU registers that we had
   originally chosen are wrong: the base starts 0x100 too late, and
   therefore we miss some PMSU registers that are important for the
   cpuidle operation. In other words, the PMSU reg specification was
   <0x22100 0x400>, but it needs to be <0x22000 0x1000>.

   This patch set solves this by introducing a new DT binding for the
   PMSU that assumes the reg property will be <0x22000 0x1000>. In
   addition to this, backward compatibility with the old DT property
   is preserved, by doing some calculation inside pmsu.c to re-adjust
   <0x22100 0x400> to the now correct <0x22000 0x1000>. The addition
   of the new DT binding will allow, one day, to get rid of the old
   deprecated binding.

 * The PMSU Device Tree node was used to describe both the PMSU
   registers themselves, but also the CPU reset registers. But this
   was a mistake: on Armada 375, we have the same CPU reset registers
   to start the secondary processors, but we don't have a
   PMSU. Therefore, the PMSU should be split in two parts: one part
   really doing the PMSU itself, and one part taking care of the CPU
   reset registers.

   This is achieved by adding a cpu-reset.c driver in
   arch/arm/mach-mvebu/, which uses a new DT node with a compatible
   property named "marvell,armada-<chip>-cpu-reset".

   This driver is backward compatible with old DT, and therefore if no
   "marvell,armada-<chip>-cpu-reset" compatible string is found, it
   will look for a PMSU compatible string, and use the second reg
   specifier of it to get the location of the CPU register registers.

   Note that we have considered using the "reset framework" to support
   this mechanism. It was working perfectly fine, except that the
   Device Tree backward compatibility requirement makes it way too
   complicated: when we're booted with an old Device Tree, we would
   have to artifically create a node for the CPU reset device, and
   then for each CPU, add a "reset" property that contains a phandle
   to the CPU reset device node we created. While this is therorically
   possible, the existing OF API in the kernel does not easily allow
   the allocation of phandle numbers.

   Moreover, the "reset framework" is mainly useful for device
   drivers, so that they don't depend on a SoC-specific set of
   functions to manage the reset line of their devices. However, in
   our case, it's the SoC-specific SMP code that calls into
   SoC-specific CPU reset code, so using the reset framework doesn't
   bring a huge benefit.

 * Setting the boot address of the secondary processor is not only
   useful for SMP, but also for cpuidle, so this functionality in
   pmsu.c is split into a separate function, so that it can be re-used
   by the cpuidle code. It is also useful for the Armada 38x SMP,
   which also uses the PMSU to set the secondary processor PMSU.

The patch series was successfully tested by using both the old and new
Device Trees: the backward compatibility logic has been tested.

Details of the patches:

 * PATCH 1 introduces the cpu-reset.c driver, with its normal DT
   binding.

 * PATCH 2 changes the pmsu.c driver to remove the CPU reset logic,
   and rely on the cpu-reset.c driver. It also introduces the backward
   compatibility code in the cpu-reset.c driver so that things
   continue to work normally.

 * PATCH 3 improves the pmsu.c driver to properly request its register
   area instead of using just of_iomap().

 * PATCH 4 introduces a new DT binding for the PMSU, which expects a
   larger register area. It also adds the necessary backward
   compatibility code to properly support the old DT binding by
   adjusting manually the base/size of the registers within the
   driver.

 * PATCH 5 switches the Armada 370/XP device trees to use the new CPU
   reset and PMSU bindings.

 * PATCH 6 splits into a separate function the code that sets the boot
   address of secondary CPUs.

In terms of dependencies, we will have 4 interconnected patch series:
Armada 375/38x coherency support, this PMSU rework series, the cpuidle
series, and the Armada 375/38x SMP support. The relations are as follows

  ---------------        ---------------------
  | pmsu-rework |        | 375/38x coherency |
  ---------------        ---------------------
        ||   ||                 ||
	||   \\____________     ||
	\/                \/    \/
  ---------------        ---------------
  |   cpuidle   |        | 375/38x SMP |
  ---------------        ---------------

In other words: cpuidle needs pmsu-rework, and 375/38x SMP needs
pmsu-rework and 375/38x coherency. Gregory will soon resend a new
version of his cpuidle patch series based on top of these PMSU
changes, and I will soon post the 375/38x SMP support.

Best regards,

Thomas

Gregory CLEMENT (3):
  ARM: mvebu: extend the PMSU registers
  ARM: mvebu: switch to the new PMSU binding in Armada 370/XP Device
    Tree
  ARM: mvebu: use a separate function to set the boot address of CPUs

Thomas Petazzoni (3):
  ARM: mvebu: introduce CPU reset code
  ARM: mvebu: start using the CPU reset driver
  ARM: mvebu: improve PMSU driver to request its resource

 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt |  14 ++-
 .../devicetree/bindings/arm/armada-cpu-reset.txt   |  17 ++++
 arch/arm/boot/dts/armada-370-xp.dtsi               |   5 +
 arch/arm/boot/dts/armada-370.dtsi                  |   5 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   6 +-
 arch/arm/mach-mvebu/Makefile                       |   2 +-
 arch/arm/mach-mvebu/armada-370-xp.h                |   3 +-
 arch/arm/mach-mvebu/common.h                       |   1 +
 arch/arm/mach-mvebu/cpu-reset.c                    | 109 +++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.c                         |  79 +++++++++++----
 10 files changed, 209 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armada-cpu-reset.txt
 create mode 100644 arch/arm/mach-mvebu/cpu-reset.c

-- 
1.8.3.2
