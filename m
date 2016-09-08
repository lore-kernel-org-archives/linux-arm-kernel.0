From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  8 Sep 2016 11:21:51 +0100
Subject: [RFCv4 6/7] perf: util: only open events on CPUs an evsel permits
In-Reply-To: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
References: <1473330112-28528-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1473330112-28528-7-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In systems with heterogeneous CPU PMUs, it's possible for each evsel to
cover a distinct set of CPUs, and hence the cpu_map associated with each
evsel may have a distinct idx<->id mapping. Any of these may be distinct from
the evlist's cpu map.

Events can be tied to the same fd so long as they use the same per-cpu
ringbuffer (i.e. so long as they are on the same CPU). To acquire the
correct FDs, we must compare the Linux logical IDs rather than the evsel
or evlist indices.

This path adds logic to perf_evlist__mmap_per_evsel to handle this,
translating IDs as required. As PMUs may cover a subset of CPUs from the
evlist, we skip the CPUs a PMU cannot handle.

Without this patch, perf record may try to mmap erroneous FDs on
heterogeneous systems, and will bail out early rather than running the
workload.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel at vger.kernel.org
---
 tools/perf/util/evlist.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 097b3ed..ea34c5a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1032,16 +1032,18 @@ perf_evlist__should_poll(struct perf_evlist *evlist __maybe_unused,
 }
 
 static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
-				       struct mmap_params *mp, int cpu,
+				       struct mmap_params *mp, int cpu_idx,
 				       int thread, int *_output, int *_output_backward)
 {
 	struct perf_evsel *evsel;
 	int revent;
+	int evlist_cpu = cpu_map__cpu(evlist->cpus, cpu_idx);
 
 	evlist__for_each_entry(evlist, evsel) {
 		struct perf_mmap *maps = evlist->mmap;
 		int *output = _output;
 		int fd;
+		int cpu;
 
 		if (evsel->attr.write_backward) {
 			output = _output_backward;
@@ -1060,6 +1062,10 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 		if (evsel->system_wide && thread)
 			continue;
 
+		cpu = cpu_map__idx(evsel->cpus, evlist_cpu);
+		if (cpu == -1)
+			continue;
+
 		fd = FD(evsel, cpu, thread);
 
 		if (*output == -1) {
-- 
1.9.1
