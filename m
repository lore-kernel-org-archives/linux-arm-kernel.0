From: dingtianhong@huawei.com (Ding Tianhong)
Date: Tue, 28 Aug 2018 21:52:29 +0800
Subject: [PATCH] arm64: don't dump stack for usermode address in show_regs
Message-ID: <d263c463-f2e3-7f2c-3eac-20297bcd9341@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch 1149aad10b ("arm64: Add dump_backtrace() in show_regs") would
help to dump the stack when debug in the socklockups, but if the issues
happened in the user space, it will be errors when dumping the usermode
address in kernel, so don't dump stack for usermode address in show_regs.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 arch/arm64/kernel/process.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 7f1628e..454825a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -249,7 +249,9 @@ void __show_regs(struct pt_regs *regs)
 void show_regs(struct pt_regs * regs)
 {
 	__show_regs(regs);
-	dump_backtrace(regs, NULL);
+
+	if (!user_mode(regs))
+		dump_backtrace(regs, NULL);
 }

 static void tls_thread_flush(void)
-- 
1.8.3.1
