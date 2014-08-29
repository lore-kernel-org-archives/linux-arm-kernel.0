From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Thu, 28 Aug 2014 22:51:06 -0700
Subject: [PATCH V3] arm: fix get_user BE behavior for target variable with
 size of 8 bytes
In-Reply-To: <1409291466-4064-1-git-send-email-victor.kamensky@linaro.org>
References: <1409291466-4064-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1409291466-4064-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

e38361d 'ARM: 8091/2: add get_user() support for 8 byte types' commit
broke V7 BE get_user call when target var size is 64 bit, but '*ptr' size
is 32 bit or smaller. e38361d changed type of __r2 from 'register
unsigned long' to 'register typeof(x) __r2 asm("r2")' i.e before the change
even when target variable size was 64 bit, __r2 was still 32 bit.
But after e38361d commit, for target var of 64 bit size, __r2 became 64
bit and now it should occupy 2 registers r2, and r3. The issue in BE case
that r3 register is least significant word of __r2 and r2 register is most
significant word of __r2. But __get_user_4 still copies result into r2 (most
significant word of __r2). Subsequent code copies from __r2 into x, but
for situation described it will pick up only garbage from r3 register.

Special __get_user_64t_(124) functions are introduced. They are similar to
corresponding __get_user_(124) function but result stored in r3 register
(lsw in case of 64 bit __r2 in BE image). Those function are used by
get_user macro in case of BE and target var size is 64bit.

Also changed __get_user_lo8 name into __get_user_32t_8 to get consistent
naming accross all cases.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/include/asm/uaccess.h | 48 ++++++++++++++++++++++++++++++++++--------
 arch/arm/lib/getuser.S         | 38 +++++++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index a4cd7af..4767eb9 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -107,8 +107,11 @@ static inline void set_fs(mm_segment_t fs)
 extern int __get_user_1(void *);
 extern int __get_user_2(void *);
 extern int __get_user_4(void *);
-extern int __get_user_lo8(void *);
+extern int __get_user_32t_8(void *);
 extern int __get_user_8(void *);
+extern int __get_user_64t_1(void *);
+extern int __get_user_64t_2(void *);
+extern int __get_user_64t_4(void *);
 
 #define __GUP_CLOBBER_1	"lr", "cc"
 #ifdef CONFIG_CPU_USE_DOMAINS
@@ -117,7 +120,7 @@ extern int __get_user_8(void *);
 #define __GUP_CLOBBER_2 "lr", "cc"
 #endif
 #define __GUP_CLOBBER_4	"lr", "cc"
-#define __GUP_CLOBBER_lo8 "lr", "cc"
+#define __GUP_CLOBBER_32t_8 "lr", "cc"
 #define __GUP_CLOBBER_8	"lr", "cc"
 
 #define __get_user_x(__r2,__p,__e,__l,__s)				\
@@ -131,12 +134,30 @@ extern int __get_user_8(void *);
 
 /* narrowing a double-word get into a single 32bit word register: */
 #ifdef __ARMEB__
-#define __get_user_xb(__r2, __p, __e, __l, __s)				\
-	__get_user_x(__r2, __p, __e, __l, lo8)
+#define __get_user_x_32t(__r2, __p, __e, __l, __s)				\
+	__get_user_x(__r2, __p, __e, __l, 32t_8)
 #else
-#define __get_user_xb __get_user_x
+#define __get_user_x_32t __get_user_x
 #endif
 
+/*
+ * storing result into proper least significant word of 64bit target var,
+ * different only for big endian case where 64 bit __r2 lsw is r3:
+ */
+#ifdef __ARMEB__
+#define __get_user_x_64t(__r2, __p, __e, __l, __s)		        \
+	   __asm__ __volatile__ (					\
+		__asmeq("%0", "r0") __asmeq("%1", "r2")			\
+		__asmeq("%3", "r1")					\
+		"bl	__get_user_64t_" #__s				\
+		: "=&r" (__e), "=r" (__r2)				\
+		: "0" (__p), "r" (__l)					\
+		: __GUP_CLOBBER_##__s)
+#else
+#define __get_user_x_64t __get_user_x
+#endif
+
+
 #define __get_user_check(x,p)							\
 	({								\
 		unsigned long __limit = current_thread_info()->addr_limit - 1; \
@@ -146,17 +167,26 @@ extern int __get_user_8(void *);
 		register int __e asm("r0");				\
 		switch (sizeof(*(__p))) {				\
 		case 1:							\
-			__get_user_x(__r2, __p, __e, __l, 1);		\
+			if (sizeof((x)) >= 8)				\
+				__get_user_x_64t(__r2, __p, __e, __l, 1); \
+			else						\
+				__get_user_x(__r2, __p, __e, __l, 1);	\
 			break;						\
 		case 2:							\
-			__get_user_x(__r2, __p, __e, __l, 2);		\
+			if (sizeof((x)) >= 8)				\
+				__get_user_x_64t(__r2, __p, __e, __l, 2); \
+			else						\
+				__get_user_x(__r2, __p, __e, __l, 2);	\
 			break;						\
 		case 4:							\
-			__get_user_x(__r2, __p, __e, __l, 4);		\
+			if (sizeof((x)) >= 8)				\
+				__get_user_x_64t(__r2, __p, __e, __l, 4); \
+			else						\
+				__get_user_x(__r2, __p, __e, __l, 4);	\
 			break;						\
 		case 8:							\
 			if (sizeof((x)) < 8)				\
-				__get_user_xb(__r2, __p, __e, __l, 4);	\
+				__get_user_x_32t(__r2, __p, __e, __l, 4); \
 			else						\
 				__get_user_x(__r2, __p, __e, __l, 8);	\
 			break;						\
diff --git a/arch/arm/lib/getuser.S b/arch/arm/lib/getuser.S
index 9386000..8ecfd15 100644
--- a/arch/arm/lib/getuser.S
+++ b/arch/arm/lib/getuser.S
@@ -80,7 +80,7 @@ ENTRY(__get_user_8)
 ENDPROC(__get_user_8)
 
 #ifdef __ARMEB__
-ENTRY(__get_user_lo8)
+ENTRY(__get_user_32t_8)
 	check_uaccess r0, 8, r1, r2, __get_user_bad
 #ifdef CONFIG_CPU_USE_DOMAINS
 	add	r0, r0, #4
@@ -90,7 +90,37 @@ ENTRY(__get_user_lo8)
 #endif
 	mov	r0, #0
 	ret	lr
-ENDPROC(__get_user_lo8)
+ENDPROC(__get_user_32t_8)
+
+ENTRY(__get_user_64t_1)
+	check_uaccess r0, 1, r1, r2, __get_user_bad8
+8: TUSER(ldrb)	r3, [r0]
+	mov	r0, #0
+	ret	lr
+ENDPROC(__get_user_64t_1)
+
+ENTRY(__get_user_64t_2)
+	check_uaccess r0, 2, r1, r2, __get_user_bad8
+#ifdef CONFIG_CPU_USE_DOMAINS
+rb	.req	ip
+9:	ldrbt	r3, [r0], #1
+10:	ldrbt	rb, [r0], #0
+#else
+rb	.req	r0
+9:	ldrb	r3, [r0]
+10:	ldrb	rb, [r0, #1]
+#endif
+	orr	r3, rb, r3, lsl #8
+	mov	r0, #0
+	ret	lr
+ENDPROC(__get_user_64t_2)
+
+ENTRY(__get_user_64t_4)
+	check_uaccess r0, 4, r1, r2, __get_user_bad8
+11: TUSER(ldr)	r3, [r0]
+	mov	r0, #0
+	ret	lr
+ENDPROC(__get_user_64t_4)
 #endif
 
 __get_user_bad8:
@@ -111,5 +141,9 @@ ENDPROC(__get_user_bad8)
 	.long	6b, __get_user_bad8
 #ifdef __ARMEB__
 	.long   7b, __get_user_bad
+	.long	8b, __get_user_bad8
+	.long	9b, __get_user_bad8
+	.long	10b, __get_user_bad8
+	.long	11b, __get_user_bad8
 #endif
 .popsection
-- 
1.8.1.4
