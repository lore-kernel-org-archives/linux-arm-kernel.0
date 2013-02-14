From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 14 Feb 2013 20:59:14 +0200
Subject: [v2 0/4] ARM: tegra: convert device tree files to use CLK defines
Message-ID: <1360868369-20093-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

With new dtc+cpp feature, we can get rid of magic numbers in dts*
files. To get rid of Tegra clock magic number, the following patches
were created with a script run as below. This can be applied for
Tegra114 clock as well.

for x in 20 30; do
    cat drivers/clk/tegra/clk-tegra$x.c | enum2define.py \
    	> arch/arm/boot/dts/tegra$x-car.h 2>/tmp/tegra$x-car.sed
    sed -i -f /tmp/tegra$x-car.sed \
    	Documentation/devicetree/bindings/clock/nvidia\,tegra$x-car.txt \
	arch/arm/boot/dts/*
done

We plan to share those DT header files with kernel source later[1].

This series depends on:

  [PATCH 0/9] ARM: tegra: use new dtc+cpp feature
  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/149613.html

v1:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/149672.html

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/149804.html

Hiroshi Doyu (4):
  ARM: tegra20: create a DT header defining CLK IDs
  ARM: tegra20: convert device tree files to use CLK defines
  ARM: tegra30: create a DT header defining CLK IDs
  ARM: tegra30: convert device tree files to use CLK defines

 .../bindings/clock/nvidia,tegra20-car.txt          |    2 +-
 .../bindings/clock/nvidia,tegra30-car.txt          |    2 +-
 arch/arm/boot/dts/tegra20-car.h                    |  114 +++++++++++++
 arch/arm/boot/dts/tegra20-paz00.dtsp               |    2 +-
 arch/arm/boot/dts/tegra20.dtsip                    |   85 +++++-----
 arch/arm/boot/dts/tegra30-car.h                    |  171 ++++++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsip                    |   87 +++++-----
 7 files changed, 375 insertions(+), 88 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra20-car.h
 create mode 100644 arch/arm/boot/dts/tegra30-car.h

--
1.7.9.5
