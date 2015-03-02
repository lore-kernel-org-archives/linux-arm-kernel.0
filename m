From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:58 +0800
Subject: [RFC PATCH v4 20/34] ftrace/x86: Ensure rec->flags no change when
 failure occures.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-21-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't change rec->flags if code modification fails.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/ftrace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 8b7b0a5..7bdba65 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -497,6 +497,7 @@ static int finish_update(struct dyn_ftrace *rec, int enable)
 {
 	unsigned long ftrace_addr;
 	int ret;
+	unsigned long old_flags = rec->flags;
 
 	ret = ftrace_update_record(rec, enable);
 
@@ -509,14 +510,18 @@ static int finish_update(struct dyn_ftrace *rec, int enable)
 	case FTRACE_UPDATE_MODIFY_CALL:
 	case FTRACE_UPDATE_MAKE_CALL:
 		/* converting nop to call */
-		return finish_update_call(rec, ftrace_addr);
+		ret = finish_update_call(rec, ftrace_addr);
+		break;
 
 	case FTRACE_UPDATE_MAKE_NOP:
 		/* converting a call to a nop */
-		return finish_update_nop(rec);
+		ret = finish_update_nop(rec);
+		break;
 	}
 
-	return 0;
+	if (ret)
+		rec->flags = old_flags;
+	return ret;
 }
 
 static void do_sync_core(void *data)
-- 
1.8.4
