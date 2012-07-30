From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 30 Jul 2012 04:58:11 -0700
Subject: [PATCH 02/11] kernel/debug: Mask KGDB NMI upon entry
In-Reply-To: <20120730115719.GA5742@lizard>
References: <20120730115719.GA5742@lizard>
Message-ID: <1343649500-18491-2-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new arch callback should manage NMIs that usually cause KGDB to
enter. That is, not all NMIs should be enabled/disabled, but only
those that issue kgdb_handle_exception().

We must mask it as serial-line interrupt can be used as an NMI, so
if the original KGDB-entry cause was say a breakpoint, then every
input to KDB console will cause KGDB to reenter, which we don't want.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 include/linux/kgdb.h      |   13 +++++++++++++
 kernel/debug/debug_core.c |   13 ++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index c4d2fc1..e0c0a2e 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -221,6 +221,19 @@ extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
  */
 extern void kgdb_arch_late(void);
 
+/**
+ *	kgdb_arch_enable_nmi - Enable or disable KGDB-entry NMI
+ *	@on: Flag to either enable or disable an NMI
+ *
+ *	This function manages NMIs that usually cause KGDB to enter. That is,
+ *	not all NMIs should be enabled or disabled, but only those that issue
+ *	kgdb_handle_exception().
+ *
+ *	The call counts disable/enable requests, it returns 1 if NMI has been
+ *	actually enabled after the call, and a value <= 0 if it is still
+ *	disabled.
+ */
+extern int kgdb_arch_enable_nmi(bool on);
 
 /**
  * struct kgdb_arch - Describe architecture specific values.
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 0557f24..38b0ab2 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -214,6 +214,11 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
 	return 0;
 }
 
+int __weak kgdb_arch_enable_nmi(bool on)
+{
+	return 0;
+}
+
 /*
  * Some architectures need cache flushes when we set/clear a
  * breakpoint:
@@ -672,6 +677,9 @@ kgdb_handle_exception(int evector, int signo, int ecode, struct pt_regs *regs)
 {
 	struct kgdb_state kgdb_var;
 	struct kgdb_state *ks = &kgdb_var;
+	int ret;
+
+	kgdb_arch_enable_nmi(0);
 
 	ks->cpu			= raw_smp_processor_id();
 	ks->ex_vector		= evector;
@@ -685,7 +693,10 @@ kgdb_handle_exception(int evector, int signo, int ecode, struct pt_regs *regs)
 	if (kgdb_info[ks->cpu].enter_kgdb != 0)
 		return 0;
 
-	return kgdb_cpu_enter(ks, regs, DCPU_WANT_MASTER);
+	ret = kgdb_cpu_enter(ks, regs, DCPU_WANT_MASTER);
+
+	kgdb_arch_enable_nmi(1);
+	return ret;
 }
 
 int kgdb_nmicallback(int cpu, void *regs)
-- 
1.7.10.4
