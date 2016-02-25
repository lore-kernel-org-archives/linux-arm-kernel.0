From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Feb 2016 23:04:50 +0100
Subject: [PATCH] ARM: s3c24xx: avoid warning for inb/outb
Message-ID: <1456437900-853667-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c24xx implements its own inb/outb macros, but the implementation
prints warnings when the port number argument is not a 32-bit scalar:

drivers/scsi/pas16.c: In function 'NCR5380_pwrite':
arch/arm/mach-s3c24xx/include/mach/io.h:193:68: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
 #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)(port)))

This slightly modifies the definition of the __ioaddrc macro to avoid
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/include/mach/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/io.h b/arch/arm/mach-s3c24xx/include/mach/io.h
index 5dd1db4e2677..235c53647aa4 100644
--- a/arch/arm/mach-s3c24xx/include/mach/io.h
+++ b/arch/arm/mach-s3c24xx/include/mach/io.h
@@ -190,7 +190,7 @@ DECLARE_IO(int,l,"")
 	result;								\
 })
 
-#define __ioaddrc(port)	((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)(port)))
+#define __ioaddrc(port)	((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
 
 #define inb(p)		(__builtin_constant_p((p)) ? __inbc(p)	   : __inb(p))
 #define inw(p)		(__builtin_constant_p((p)) ? __inwc(p)	   : __inw(p))
-- 
2.7.0
