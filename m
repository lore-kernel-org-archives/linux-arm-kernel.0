From: josephl@nvidia.com (Joseph Lo)
Date: Tue, 8 Oct 2013 12:50:02 +0800
Subject: [PATCH V2 0/6] ARM: tegra: basic support for Tegra124 SoC
Message-ID: <1381207808-14734-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds basic support for the new Tegra SoC, Tegra124. To bring
up the system, it also needs an initrd as rootfs. Because most of the
peripheral not be enabled yet in this series, it depends on the clock and
pinctrl driver.

Here are the commands for U-Boot that I used for booting system to
console prompt:
* preparing kernel & initrd image
mkimage -A arm -T kernel_noload -C none -a 0 -e 0 -d zImage kernel.img
mkimage -A arm -C none -T ramdisk -a ${initrd_addr} -d rootfs.img.gz rootfs.img

* boot cmd for U-Boot
setenv bootargs console=ttyS0,115200 loglevel=8 init=/bin/sh
ext2load mmc ${mmc_dev}:${boot_part} ${kernel_addr_r} kernel.img
ext2load mmc ${mmc_dev}:${boot_part} ${ramdisk_addr_r} rootfs.img
ext2load mmc ${mmc_dev}:${boot_part} ${fdt_addr_r} tegra124-venice2.dtb
bootm ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}

Verified on Venice2.

V2:
* squash the [v1 1/7] ~ [v2 3/7] into the 1st patch in v2
* add PMC compatible value for Tegra124
* fix the device node name with address
* fix PMC compatible value in DT

Joseph Lo (6):
  ARM: tegra: add Tegra124 SoC support
  ARM: tegra: add PMC compatible value for Tegar124
  ARM: tegra: Add initial device tree for Tegra124
  ARM: tegra: add Venice2 board support
  HACK: arm: tegra: reuse the Tegra114 clock driver for Tegra124
  ARM: tegra: enable Tegra124 support

 arch/arm/boot/dts/Makefile             |   3 +-
 arch/arm/boot/dts/tegra124-venice2.dts |  20 +++++
 arch/arm/boot/dts/tegra124.dtsi        | 140 +++++++++++++++++++++++++++++++++
 arch/arm/configs/tegra_defconfig       |   1 +
 arch/arm/mach-tegra/Kconfig            |   8 ++
 arch/arm/mach-tegra/fuse.h             |   1 +
 arch/arm/mach-tegra/platsmp.c          |   2 +
 arch/arm/mach-tegra/pmc.c              |   1 +
 arch/arm/mach-tegra/tegra.c            |   1 +
 drivers/clk/tegra/clk-tegra114.c       |   1 +
 10 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/tegra124-venice2.dts
 create mode 100644 arch/arm/boot/dts/tegra124.dtsi

-- 
1.8.4
