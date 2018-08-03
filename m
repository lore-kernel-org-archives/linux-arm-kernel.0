From: saiprakash.ranjan@codeaurora.org (Sai Prakash Ranjan)
Date: Fri,  3 Aug 2018 19:58:41 +0530
Subject: [RFC PATCH 0/3] Register read/write tracing with dynamic debug and
 pstore
Message-ID: <cover.1533211508.git.saiprakash.ranjan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds a new tracing facility for register reads and writes called
Register Trace Buffer(RTB).

We also add pstore support through which we can save all register read/write logs into a
persistent ram buffer that can be dumped after reboot.

It can be used to determine from where register was read/written before unclocked
access or some kind of bus hang or an unexpected reset caused by some buggy driver
which happens a lot during initial development stages.

In addition to this, we provide dynamic debug support to filter out unwanted logs
and limit trace to only specific files or directories since there can be aweful
lot of register events and we will be interested only in specific drivers or subsystems
which we will be working on. Last few RTB entries will give us the hint for debugging.
With dynamic debug, we are also reducing the overhead of tracing considerably.

Also as a bonus, this tracing can be extended to include IRQ, printk, context switch
and lot other things with proper hooks. It can be very helpful for real case debug scenarios.

Below is a simple example of identifying cause for bus hang in qcom mdp tested on db410c.
This hang was intentionally introduced just to show the usecase of RTB.
The module used can be found here: https://github.com/saiprakash-ranjan/Bus-Hang which does
an unclocked access and will reset db410c and later logs can be viewed through pstore.

Note: I just copied bus_hang.c to drivers/soc/qcom and built it.

1) Set bootargs with dyndbg parameter as below:

   # dyndbg="file drivers/soc/qcom/* +p"

2) Bus hang by reading below debugfs entry with bus_hang module.

   # cat /sys/kernel/debug/hang/bus_hang

3) After restart, we can find the cause in last entry i.e. (bus_hang_mdp+0x98/0xb0)

   # cat /sys/fs/pstore/rtb-ramoops-0
   [LOGK_WRITEL ] ts:1373101930  data:ffff00000cd065a4  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
   [LOGK_WRITEL ] ts:1373311878  data:ffff00000cd06608  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
   [LOGK_READL  ] ts:18177142294  data:ffff00000ab85040 <ffff00000867cdc8>  bus_hang_mdp+0x98/0xb0

4) Offending register access found as below:

   # (gdb)
   # (gdb) list *(bus_hang_mdp+0x98)
   # 0xffff00000867cdc8 is in bus_hang_mdp (drivers/soc/qcom/bus_hang.c:10).
   # 5       static int bus_hang_mdp(void *data, u64 *val)
   # 6       {
   # 7               void *p = ioremap(0x01a01000, SZ_4K);
   # 8               unsigned int a;
   # 9
   # 10              a = __raw_readl((void *)((unsigned long)p + 0x40));  <----
   # 11
   # 12              *val = a;
   # 13
   # 14              return 0;
   # (gdb)

There will be a lot more real usecases where RTB can be used. Maybe we can test on other boards as well.

Patchwise one line description is given below:

This trace module is based on RTB driver in CAF.
Link: https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/kernel/trace/msm_rtb.c

Patch 1 provides the api called uncached_logk which can be used to log register accesses.

Patch 2 adds the pstore support for viewing the logs.

Patch 3 adds dynamic debug support to filter the register readl/writel access.

Sai Prakash Ranjan (3):
  tracing: Add support for logging data to uncached buffer
  pstore: Add register readl/writel tracing support
  dynamic_debug: Add support for dynamic register trace

 .../bindings/reserved-memory/ramoops.txt      |   7 +-
 arch/arm64/include/asm/io.h                   |  93 ++++++++++
 fs/pstore/Kconfig                             |  12 ++
 fs/pstore/Makefile                            |   1 +
 fs/pstore/inode.c                             |  71 +++++++-
 fs/pstore/internal.h                          |   8 +
 fs/pstore/platform.c                          |   4 +
 fs/pstore/ram.c                               |  42 ++++-
 fs/pstore/rtb.c                               |  45 +++++
 include/linux/dynamic_debug.h                 |  10 ++
 include/linux/pstore.h                        |   2 +
 include/linux/pstore_ram.h                    |   1 +
 include/linux/rtb.h                           |  31 ++++
 kernel/trace/Kconfig                          |   8 +
 kernel/trace/Makefile                         |   2 +
 kernel/trace/trace_rtb.c                      | 163 ++++++++++++++++++
 16 files changed, 495 insertions(+), 5 deletions(-)
 create mode 100644 fs/pstore/rtb.c
 create mode 100644 include/linux/rtb.h
 create mode 100644 kernel/trace/trace_rtb.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
