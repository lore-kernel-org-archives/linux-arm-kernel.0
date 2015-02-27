From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Feb 2015 14:29:28 +0100
Subject: [PATCH 1/8] mtd: nand: pxa3xx: disable DMA support on MMP
In-Reply-To: <1425043775-3106827-1-git-send-email-arnd@arndb.de>
References: <1425043775-3106827-1-git-send-email-arnd@arndb.de>
Message-ID: <1425043775-3106827-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMP platform traditionally uses ad-hoc DMA engine support
by having the slave drivers write directly to the DMA register
set, just as we do for PXA.

Nowadays, MMP has a proper dmaengine driver, but that conflicts
with the old method, so we cannot enable both at the same time.

Independent of this, we want to have multiplatform support
on MMP, which means the mach/dma.h header file becomes inaccessible
to the nand driver.

This patch disables the ad-hoc DMA support in the pxa3xx
nand driver for MMP, leaving it enabled only for PXA,
to address both of the above issues.

A patch series from Daniel Mack exists that should address
the performance impact this has over the traditional method:
http://www.spinics.net/lists/arm-kernel/msg265162.html
This patch series is still under review and needs more
testing, but I hope we can merge it soon.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 96b0b1d27df1..06d449591432 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -28,7 +28,7 @@
 #include <linux/of_device.h>
 #include <linux/of_mtd.h>
 
-#if defined(CONFIG_ARCH_PXA) || defined(CONFIG_ARCH_MMP)
+#if defined(CONFIG_ARCH_PXA)
 #define ARCH_HAS_DMA
 #endif
 
-- 
2.1.0.rc2
