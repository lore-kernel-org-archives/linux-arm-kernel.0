From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 23 Oct 2014 20:14:26 +0200
Subject: [PATCH 0/4] Hot plug support for Armada 38x
Message-ID: <1414088070-12510-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set adds the hot plug and also kexec support for the Armada
38x Socs.

The first patch was done in order to have the same code between Armada
XP and the Cortex A9 based mvebu SoCs. In order to ensure the the
backward compatibility for the device tree, it is only a preliminary
work for it.

The second patch moves the SCU power up sequence in a dedicated
assembly function. It was done in order to reuse it in the 3rd patch.

The third patch fixes the secondary startup for the cortex A9 mvebu
SoC. Indeed, the initial code was written with the assumption the SCU
will be always power on, which is not only true especially in the
kexec case.

These 2 patches may worth to be pushed to the stable kernel.

Then the last patch adds the CPU hotplug support for Armada 38x. I
tested the hotplug using the /sys/devices/system/cpu/cpu1/online
virtual file.  I also tested the kexec feature and managed to switch
to a new kernel using kexec.

Thanks,

Gregory


Gregory CLEMENT (4):
  ARM: mvebu: Clean-up the Armada XP support
  ARM: mvebu: Move SCU power up in a function
  ARM: mvebu: Fix secondary startup for Cortex A9 SoC
  ARM: mvebu: Implement CPU hotplug support for Armada 38x

 arch/arm/mach-mvebu/armada-370-xp.h |  6 -----
 arch/arm/mach-mvebu/board-v7.c      |  4 +++
 arch/arm/mach-mvebu/coherency.c     |  1 -
 arch/arm/mach-mvebu/cpu-reset.c     |  1 -
 arch/arm/mach-mvebu/headsmp-a9.S    |  1 +
 arch/arm/mach-mvebu/platsmp-a9.c    | 53 +++++++++++++++++++++++++++++++++++--
 arch/arm/mach-mvebu/platsmp.c       |  2 ++
 arch/arm/mach-mvebu/pmsu.c          |  3 +--
 arch/arm/mach-mvebu/pmsu.h          |  2 ++
 arch/arm/mach-mvebu/pmsu_ll.S       | 20 +++++++++-----
 10 files changed, 74 insertions(+), 19 deletions(-)

-- 
1.9.1
