From: julien.thierry@arm.com (Julien Thierry)
Date: Thu,  6 Sep 2018 17:38:03 +0100
Subject: [PATCH v2 4/9] ARM: oabi-compat: copy oabi events using
 __copy_to_user()
In-Reply-To: <1536251888-8302-1-git-send-email-julien.thierry@arm.com>
References: <1536251888-8302-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1536251888-8302-5-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy all events to user using __copy_to_user() rather than copy members
of each event individually with __put_user_error().
This has the benefit of disabling/enabling PAN once for the whole copy
intead of once per write.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm/kernel/sys_oabi-compat.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index f0dd4b6..c89d27e 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -278,7 +278,7 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 {
 	struct epoll_event *kbuf;
 	mm_segment_t fs;
-	long ret, err, i;
+	long ret, err;
 
 	if (maxevents <= 0 ||
 			maxevents > (INT_MAX/sizeof(*kbuf)) ||
@@ -294,11 +294,9 @@ asmlinkage long sys_oabi_epoll_wait(int epfd,
 	ret = sys_epoll_wait(epfd, kbuf, maxevents, timeout);
 	set_fs(fs);
 	err = 0;
-	for (i = 0; i < ret; i++) {
-		__put_user_error(kbuf[i].events, &events->events, err);
-		__put_user_error(kbuf[i].data,   &events->data,   err);
-		events++;
-	}
+	if (ret > 0)
+		err = __copy_to_user(events, kbuf, ret * sizeof(*kbuf));
+
 	kfree(kbuf);
 	return err ? -EFAULT : ret;
 }
-- 
1.9.1
