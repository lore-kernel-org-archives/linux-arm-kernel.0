From: john.garry@huawei.com (John Garry)
Date: Wed, 6 Dec 2017 00:13:15 +0800
Subject: [RFC PATCH 1/5] perf jevents: add support for pmu events vendor
 subdirectory
In-Reply-To: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
References: <1512490399-94107-1-git-send-email-john.garry@huawei.com>
Message-ID: <1512490399-94107-2-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some architectures (like arm64), it is required to
support a vendor sub-directory and not put all the JSONs
for a given vendor in the same dir.

This is because all the events for the same vendor will be
in the same pmu events table, which may cause conflict.
This conflict would be in the instance that a vendor's custom
implemented events do have the same meaning on different
platforms. In addition, "perf list" command may list events
which are not even supported for a given platform.

This patch adds support for an arch/vendor/platform directory
hierarchy, while maintaining support for arch/platform
structure. In this, each platform would always have its own pmu
events table.

In generated file pmu_events.c, each platform table name is in
the format pme{_vendor}_platform, like this:

struct pmu_events_map pmu_events_map[] = {
{
	.cpuid = "0x00000000420f5160",
	.version = "v1",
	.type = "core",
	.table = pme_cavium_thunderx2
},
{
	.cpuid = 0,
	.version = 0,
	.type = 0,
	.table = 0,
},
};

or this:

struct pmu_events_map pmu_events_map[] = {
{
	.cpuid = "GenuineIntel-6-56",
	.version = "v5",
	.type = "core",
	.table = pme_broadwellde
},

[snip]

{
	.cpuid = 0,
	.version = 0,
	.type = 0,
	.table = 0,
},
};

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 57 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index b578aa2..a0d489e 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -588,7 +588,7 @@ static char *file_name_to_table_name(char *fname)
 	 * Derive rest of table name from basename of the JSON file,
 	 * replacing hyphens and stripping out .json suffix.
 	 */
-	n = asprintf(&tblname, "pme_%s", basename(fname));
+	n = asprintf(&tblname, "pme_%s", fname);
 	if (n < 0) {
 		pr_info("%s: asprintf() error %s for file %s\n", prog,
 				strerror(errno), fname);
@@ -598,7 +598,7 @@ static char *file_name_to_table_name(char *fname)
 	for (i = 0; i < strlen(tblname); i++) {
 		c = tblname[i];
 
-		if (c == '-')
+		if (c == '-' || c == '/')
 			tblname[i] = '_';
 		else if (c == '.') {
 			tblname[i] = '\0';
@@ -755,15 +755,52 @@ static int get_maxfds(void)
 static FILE *eventsfp;
 static char *mapfile;
 
+static int isLeafDir(const char *fpath)
+{
+	DIR 		  *d;
+	struct dirent *dir;
+	int res = 1;
+	d = opendir(fpath);
+	if (!d)
+		return 0;
+
+	while ((dir = readdir(d)) != NULL) {
+		if (dir-> d_type == DT_DIR && dir->d_name[0] != '.') {
+			res = 0;
+			break;
+		}
+	}
+
+	closedir(d);
+
+	return res;
+}
+
 static int process_one_file(const char *fpath, const struct stat *sb,
 			    int typeflag, struct FTW *ftwbuf)
 {
-	char *tblname, *bname  = (char *) fpath + ftwbuf->base;
+	char *tblname, *bname;
 	int is_dir  = typeflag == FTW_D;
 	int is_file = typeflag == FTW_F;
 	int level   = ftwbuf->level;
 	int err = 0;
 
+	if (level == 2 && is_dir) {
+		/*
+		 * For level 2 directory, bname will include parent name,
+		 * like vendor/platform. So search back from platform dir
+		 * to find this.
+		 */
+		bname = (char *) fpath + ftwbuf->base - 2;
+		while (true) {
+			if (*bname == '/')
+				break;
+			bname--;
+		}
+		bname++;
+	} else
+		bname = (char *) fpath + ftwbuf->base;
+
 	pr_debug("%s %d %7jd %-20s %s\n",
 		 is_file ? "f" : is_dir ? "d" : "x",
 		 level, sb->st_size, bname, fpath);
@@ -773,7 +810,7 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 		return 0;
 
 	/* model directory, reset topic */
-	if (level == 1 && is_dir) {
+	if (level == 1 && is_dir && isLeafDir(fpath)) {
 		if (close_table)
 			print_events_table_suffix(eventsfp);
 
@@ -791,6 +828,18 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 
 		print_events_table_prefix(eventsfp, tblname);
 		return 0;
+	} else if (level == 2 && is_dir) {
+		if (close_table)
+			print_events_table_suffix(eventsfp);
+
+		tblname = file_name_to_table_name(bname);
+		if (!tblname) {
+			pr_info("%s: Error determining table name for %s, exiting\n", prog,
+				bname);
+			return -1;
+		}
+
+		print_events_table_prefix(eventsfp, tblname);
 	}
 
 	/*
-- 
1.9.1
