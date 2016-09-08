From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  8 Sep 2016 11:21:52 +0100
Subject: [RFCv4 7/7] perf: util: support alternative sysfs cpumask
In-Reply-To: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
References: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1473330112-28528-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The perf tools can read a cpumask file for a PMU, describing a subset of
CPUs which that PMU covers. So far this has only been used to cater for
uncore PMUs, which in practice happen to only have a single CPU
described in the mask.

Until recently, the perf tools only correctly handled cpumask containing
a single CPU, and only when monitoring in system-wide mode. For example,
prior to commit 00e727bb389359c8 ("perf stat: Balance opening and
reading events"), a mask with more than a single CPU could cause
perf stat to hang. When a CPU PMU covers a subset of CPUs, but lacks a
cpumask, perf record will fail to open events (on the cores the PMU does
not support), and gives up.

For systems with heterogeneous CPUs such as ARM big.LITTLE systems, this
presents a problem. We have a PMU for each microarchitecture (e.g. a big
PMU and a little PMU), and would like to expose a cpumask for each (so
as to allow perf record and other tools to do the right thing). However,
doing so kernel-side will cause old perf binaries to not function (e.g.
hitting the issue solved by 00e727bb389359c8), and thus commits the
cardinal sin of breaking (existing) userspace.

To address this chicken-and-egg problem, this patch adds support got a
new file, cpus, which is largely identical to the existing cpumask file.
A kernel can expose this file, knowing that new perf binaries will
correctly support it, while old perf binaries will not look for it (and
thus will not be broken).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel at vger.kernel.org
---
 tools/perf/util/pmu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ddb0261..2babcdf 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -445,14 +445,23 @@ static struct cpu_map *pmu_cpumask(const char *name)
 	FILE *file;
 	struct cpu_map *cpus;
 	const char *sysfs = sysfs__mountpoint();
+	const char *templates[] = {
+		 "%s/bus/event_source/devices/%s/cpumask",
+		 "%s/bus/event_source/devices/%s/cpus",
+		 NULL
+	};
+	const char **template;
 
 	if (!sysfs)
 		return NULL;
 
-	snprintf(path, PATH_MAX,
-		 "%s/bus/event_source/devices/%s/cpumask", sysfs, name);
+	for (template = templates; *template; template++) {
+		snprintf(path, PATH_MAX, *template, sysfs, name);
+		if (stat(path, &st) == 0)
+			break;
+	}
 
-	if (stat(path, &st) < 0)
+	if (!*template)
 		return NULL;
 
 	file = fopen(path, "r");
-- 
1.9.1
