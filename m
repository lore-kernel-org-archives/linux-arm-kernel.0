From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Wed,  2 Oct 2013 14:34:16 +0300
Subject: [RFC PATCH] ARM: Flush L2 cache on soft_restart
Message-ID: <1380713656-24752-1-git-send-email-taras.kondratiuk@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kexec disables L2 cache before jumping to reboot code,
but it doesn't flush it. So often just copied reboot code
gets corrupted, because part of it is stored in L2 cache
and have not reached memory.

Flushing cache prevents this corruption.

I'm facing this issue on Pandaboard ES, but it looks like
similar issue is observed on TC2 board [1].

[1] http://www.spinics.net/lists/arm-kernel/msg264339.html

Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 arch/arm/kernel/process.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 94f6b05..e359b62 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -103,9 +103,11 @@ void soft_restart(unsigned long addr)
 	local_irq_disable();
 	local_fiq_disable();
 
-	/* Disable the L2 if we're the last man standing. */
-	if (num_online_cpus() == 1)
+	/* Flush and disable the L2 if we're the last man standing. */
+	if (num_online_cpus() == 1) {
+		outer_flush_all();
 		outer_disable();
+	}
 
 	/* Change to the new stack and continue with the reset. */
 	call_with_stack(__soft_restart, (void *)addr, (void *)stack);
-- 
1.7.9.5
