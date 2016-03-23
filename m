From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Mar 2016 11:39:31 +0100
Subject: [PATCH] ARM: floppy: avoid gcc-6 warning
Message-ID: <1458729581-3195712-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc-6.0 warns about comparisons between two identical expressions,
which is what we get in the floppy driver when writing to the FD_DOR
register:

drivers/block/floppy.c: In function 'set_dor':
drivers/block/floppy.c:810:44: error: self-comparison always evaluates to true [-Werror=tautological-compare]
   fd_outb(newdor, FD_DOR);

It would be nice to use a static inline function instead of the
macro, to avoid the warning, but we cannot do that because the
FD_DOR definition is incomplete at this point.

Adding a cast to (u32) is a harmless way to shut up the warning,
just not very nice.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/floppy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/floppy.h b/arch/arm/include/asm/floppy.h
index f4882553fbb0..85a34cc8316a 100644
--- a/arch/arm/include/asm/floppy.h
+++ b/arch/arm/include/asm/floppy.h
@@ -17,7 +17,7 @@
 
 #define fd_outb(val,port)			\
 	do {					\
-		if ((port) == FD_DOR)		\
+		if ((port) == (u32)FD_DOR)	\
 			fd_setdor((val));	\
 		else				\
 			outb((val),(port));	\
-- 
2.7.0
