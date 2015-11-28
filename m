From: huawei.libin@huawei.com (Li Bin)
Date: Sat, 28 Nov 2015 15:50:09 +0800
Subject: [PATCH] arm64: ftrace: stop using kstop_machine to enable/disable
 tracing
Message-ID: <1448697009-17211-1-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64, kstop_machine which is hugely disruptive to a running
system is not needed to convert nops to ftrace calls or back,
because that modifed code is a single 32bit instructions which
is impossible to cross cache (or page) boundaries, and the used str
instruction is single-copy atomic.

Cc: <stable@vger.kernel.org> # 3.18+
Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 arch/arm64/kernel/ftrace.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index c851be7..9669b33 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -93,6 +93,11 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 	return ftrace_modify_code(pc, old, new, true);
 }
 
+void arch_ftrace_update_code(int command)
+{
+	ftrace_modify_all_code(command);
+}
+
 int __init ftrace_dyn_arch_init(void)
 {
 	return 0;
-- 
1.7.1
