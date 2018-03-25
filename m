From: stefan@agner.ch (Stefan Agner)
Date: Sun, 25 Mar 2018 20:09:59 +0200
Subject: [PATCH v2 6/6] ARM: uaccess: remove const to avoid duplicate specifier
In-Reply-To: <20180325180959.28008-1-stefan@agner.ch>
References: <20180325180959.28008-1-stefan@agner.ch>
Message-ID: <20180325180959.28008-7-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some users of get_user use the macro with an argument p which
is already specified as static. When using clang this leads to
a duplicate specifier:
    CC      arch/arm/kernel/process.o
  In file included from init/do_mounts.c:15:
  In file included from ./include/linux/tty.h:7:
  In file included from ./include/uapi/linux/termios.h:6:
  In file included from ./arch/arm/include/generated/uapi/asm/termios.h:1:
  ./include/asm-generic/termios.h:25:6: warning: duplicate 'const' declaration
          specifier [-Wduplicate-decl-specifier]
          if (get_user(tmp, &termio->c_iflag) < 0)
              ^
  ./arch/arm/include/asm/uaccess.h:195:3: note: expanded from macro 'get_user'
                  __get_user_check(x, p);                                 \
                  ^
  ./arch/arm/include/asm/uaccess.h:155:12: note: expanded from macro
          '__get_user_check'
                  register const typeof(*(p)) __user *__p asm("r0") = (p);\

Remove the const attribute from the register declaration
to avoid the duplicate const specifier. In a test with ptrace.c
and traps.c (both using get_user with non-const arguments for p)
the generated code was exactly the same.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Similar issue has already been discussed here:
https://patchwork.kernel.org/patch/9693821/

 arch/arm/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 0bf2347495f1..3d614e90c19f 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -152,7 +152,7 @@ extern int __get_user_64t_4(void *);
 #define __get_user_check(x, p)						\
 	({								\
 		unsigned long __limit = current_thread_info()->addr_limit - 1; \
-		register const typeof(*(p)) __user *__p asm("r0") = (p);\
+		register typeof(*(p)) __user *__p asm("r0") = (p);	\
 		register typeof(x) __r2 asm("r2");			\
 		register unsigned long __l asm("r1") = __limit;		\
 		register int __e asm("r0");				\
-- 
2.16.2
