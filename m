From: keescook@chromium.org (Kees Cook)
Date: Thu, 10 Jul 2014 11:40:22 -0700
Subject: [PATCH v10 02/11] seccomp: extract check/assign mode helpers
In-Reply-To: <1405017631-27346-1-git-send-email-keescook@chromium.org>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
Message-ID: <1405017631-27346-3-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support splitting mode 1 from mode 2, extract the mode checking and
assignment logic into common functions.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index afb916c7e890..03a5959b7930 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -194,7 +194,23 @@ static u32 seccomp_run_filters(int syscall)
 	}
 	return ret;
 }
+#endif /* CONFIG_SECCOMP_FILTER */
 
+static inline bool seccomp_check_mode(unsigned long seccomp_mode)
+{
+	if (current->seccomp.mode && current->seccomp.mode != seccomp_mode)
+		return false;
+
+	return true;
+}
+
+static inline void seccomp_assign_mode(unsigned long seccomp_mode)
+{
+	current->seccomp.mode = seccomp_mode;
+	set_tsk_thread_flag(current, TIF_SECCOMP);
+}
+
+#ifdef CONFIG_SECCOMP_FILTER
 /**
  * seccomp_attach_filter: Attaches a seccomp filter to current.
  * @fprog: BPF program to install
@@ -490,8 +506,7 @@ static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
 {
 	long ret = -EINVAL;
 
-	if (current->seccomp.mode &&
-	    current->seccomp.mode != seccomp_mode)
+	if (!seccomp_check_mode(seccomp_mode))
 		goto out;
 
 	switch (seccomp_mode) {
@@ -512,8 +527,7 @@ static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
 		goto out;
 	}
 
-	current->seccomp.mode = seccomp_mode;
-	set_thread_flag(TIF_SECCOMP);
+	seccomp_assign_mode(seccomp_mode);
 out:
 	return ret;
 }
-- 
1.7.9.5
