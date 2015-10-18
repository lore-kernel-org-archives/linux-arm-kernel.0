From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:41 -0600
Subject: [PATCH V2 24/30] perf tools: making function set_max_cpu_num() non
 static
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-25-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For memory allocation purpuses, code located in other places
then util/cpumap.c may want to know how many CPUs the system has.

This patch is making function set_max_cpu_num() available to
other parts of the perf tool so that global variable
@max_cpu_num gets the right value when referenced by cpu__max_cpu().

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cpumap.c | 2 +-
 tools/perf/util/cpumap.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 3667e2123e5b..97ef46e4a0f6 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -373,7 +373,7 @@ out:
 }
 
 /* Determine highest possible cpu in the system for sparse allocation */
-static void set_max_cpu_num(void)
+void set_max_cpu_num(void)
 {
 	const char *mnt;
 	char path[PATH_MAX];
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 0af9cecb4c51..6f7dce7dcca6 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -14,6 +14,7 @@ struct cpu_map {
 	int map[];
 };
 
+void set_max_cpu_num(void);
 struct cpu_map *cpu_map__new(const char *cpu_list);
 struct cpu_map *cpu_map__dummy_new(void);
 struct cpu_map *cpu_map__read(FILE *file);
-- 
1.9.1
