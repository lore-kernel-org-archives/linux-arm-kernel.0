From: leo.yan@linaro.org (Leo Yan)
Date: Sun, 26 Mar 2017 02:23:08 +0800
Subject: [PATCH v5 0/9] coresight: enable debug module
Message-ID: <1490466197-29163-1-git-send-email-leo.yan@linaro.org>
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

Patch 0001 is to document the dt binding; patch 0002 is to document
boot parameters used in kernel command line.

Patch 0003 is used to fix the func of_get_coresight_platform_data()
doesn't properly drop the reference to the CPU node pointer; and
patch 0004 is refactor to add new function of_coresight_get_cpu().
Patch 0005 is to add const quality to structure device_node.

Patch 0006 is the driver for CPU debug module.

Patches 0007/0008 in this series are to enable debug unit on 96boards
Hikey, patch 0007 is to add apb clock for debug unit and patch 0006
is to add DT nodes for debug unit. Patch 0009 is to enable debug on
96boards DB410c. Have verified on both two boards.

We can enable debugging with two method, adding parameters into kernel
command line for build-in module:
  coresight_cpu_debug.enable=1
  coresight_cpu_debug.idle_constraint=0

Or we can wait the system has booted up to use debugfs nodes to enable
debugging and set idle constraints:
  # echo 1 > /sys/kernel/debug/coresight_cpu_debug/enable
  # echo 0 > /sys/kernel/debug/coresight_cpu_debug/idle_constraint

As result we can get below log after input command:
echo c > /proc/sysrq-trigger:

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

Changes from v4:
* This version is mainly credit to ARM colleagues many contribution
  ideas for better quality (Thanks a lot Suzuki, Mike and Sudeep!).
* According to Suzuki suggestion, refined debug module driver to avoid
  memory leak for drvdata struct, handle PCSAMPLE_MODE=1, use flag
  drvdata.pc_has_offset to indicate if PCSR has offset, minor fixes.
* According to Mathieu suggestion, refined dt binding description.
* Changed driver to support module mode;
* According to Mike suggestion and very appreciate the pseudo code,
  added support to force CPU powered up with register EDPRCR;
* According to discussions, added command line and debugfs nodes to
  support enabling debugging for boot time, or later can dynamically
  enable/disable debugging by debugfs.
* According to Rob Herring suggestion, one minor fixes in DT binding.
* According to Stephen Boyd suggestion, add const quality to structure
  device_node. And used use of_cpu_device_node_get() to replace
  of_get_cpu_node() in patch 0003.

Changes from v3:
* Added Suzuki K Poulose's patch to fix issue for the func
  of_get_coresight_platform_data() doesn't properly drop the reference
  to the CPU node pointer.
* According to Suzuki suggestion, added code to handl the corner case
  for ARMv8 CPU with aarch32 mode.
* According to Suzuki suggestion, changed compatible string to
  "arm,coresight-cpu-debug".
* According to Mathieu suggestion, added "power-domains" as optional
  properties.

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


Leo Yan (8):
  coresight: bindings for CPU debug module
  doc: Add documentation for Coresight CPU debug
  coresight: refactor with function of_coresight_get_cpu
  coresight: use const for device_node structures
  coresight: add support for CPU debug module
  clk: hi6220: add debug APB clock
  arm64: dts: hi6220: register debug module
  arm64: dts: qcom: msm8916: Add debug unit

Suzuki K Poulose (1):
  coresight: of_get_coresight_platform_data: Add missing of_node_put

 Documentation/admin-guide/kernel-parameters.txt    |  21 +
 .../bindings/arm/coresight-cpu-debug.txt           |  48 ++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  64 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  32 +
 drivers/clk/hisilicon/clk-hi6220.c                 |   1 +
 drivers/hwtracing/coresight/Kconfig                |  11 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-cpu-debug.c  | 704 +++++++++++++++++++++
 drivers/hwtracing/coresight/of_coresight.c         |  44 +-
 include/dt-bindings/clock/hi6220-clock.h           |   5 +-
 include/linux/coresight.h                          |   6 +-
 11 files changed, 920 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 create mode 100644 drivers/hwtracing/coresight/coresight-cpu-debug.c

-- 
2.7.4
