From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 15 Jan 2013 10:13:09 +0200
Subject: [v3 0/9] ARM: Initial support for Tegra 114 SoC
Message-ID: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds initial support for NVIDIA's new Tegra 114 SoC
(T114) based on the ARM Cortex-A15 MP. It has the minimal support to
allow the kernel to boot up into shell console. This can be used as a
basis for adding other device drivers for this SoC. Currently there
are 2 evaluation boards available, "Dalmore" and "Pluto".

For those who want to try:

  $ make ARCH=arm tegra_defconfig
  $ scripts/config -e ARCH_TEGRA_114_SOC -d DRM -d SUSPEND \
    	-d PM_RUNTIME -d CPU_FREQ -d CPU_IDLE -d HOTPLUG_CPU
  $ make ARCH=arm menuconfig # if needed to configure more
  $ make ARCH=arm all -j9

You may also want to enable CONFIG_ARM_APPENDED_DTB and
CONFIG_ARM_ATAG_DTB_COMPAT if the bootloader doesn't support DT yet.

Verified that this single image booted up with "Dalmore(T114)",
"Pluto(T114)" and "Cardhu(T30)". For "Cardhu(T30)" with this single
image, SPI driver doesn't seem to afford the above configuration , it
hangs at boot-up. With SPI disabled, it's ok.

v3:
Rebased against next-20130115.
Dropped TSC/arch timer patch.
Use /cpus entry in DT to detect cpu core #.

v2:
Rebased against the latest Stephen Warren's linux-next_common
Add /cpus entry in DT
Add comment to initialize TSC only in secure mode.


Hiroshi Doyu (9):
  ARM: tegra: fuse: Add chipid TEGRA114 0x35
  HACK: ARM: tegra: Use CLK_IGNORE_UNUSED for Tegra 114 SoC
  ARM: tegra: Use DT /cpu node to detect number of CPU core
  ARM: Add API to detect SCU base address from CP15
  ARM: tegra: Skip scu_enable(scu_base) if not Cortex A9
  ARM: dt: tegra114: Add new SoC base, Tegra 114 SoC
  ARM: dt: tegra114: Add new board, Dalmore
  ARM: dt: tegra114: Add new board, Pluto
  ARM: tegra: Add initial support for Tegra 114 SoC.

 arch/arm/boot/dts/Makefile                |    4 +-
 arch/arm/boot/dts/tegra114-dalmore.dts    |   21 ++++++
 arch/arm/boot/dts/tegra114-pluto.dts      |   21 ++++++
 arch/arm/boot/dts/tegra114.dtsi           |  116 +++++++++++++++++++++++++++++
 arch/arm/include/asm/smp_scu.h            |   17 +++++
 arch/arm/mach-tegra/Kconfig               |   10 +++
 arch/arm/mach-tegra/Makefile              |    1 +
 arch/arm/mach-tegra/board-dt-tegra114.c   |   48 ++++++++++++
 arch/arm/mach-tegra/common.c              |    1 +
 arch/arm/mach-tegra/fuse.h                |    1 +
 arch/arm/mach-tegra/platsmp.c             |   22 ++----
 arch/arm/mach-tegra/tegra30_clocks_data.c |    2 +
 12 files changed, 246 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra114-dalmore.dts
 create mode 100644 arch/arm/boot/dts/tegra114-pluto.dts
 create mode 100644 arch/arm/boot/dts/tegra114.dtsi
 create mode 100644 arch/arm/mach-tegra/board-dt-tegra114.c

-- 
1.7.9.5
