From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Aug 2017 16:05:26 +0200
Subject: [PATCH] [RFC] ARM: vdso: work around gcc-8 warning
Message-ID: <20170823140538.1590432-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-8 correctly points out that reading four bytes from a pointer to a
'char' variable is wrong

arch/arm/kernel/vdso.c: In function 'vdso_init':
arch/arm/kernel/vdso.c:200:6: error: '__builtin_memcmp_eq' reading 4 bytes from a region of size 1 [-Werror=stringop-overflow=]

However, in this case the variable just stands for the beginning of the
vdso and is not actually a 'char', so the code is doing what it is meant
to do.

Not sure what the best solution for this is, changing the hack to
declare the variable as 'int' instead makes the warning go away.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/vdso.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
index d0295f1dd1a3..eff7d3a1d1ce 100644
--- a/arch/arm/include/asm/vdso.h
+++ b/arch/arm/include/asm/vdso.h
@@ -11,7 +11,7 @@ struct mm_struct;
 
 void arm_install_vdso(struct mm_struct *mm, unsigned long addr);
 
-extern char vdso_start, vdso_end;
+extern int vdso_start, vdso_end;
 
 extern unsigned int vdso_total_pages;
 
-- 
2.9.0
