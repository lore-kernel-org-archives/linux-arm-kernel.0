From: leo.yan@linaro.org (Leo Yan)
Date: Fri,  3 Mar 2017 14:00:04 +0800
Subject: [PATCH v3 0/5] coresight: enable debug module
Message-ID: <1488520809-31670-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8 architecture reference manual (ARM DDI 0487A.k) Chapter H7 "The
Sample-based Profiling Extension" has description for sampling
registers, we can utilize these registers to check program counter
value with combined CPU exception level, secure state, etc. So this is
helpful for CPU lockup bugs, e.g. if one CPU has run into infinite loop
with IRQ disabled; the 'hang' CPU cannot switch context and handle any
interrupt, so it cannot handle SMP call for stack dump, etc.

This patch series is to enable coresight debug module with sample-based
registers and register call back notifier for PCSR register dumping
when panic happens, so we can see below dumping info for panic; and
this patch series has considered the conditions for access permission
for debug registers self, so this can avoid access debug registers when
CPU power domain is off; the driver also try to figure out the CPU is
in secure or non-secure state.

The last two patches in this series is to enable debug unit on 96boards
Hikey, the first patch is to add apb clock for debug unit and the second
patch is to add DT nodes for debug unit. As result we can below log
after input command: echo c > /proc/sysrq-trigger:

ARM external debug module:
CPU[0]:
 EDPRSR:  0000000b (Power:On DLK:Unlock)
 EDPCSR:  [<ffff00000808eb54>] handle_IPI+0xe4/0x150
 EDCIDSR: 00000000
 EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
CPU[1]:
 EDPRSR:  0000000b (Power:On DLK:Unlock)
 EDPCSR:  [<ffff0000087a64c0>] debug_notifier_call+0x108/0x288
 EDCIDSR: 00000000
 EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)

[...]

Changes from v2:
* According to Mathieu Poirier suggestion, applied some minor fixes.
* Added two extra patches for enabling debug module on Hikey.

Changes from v1:
* According to Mike Leach suggestion, removed the binding for debug
  module clocks which have been directly provided by CPU clocks.
* According to Mathieu Poirier suggestion, added function
  of_coresight_get_cpu() and some minor refactors for debug module
  driver.

Changes from RFC:
* According to Mike Leach suggestion, added check for EDPRSR to avoid
  lockup; added supporting EDVIDSR and EDCIDSR registers.
* According to Mark Rutland and Mathieu Poirier suggestion, rewrote
  the documentation for DT binding.
* According to Mark and Mathieu suggestion, refined debug driver.


Leo Yan (5):
  coresight: bindings for debug module
  coresight: refactor with function of_coresight_get_cpu
  coresight: add support for debug module
  clk: hi6220: add debug APB clock
  arm64: dts: hi6220: register debug module

 .../devicetree/bindings/arm/coresight-debug.txt    |  40 +++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  64 ++++
 drivers/clk/hisilicon/clk-hi6220.c                 |   1 +
 drivers/hwtracing/coresight/Kconfig                |  10 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-debug.c      | 377 +++++++++++++++++++++
 drivers/hwtracing/coresight/of_coresight.c         |  37 +-
 include/dt-bindings/clock/hi6220-clock.h           |   5 +-
 include/linux/coresight.h                          |   2 +
 9 files changed, 524 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-debug.txt
 create mode 100644 drivers/hwtracing/coresight/coresight-debug.c

-- 
2.7.4
