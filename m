From: hidehiro.kawai.ez@hitachi.com (Hidehiro Kawai)
Date: Fri, 10 Jul 2015 20:33:31 +0900
Subject: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is
 not available
In-Reply-To: <20150710113331.4368.10495.stgit@softrs>
References: <20150710113331.4368.10495.stgit@softrs>
Message-ID: <20150710113331.4368.63745.stgit@softrs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You can call panic notifiers and kmsg dumpers before kdump by
specifying "crash_kexec_post_notifiers" as a boot parameter.
However, it doesn't make sense if kdump is not available.  In that
case, disable "crash_kexec_post_notifiers" boot parameter so that
you can't change the value of the parameter.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
---
 kernel/panic.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 04e91ff..5252331 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -502,12 +502,14 @@ __visible void __stack_chk_fail(void)
 core_param(pause_on_oops, pause_on_oops, int, 0644);
 core_param(panic_on_warn, panic_on_warn, int, 0644);
 
+#ifdef CONFIG_CRASH_DUMP
 static int __init setup_crash_kexec_post_notifiers(char *s)
 {
 	crash_kexec_post_notifiers = true;
 	return 0;
 }
 early_param("crash_kexec_post_notifiers", setup_crash_kexec_post_notifiers);
+#endif
 
 static int __init oops_setup(char *s)
 {
