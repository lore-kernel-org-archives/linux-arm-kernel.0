From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 13 Feb 2015 13:40:41 +0800
Subject: [RFC PATCH v3 10/26] ftrace: x86: try to fix ftrace when
 ftrace_replace_code.
In-Reply-To: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
References: <1423805941-61407-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1423806041-61907-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For ftrace x86, when ftrace_replace_code(), if it failed to add
breakpoint, trigger a bugfix trying instead of ftrace_bug().

Only give one chance for fixing at add_breakpoints(). If it fails at
other stage, bug directly.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/ftrace.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 7bdba65..c869138 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -553,8 +553,16 @@ void ftrace_replace_code(int enable)
 		rec = ftrace_rec_iter_record(iter);
 
 		ret = add_breakpoints(rec, enable);
-		if (ret)
-			goto remove_breakpoints;
+		if (ret) {
+			/*
+			 * Don't trigger ftrace_bug here. Let it done by
+			 * remove_breakpoints procedure.
+			 */
+			ret = __ftrace_tryfix_bug(ret, enable, rec,
+					add_breakpoints(rec, enable), false);
+			if (ret)
+				goto remove_breakpoints;
+		}
 		count++;
 	}
 
-- 
1.8.4
