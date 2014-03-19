From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:29 +0100
Subject: [PATCH 32/62] ARM: pxa: fix pxa_ssp_* declarations
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-33-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The functions declared in include/linux/pxa2xx_ssp.h are
defined in plat-pxa/ssp.c, which can also be built for
PLAT_MMP, but may be disabled there. This can lead to
both unresolved symbols at link time and to duplicate
symbols at compile time for random configurations.

Changing the #ifdef in the header file to match the
Kconfig symbol that decides if the file is built solves
both problems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>
---
 include/linux/pxa2xx_ssp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 4944420..f2b4051 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -219,7 +219,7 @@ static inline u32 pxa_ssp_read_reg(struct ssp_device *dev, u32 reg)
 	return __raw_readl(dev->mmio_base + reg);
 }
 
-#ifdef CONFIG_ARCH_PXA
+#if IS_ENABLED(CONFIG_PXA_SSP)
 struct ssp_device *pxa_ssp_request(int port, const char *label);
 void pxa_ssp_free(struct ssp_device *);
 struct ssp_device *pxa_ssp_request_of(const struct device_node *of_node,
-- 
1.8.3.2
