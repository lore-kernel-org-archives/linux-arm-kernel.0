From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 21 Dec 2017 16:20:11 +0800
Subject: [PATCH v3 2/6] doc: Add documentation for Coresight panic kdump
In-Reply-To: <1513844415-11427-1-git-send-email-leo.yan@linaro.org>
References: <1513844415-11427-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1513844415-11427-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add detailed documentation for Coresight panic kdump, which contains
the idea for why need this and introduce the framework implementation
and usage.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../trace/coresight/coresight-panic-kdump.txt      | 91 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 92 insertions(+)
 create mode 100644 Documentation/trace/coresight/coresight-panic-kdump.txt

diff --git a/Documentation/trace/coresight/coresight-panic-kdump.txt b/Documentation/trace/coresight/coresight-panic-kdump.txt
new file mode 100644
index 0000000..6bf9cac
--- /dev/null
+++ b/Documentation/trace/coresight/coresight-panic-kdump.txt
@@ -0,0 +1,91 @@
+		Coresight Panic Kdump
+		=====================
+
+   Author:   Leo Yan <leo.yan@linaro.org>
+   Date:     Dec 21th, 2017
+
+Introduction
+------------
+
+Coresight has different sinks for trace data, the trace data is quite useful
+for postmortem debugging.  Embedded Trace Buffer (ETB) is one type sink which
+provides on-chip storage of trace data, usually uses SRAM as buffer with
+several KBs size; if the SoC designs to support 'Local ETF' (ARM DDI 0461B,
+chapter 1.2.7), every CPU has one local ETB buffer so the per CPU trace data
+can avoid to be overwritted by other CPUs.  Trace Memory Controller (TMC) is
+another kind sink designed as a successor to the CoreSight ETB to capture trace
+into DRAM.
+
+After Linux kernel trigger panic, the trace data keeps the last execution flow
+before issues happen.  We could consider the trace data is quite useful for
+postmortem debugging, especially when we can record trace data into DRAM and rely
+on kdump to save them into vmcore file; at the end we can retrieve trace data
+from vmcore file and "offline" to analyze the execution flow.
+
+
+Implementation
+--------------
+
+Coresight panic kdump is a simple framework to support dump functionality,
+it maintains dump list with every node recording the dump buffer base address
+and buffer size.  Coresight panic kdump provides the general APIs
+{coresight_kdump_add|coresight_kdump_del} as helper functions so any coresight
+device can add itself into dump list or delete as needed.
+
+Generally coresight device set its 'panic_cb' in the ops structure, the panic
+notifier iterates dump list and invokes callback function to dump device specific
+info.
+
+For easily used by offline analysis, we also record tracer metadata so can
+retrieve tracer IDs and configuration, in this case the node records CPU number so
+can create connection between the metadata and specific CPU.  The tracer
+driver uses helper function coresight_kdump_update() to update the dump
+buffer base address and buffer size; so the tracer can save metadata at runtime
+and these info can be prepared well pre panic happening.
+
+
+Usage
+-----
+
+Build Linux kernel with enabling 'CONFIG_CORESIGHT_PANIC_KDUMP' configuration.
+
+After system booting up, we need firstly prepare dump-capture kernel, this can
+refer doc [1] chapter 'Load the Dump-capture Kernel' for detailed steps.  Then
+we need enable the coresight tracer, this can use either perf framework method
+or sysFS interface, please refer doc [2] chapter 'How to use the tracer modules'
+for detailed steps.
+
+When kernel panic happens, the panic kdump records trace data and launches
+dump-capture kernel, we can utilize the dump-capture kernel to save kernel dump
+file, this can refer doc [1] chapter 'Write Out the Dump File'.
+
+After get kernel dump file, we can use 'crash' tool + csdump.so extension to
+extract trace data and generate 'perf.data' file:
+
+  ./crash vmcore vmlinux
+  crash> extend csdump.so
+  crash> csdump output_dir
+
+  We can see in the 'output_dir' there will generate out three files:
+  output_dir/
+  ??? cstrace.bin       -> trace raw data
+  ??? metadata.bin      -> meta data
+  ??? perf.data         -> 'perf' format compatible file
+
+Finally use 'perf' tool for offline analysis:
+
+  ./perf script -v -F cpu,event,ip,sym,symoff -i perf.data -k vmlinux --kallsyms /proc/kallsyms
+  [001]         instructions:  ffff000008559ad0 pl011_console_write+0x90
+  [001]         instructions:  ffff000008559230 pl011_read+0x0
+  [001]         instructions:  ffff00000855924c pl011_read+0x1c
+  [001]         instructions:  ffff000008559ae0 pl011_console_write+0xa0
+  [001]         instructions:  ffff000008559ad0 pl011_console_write+0x90
+  [001]         instructions:  ffff000008559230 pl011_read+0x0
+  [001]         instructions:  ffff00000855924c pl011_read+0x1c
+  [001]         instructions:  ffff000008559ae0 pl011_console_write+0xa0
+  [001]         instructions:  ffff000008559ad0 pl011_console_write+0x90
+  [001]         instructions:  ffff000008559230 pl011_read+0x0
+  [001]         instructions:  ffff00000855924c pl011_read+0x1c
+
+[1] Documentation/kdump/kdump.txt
+[2] Documentation/trace/coresight/coresight.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index d7a6fc7..26276e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1309,6 +1309,7 @@ S:	Maintained
 F:	drivers/hwtracing/coresight/*
 F:	Documentation/trace/coresight/coresight.txt
 F:	Documentation/trace/coresight/coresight-cpu-debug.txt
+F:	Documentation/trace/coresight/coresight-panic-kdump.txt
 F:	Documentation/devicetree/bindings/arm/coresight.txt
 F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
-- 
2.7.4
