From: kim.phillips@arm.com (Kim Phillips)
Date: Fri, 27 Oct 2017 18:38:20 -0500
Subject: [PATCH 2/2] perf tools: arm-spe: add customized strerror function
Message-ID: <20171027183820.8f7a789c322fca10db8f9b3f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a routine to try to help the user determine how they're
supposed to use the SPE driver.

Example #1:  Trouble setting sample rate:

$ sudo ./perf record -e arm_spe_0/ts_enable=1,pa_enable=1/ -F 1 true
Error:
required sample period missing.  Use '--count=<non-zero value>'
$ ./perf record -e arm_spe_0/ts_enable=1/ -c 0 true
Error:
required sample period missing.  Use '--count=<non-zero value>'
$ ./perf record -e arm_spe_0/ts_enable=1/ -c 1 true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.009 MB perf.data ]
$

Example #2:  Non-privileged user tries to obtain physical address data:

$ ./perf record -e arm_spe_0/ts_enable=1,pa_enable=1/ -c 1 true
Error:
arm_spe_0/ts_enable=1,pa_enable=1/:u: physical address and time, and EL1 context ID data collection
        require admin privileges
$ sudo ./perf record -e arm_spe_0/ts_enable=1,pa_enable=1/ -c 1 true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.054 MB perf.data ]
$

Example #3:  Trying to exclude idle profiling:

$ sudo ./perf record -e arm_spe_0/ts_enable=1,pa_enable=1/I -c 1 true
Error:
arm_spe_0/ts_enable=1,pa_enable=1/I: Cannot exclude profiling when idle, try without //I
$

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
DO NOT APPLY:  This should really be an RFC, since depends on this RFC:

https://www.spinics.net/lists/arm-kernel/msg613725.html

but providing as part of SPE tool patch anyway in case it helps
resolve the RFC.

 tools/perf/arch/arm64/util/evsel.c | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/perf/arch/arm64/util/evsel.c b/tools/perf/arch/arm64/util/evsel.c
index e09cbb5d1518..222bf761d11b 100644
--- a/tools/perf/arch/arm64/util/evsel.c
+++ b/tools/perf/arch/arm64/util/evsel.c
@@ -70,6 +70,44 @@ target__has_task(target), target__has_cpu(target), target__none(target)
 	return 0;
 }
 
+#ifdef HAVE_AUXTRACE_SUPPORT
+static int strerror_arm_spe(struct perf_evsel *evsel,
+			    struct target *target __maybe_unused,
+			    int err, char *msg, size_t size)
+{
+	const char *evname = perf_evsel__name(evsel);
+	struct perf_event_attr *attr = &evsel->attr;
+
+	switch (err) {
+	case EOPNOTSUPP:
+		if (attr->exclude_idle)
+			return scnprintf(msg, size,
+	"%s: Cannot exclude profiling when idle, try without //I\n", evname);
+		return scnprintf(msg, size, "%s: unsupported error code:\n"
+	"EITHER this driver may not support a possibly h/w-implementation\n"
+	"\tdefined event filter bit that has been set in the PMSEVFR register\n"
+	"OR h/w doesn't support filtering by one or more of: latency,\n"
+	"\toperation type, or events\n", evname);
+		break;
+	case EACCES:
+		if (strstr(evname, "pa_enable") || strstr(evname, "pct_enable"))
+			return scnprintf(msg, size,
+	"%s: physical address and time, and EL1 context ID data collection\n"
+	"\trequire admin privileges\n", evname);
+		break;
+	case EINVAL:
+		if (attr->freq || !attr->sample_period)
+			return scnprintf(msg, size,
+	"required sample period missing.  Use '--count=<non-zero value>'\n");
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+#endif
+
 int perf_evsel__open_strerror_arch(struct perf_evsel *evsel,
 				   struct target *target,
 				   int err, char *msg, size_t size)
@@ -80,5 +118,10 @@ int perf_evsel__open_strerror_arch(struct perf_evsel *evsel,
 	if (strstarts(evname, "ccn"))
 		return ccn_strerror(evsel, target, err, msg, size);
 
+#ifdef HAVE_AUXTRACE_SUPPORT
+	if (strstarts(evname, "arm_spe"))
+		return strerror_arm_spe(evsel, target, err, msg, size);
+#endif
+
 	return 0;
 }
-- 
2.14.2
