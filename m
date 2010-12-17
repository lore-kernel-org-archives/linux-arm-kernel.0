From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 17 Dec 2010 14:08:29 +0800
Subject: [PATCH] [ARM] Add missing include "asm/memory.h"
Message-ID: <1292566109.21261.1.camel@mola>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes below build error by adding the missing asm/memory.h,
which is needed for arch_is_coherent().

$ make pxa3xx_defconfig; make
  CC      init/do_mounts_rd.o
In file included from include/linux/list_bl.h:5,
                 from include/linux/rculist_bl.h:7,
                 from include/linux/dcache.h:7,
                 from include/linux/fs.h:381,
                 from init/do_mounts_rd.c:3:
include/linux/bit_spinlock.h: In function 'bit_spin_unlock':
include/linux/bit_spinlock.h:61: error: implicit declaration of function 'arch_is_coherent'
make[1]: *** [init/do_mounts_rd.o] Error 1
make: *** [init] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/include/asm/system.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index ec4327a..3222ab8 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -155,6 +155,7 @@ extern unsigned int user_debug;
 #define rmb()		dmb()
 #define wmb()		mb()
 #else
+#include <asm/memory.h>
 #define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
 #define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
 #define wmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
-- 
1.7.2
