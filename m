From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 10 Sep 2018 11:42:43 +0100
Subject: [PATCH v3 4/9] ARM: oabi-compat: copy oabi events using
 __copy_to_user()
In-Reply-To: <1536576168-40096-1-git-send-email-julien.thierry@arm.com>
References: <1536576168-40096-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1536576168-40096-5-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy events to user using __copy_to_user() rather than copy members of
individually with __put_user_error().
This has the benefit of disabling/enabling PAN once per event intead of
once per event member.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm/kernel/sys_oabi-compat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index f0dd4b6..40da087 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -277,6 +277,7 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 				    int maxevents, int timeout)
 {
 	struct epoll_event *kbuf;
+	struct oabi_epoll_event e;
 	mm_segment_t fs;
 	long ret, err, i;
 
@@ -295,8 +296,11 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 	set_fs(fs);
 	err = 0;
 	for (i = 0; i < ret; i++) {
-		__put_user_error(kbuf[i].events, &events->events, err);
-		__put_user_error(kbuf[i].data,   &events->data,   err);
+		e.events = kbuf[i].events;
+		e.data = kbuf[i].data;
+		err = __copy_to_user(events, &e, sizeof(e));
+		if (err)
+			break;
 		events++;
 	}
 	kfree(kbuf);
-- 
1.9.1
