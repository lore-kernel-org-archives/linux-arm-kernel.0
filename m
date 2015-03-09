From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Mon,  9 Mar 2015 18:03:44 +0000
Subject: [PATCH 1/2] of: fix handling of '/' in options for
 of_find_node_by_path()
In-Reply-To: <1425924225-22748-1-git-send-email-leif.lindholm@linaro.org>
References: <1425924225-22748-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1425924225-22748-2-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure proper handling of paths with appended options (after ':'),
where those options may contain a '/'.

Fixes: 7914a7c5651a ("of: support passing console options with stdout-path")
Reported-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 drivers/of/base.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 0a8aeb8..8b904e5 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -714,16 +714,17 @@ static struct device_node *__of_find_node_by_path(struct device_node *parent,
 						const char *path)
 {
 	struct device_node *child;
-	int len = strchrnul(path, '/') - path;
-	int term;
+	int len;
+	const char *end;
 
+	end = strchr(path, ':');
+	if (!end)
+		end = strchrnul(path, '/');
+
+	len = end - path;
 	if (!len)
 		return NULL;
 
-	term = strchrnul(path, ':') - path;
-	if (term < len)
-		len = term;
-
 	__for_each_child_of_node(parent, child) {
 		const char *name = strrchr(child->full_name, '/');
 		if (WARN(!name, "malformed device_node %s\n", child->full_name))
@@ -768,8 +769,12 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
 
 	/* The path could begin with an alias */
 	if (*path != '/') {
-		char *p = strchrnul(path, '/');
-		int len = separator ? separator - path : p - path;
+		int len;
+		const char *p = separator;
+
+		if (!p)
+			p = strchrnul(path, '/');
+		len = p - path;
 
 		/* of_aliases must not be NULL */
 		if (!of_aliases)
@@ -794,6 +799,8 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
 		path++; /* Increment past '/' delimiter */
 		np = __of_find_node_by_path(np, path);
 		path = strchrnul(path, '/');
+		if (separator && separator < path)
+			break;
 	}
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 	return np;
-- 
2.1.4
