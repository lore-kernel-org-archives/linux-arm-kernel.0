From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 21 Nov 2017 11:08:40 +0800
Subject: [PATCH v2 0/4] coresight: support panic dump functionality
Message-ID: <1511233724-11867-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

### Introduction ###

Embedded Trace Buffer (ETB) provides on-chip storage of trace data,
usually has buffer size from 2KB to 8KB. These data has been used for
profiling and this has been well implemented in coresight driver.

This patch set is to explore ETB RAM data for postmortem debugging.
We could consider ETB RAM data is quite useful for postmortem debugging,
especially if the hardware design with local ETB buffer (ARM DDI 0461B)
chapter 1.2.7. 'Local ETF', with this kind design every CPU has one
dedicated ETB RAM. So it's quite handy that we can use alive CPU to help
dump the hang CPU ETB RAM. Then we can quickly get to know what's the
exact execution flow before its hang.

Due ETB RAM buffer has small size, if all CPUs shared one ETB buffer
then the trace data for causing error is easily to be overwritten by
other PEs; but even so sometimes we still have chance to go through the
trace data to assist debugging panic issues.

### Implementation ###

Firstly we need provide a unified APIs for panic dump functionality, so
it can be easily extended to enable panic dump for multiple drivers. This
is finished by patch 0001, it registers panic notifier, and provide the
general APIs {coresight_dump_add|coresight_dump_del} as helper functions
so any coresight device can add into dump list or delete itself
as needed.

Generally coresight devices can add itself into panic dump when
registration, if the coresight device wants to do dump it will set its
'panic_cb' in the ops structure. So patch 0002 is to add and delete panic
dump node for devices.

Patch 0003 and 0004 are to add panic callback functions for tmc and etm4x
drivers; so tmc dirver can save specific trace data for ETB/ETF when panic
happens, and etm4x driver can save metadata for offline analysis.

### Usage ###

Below are the example for how to use panic dump functionality on 96boards
Hikey, the brief flow is: when the panic happens the ETB panic callback
function saves trace data into memory, then relies on kdump to use
recovery kernel to save DDR content as kernel core dump file; after we
transfer kernel core dump file from board to host PC, use 'crash' tool +
extension program to extract trace data and generate 'perf' format
compatible file.

- Enable tracing on Hikey; in theory there have two methods to enable
  tracing:

  The first method is to use sysfs interface to enable coresight tracing:
  echo 1 > /sys/bus/coresight/devices/f6402000.etf/enable_sink
  echo 1 > /sys/bus/coresight/devices/f659c000.etm/enable_source
  echo 1 > /sys/bus/coresight/devices/f659d000.etm/enable_source
  echo 1 > /sys/bus/coresight/devices/f659e000.etm/enable_source
  echo 1 > /sys/bus/coresight/devices/f659f000.etm/enable_source
  echo 1 > /sys/bus/coresight/devices/f65dc000.etm/enable_source
  echo 1 > /sys/bus/coresight/devices/f65dd000.etm/enable_source
  echo 1 > /sys/bus/coresight/devices/f65de000.etm/enable_source
  echo 1 > /sys/bus/coresight/devices/f65df000.etm/enable_source

  The second method is to use tool 'perf' with snapshot method, this
  command is expected to enable tracing and wait for specific event happen
  and capture the snapshot trace data, this method also can be smoothly
  used for panic dump. This command currently is failure on Hikey due
  now coresight only support '--per-thread' method with perf tool:
  ./perf record --snapshot -S8196 -e cs_etm/@f6402000.etf/ -- sleep 1000 &

- Load recovery kernel for kdump:

  ARM64's kdump supports to use the same kernel image both for main
  kernel and dump-capture kernel; so we can simply to load dump-capture
  kernel with below command:
  ./kexec -p vmlinux --dtb=hi6220-hikey.dtb --append="root=/dev/mmcblk0p9
  rw  maxcpus=1 reset_devices earlycon=pl011,0xf7113000 nohlt
  initcall_debug console=tty0 console=ttyAMA3,115200 clk_ignore_unused"

- Download kernel dump file:

  After kernel panic happens, the kdump launches dump-capture kernel;
  so we need save kernel's dump file on target:
  cp /proc/vmcore ./vmcore

  Finally we can copy 'vmcore' file onto PC.

- Use 'crash' tool + csdump.so extension to extract trace data:

  After we download vmcore file from Hikey board to host PC, we can
  use 'crash' tool + csdump.so to generate 'perf.data' file:

  ./crash vmcore vmlinux
  crash> extend csdump.so
  crash> csdump output_dir

  We can see in the 'output_dir' there will generate out three files:
  output_dir/
  ??? cstrace.bin       -> trace raw data
  ??? metadata.bin      -> meta data
  ??? perf.data         -> 'perf' format compatible file

  The source code of 'csdump.so' will be sent to mailing list sepeartely.

- User 'perf' tool for offline analysis:

  On Hikey board:
  ./perf script -v -F cpu,event,ip -i perf_2.data -k vmlinux

  [001]         instructions:  ffff000008559ad0
  [001]         instructions:  ffff000008559230
  [001]         instructions:  ffff00000855924c
  [001]         instructions:  ffff000008559ae0
  [001]         instructions:  ffff000008559ad0
  [001]         instructions:  ffff000008559230
  [001]         instructions:  ffff00000855924c
  [001]         instructions:  ffff000008559ae0
  [001]         instructions:  ffff000008559ad0

Changes from v1:
* Add support to dump ETMv4 meta data.
* Wrote 'crash' extension csdump.so so rely on it to generate 'perf'
  format compatible file.
* Refactored panic dump driver to support pre & post panic dump.

Changes from RFC:
* Follow Mathieu's suggestion, use general framework to support dump
  functionality.
* Changed to use perf to analyse trace data.


Leo Yan (4):
  coresight: Support panic dump functionality
  coresight: Add and delete dump node for registration/unregistration
  coresight: tmc: Hook panic dump callback for ETB/ETF
  coresight: etm4x: Hook panic dump callback for etmv4

 drivers/hwtracing/coresight/Kconfig                |   9 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-etm4x.c      |  22 +++
 drivers/hwtracing/coresight/coresight-etm4x.h      |  15 ++
 drivers/hwtracing/coresight/coresight-panic-dump.c | 211 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h       |  17 ++
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  29 +++
 drivers/hwtracing/coresight/coresight.c            |   7 +
 include/linux/coresight.h                          |   7 +
 9 files changed, 318 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/coresight-panic-dump.c

-- 
2.7.4
