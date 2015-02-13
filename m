From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:40:26 +0800
Subject: [RFC PATCH v3 04/26] ftrace: don't update record flags if code
 modification fail.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806026-61660-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X86 and common ftrace_replace_code() behave differently.

In x86, rec->flags get updated only when (almost) all works are done. In
common code, rec->flags is updated before code modification, and never
get restored when code modification fails.

This patch ensures rec->flags kept its original value if
ftrace_replace_code() fail. A later patch will correct that function
for x86.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kernel/trace/ftrace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 45e5cb1..6c6cbb1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2254,23 +2254,30 @@ __ftrace_replace_code(struct dyn_ftrace *rec, int enable)
 	/* This needs to be done before we call ftrace_update_record */
 	ftrace_old_addr = ftrace_get_addr_curr(rec);
 
-	ret = ftrace_update_record(rec, enable);
+	ret = ftrace_test_record(rec, enable);
 
 	switch (ret) {
 	case FTRACE_UPDATE_IGNORE:
 		return 0;
 
 	case FTRACE_UPDATE_MAKE_CALL:
-		return ftrace_make_call(rec, ftrace_addr);
+		ret = ftrace_make_call(rec, ftrace_addr);
+		break;
 
 	case FTRACE_UPDATE_MAKE_NOP:
-		return ftrace_make_nop(NULL, rec, ftrace_old_addr);
+		ret = ftrace_make_nop(NULL, rec, ftrace_old_addr);
+		break;
 
 	case FTRACE_UPDATE_MODIFY_CALL:
-		return ftrace_modify_call(rec, ftrace_old_addr, ftrace_addr);
+		ret = ftrace_modify_call(rec, ftrace_old_addr, ftrace_addr);
+		break;
 	}
 
-	return -1; /* unknow ftrace bug */
+	if (ret)
+		return -1; /* unknow ftrace bug */
+
+	ftrace_update_record(rec, enable);
+	return 0;
 }
 
 void __weak ftrace_replace_code(int enable)
-- 
1.8.4
