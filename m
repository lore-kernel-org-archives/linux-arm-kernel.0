From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 3 Jun 2013 21:59:03 +0800
Subject: [PATCH] thermal: thermal_core: policy store via sysfs is broken
Message-ID: <1370267943-13297-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When function __find_governor() gets called from policy_store(), the
argument 'buf' has a '\n' character at the end.  This causes strnicmp()
mismatches all the time.  Consequently, policy_store() will always
return -EINVAL, and hence the policy store via sysfs will always fail
even when users store a correct policy name.

Fix the problem by using strncasecmp() for policy name matching in
__find_governor().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/thermal/thermal_core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d755440..6ba869f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -57,9 +57,10 @@ static struct thermal_governor *__find_governor(const char *name)
 {
 	struct thermal_governor *pos;
 
-	list_for_each_entry(pos, &thermal_governor_list, governor_list)
-		if (!strnicmp(name, pos->name, THERMAL_NAME_LENGTH))
+	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
+		if (!strncasecmp(name, pos->name, strlen(pos->name)))
 			return pos;
+	}
 
 	return NULL;
 }
-- 
1.7.9.5
