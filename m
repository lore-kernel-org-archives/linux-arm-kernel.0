From: bamvor.zhangjian@huawei.com (Zhang Jian(Bamvor))
Date: Tue, 10 Feb 2015 18:10:11 +0800
Subject: [PATCH] compat: Fix endian issue in union sigval
Message-ID: <1423563011-12377-1-git-send-email-bamvor.zhangjian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In 64bit architecture, sigval_int is the high 32bit of sigval_ptr in
big endian kernel compare with low 32bit of sigval_ptr in little
endian kernel. reference:

    typedef union sigval {
        int sival_int;
        void *sival_ptr;
    } sigval_t;

During compat_mq_notify or compat_timer_create, kernel get sigval
from user space by reading sigval.sival_int. This is correct in 32 bit
kernel and in 64bit little endian kernel. And It is wrong in 64bit big
endian kernel:
It get the high 32bit of sigval_ptr and put it to low 32bit of
sigval_ptr. And the high 32bit sigval_ptr in empty in arm 32bit user
space struct. So, kernel lost the value of sigval_ptr.

The following patch get the sigval_ptr in stead of sigval_int in order
to avoid endian issue.
Test pass in arm64 big endian and little endian kernel.

Signed-off-by: Zhang Jian(Bamvor) <bamvor.zhangjian@huawei.com>
---
 ipc/compat_mq.c | 7 ++-----
 kernel/compat.c | 6 ++----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/ipc/compat_mq.c b/ipc/compat_mq.c
index ef6f91c..2e07343 100644
--- a/ipc/compat_mq.c
+++ b/ipc/compat_mq.c
@@ -99,11 +99,8 @@ COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
 	if (u_notification) {
 		struct sigevent n;
 		p = compat_alloc_user_space(sizeof(*p));
-		if (get_compat_sigevent(&n, u_notification))
-			return -EFAULT;
-		if (n.sigev_notify == SIGEV_THREAD)
-			n.sigev_value.sival_ptr = compat_ptr(n.sigev_value.sival_int);
-		if (copy_to_user(p, &n, sizeof(*p)))
+		if (get_compat_sigevent(&n, u_notification) ||
+		    copy_to_user(p, &n, sizeof(*p)))
 			return -EFAULT;
 	}
 	return sys_mq_notify(mqdes, p);
diff --git a/kernel/compat.c b/kernel/compat.c
index ebb3c36..13a0e5d 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -871,16 +871,14 @@ COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
  * We currently only need the following fields from the sigevent
  * structure: sigev_value, sigev_signo, sig_notify and (sometimes
  * sigev_notify_thread_id).  The others are handled in user mode.
- * We also assume that copying sigev_value.sival_int is sufficient
- * to keep all the bits of sigev_value.sival_ptr intact.
  */
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event)
 {
 	memset(event, 0, sizeof(*event));
 	return (!access_ok(VERIFY_READ, u_event, sizeof(*u_event)) ||
-		__get_user(event->sigev_value.sival_int,
-			&u_event->sigev_value.sival_int) ||
+		__get_user(*(long long*)event->sigev_value.sival_ptr,
+			&u_event->sigev_value.sival_ptr) ||
 		__get_user(event->sigev_signo, &u_event->sigev_signo) ||
 		__get_user(event->sigev_notify, &u_event->sigev_notify) ||
 		__get_user(event->sigev_notify_thread_id,
-- 
1.8.4.5
