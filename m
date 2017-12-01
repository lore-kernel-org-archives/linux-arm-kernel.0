From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  1 Dec 2017 12:25:02 +0100
Subject: [PATCH 0/6]  Add CPU Frequency scaling support on Armada 37xx
Message-ID: <20171201112508.14121-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds the CPU Frequency support on Armada 37xx using
DVFS. It is based on the initial work of Evan Wang and Victor Gu.

DVFS control is done by a set of registers from the North Bridge Power
Management block. The binding for this block is documented in patch 1.

While adding a new cpufreq driver I found that the Kconfig and
Makefile were no more in order, so it is fixed by patch 2 and 3.

The 4th patch is just about updating the MAINTAINERS file with the new
driver.

The next patch is the real purpose of the series. The main goal of
this driver is to setup the CPU load level in the hardware to
associate them to CPU frequencies and register a standard cpufreq
driver. Note that the hardware also capable of doing AVS (Adaptive
Voltage Scaling), by associating a voltage on each level beside the
CPU frequency. However, this support is not yet ready, so it is not
part of this series.

Finally, the last patch is for arm-soc the arm-soc subsystem through
mvebu and update the device tree to support the CPU frequency scaling.

An update on the CPU clock driver is needed in order to take into
account the DVFS setting. It's the purpose of an other series already
sent, but is no dependencies between the series (for building or at
runtime).

Thanks,

Gregory

Gregory CLEMENT (6):
  dt-bindings: marvell: Add documentation for the North Bridge PM on
    Armada 37xx
  cpufreq: ARM: sort the Kconfig menu
  cpufreq: sort the drivers in ARM part
  MAINTAINERS: add new entries for Armada 37xx cpufreq driver
  cpufreq: Add DVFS support for Armada 37xx
  arm64: dts: marvell: armada-37xx: add nodes allowing cpufreq support

 .../bindings/arm/marvell/armada-37xx.txt           |  19 ++
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |   1 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   7 +
 drivers/cpufreq/Kconfig.arm                        |  89 ++++----
 drivers/cpufreq/Makefile                           |   9 +-
 drivers/cpufreq/armada-37xx-cpufreq.c              | 241 +++++++++++++++++++++
 7 files changed, 322 insertions(+), 45 deletions(-)
 create mode 100644 drivers/cpufreq/armada-37xx-cpufreq.c

-- 
2.15.0
