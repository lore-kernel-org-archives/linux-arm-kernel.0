From: liuj97@gmail.com (Jiang Liu)
Date: Fri, 27 Sep 2013 16:04:41 +0800
Subject: [RFT PATCH v1 1/7] arm64: fix possible invalid FPSIMD initialization
 state
In-Reply-To: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
References: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
Message-ID: <1380269087-8520-2-git-send-email-liuj97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@huawei.com>

If context switching happens during executing fpsimd_flush_thread(),
stale value in FPSIMD registers will be saved into current thread's
fpsimd_state by fpsimd_thread_switch(). That may cause invalid
initialization state for the new process, so disable preemption
when executing fpsimd_flush_thread().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 arch/arm64/kernel/fpsimd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1f2e4d5..bb785d2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -80,8 +80,10 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 void fpsimd_flush_thread(void)
 {
+	preempt_disable();
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 	fpsimd_load_state(&current->thread.fpsimd_state);
+	preempt_enable();
 }
 
 #ifdef CONFIG_KERNEL_MODE_NEON
-- 
1.8.1.2
