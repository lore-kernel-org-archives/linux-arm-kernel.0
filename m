From: hari.vyas@broadcom.com (Hari Vyas)
Date: Thu, 19 Jul 2018 15:18:54 +0530
Subject: [PATCH] arm64: fix for restoring console loglevel after handling traps
In-Reply-To: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
References: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
Message-ID: <1531993734-1463-2-git-send-email-hari.vyas@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of handling traps, console loglevel is set to max i.e.
motormouth to provide maximum log information but this is not
restored after graceful handling of culprit user level process.

As console loglevel is set to maximum, this causes unnecessary
debug messages from modules which supports dynamic debugging.
One such example is pci module which prints lot of unnecessary
debug message while rescanning pci device.

Issue is fixed by providing separate functions for changing
console loglevel message, saving previous console loglevel
and restoring loglevel.

Currently loglevel is restored from arm64 traps handling where
issue was observed but same can be adapted from other (platform)
specific code on need basis.

Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
---
 arch/arm64/kernel/traps.c |  6 +++++-
 include/linux/printk.h    | 38 +++++++++++++++++++++++++++++++++++---
 kernel/printk/printk.c    |  3 +++
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index d399d45..6d37995 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -211,6 +211,8 @@ void die(const char *str, struct pt_regs *regs, int err)
 
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
+
+	restore_console_loglevel();
 	oops_exit();
 
 	if (in_interrupt())
@@ -624,6 +626,7 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
 	die("Oops - bad mode", regs, 0);
 	local_daif_mask();
 	panic("bad mode");
+	restore_console_loglevel();
 }
 
 /*
@@ -680,6 +683,7 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
 	 * to get a better stack trace.
 	 */
 	nmi_panic(NULL, "kernel stack overflow");
+	restore_console_loglevel();
 	cpu_park_loop();
 }
 #endif
@@ -694,7 +698,7 @@ void __noreturn arm64_serror_panic(struct pt_regs *regs, u32 esr)
 		__show_regs(regs);
 
 	nmi_panic(regs, "Asynchronous SError Interrupt");
-
+	restore_console_loglevel();
 	cpu_park_loop();
 	unreachable();
 }
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6d7e800..7c261f8 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -60,22 +60,54 @@ static inline const char *printk_skip_headers(const char *buffer)
  */
 #define CONSOLE_LOGLEVEL_DEFAULT CONFIG_CONSOLE_LOGLEVEL_DEFAULT
 
+#define LOGLEVEL_STACK_MAX 4
+#define LOGLEVEL_STACK_EMPTY -1
 extern int console_printk[];
+extern int stack_pos;
+extern int old_console_loglevel[];
 
 #define console_loglevel (console_printk[0])
 #define default_message_loglevel (console_printk[1])
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
 
+static inline void set_console_loglevel(int loglevel)
+{
+	console_loglevel = loglevel;
+}
+
+static inline int get_console_loglevel(void)
+{
+	return console_loglevel;
+}
+
+/* Sets new console log level and saves previous one */
+static inline void break_console_loglevel(int loglevel)
+{
+	int current_loglevel = get_console_loglevel();
+
+	if (loglevel != current_loglevel) {
+		if (stack_pos < LOGLEVEL_STACK_MAX)
+			old_console_loglevel[++stack_pos] = current_loglevel;
+		set_console_loglevel(loglevel);
+	}
+}
+
+/* Restores previous console log level */
+static inline void restore_console_loglevel(void)
+{
+	if (stack_pos > LOGLEVEL_STACK_EMPTY)
+		console_loglevel = old_console_loglevel[stack_pos--];
+}
+
 static inline void console_silent(void)
 {
-	console_loglevel = CONSOLE_LOGLEVEL_SILENT;
+	break_console_loglevel(CONSOLE_LOGLEVEL_SILENT);
 }
 
 static inline void console_verbose(void)
 {
-	if (console_loglevel)
-		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
+	break_console_loglevel(CONSOLE_LOGLEVEL_MOTORMOUTH);
 }
 
 /* strlen("ratelimit") + 1 */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2478083..6548b52 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -66,6 +66,9 @@
 	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
 };
 
+int stack_pos = -1;
+int old_console_loglevel[LOGLEVEL_STACK_MAX];
+
 /*
  * Low level drivers may need that to know if they can schedule in
  * their unblank() callback or not. So let's export it.
-- 
1.9.1
