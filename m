From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Sep 2015 01:14:19 +0300
Subject: [PATCH v5 22/23] aarch64: ilp32: msgrcv, msgsnd handlers
In-Reply-To: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1443564860-31208-23-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

msgsnd and msgrcv syscall arguments are different in
lp64 and ilp32 ABIs. In this patch, ilp32-specific
handlers introduced to take it into account.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
index 623191a..09605be 100644
--- a/arch/arm64/kernel/sys_ilp32.c
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -21,6 +21,7 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/msg.h>
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -158,6 +159,50 @@ long ilp32_sys_sigaltstack(const stack_t __user *uss_ptr,
    for stack_t might not be non-zero. */
 #define sys_sigaltstack		ilp32_sys_sigaltstack
 
+struct ilp32_msgbuf {
+	s32 mtype;	/* type of message */
+	char mtext[1];	/* message text */
+};
+
+long ilp32_sys_msgsnd(s32 msqid, struct ilp32_msgbuf __user *msgp, s32 msgsz, s32 msgflg)
+{
+	long mtype;
+
+	if (msgsz < 0)
+		return -EINVAL;
+
+	if (get_user(mtype, &msgp->mtype))
+		return -EFAULT;
+	return do_msgsnd(msqid, mtype, msgp->mtext, msgsz, msgflg);
+}
+
+#define sys_msgsnd		ilp32_sys_msgsnd
+
+extern int store_msg(void __user *dest, struct msg_msg *msg, size_t len);
+static long ilp32_do_msg_fill(void __user *dest, struct msg_msg *msg, size_t bufsz)
+{
+	struct ilp32_msgbuf __user *msgp = dest;
+	size_t msgsz;
+
+	if (put_user(msg->m_type, &msgp->mtype))
+		return -EFAULT;
+
+	msgsz = (bufsz > msg->m_ts) ? msg->m_ts : bufsz;
+	if (store_msg(msgp->mtext, msg, msgsz))
+		return -EFAULT;
+	return msgsz;
+}
+
+long ilp32_sys_msgrcv(s32 msqid, struct ilp32_msgbuf __user *msgp, s32 msgsz,
+		s32 msgtyp, s32 msgflg)
+{
+	if (msgsz < 0)
+		return -EINVAL;
+
+	return do_msgrcv(msqid, msgp, msgsz, msgtyp, msgflg, ilp32_do_msg_fill);
+}
+
+#define sys_msgrcv		ilp32_sys_msgrcv
 
 #include <asm/syscall.h>
 
-- 
2.1.4
