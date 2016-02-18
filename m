From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 15:01:58 +0100
Subject: [PATCH 6/9] ARM: uaccess: avoid warning for NOMMU in access_ok
In-Reply-To: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
Message-ID: <1455804123-2526139-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_MMU is disabled, the access_ok() and __range_ok()
macros always return success, and there is a cast to void
to ensure the compiler does not warn about an unused address
variable. However, at least one driver has a variable for
the size argument as well and does warn about that one:

drivers/vhost/vhost.c: In function 'vq_access_ok':
drivers/vhost/vhost.c:633:9: warning: unused variable 's' [-Wunused-variable]

This changes the macro to also ignore the size argument
explicitly to shut up that warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 35c9db857ebe..9c74c84a10d2 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -290,7 +290,7 @@ extern int __put_user_8(void *, unsigned long long);
 
 #define segment_eq(a, b)		(1)
 #define __addr_ok(addr)		((void)(addr), 1)
-#define __range_ok(addr, size)	((void)(addr), 0)
+#define __range_ok(addr, size)	((void)(addr), (void)(size), 0)
 #define get_fs()		(KERNEL_DS)
 
 static inline void set_fs(mm_segment_t fs)
-- 
2.7.0
