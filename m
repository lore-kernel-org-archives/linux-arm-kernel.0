From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 24 May 2017 08:02:48 +0800
Subject: [PATCH v12 0/9] coresight: enable debug module
Message-ID: <1495584177-32193-1-git-send-email-leo.yan@linaro.org>
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

Patch 0001 is to document the dt binding; patch 0002 adds one detailed
document to describe the Coresight debug module implementation, the
clock and power domain impaction on the driver, some examples for usage.

Patch 0003 is to document boot parameters used in kernel command line.

Patch 0004 is to add file entries for MAINTAINERS.

Patch 0005 is used to fix the func of_get_coresight_platform_data()
doesn't properly drop the reference to the CPU node pointer; and
patch 0006 is refactor to add new function of_coresight_get_cpu().

Patch 0007 is the driver for CPU debug module.

Patch 0008 in this series are to enable debug unit on 96boards Hikey,
Patch 0009 is to enable debug on 96boards DB410c. Have verified on both
two boards.

We can enable debugging with two methods, adding parameters into kernel
command line for build-in module:
  coresight_cpu_debug.enable=1

Or we can wait the system has booted up to use debugfs nodes to enable
debugging:
  # echo 1 > /sys/kernel/debug/coresight_cpu_debug/enable

As result we can get below log after input command:
echo c > /proc/sysrq-trigger:

ARM external debug module:
coresight-cpu-debug 850000.debug: CPU[0]:
coresight-cpu-debug 850000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
coresight-cpu-debug 850000.debug:  EDPCSR:  [<ffff00000808e9bc>] handle_IPI+0x174/0x1d8
coresight-cpu-debug 850000.debug:  EDCIDSR: 00000000
coresight-cpu-debug 850000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)
coresight-cpu-debug 852000.debug: CPU[1]:
coresight-cpu-debug 852000.debug:  EDPRSR:  00000001 (Power:On DLK:Unlock)
coresight-cpu-debug 852000.debug:  EDPCSR:  [<ffff0000087fab34>] debug_notifier_call+0x23c/0x358
coresight-cpu-debug 852000.debug:  EDCIDSR: 00000000
coresight-cpu-debug 852000.debug:  EDVIDSR: 90000000 (State:Non-secure Mode:EL1/0 Width:64bits VMID:0)

[...]

Changes from v11:
* Dismissed checkpatch.pl warning about "quoted string split across
  multiple lines" and "line over 80 characters".

Changes from v10:
* Followed Liviu suggestion to improve readability of the documentation.
* ARM Juno DTS binding patch has been picked by Sudeep, so this patch
  set has not included anymore. Great!

Changes from v9:
* Used dev_xyz() to replace pr_xyz() for print log.
* Added DT binding patch for Juno shared by Suzuki.

Changes from v8:
* According to Mathieu suggestions to split the doc into two patches,
  one is for kernel parameter and another is for driver documentation.
* Add file entries to MAINTAINERS.
* According to Mathieu suggestions, refined functions
  debug_enable_func()/debug_disable_func().

Changes from v7:
* Fix operator priority bug.
* Minor sequence adjustment for function debug_func_exit().

Changes from v6:
* According to Suzuki and Mathieu suggestions, refined debug module
  driver to install panic notifier when insmod module; refined function
  debug_force_cpu_powered_up() for CPU power state checking; some minor
  fixing for output log, adding comments for memory barrier, code
  alignment.

Changes from v5:
* According to Suzuki and Mathieu suggestions, refined debug module
  driver to drop unused structure members, refactored initialization
  code to distinguish hardware implementation features, refactored
  flow for forcing CPU powered up, supported pm_runtime operations.
* Added one new doc file: Documentation/trace/coresight-cpu-debug.txt,
  which is used to describe detailed info for implementation, clock
  and power domain impaction on debug module, and exmaples for common
  usage.
* Removed "idle constraints" from debug driver.

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
  doc: Add coresight_cpu_debug.enable to kernel-parameters.txt
  MAINTAINERS: update file entries for Coresight subsystem
  coresight: refactor with function of_coresight_get_cpu
  coresight: add support for CPU debug module
  arm64: dts: hi6220: register debug module
  arm64: dts: qcom: msm8916: Add debug unit

Suzuki K Poulose (1):
  coresight: of_get_coresight_platform_data: Add missing of_node_put

 Documentation/admin-guide/kernel-parameters.txt    |   7 +
 .../bindings/arm/coresight-cpu-debug.txt           |  49 ++
 Documentation/trace/coresight-cpu-debug.txt        | 175 ++++++
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  64 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  32 +
 drivers/hwtracing/coresight/Kconfig                |  14 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-cpu-debug.c  | 696 +++++++++++++++++++++
 drivers/hwtracing/coresight/of_coresight.c         |  40 +-
 include/linux/coresight.h                          |   3 +
 11 files changed, 1071 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 create mode 100644 Documentation/trace/coresight-cpu-debug.txt
 create mode 100644 drivers/hwtracing/coresight/coresight-cpu-debug.c

-- 
2.7.4
