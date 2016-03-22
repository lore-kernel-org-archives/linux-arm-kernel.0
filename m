From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 22 Mar 2016 18:58:26 +0100
Subject: [PATCH 3/6] of: Remove counting special case from
 __of_parse_phandle_with_args()
In-Reply-To: <1458669509-7178-1-git-send-email-joro@8bytes.org>
References: <1458669509-7178-1-git-send-email-joro@8bytes.org>
Message-ID: <1458669509-7178-4-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <jroedel@suse.de>

The index = -1 case in __of_parse_phandle_with_args() is
used to just return the number of phandles. That special
case needs extra handling, so move it to the place where it
is needed: of_count_phandle_with_args().

This allows to further simplify __of_parse_phandle_with_args()
later on.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/of/base.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 4036512..15593cd 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1583,10 +1583,7 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 	 * Unlock node before returning result; will be one of:
 	 * -ENOENT : index is for empty phandle
 	 * -EINVAL : parsing error on data
-	 * [1..n]  : Number of phandle (count mode; when index = -1)
 	 */
-	if (rc == -ENOENT && index < 0)
-		rc = cur_index;
 
  err:
 	if (it.node)
@@ -1722,8 +1719,20 @@ EXPORT_SYMBOL(of_parse_phandle_with_fixed_args);
 int of_count_phandle_with_args(const struct device_node *np, const char *list_name,
 				const char *cells_name)
 {
-	return __of_parse_phandle_with_args(np, list_name, cells_name, 0, -1,
-					    NULL);
+	struct of_phandle_iterator it;
+	int rc, cur_index = 0;
+
+	rc = of_phandle_iterator_init(&it, np, list_name, cells_name, 0);
+	if (rc)
+		return rc;
+
+	while ((rc = of_phandle_iterator_next(&it)) == 0)
+		cur_index += 1;
+
+	if (rc != -ENOENT)
+		return rc;
+
+	return cur_index;
 }
 EXPORT_SYMBOL(of_count_phandle_with_args);
 
-- 
1.9.1
