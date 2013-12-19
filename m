From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 19 Dec 2013 04:36:33 -0800
Subject: [PATCH 0/6] clk: tegra: add basic support for the DFLL clocksource
Message-ID: <20131219122857.3226.42830.stgit@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for the open-loop mode of the
Tegra DFLL root clock source.  The DFLL can be used to provide an
energy-efficient and reliable clock signal for the Tegra114 fast
CPU cluster.

The core DFLL code requires some SoC-specific integration and
characterization data to function.  For the time being, this has
been implemented via small shim drivers that are probed from DT
data and which pass per-SoC information to the DFLL core code.
Future patches will add board tuning data to the DT files.

This series isn't sufficient for the DFLL to be usable as the
fast CPU clock source.  Further software support is needed to
switch the CPU cluster's clock from the default PLLX to the DFLL.

To test the basic functionality of the DFLL driver, something
like the following can be executed:

mount -t debugfs none /debug
cd /debug/tegra_dfll_fcpu/
echo 0 > enable
cat output_rate   # ensure that it is 0
echo 1 > enable
cat output_rate   # ensure that it is greater than 0

Future DFLL patches are planned to include reset controller
support, Tegra124 support, and closed-loop mode support.


- Paul

---

Danny Huang (1):
      ARM: tegra: fuse: add functions to read speedo ID and process ID

Paul Walmsley (5):
      ARM: tegra114: fuse: add DFLL FCPU minimum voltage override test function
      clk: tegra: add library for the DFLL clocksource (open-loop mode)
      ARM: DTS: tegra: add the DFLL IP block to the T114 SoC file
      ARM: DTS: tegra: add DFLL integration to the Dalmore DTS file
      clk: tegra: add Tegra114 FCPU DFLL clocksource platform driver


 .../bindings/clock/nvidia,tegra114-dfll.txt        |   59 +
 arch/arm/boot/dts/tegra114-dalmore.dts             |    4 
 arch/arm/boot/dts/tegra114.dtsi                    |   10 
 arch/arm/mach-tegra/fuse.c                         |   41 +
 drivers/clk/Kconfig                                |    2 
 drivers/clk/tegra/Kconfig                          |   18 
 drivers/clk/tegra/Makefile                         |   11 
 drivers/clk/tegra/clk-dfll.c                       | 1229 ++++++++++++++++++++
 drivers/clk/tegra/clk-dfll.h                       |   54 +
 drivers/clk/tegra/clk-tegra114-dfll-fcpu.c         |  169 +++
 include/linux/tegra-soc.h                          |    6 
 11 files changed, 1602 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra114-dfll.txt
 create mode 100644 drivers/clk/tegra/Kconfig
 create mode 100644 drivers/clk/tegra/clk-dfll.c
 create mode 100644 drivers/clk/tegra/clk-dfll.h
 create mode 100644 drivers/clk/tegra/clk-tegra114-dfll-fcpu.c

   text    data     bss     dec     hex filename
8010955  394200  352064 8757219  859fe3 vmlinux.next-20131218
8014811  395096  352064 8761971  85b273 vmlinux.next-20131218-dfll
