From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 18 Sep 2015 10:26:34 -0600
Subject: [RFC PATCH 20/20] coresight: updating documentation to reflect
 integration with perf
In-Reply-To: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
References: <1442593594-10665-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1442593594-10665-21-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a new section giving information on how coresight has been
integrated with the perf subsystem along with a general idea of how
to control tracing from the perf tool cmd line.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight.txt | 116 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 0a5c3290e732..330020082b02 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -193,10 +193,120 @@ the information carried in "THIS_MODULE".
 How to use
 ----------
 
-Before trace collection can start, a coresight sink needs to be identify.
-There is no limit on the amount of sinks (nor sources) that can be enabled at
+There is two ways to use the coresight framework: 1) using the perf cmd line
+tool and 2) interacting directly with the coresight devices using the sysFS
+interface.  The latter will slowly be faded out as more functionality become
+available from the perf cmd line tool but for the time being both are still
+supported.  The following sections provide details on using both methods.
+
+1) Using perf framework:
+
+Coresight tracers like ETM and PTM are represented using the Perf framework's
+Performance Monitoring Unit (PMU).  As such the perf framework takes charge of
+controlling when tracing happens based on when the process(es) of interest are
+scheduled.  When configure in a system, Coresight PMUs will be listed when
+queried by the perf command line tool:
+
+linaro at linaro-nano:~$ ./perf list pmu
+
+List of pre-defined events (to be used in -e):
+
+  cs_etm//                                           [Kernel PMU event]
+
+linaro at linaro-nano:~$
+
+Regardless of the amnout ETM/PTM IP block in a system (usually equal to the
+amount of processor core), the "cs_etm" PMU will be listed only once.
+
+Before a trace can be configured and started a Coresight sink needs to be
+selected using the sysFS method (see below).  This is only temporary until
+sink selection can be made from the command line tool.
+
+linaro at linaro-nano:~$ ls /sys/bus/coresight/devices
+20010000.etb  20030000.tpiu  20040000.funnel  2201c000.ptm
+2201d000.ptm  2203c000.etm  2203d000.etm  2203e000.etm  replicator
+
+linaro at linaro-nano:~$ echo 1 > /sys/bus/coresight/devices/20010000.etb/enable_sink
+
+Once a sink has been selected configuring a Coresight PMU works the same way as
+any other PMU.  As such tracing can happen for a single CPU, a group of CPU, per
+thread or a combination of those:
+
+linaro at linaro-nano:~$ perf record -e cs_etm// --per-thread <command>
+
+linaro at linaro-nano:~$ perf record -C 0,2-3 -e cs_etm// <command>
+
+Tracing limited to user and kernel space can also be used to narrow the amount
+of collected tracers:
+
+linaro at linaro-nano:~$ perf record -e cs_etm//u --per-thread <command>
+
+linaro at linaro-nano:~$ perf record -C 0,2-3 -e cs_etm//k <command>
+
+As of this writing two ETM/PTM specific options have are available: cycle
+accurate and timestamp (please refer to the Embedded Trace Macrocell reference
+manual for details on these options).  By default both are disabled but using
+the "cycacc" and "timestamp" mnemonic within the double '/' will see those
+options configure for the upcoming trace run:
+
+linaro at linaro-nano:~$ perf record -e cs_etm/cycacc/ --per-thread <command>
+
+linaro at linaro-nano:~$ perf record -C 0,2-3 -e cs_etm/cycacc,timestamp/ <command>
+
+The Coresight PMUs can be configured to work in "full trace" or "snapshot" mode.
+In full trace mode trade acquisition is enable from beginning to end with trace
+data being recorded continuously:
+
+linaro at linaro-nano:~$ perf record -e cs_etm// dd if=/dev/random of=./test.txt bs=1k count=1000
+
+Since this can lead to a significant amount of data and that some device are
+limited in disk space snapshot mode can be used instead.  In snapshot mode
+traces are still collected in the ring buffer but not communicated to user
+space.  The ring buffer is allowed to wrap around, providing the latest
+information before an event of interest happens.  Significant events are
+communicated by sending a USR2 signal to the user space command line tool.
+From there the tool will stop trace collection and harvest data from the ring
+buffer before re-enabling traces.  Snapshot mode can be invoked using '-S' when
+launching a trace collection:
+
+linaro at linaro-nano:~$ perf record -S -e cs_etm// dd if=/dev/random of=./test.txt bs=1k count=1000
+
+Trace data collected during trace runs end up in the centennial "perf.data"
+file. Trace configuration information necessary for trace decoding are also
+embedded in the "perf.data" file.  Two new headers, 'PERF_RECORD_AUXTRACE_INFO'
+and 'PERF_RECORD_AUXTRACE' have been added to list of event types in order to
+find out where the different sections start.
+
+It is worth nothing that a set of metadata information exists for each tracer
+that participated in a trace run.  As such if 5 processors have been engaged,
+5 set of metadata will be found in the perf.data file.  This is to ensure that
+tracer decompression tools have all the information they need in order to
+process the trace data.
+
+Metadata information is collected directly from the ETM/PTM management registers
+using the sysFS interface.  Since there is not way for the perf command line
+tool to associate a CPU with a tracer, a symbolic link has been created between
+the cs_etm sysFS event directory and each Coresight tracer:
+
+linaro at linaro-nano:~$ ls /sys/bus/event_source/devices/cs_etm
+cpu0  cpu1  cpu2  cpu3  cpu4  format  perf_event_mux_interval_ms
+power  subsystem  type  uevent
+
+linaro at linaro-nano:~$ ls /sys/bus/event_source/devices/cs_etm/cpu0/mgmt/
+etmccer  etmccr  etmcr  etmidr  etmscr  etmtecr1  etmtecr2
+etmteevr  etmtraceidr  etmtssvr
+
+2) Using the sysFS interface:
+
+Most, if not all, configuration registers are made available to users via the
+sysFS interface.  Until all coresight ETM drivers have been converted to perf,
+it will also be possible to start and stop traces from sysFS.
+
+As with the perf method described above, a coresight sink needs to be identify
+before trace collection can commence.  Using the sysFS method _only_, there is
+no limit on the amount of sinks (nor sources) that can be enabled at
 any given moment.  As a generic operation, all device pertaining to the sink
-class will have an "active" entry in sysfs:
+class will have an "enable_sink" entry in sysfs:
 
 root:/sys/bus/coresight/devices# ls
 replicator  20030000.tpiu    2201c000.ptm  2203c000.etm  2203e000.etm
-- 
1.9.1
