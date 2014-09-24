From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Sep 2014 12:06:29 -0700
Subject: [PATCH] drivers/soc: ti: fix build break with modules
In-Reply-To: <5422CDB1.9060505@ti.com>
References: <5422CDB1.9060505@ti.com>
Message-ID: <1411585589-6108-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes below build break by not switching to stubs when the driver is a module:

drivers/soc/ti/knav_dma.c:418:7: error: redefinition of 'knav_dma_open_channel'
 void *knav_dma_open_channel(struct device *dev, const char *name,
       ^
In file included from drivers/soc/ti/knav_dma.c:26:0:
include/linux/soc/ti/knav_dma.h:165:21: note: previous definition of 'knav_dma_open_channel' was here
 static inline void *knav_dma_open_channel(struct device *dev, const char *name,
                     ^

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 include/linux/soc/ti/knav_dma.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soc/ti/knav_dma.h b/include/linux/soc/ti/knav_dma.h
index e864a3e..dad035c 100644
--- a/include/linux/soc/ti/knav_dma.h
+++ b/include/linux/soc/ti/knav_dma.h
@@ -157,7 +157,7 @@ struct knav_dma_desc {
 	u32	pad[4];
 } ____cacheline_aligned;
 
-#ifdef CONFIG_KEYSTONE_NAVIGATOR_DMA
+#if IS_ENABLED(CONFIG_KEYSTONE_NAVIGATOR_DMA)
 void *knav_dma_open_channel(struct device *dev, const char *name,
 				struct knav_dma_cfg *config);
 void knav_dma_close_channel(void *channel);
-- 
1.7.10.4
