From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Wed, 26 Apr 2017 14:56:20 +0530
Subject: [PATCH] perf evsel: Fix to perf-stat malloc corruption on arm64
 platforms
Message-ID: <1493198780-25415-1-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases, ncpus used for perf_evsel__alloc_fd and for
perf_evsel__close are not the same, this is causing memory
overwrite/corruption.

Fixing issue by using same ncpus in perf_evsel__alloc_fd.

This bug is more evident on arm64 platforms, which uses
cpu_map(cpus) for PMU core devices.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/util/evsel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ac59710..0dc94d7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1489,7 +1489,9 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		nthreads = threads->nr;
 
 	if (evsel->fd == NULL &&
-	    perf_evsel__alloc_fd(evsel, cpus->nr, nthreads) < 0)
+	    perf_evsel__alloc_fd(evsel,
+				evsel->cpus ? evsel->cpus->nr : cpus->nr,
+				nthreads) < 0)
 		return -ENOMEM;
 
 	if (evsel->cgrp) {
-- 
1.8.1.4
