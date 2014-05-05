From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Mon, 05 May 2014 10:13:58 +0400
Subject: [PATCH] arm: put_user: fix possible data corruption in put_user
Message-ID: <1399270438-26181-1-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to arm procedure call standart r2 register is call-cloberred.
So after the result of x expression was put into r2 any following
function call in p may overwrite r2. To fix this, the result of p
expression must be saved to the temporary variable before the
assigment x expression to __r2.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 12c3a5d..4b584ac 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -171,8 +171,9 @@ extern int __put_user_8(void *, unsigned long long);
 #define __put_user_check(x,p)							\
 	({								\
 		unsigned long __limit = current_thread_info()->addr_limit - 1; \
+		const typeof(*(p)) __user *tmp_p = (p);			\
 		register const typeof(*(p)) __r2 asm("r2") = (x);	\
-		register const typeof(*(p)) __user *__p asm("r0") = (p);\
+		register const typeof(*(p)) __user *__p asm("r0") = tmp_p; \
 		register unsigned long __l asm("r1") = __limit;		\
 		register int __e asm("r0");				\
 		switch (sizeof(*(__p))) {				\
-- 
1.8.3.2
