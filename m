From: benwolsieffer@gmail.com (Ben Wolsieffer)
Date: Sat,  3 Nov 2018 19:32:20 -0400
Subject: [PATCH v2] staging: vchiq_arm: fix compat VCHIQ_IOC_AWAIT_COMPLETION
In-Reply-To: <101171304.143617.1541286450992@email.ionos.de>
References: <101171304.143617.1541286450992@email.ionos.de>
Message-ID: <20181103233219.13685-1-benwolsieffer@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatibility ioctl wrapper for VCHIQ_IOC_AWAIT_COMPLETION assumes that
the native ioctl always uses a message buffer and decrements msgbufcount.
Certain message types do not use a message buffer and in this case
msgbufcount is not decremented, and completion->header for the message is
NULL. Because the wrapper unconditionally decrements msgbufcount, the
calling process may assume that a message buffer has been used even when
it has not.

This results in a memory leak in the userspace code that interfaces with
this driver. When msgbufcount is decremented, the userspace code assumes
that the buffer can be freed though the reference in completion->header,
which cannot happen when the reference is NULL.

This patch causes the wrapper to only decrement msgbufcount when the
native ioctl decrements it. Note that we cannot simply copy the native
ioctl's value of msgbufcount, because the wrapper only retrieves messages
from the native ioctl one at a time, while userspace may request multiple
messages.

See https://github.com/raspberrypi/linux/pull/2703 for more discussion of
this patch.

Fixes: 5569a12 ("staging: vchiq_arm: Add compatibility wrappers for ioctls")

Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
---

I added the missing recipients and a link to the GitHub PR in the commit
message.

 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index d67987fbf25e..8ff0e7e860f3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1461,6 +1461,7 @@ vchiq_compat_ioctl_await_completion(struct file *file,
 	struct vchiq_await_completion32 args32;
 	struct vchiq_completion_data32 completion32;
 	unsigned int *msgbufcount32;
+	unsigned int msgbufcount_native;
 	compat_uptr_t msgbuf32;
 	void *msgbuf;
 	void **msgbufptr;
@@ -1572,7 +1573,11 @@ vchiq_compat_ioctl_await_completion(struct file *file,
 			 sizeof(completion32)))
 		return -EFAULT;
 
-	args32.msgbufcount--;
+	if (get_user(msgbufcount_native, &args->msgbufcount))
+		return -EFAULT;
+
+	if (!msgbufcount_native)
+		args32.msgbufcount--;
 
 	msgbufcount32 =
 		&((struct vchiq_await_completion32 __user *)arg)->msgbufcount;
-- 
2.19.1
