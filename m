From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 3 Mar 2015 13:09:04 +0800
Subject: [PATCH 2/3] ftrace/x86: don't return error if other makes a same code
 change.
In-Reply-To: <1425359345-38714-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
 <1425359345-38714-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425359345-38714-3-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In ftrace_modify_code_direct(), if the target instruction has already
been modified by other to the desire instruction, don't return error.

This patch is for early kprobe. If an early kprobe is unregistered
before ftrace is ready, the instruction may have already been restored
to NOP.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/ftrace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 0a86c7c..fba1779 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -121,8 +121,13 @@ ftrace_modify_code_direct(unsigned long ip, unsigned const char *old_code,
 		return -EFAULT;
 
 	/* Make sure it is what we expect it to be */
-	if (memcmp(replaced, old_code, MCOUNT_INSN_SIZE) != 0)
-		return -EINVAL;
+	if (memcmp(replaced, old_code, MCOUNT_INSN_SIZE) != 0) {
+		/* Check if someone else has already done it */
+		if (memcmp(replaced, new_code, MCOUNT_INSN_SIZE) != 0)
+			return -EINVAL;
+		else
+			return 0;
+	}
 
 	ip = text_ip_addr(ip);
 
-- 
1.8.4
