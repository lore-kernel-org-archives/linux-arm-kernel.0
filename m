From: geoff@infradead.org (Geoff Levand)
Date: Tue, 09 Sep 2014 22:49:05 +0000
Subject: [PATCH 10/13] arm64/kexec: Revert change to machine_shutdown()
In-Reply-To: <cover.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
Message-ID: <de2fda64cc5eebcf96d9d845b185c6382c900ac3.1410302383.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 90f51a09ef83 ("arm64: Fix machine_shutdown() definition") changed the
implementation of machine_shutdown() from calling smp_send_stop() to
calling disable_nonboot_cpus().  Revert that part of the commit so that
machine_shutdown() once again calls smp_send_stop().

With the application of another patch in this series, (arm64: Use cpu_ops for
smp_stop), smp_send_stop() will do the correct thing for a kexec reboot. This
change also corrects the source code comment for the machine_shutdown() routine.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/process.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 0a3414b..cd0ae9d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -101,15 +101,12 @@ void arch_cpu_idle_dead(void)
 /*
  * Called by kexec, immediately prior to machine_kexec().
  *
- * This must completely disable all secondary CPUs; simply causing those CPUs
- * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
- * kexec'd kernel to use any and all RAM as it sees fit, without having to
- * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
- * functionality embodied in disable_nonboot_cpus() to achieve this.
+ * This must shutdown all secondary CPUs.  The functionality
+ * embodied in smp_send_stop() will achieve this.
  */
 void machine_shutdown(void)
 {
-	disable_nonboot_cpus();
+	smp_send_stop();
 }
 
 /*
-- 
1.9.1
