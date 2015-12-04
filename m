From: huawei.libin@huawei.com (Li Bin)
Date: Fri, 4 Dec 2015 11:38:40 +0800
Subject: [PATCH v3 2/2] arm64: ftrace: fix the comments for ftrace_modify_code
In-Reply-To: <1449200320-24854-1-git-send-email-huawei.libin@huawei.com>
References: <1449200320-24854-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <1449200320-24854-3-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to worry about module and __init text disappearing
case, because that ftrace has a module notifier that is called when
a module is being unloaded and before the text goes away and this
code grabs the ftrace_lock mutex and removes the module functions
from the ftrace list, such that it will no longer do any
modifications to that module's text, the update to make functions
be traced or not is done under the ftrace_lock mutex as well.
And by now, __init section codes should not been modified
by ftrace, because it is black listed in recordmcount.c and
ignored by ftrace.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 arch/arm64/kernel/ftrace.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 9669b33..8f7005b 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -29,12 +29,11 @@ static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
 
 	/*
 	 * Note:
-	 * Due to modules and __init, code can disappear and change,
-	 * we need to protect against faulting as well as code changing.
-	 * We do this by aarch64_insn_*() which use the probe_kernel_*().
-	 *
-	 * No lock is held here because all the modifications are run
-	 * through stop_machine().
+	 * We are paranoid about modifying text, as if a bug were to happen, it
+	 * could cause us to read or write to someplace that could cause harm.
+	 * Carefully read and modify the code with aarch64_insn_*() which uses
+	 * probe_kernel_*(), and make sure what we read is what we expected it
+	 * to be before modifying it.
 	 */
 	if (validate) {
 		if (aarch64_insn_read((void *)pc, &replaced))
-- 
1.7.1
