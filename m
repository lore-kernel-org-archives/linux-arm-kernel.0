From: john.garry@huawei.com (John Garry)
Date: Thu, 8 Mar 2018 18:58:27 +0800
Subject: [PATCH v3 02/11] perf vendor events: fix error code in json_events()
In-Reply-To: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
Message-ID: <1520506716-197429-3-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When EXPECT macro fails an assertion, the error code is
not properly set after the first loop of tokens in function
json_events().

This is because err is set to the return value from func
function pointer call, which must be 0 to continue to loop,
yet it is not reset for for each loop. I assume that this was
not the intention, so change the code so err is set
appropriately in EXPECT macro itself.

In addition to this, the indention in EXPECT macro is
tidied. The current indention alludes that the 2 statements
following the if statement are in the body, which is not
true.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/pmu-events/jevents.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 9e0a21e..edff989 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -249,9 +249,10 @@ static const char *field_to_perf(struct map *table, char *map, jsmntok_t *val)
 	jsmntok_t *loc = (t);					\
 	if (!(t)->start && (t) > tokens)			\
 		loc = (t) - 1;					\
-		pr_err("%s:%d: " m ", got %s\n", fn,		\
-			json_line(map, loc),			\
-			json_name(t));				\
+	pr_err("%s:%d: " m ", got %s\n", fn,			\
+	       json_line(map, loc),				\
+	       json_name(t));					\
+	err = -EIO;						\
 	goto out_free;						\
 } } while (0)
 
@@ -416,7 +417,7 @@ int json_events(const char *fn,
 		      char *metric_name, char *metric_group),
 	  void *data)
 {
-	int err = -EIO;
+	int err;
 	size_t size;
 	jsmntok_t *tokens, *tok;
 	int i, j, len;
-- 
1.9.1
