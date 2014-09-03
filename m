From: keescook@chromium.org (Kees Cook)
Date: Wed,  3 Sep 2014 14:57:07 -0700
Subject: [PATCH v5 6/8] arm: kgdb: Handle read-only text / modules
In-Reply-To: <1409781429-27593-1-git-send-email-keescook@chromium.org>
References: <1409781429-27593-1-git-send-email-keescook@chromium.org>
Message-ID: <1409781429-27593-7-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Anderson <dianders@chromium.org>

Handle the case where someone has set the text segment of the kernel
as read-only by using the newly introduced "patch" mechanism.

Signed-off-by: Doug Anderson <dianders@chromium.org>
[kees: switched structure size check to BUILD_BUG_ON (sboyd)]
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/Makefile |  2 +-
 arch/arm/kernel/kgdb.c   | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 38ddd9f83d0e..70b730766330 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -67,7 +67,7 @@ test-kprobes-objs		+= kprobes-test-arm.o
 endif
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
 obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
-obj-$(CONFIG_KGDB)		+= kgdb.o
+obj-$(CONFIG_KGDB)		+= kgdb.o patch.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
 obj-$(CONFIG_OF)		+= devtree.o
diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index a74b53c1b7df..07db2f8a1b45 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -12,8 +12,12 @@
 #include <linux/irq.h>
 #include <linux/kdebug.h>
 #include <linux/kgdb.h>
+#include <linux/uaccess.h>
+
 #include <asm/traps.h>
 
+#include "patch.h"
+
 struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] =
 {
 	{ "r0", 4, offsetof(struct pt_regs, ARM_r0)},
@@ -244,6 +248,31 @@ void kgdb_arch_exit(void)
 	unregister_die_notifier(&kgdb_notifier);
 }
 
+int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
+{
+	int err;
+
+	/* patch_text() only supports int-sized breakpoints */
+	BUILD_BUG_ON(sizeof(int) != BREAK_INSTR_SIZE);
+
+	err = probe_kernel_read(bpt->saved_instr, (char *)bpt->bpt_addr,
+				BREAK_INSTR_SIZE);
+	if (err)
+		return err;
+
+	patch_text((void *)bpt->bpt_addr,
+		   *(unsigned int *)arch_kgdb_ops.gdb_bpt_instr);
+
+	return err;
+}
+
+int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
+{
+	patch_text((void *)bpt->bpt_addr, *(unsigned int *)bpt->saved_instr);
+
+	return 0;
+}
+
 /*
  * Register our undef instruction hooks with ARM undef core.
  * We regsiter a hook specifically looking for the KGB break inst
-- 
1.9.1
