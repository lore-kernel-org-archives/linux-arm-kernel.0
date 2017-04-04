From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue,  4 Apr 2017 13:06:41 +0530
Subject: [PATCH 1/3] perf jevents: Add support to use core pmu name other than
 cpu
In-Reply-To: <1491291403-29893-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1491291403-29893-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <1491291403-29893-2-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jevents assumes core event devices are listed as cpu in
sysfs, however some architecture like arm64 have custom names.

Adding provision in json files to define CPU name and
required changes in jevents.c to parse.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/pmu-events/jevents.c    | 15 ++++++++++-----
 tools/perf/pmu-events/jevents.h    |  3 ++-
 tools/perf/pmu-events/pmu-events.h |  1 +
 tools/perf/util/pmu.c              |  2 +-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index eed0934..b20e7d1 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -289,7 +289,8 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
 	close_table = 1;
 }
 
-static int print_events_table_entry(void *data, char *name, char *event,
+static int print_events_table_entry(void *data, char *name, char *cpu,
+				    char *event,
 				    char *desc, char *long_desc,
 				    char *pmu, char *unit, char *perpkg)
 {
@@ -304,6 +305,7 @@ static int print_events_table_entry(void *data, char *name, char *event,
 	fprintf(outfp, "{\n");
 
 	fprintf(outfp, "\t.name = \"%s\",\n", name);
+	fprintf(outfp, "\t.cpu = \"%s\",\n", cpu);
 	fprintf(outfp, "\t.event = \"%s\",\n", event);
 	fprintf(outfp, "\t.desc = \"%s\",\n", desc);
 	fprintf(outfp, "\t.topic = \"%s\",\n", topic);
@@ -360,8 +362,8 @@ static char *real_event(const char *name, char *event)
 
 /* Call func with each event in the json file */
 int json_events(const char *fn,
-	  int (*func)(void *data, char *name, char *event, char *desc,
-		      char *long_desc,
+	  int (*func)(void *data, char *name, char *cpu, char *event,
+		      char *desc, char *long_desc,
 		      char *pmu, char *unit, char *perpkg),
 	  void *data)
 {
@@ -381,7 +383,8 @@ int json_events(const char *fn,
 	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
 	tok = tokens + 1;
 	for (i = 0; i < tokens->size; i++) {
-		char *event = NULL, *desc = NULL, *name = NULL;
+		char *event = NULL, *desc = NULL;
+		char *name = NULL, *cpu = NULL;
 		char *long_desc = NULL;
 		char *extra_desc = NULL;
 		char *pmu = NULL;
@@ -421,6 +424,8 @@ int json_events(const char *fn,
 				free(code);
 			} else if (json_streq(map, field, "EventName")) {
 				addfield(map, &name, "", "", val);
+			} else if (json_streq(map, field, "CPU")) {
+				addfield(map, &cpu, "", "", val);
 			} else if (json_streq(map, field, "BriefDescription")) {
 				addfield(map, &desc, "", "", val);
 				fixdesc(desc);
@@ -487,7 +492,7 @@ int json_events(const char *fn,
 			addfield(map, &event, ",", msr->pname, msrval);
 		fixname(name);
 
-		err = func(data, name, real_event(name, event), desc, long_desc,
+		err = func(data, name, cpu, real_event(name, event), desc, long_desc,
 				pmu, unit, perpkg);
 		free(event);
 		free(desc);
diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
index 71e13de..d423295 100644
--- a/tools/perf/pmu-events/jevents.h
+++ b/tools/perf/pmu-events/jevents.h
@@ -2,7 +2,8 @@
 #define JEVENTS_H 1
 
 int json_events(const char *fn,
-		int (*func)(void *data, char *name, char *event, char *desc,
+		int (*func)(void *data, char *name, char *cpu,
+				char *event, char *desc,
 				char *long_desc,
 				char *pmu,
 				char *unit, char *perpkg),
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index c669a3c..c8da522 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -6,6 +6,7 @@
  */
 struct pmu_event {
 	const char *name;
+	const char *cpu;
 	const char *event;
 	const char *desc;
 	const char *topic;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 12f84dd..31b02d4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -556,7 +556,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, const char *name)
 		if (!pe->name)
 			break;
 
-		pname = pe->pmu ? pe->pmu : "cpu";
+		pname = pe->pmu ? pe->pmu : pe->cpu ? pe->cpu :"cpu";
 		if (strncmp(pname, name, strlen(pname)))
 			continue;
 
-- 
1.8.1.4
