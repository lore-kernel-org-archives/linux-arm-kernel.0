From: robert.walker@arm.com (Robert Walker)
Date: Wed, 14 Feb 2018 11:24:41 +0000
Subject: [PATCH v2 3/3] coresight: Update documentation for perf usage
In-Reply-To: <1518607481-4059-1-git-send-email-robert.walker@arm.com>
References: <1518607481-4059-1-git-send-email-robert.walker@arm.com>
Message-ID: <1518607481-4059-4-git-send-email-robert.walker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add notes on using perf to collect and analyze CoreSight trace

Signed-off-by: Robert Walker <robert.walker@arm.com>
---
 Documentation/trace/coresight.txt | 51 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index a33c88c..eb5d1e4 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -330,3 +330,54 @@ Details on how to use the generic STM API can be found here [2].
 
 [1]. Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
 [2]. Documentation/trace/stm.txt
+
+
+Using perf tools
+----------------
+
+perf can be used to record and analyze trace of programs.
+
+Execution can be recorded using perf record with the cs_etm event,
+specifying the name of the sink to record to, e.g:
+
+    perf record -e cs_etm/@20070000.etr/u --per-thread
+
+The perf report and script commands can be used to analyze execution,
+synthesizing instruction and branch events from the instruction trace. perf
+inject can be used to replace the trace data with the synthesized events.
+The --itrace option controls the type and frequency of synthesized events
+(see perf documentation).
+
+Note that only 64-bit programs are currently supported - further work is
+required to support instruction decode of 32-bit Arm programs.
+
+
+Generating coverage files for Feedback Directed Optimization: AutoFDO
+---------------------------------------------------------------------
+
+perf inject accepts the --itrace option in which case tracing data is
+removed and replaced with the synthesized events. e.g.
+
+	perf inject --itrace --strip -i perf.data -o perf.data.new
+
+Below is an example of using ARM ETM for autoFDO.  It requires autofdo
+(https://github.com/google/autofdo) and gcc version 5.  The bubble
+sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tutorial).
+
+	$ gcc-5 -O3 sort.c -o sort
+	$ taskset -c 2 ./sort
+	Bubble sorting array of 30000 elements
+	5910 ms
+
+	$ perf record -e cs_etm/@20070000.etr/u --per-thread taskset -c 2 ./sort
+	Bubble sorting array of 30000 elements
+	12543 ms
+	[ perf record: Woken up 35 times to write data ]
+	[ perf record: Captured and wrote 69.640 MB perf.data ]
+
+	$ perf inject -i perf.data -o inj.data --itrace=il64 --strip
+	$ create_gcov --binary=./sort --profile=inj.data --gcov=sort.gcov -gcov_version=1
+	$ gcc-5 -O3 -fauto-profile=sort.gcov sort.c -o sort_autofdo
+	$ taskset -c 2 ./sort_autofdo
+	Bubble sorting array of 30000 elements
+	5806 ms
-- 
2.7.4
