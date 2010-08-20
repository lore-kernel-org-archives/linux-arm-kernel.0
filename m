From: jgq516@gmail.com (xiaojiang)
Date: Fri, 20 Aug 2010 14:51:02 +0800
Subject: [PATCH] ftrace: Fix compile error if DYNAMIC_FTRACE is enabled
Message-ID: <AANLkTimm=JeJKqroqP4tECwAPJWtqpa8at0QkyFKSW0t@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__gnu_mcount_nc() is implemented when kernel doesn't
enable CONFIG_DYNAMIC_FTRACE, so added the condition
where the function are declared.

Signed-off-by: xiaojiang <jgq516@gmail.com>
---
 arch/arm/include/asm/ftrace.h |    2 ++
 arch/arm/kernel/armksyms.c    |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 103f7ee..a1c58ab 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -7,8 +7,10 @@

 #ifndef __ASSEMBLY__
 extern void mcount(void);
+#ifndef CONFIG_DYNAMIC_FTRACE
 extern void __gnu_mcount_nc(void);
 #endif
+#endif

 #endif

diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 8214bfe..62d00b0 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -166,5 +166,7 @@ EXPORT_SYMBOL(_find_next_bit_be);

 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(mcount);
+#ifndef CONFIG_DYNAMIC_FTRACE
 EXPORT_SYMBOL(__gnu_mcount_nc);
 #endif
+#endif
--
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100820/61bf5cf5/attachment-0001.html>
