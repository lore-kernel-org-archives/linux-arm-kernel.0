From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue, 16 May 2017 14:03:38 +0530
Subject: [PATCH v3 3/4] perf utils: Add helper function is_pmu_core to detect
 PMU CORE devices
In-Reply-To: <1494923619-18687-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1494923619-18687-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <1494923619-18687-4-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms, PMU core devices sysfs name is not cpu.
Adding function is_pmu_core to detect as core device using
core device specific hints in sysfs.

For arm64 platforms, all core devices have file "cpus" in sysfs.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/util/pmu.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index aefdbd1..0057d1c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -506,6 +506,39 @@ static struct cpu_map *pmu_cpumask(const char *name)
 }
 
 /*
+ *  PMU CORE devices have different name other than cpu in sysfs on some
+ *  platforms. looking for possible sysfs files to identify as core device.
+ */
+static int is_pmu_core(const char *name)
+{
+	struct stat st;
+	char path[PATH_MAX];
+	const char *sysfs = sysfs__mountpoint();
+	const char **template;
+	const char *templates[] = {
+		 "%s/bus/event_source/devices/%s/cpus",
+		 NULL
+	};
+
+	if (!sysfs)
+		return 0;
+
+	/* Look for cpu sysfs */
+	snprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu", sysfs);
+	if ((stat(path, &st) == 0) &&
+			(strncmp(name, "cpu", strlen("cpu")) == 0))
+		return 1;
+
+	for (template = templates; *template; template++) {
+		snprintf(path, PATH_MAX, *template, sysfs, name);
+		if (stat(path, &st) == 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+/*
  * Return the CPU id as a raw string.
  *
  * Each architecture should provide a more precise id string that
@@ -558,15 +591,18 @@ static void pmu_add_cpu_aliases(struct list_head *head, const char *name,
 	 */
 	i = 0;
 	while (1) {
-		const char *pname;
 
 		pe = &map->table[i++];
 		if (!pe->name)
 			break;
 
-		pname = pe->pmu ? pe->pmu : "cpu";
-		if (strncmp(pname, name, strlen(pname)))
-			continue;
+		if (!is_pmu_core(name)) {
+			/* check for uncore devices */
+			if (pe->pmu == NULL)
+				continue;
+			if (strncmp(pe->pmu, name, strlen(pe->pmu)))
+				continue;
+		}
 
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
-- 
1.8.1.4
