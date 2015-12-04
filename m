From: huawei.libin@huawei.com (Li Bin)
Date: Fri, 4 Dec 2015 10:18:39 +0800
Subject: [PATCH v2 2/2] arm64: ftrace: fix the comments for ftrace_modify_code
In-Reply-To: <1449195519-17901-1-git-send-email-huawei.libin@huawei.com>
References: <1449195519-17901-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <1449195519-17901-3-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to worry about module text disappearing case,
because that ftrace has a module notifier that is called when
a module is being unloaded and before the text goes away, and this
code grabs the ftrace_lock mutex and removes the module functions
from the ftrace list, such that it will no longer do any
modifications to that module's text.
The update to make functions be traced or not is done under the
ftrace_lock mutex as well.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 arch/arm64/kernel/ftrace.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 9669b33..ee91c0c 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -29,12 +29,9 @@ static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
 
 	/*
 	 * Note:
-	 * Due to modules and __init, code can disappear and change,
+	 * Due to __init, code can disappear and change,
 	 * we need to protect against faulting as well as code changing.
 	 * We do this by aarch64_insn_*() which use the probe_kernel_*().
-	 *
-	 * No lock is held here because all the modifications are run
-	 * through stop_machine().
 	 */
 	if (validate) {
 		if (aarch64_insn_read((void *)pc, &replaced))
-- 
1.7.1
