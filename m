From: leo.yan@linaro.org (Leo Yan)
Date: Tue,  4 Aug 2015 15:27:25 +0800
Subject: [PATCH v4 0/4] clk: hisilicon: support stub clock
Message-ID: <1438673249-6051-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for hisilicon stub clock driver. On hi6220,
the bootloader needs load the firmware image and set info for OPPs;
after run into kernel, the stub clock driver is used to communicate
w/t firmware for cpu dynamic frequency scaling.

In patch series v1/v2, the stub clock driver simply writes request in
sram and send ipc to firmware; For patch series v3, the firmware has
been upgraded to use mailbox, so stub clock driver will call standard
mailbox APIs to request mailbox channel and send message to firmware.

Patch 4 adds stub clock node into dts and it references mailbox with
phandle, so patch 4 will depend on mailbox driver's patch series [1].
These patches have been tested on 96board hikey and is used by cpufreq
driver.

Changes from v3:
* Patch "clk: hisi: refine parameter checking for init" [2] has been
  applied to clk-next, so skip it in v4
* According to Stephen Boyd's review, fix and refine stub clock driver
* The stub clock driver depends on mailbox channel's initialization, so
  mailbox init firstly with core_initcall() and use subsys_initcall()
  for stub clock driver

Changes from v2:
* Use platform_device's probe for clock's initialization
* Use mailbox channel for clock frequency change

Changes from v1:
* Refine parameter checking for init flow
* Remove unnecessary debugging info
* Modify to check spinlock pointer when register clocks

[1] http://archive.arm.linux.org.uk/lurker/message/20150803.011307.1062b247.en.html
[2] http://archive.arm.linux.org.uk/lurker/message/20150803.011334.4b6f2fc7.en.html


Leo Yan (4):
  dt-bindings: arm: Hi6220: add doc for SRAM controller
  dt-bindings: clk: Hi6220: Document stub clock driver
  clk: Hi6220: add stub clock driver
  arm64: dts: add Hi6220's stub clock node

 .../bindings/arm/hisilicon/hisilicon.txt           |  18 ++
 .../devicetree/bindings/clock/hi6220-clock.txt     |  19 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  23 ++
 drivers/clk/hisilicon/Kconfig                      |   2 +-
 drivers/clk/hisilicon/Makefile                     |   2 +-
 drivers/clk/hisilicon/clk-hi6220-stub.c            | 276 +++++++++++++++++++++
 6 files changed, 337 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/hisilicon/clk-hi6220-stub.c

-- 
1.9.1
