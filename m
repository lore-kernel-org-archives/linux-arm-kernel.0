From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  5 Oct 2012 16:55:15 +0200
Subject: [PATCH 01/16] ARM: warnings in arch/arm/include/asm/uaccess.h
In-Reply-To: <1349448930-23976-1-git-send-email-arnd@arndb.de>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
Message-ID: <1349448930-23976-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On NOMMU ARM, the __addr_ok() and __range_ok() macros do not evaluate
their arguments, which may lead to harmless build warnings in some
code where the variables are not used otherwise. Adding a cast to void
gets rid of the warning and does not make any semantic changes.

Without this patch, building at91x40_defconfig results in:

fs/read_write.c: In function 'rw_copy_check_uvector':
fs/read_write.c:684:9: warning: unused variable 'buf' [-Wunused-variable]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/uaccess.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 77bd79f..7e1f760 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -200,8 +200,8 @@ extern int __put_user_8(void *, unsigned long long);
 #define USER_DS			KERNEL_DS
 
 #define segment_eq(a,b)		(1)
-#define __addr_ok(addr)		(1)
-#define __range_ok(addr,size)	(0)
+#define __addr_ok(addr)		((void)(addr),1)
+#define __range_ok(addr,size)	((void)(addr),0)
 #define get_fs()		(KERNEL_DS)
 
 static inline void set_fs(mm_segment_t fs)
-- 
1.7.10
