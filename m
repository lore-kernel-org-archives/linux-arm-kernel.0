From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  5 Jun 2014 11:06:13 +0200
Subject: [PATCH 5/5] ARM: make user_addr_max more robust
In-Reply-To: <1401959173-13117-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1401959173-13117-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1401959173-13117-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_MMU=y get_fs() returns current_thread_info()->addr_limit
which is initialized as USER_DS (which in turn is defined to TASK_SIZE)
for userspace processes. At least theoretically
current_thread_info()->addr_limit is changable by set_fs() to a
different limit, so checking for KERNEL_DS is more robust.

With !CONFIG_MMU get_fs returns KERNEL_DS. To see what the old variant
did you'd have to find out that USER_DS == KERNEL_DS which isn't needed
any more with the variant this patch introduces. So it's a bit easier to
understand, too.

Also if the limit was changed this limit should be returned, not
TASK_SIZE.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Cc: Ben Hutchings <ben@decadent.org.uk>

BTW, alpha, m68k, openrisc and sparc use the same definition of user_addr_max
as arm before this patch.

 arch/arm/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 75d95799b6e6..fd42da46828d 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -224,7 +224,7 @@ static inline void set_fs(mm_segment_t fs)
 #define access_ok(type,addr,size)	(__range_ok(addr,size) == 0)
 
 #define user_addr_max() \
-	(segment_eq(get_fs(), USER_DS) ? TASK_SIZE : ~0UL)
+	(segment_eq(get_fs(), KERNEL_DS) ? ~0UL : get_fs())
 
 /*
  * The "__xxx" versions of the user access functions do not verify the
-- 
2.0.0.rc2
