From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 21 Dec 2017 16:20:09 +0800
Subject: [PATCH v3 0/6] Coresight: support panic kdump
Message-ID: <1513844415-11427-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is to explore Coresight trace data for postmortem
debugging.  When kernel panic happens, the Coresight panic kdump can
help save on-chip trace data and tracer metadata into DRAM, later
relies on kdump and crash/perf for "offline" analysis.

The documentation is important to understand the purpose of Coresight
panic kdump, the implementation and usage. Patches 0001/0002 are used
to relocate and add related documenation.

Patch 0003 introduces the simple panic kdump framework which can be
easily used by Coresight devices.

Patches 0004/0005 support panic kdump for ETB; Patch 0006 supports
the dump for ETMv4. As Mathieu suggested, patch 0006 distinguish two
different tracer enabling mode: sysFS interface and perf mode.

This patch set have been verified on 96boards Hikey with tracer
enabling by sysFS interface.

Changes from v2:
* Add the two patches for documentation.
* Following Mathieu suggestion, reworked the panic kdump framework,
  removed the useless flag "PRE_PANIC".
* According to comment, changed to add and delete kdump node operations
  in sink enable/disable functions;
* According to Mathieu suggestion, handle kdump node
  addition/deletion/updating separately for sysFS interface and perf
  method.

Changes from v1:
* Add support to dump ETMv4 meta data.
* Wrote 'crash' extension csdump.so so rely on it to generate 'perf'
  format compatible file.
* Refactored panic dump driver to support pre & post panic dump.

Changes from RFC:
* Follow Mathieu's suggestion, use general framework to support dump
  functionality.
* Changed to use perf to analyse trace data.


Leo Yan (6):
  doc: Add Coresight documentation directory
  doc: Add documentation for Coresight panic kdump
  coresight: Support panic kdump functionality
  coresight: tmc: Hook callback for panic kdump
  coresight: Add and delete sink callback for panic kdump list
  coresight: etm4x: Support panic kdump

 Documentation/trace/coresight-cpu-debug.txt        | 187 ------------
 Documentation/trace/coresight.txt                  | 332 ---------------------
 .../trace/coresight/coresight-cpu-debug.txt        | 187 ++++++++++++
 .../trace/coresight/coresight-panic-kdump.txt      |  91 ++++++
 Documentation/trace/coresight/coresight.txt        | 332 +++++++++++++++++++++
 MAINTAINERS                                        |   5 +-
 drivers/hwtracing/coresight/Kconfig                |   9 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  12 +-
 drivers/hwtracing/coresight/coresight-etm4x.c      |  23 ++
 drivers/hwtracing/coresight/coresight-etm4x.h      |  15 +
 .../hwtracing/coresight/coresight-panic-kdump.c    | 154 ++++++++++
 drivers/hwtracing/coresight/coresight-priv.h       |  13 +
 drivers/hwtracing/coresight/coresight-tmc-etf.c    |  29 ++
 drivers/hwtracing/coresight/coresight.c            |  12 +
 include/linux/coresight.h                          |   7 +
 16 files changed, 887 insertions(+), 522 deletions(-)
 delete mode 100644 Documentation/trace/coresight-cpu-debug.txt
 delete mode 100644 Documentation/trace/coresight.txt
 create mode 100644 Documentation/trace/coresight/coresight-cpu-debug.txt
 create mode 100644 Documentation/trace/coresight/coresight-panic-kdump.txt
 create mode 100644 Documentation/trace/coresight/coresight.txt
 create mode 100644 drivers/hwtracing/coresight/coresight-panic-kdump.c

-- 
2.7.4
