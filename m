From: john.garry@huawei.com (John Garry)
Date: Wed, 6 Dec 2017 00:13:16 +0800
Subject: [RFC PATCH 2/5] perf jevents: add support for arch recommended events
In-Reply-To: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
Message-ID: <1512490399-94107-3-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some architectures (like arm64), there are architecture-
defined recommended events. Vendors may not be obliged to
follow the recommendation and may implement their own pmu
event for a specific event code.

This patch adds support for parsing events from arch-defined
recommended JSONs, and then fixing up vendor events when
they have implemented these events as recommended.

In the vendor JSON, to specify that the event is supported
according to the recommendation, only the event code is
added to the JSON entry - no other event elements need be
added, like below:
[
    {
        "EventCode": "0x40",
    },

]

The pmu event parsing will check for "BriefDescription"
field presence only for this.

If "BriefDescription" is present, then it is implied
that the vendor has implemented their own custom event,
and there is no fixup. Other fields are ignored.

*TODO: update documentation

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 215 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 198 insertions(+), 17 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index a0d489e..a820ed4 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -42,6 +42,7 @@
 #include <dirent.h>
 #include <sys/time.h>			/* getrlimit */
 #include <sys/resource.h>		/* getrlimit */
+#include <sys/queue.h>
 #include <ftw.h>
 #include <sys/stat.h>
 #include "jsmn.h"
@@ -366,6 +367,94 @@ static int print_events_table_entry(void *data, char *name, char *event,
 	return 0;
 }
 
+struct event_struct {
+	char *name;
+	char *event;
+	char *desc;
+	char *long_desc;
+	char *pmu;
+	char *unit;
+	char *perpkg;
+	char *metric_expr;
+	char *metric_name;
+	char *metric_group;
+	LIST_ENTRY(event_struct) list;
+	char strings[];
+};
+
+LIST_HEAD(listhead, event_struct) recommended_events;
+
+static int save_recommended_events(void *data, char *name, char *event,
+				    char *desc, char *long_desc,
+				    char *pmu, char *unit, char *perpkg,
+				    char *metric_expr,
+				    char *metric_name, char *metric_group)
+{
+	static int count = 0;
+	char temp[1024];
+	struct event_struct *es;
+	struct stat *sb = data;
+	int len = 0;
+	char *strings;
+
+	/*
+	 * Lazily allocate size of the JSON file to hold the
+	 * strings, which would be more than large enough.
+	 */
+	len = sb->st_size;
+
+	es = malloc(sizeof(*es) + len);
+	if (!es)
+		return -ENOMEM;
+	memset(es, 0, sizeof(*es));
+	LIST_INSERT_HEAD(&recommended_events, es, list);
+
+	strings = &es->strings[0];
+
+	if (name) {
+		es->name = strings;
+		strings += snprintf(strings, len, "%s", name) + 1;
+	}
+	if (event) {
+		es->event = strings;
+		strings += snprintf(strings, len, "%s", event) + 1;
+	}
+	if (desc) {
+		es->desc = strings;
+		strings += snprintf(strings, len, "%s", desc) + 1;
+	}
+	if (long_desc) {
+		es->long_desc = strings;
+		strings += snprintf(strings, len, "%s", long_desc) + 1;
+	}
+	if (pmu) {
+		es->pmu = strings;
+		strings += snprintf(strings, len, "%s", pmu) + 1;
+	}
+	if (unit) {
+		es->unit = strings;
+		strings += snprintf(strings, len, "%s", unit) + 1;
+	}
+	if (perpkg) {
+		es->perpkg = strings;
+		strings += snprintf(strings, len, "%s", perpkg) + 1;
+	}
+	if (metric_expr) {
+		es->metric_expr = strings;
+		strings += snprintf(strings, len, "%s", metric_expr) + 1;
+	}
+	if (metric_name) {
+		es->metric_name = strings;
+		strings += snprintf(strings, len, "%s", metric_name) + 1;
+	}
+	if (metric_group) {
+		es->metric_group = strings;
+		strings += snprintf(strings, len, "%s", metric_group) + 1;
+	}
+
+	return 0;
+}
+
 static void print_events_table_suffix(FILE *outfp)
 {
 	fprintf(outfp, "{\n");
@@ -407,6 +496,61 @@ static char *real_event(const char *name, char *event)
 	return event;
 }
 
+static void fixup_field(char *from, char **to)
+{
+	/*
+	 * If we already had a valid pointer (string), then
+	 * don't allocate a new one, just reuse and overwrite.
+	 */
+	if (!*to)
+		*to = malloc(strlen(from));
+
+	strcpy(*to, from);
+}
+
+static int try_fixup(const char *fn, char *event, char **desc, char **name, char **long_desc, char **pmu, char **filter,
+				char **perpkg, char **unit, char **metric_expr, char **metric_name, char **metric_group)
+{
+	/* try to find matching event from recommended values */
+	struct event_struct *es;
+
+	LIST_FOREACH(es, &recommended_events, list) {
+		if (!strcmp(event, es->event)) {
+			/* now fixup */
+			if (es->desc)
+				fixup_field(es->desc, desc);
+			if (es->name)
+				fixup_field(es->name, name);
+			if (es->long_desc)
+				fixup_field(es->long_desc, long_desc);
+			if (es->pmu)
+				fixup_field(es->pmu, pmu);
+		//	if (event_struct->filter)
+		//		fixup_field(event_struct->filter, filter);
+			if (es->perpkg)
+				fixup_field(es->perpkg, perpkg);
+			if (es->unit)
+				fixup_field(es->unit, unit);
+			if (es->metric_expr)
+				fixup_field(es->metric_expr, metric_expr);
+			if (es->metric_name)
+				fixup_field(es->metric_name, metric_name);
+			if (es->metric_group)
+				fixup_field(es->metric_group, metric_group);
+
+			return 0;
+		}
+	}
+
+	pr_err("%s: could not find matching %s for %s\n", prog, event, fn);
+	return -1;
+}
+
+#define  FREE_MEMORIES \
+		free(event); free(desc); free(name); free(long_desc); \
+		free(extra_desc);  free(pmu); free(filter); free(perpkg); \
+		free(unit); free(metric_expr); free(metric_name);
+
 /* Call func with each event in the json file */
 int json_events(const char *fn,
 	  int (*func)(void *data, char *name, char *event, char *desc,
@@ -551,20 +695,22 @@ int json_events(const char *fn,
 		if (name)
 			fixname(name);
 
+		if (!desc) {
+			/*
+			 * If we have no valid desc, then fixup *all* values from recommended
+			 * by matching the event.
+			 */
+			err = try_fixup(fn, event, &desc, &name, &long_desc, &pmu, &filter, &perpkg, &unit, &metric_expr,
+					&metric_name, &metric_group);
+			if (err) {
+				FREE_MEMORIES
+				goto out_free;
+			}
+		}
+
 		err = func(data, name, real_event(name, event), desc, long_desc,
 			   pmu, unit, perpkg, metric_expr, metric_name, metric_group);
-		free(event);
-		free(desc);
-		free(name);
-		free(long_desc);
-		free(extra_desc);
-		free(pmu);
-		free(filter);
-		free(perpkg);
-		free(unit);
-		free(metric_expr);
-		free(metric_name);
-		free(metric_group);
+		FREE_MEMORIES
 		if (err)
 			break;
 		tok += j;
@@ -776,6 +922,32 @@ static int isLeafDir(const char *fpath)
 	return res;
 }
 
+static int isJsonFile(const char *name)
+{
+	const char *suffix;
+
+	if (strlen(name) < 5)
+		return 0;
+
+	suffix = name + strlen(name) - 5;
+
+	if (strncmp(suffix, ".json", 5) == 0)
+		return 1;
+	return 0;
+}
+
+static int preprocess_level0_files(const char *fpath, const struct stat *sb,
+				int typeflag, struct FTW *ftwbuf)
+{
+	int level	= ftwbuf->level;
+	int is_file = typeflag == FTW_F;
+
+	if (level == 1 && is_file && isJsonFile(fpath))
+		return json_events(fpath, save_recommended_events, (void *)sb);
+
+	return 0;
+}
+
 static int process_one_file(const char *fpath, const struct stat *sb,
 			    int typeflag, struct FTW *ftwbuf)
 {
@@ -806,8 +978,10 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 		 level, sb->st_size, bname, fpath);
 
 	/* base dir */
-	if (level == 0)
-		return 0;
+	if (level == 0) {
+		LIST_INIT(&recommended_events);
+		return nftw(fpath, preprocess_level0_files, get_maxfds(), 0);
+	}
 
 	/* model directory, reset topic */
 	if (level == 1 && is_dir && isLeafDir(fpath)) {
@@ -869,9 +1043,7 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 	 * ignore it. It could be a readme.txt for instance.
 	 */
 	if (is_file) {
-		char *suffix = bname + strlen(bname) - 5;
-
-		if (strncmp(suffix, ".json", 5)) {
+		if (!isJsonFile(bname)) {
 			pr_info("%s: Ignoring file without .json suffix %s\n", prog,
 				fpath);
 			return 0;
@@ -933,6 +1105,7 @@ int main(int argc, char *argv[])
 	const char *output_file;
 	const char *start_dirname;
 	struct stat stbuf;
+	struct event_struct *es1, *es2;
 
 	prog = basename(argv[0]);
 	if (argc < 4) {
@@ -988,6 +1161,14 @@ int main(int argc, char *argv[])
 		goto empty_map;
 	}
 
+	/* Free struct for recommended events */
+	es1 = LIST_FIRST(&recommended_events);
+	while (es1) {
+		es2 = LIST_NEXT(es1, list);
+		free(es1);
+		es1 = es2;
+	}
+
 	if (close_table)
 		print_events_table_suffix(eventsfp);
 
-- 
1.9.1
