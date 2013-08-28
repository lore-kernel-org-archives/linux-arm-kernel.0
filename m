From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 28 Aug 2013 12:35:59 +0100
Subject: [RFC PATCH 07/14] arm64: kernel: implement fpsimd CPU PM notifier
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1377689766-17642-8-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a CPU enters a low power state, its FP register content is lost.
This patch adds a notifier to save the FP context on CPU shutdown
and restore it on CPU resume. The context is saved and restored only
if the suspending thread is not a kernel thread, mirroring the current
context switch behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e8b8357..b5b94f6 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -17,6 +17,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/sched.h>
@@ -83,6 +84,39 @@ void fpsimd_flush_thread(void)
 	fpsimd_load_state(&current->thread.fpsimd_state);
 }
 
+#ifdef CONFIG_CPU_PM
+static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
+				  unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		if (current->mm)
+			fpsimd_save_state(&current->thread.fpsimd_state);
+		break;
+	case CPU_PM_EXIT:
+		if (current->mm)
+			fpsimd_load_state(&current->thread.fpsimd_state);
+		break;
+	case CPU_PM_ENTER_FAILED:
+	default:
+		return NOTIFY_DONE;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block fpsimd_cpu_pm_notifier_block = {
+	.notifier_call = fpsimd_cpu_pm_notifier,
+};
+
+static void fpsimd_pm_init(void)
+{
+	cpu_pm_register_notifier(&fpsimd_cpu_pm_notifier_block);
+}
+
+#else
+static inline void fpsimd_pm_init(void) { }
+#endif /* CONFIG_CPU_PM */
+
 /*
  * FP/SIMD support code initialisation.
  */
@@ -101,6 +135,8 @@ static int __init fpsimd_init(void)
 	else
 		elf_hwcap |= HWCAP_ASIMD;
 
+	fpsimd_pm_init();
+
 	return 0;
 }
 late_initcall(fpsimd_init);
-- 
1.8.3.4
