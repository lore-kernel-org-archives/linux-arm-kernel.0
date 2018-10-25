From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 24 Oct 2018 17:09:04 -0700
Subject: [PATCH 1/2] perf tools: Make find_vdso_map() more modular
In-Reply-To: <20181025000905.6095-1-f.fainelli@gmail.com>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
Message-ID: <20181025000905.6095-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for checking that the vectors page on the ARM
architecture, refactor the find_vdso_map() function to accept finding an
arbitrary string and create a dedicated helper function for that under
util/find-map.c and update find_vdso_map() to use it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/perf/util/find-map.c      | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/find-vdso-map.c | 30 +++---------------------------
 2 files changed, 34 insertions(+), 27 deletions(-)
 create mode 100644 tools/perf/util/find-map.c

diff --git a/tools/perf/util/find-map.c b/tools/perf/util/find-map.c
new file mode 100644
index 000000000000..42533fc21108
--- /dev/null
+++ b/tools/perf/util/find-map.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+static int find_map(void **start, void **end, const char *name)
+{
+	FILE *maps;
+	char line[128];
+	int found = 0;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps) {
+		fprintf(stderr, "vdso: cannot open maps\n");
+		return -1;
+	}
+
+	while (!found && fgets(line, sizeof(line), maps)) {
+		int m = -1;
+
+		/* We care only about private r-x mappings. */
+		if (2 != sscanf(line, "%p-%p r-xp %*x %*x:%*x %*u %n",
+				start, end, &m))
+			continue;
+		if (m < 0)
+			continue;
+
+		if (!strncmp(&line[m], name, sizeof(name) - 1))
+			found = 1;
+	}
+
+	fclose(maps);
+	return !found;
+}
+
diff --git a/tools/perf/util/find-vdso-map.c b/tools/perf/util/find-vdso-map.c
index d7823e3508fc..840d7d6e29e2 100644
--- a/tools/perf/util/find-vdso-map.c
+++ b/tools/perf/util/find-vdso-map.c
@@ -1,31 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "find-map.c"
+
 static int find_vdso_map(void **start, void **end)
 {
-	FILE *maps;
-	char line[128];
-	int found = 0;
-
-	maps = fopen("/proc/self/maps", "r");
-	if (!maps) {
-		fprintf(stderr, "vdso: cannot open maps\n");
-		return -1;
-	}
-
-	while (!found && fgets(line, sizeof(line), maps)) {
-		int m = -1;
-
-		/* We care only about private r-x mappings. */
-		if (2 != sscanf(line, "%p-%p r-xp %*x %*x:%*x %*u %n",
-				start, end, &m))
-			continue;
-		if (m < 0)
-			continue;
-
-		if (!strncmp(&line[m], VDSO__MAP_NAME,
-			     sizeof(VDSO__MAP_NAME) - 1))
-			found = 1;
-	}
-
-	fclose(maps);
-	return !found;
+	return find_map(start, end, VDSO__MAP_NAME);
 }
-- 
2.17.1
