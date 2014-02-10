From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 10 Feb 2014 16:22:32 +0100
Subject: [RFC PATCH 0/3] Syscon early initialization
Message-ID: <cover.1392045742.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series come from my discussion with Arnd at KS and then
on some other threads/IRCs(Arnd and Mark) that SoC vendors
are more and more try to add misc functionality to
one memory region. For this purpose syscon driver is in the kernel.
But regular syscon driver is initialized too late
and platforms are trying to create specific code to handle it.

For this purpose the series have been created to provide
early syscon initialization and regmap creation first
and then attaching device.

The last patch is zynq specific patch to clear slcr driver
and clock driver can profit from it too when clk regmap is ready.

Also moving syscon driver from mfs should be consider.

Thanks for your comments,
Michal


Michal Simek (3):
  regmap: Separate regmap dev initialization
  mfd: syscon: Support early initialization
  ARM: zynq: Use early syscon initialization

 arch/arm/boot/dts/zynq-7000.dtsi |   1 +
 arch/arm/mach-zynq/common.c      |   6 +-
 arch/arm/mach-zynq/slcr.c        |  42 +------------
 drivers/base/regmap/regmap.c     |  41 +++++++++----
 drivers/clk/zynq/clkc.c          |  57 ++++++------------
 drivers/mfd/syscon.c             | 126 +++++++++++++++++++++++++++++++++------
 include/linux/mfd/syscon.h       |  11 ++++
 include/linux/regmap.h           |   2 +
 8 files changed, 173 insertions(+), 113 deletions(-)

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/69ed2e02/attachment.sig>
