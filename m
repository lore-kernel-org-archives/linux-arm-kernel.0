From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:28 +0100
Subject: [PATCH 31/62] ARM: pxa: fix colibri build
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-32-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The colibri_ohci_init function performs a register access through
the io_p2v() macro, which requires the IOMEM macro to be defined.

By explicitly including the asm/io.h header file that contains
this macro, we avoid the build error:

arch/arm/mach-pxa/colibri-evalboard.c: In function 'colibri_ohci_init':
arch/arm/mach-pxa/colibri-evalboard.c:68:2: error: implicit declaration of function 'IOMEM' [-Werror=implicit-function-declaration]
  UP2OCR = UP2OCR_HXS | UP2OCR_HXOE | UP2OCR_DPPDE | UP2OCR_DMPDE;

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-pxa/colibri-evalboard.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/colibri-evalboard.c b/arch/arm/mach-pxa/colibri-evalboard.c
index 8404b24..638b0bb 100644
--- a/arch/arm/mach-pxa/colibri-evalboard.c
+++ b/arch/arm/mach-pxa/colibri-evalboard.c
@@ -20,6 +20,7 @@
 #include <asm/mach/arch.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <asm/io.h>
 
 #include <mach/pxa27x.h>
 #include <mach/colibri.h>
-- 
1.8.3.2
