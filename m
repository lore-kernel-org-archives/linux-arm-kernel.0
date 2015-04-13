From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 13 Apr 2015 21:44:28 +0200
Subject: [PATCH v4 18/24] ptrace: Allow compat to use the native siginfo
In-Reply-To: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
Message-ID: <eb0b2fe96365aa6dcceff328406d4292e88c23f6.1428953303.git.philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Set COMPAT_USE_NATIVE_SIGINFO to be true for non AARCH32 tasks.

With ARM64 ILP32 ABI, we want to use the non-compat
siginfo as we want to simplify signal handling for this new ABI.
This patch just adds a new define COMPAT_USE_NATIVE_SIGINFO and
if it is true then read/write in the compat case as it was the
non-compat case.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
---
 include/linux/compat.h |  4 ++++
 kernel/ptrace.c        | 24 +++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index ab25814..d11c556 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -24,6 +24,10 @@
 #define COMPAT_USE_64BIT_TIME 0
 #endif
 
+#ifndef COMPAT_USE_NATIVE_SIGINFO
+#define COMPAT_USE_NATIVE_SIGINFO 0
+#endif
+
 #ifndef __SC_DELOUSE
 #define __SC_DELOUSE(t,v) ((t)(unsigned long)(v))
 #endif
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 227fec3..5bea58b 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -640,7 +640,7 @@ static int ptrace_peek_siginfo(struct task_struct *child,
 			break;
 
 #ifdef CONFIG_COMPAT
-		if (unlikely(is_compat_task())) {
+		if (unlikely(is_compat_task() && !COMPAT_USE_NATIVE_SIGINFO)) {
 			compat_siginfo_t __user *uinfo = compat_ptr(data);
 
 			if (copy_siginfo_to_user32(uinfo, &info) ||
@@ -1108,16 +1108,26 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 
 	case PTRACE_GETSIGINFO:
 		ret = ptrace_getsiginfo(child, &siginfo);
-		if (!ret)
-			ret = copy_siginfo_to_user32(
-				(struct compat_siginfo __user *) datap,
-				&siginfo);
+		if (!ret) {
+			if (COMPAT_USE_NATIVE_SIGINFO)
+				ret = copy_siginfo_to_user(
+					(struct siginfo __user *) datap,
+					&siginfo);
+			else
+				ret = copy_siginfo_to_user32(
+					(struct compat_siginfo __user *) datap,
+					&siginfo);
+		}
 		break;
 
 	case PTRACE_SETSIGINFO:
 		memset(&siginfo, 0, sizeof siginfo);
-		if (copy_siginfo_from_user32(
-			    &siginfo, (struct compat_siginfo __user *) datap))
+		if (COMPAT_USE_NATIVE_SIGINFO)
+			ret = copy_from_user(&siginfo, datap, sizeof(siginfo));
+		else
+			ret = copy_siginfo_from_user32(
+				 &siginfo, (struct compat_siginfo __user *) datap);
+		if (ret)
 			ret = -EFAULT;
 		else
 			ret = ptrace_setsiginfo(child, &siginfo);
-- 
1.9.1
