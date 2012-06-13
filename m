From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 13 Jun 2012 14:14:09 +0200
Subject: [PATCH] ARM: dma-mapping: fix debug messages in dmabounce code
Message-ID: <1339589649-31970-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the usage of uninitialized variables in dmabounce code
intoduced by commit a227fb92 ('ARM: dma-mapping: remove offset parameter
to prepare for generic dma_ops'):
arch/arm/common/dmabounce.c: In function ?dmabounce_sync_for_device?:
arch/arm/common/dmabounce.c:409: warning: ?off? may be used uninitialized in this function
arch/arm/common/dmabounce.c:407: note: ?off? was declared here
arch/arm/common/dmabounce.c: In function ?dmabounce_sync_for_cpu?:
arch/arm/common/dmabounce.c:369: warning: ?off? may be used uninitialized in this function
arch/arm/common/dmabounce.c:367: note: ?off? was declared here

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/common/dmabounce.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 9d7eb53..aa07f59 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -366,8 +366,8 @@ static int __dmabounce_sync_for_cpu(struct device *dev, dma_addr_t addr,
 	struct safe_buffer *buf;
 	unsigned long off;
 
-	dev_dbg(dev, "%s(dma=%#x,off=%#lx,sz=%zx,dir=%x)\n",
-		__func__, addr, off, sz, dir);
+	dev_dbg(dev, "%s(dma=%#x,sz=%zx,dir=%x)\n",
+		__func__, addr, sz, dir);
 
 	buf = find_safe_buffer_dev(dev, addr, __func__);
 	if (!buf)
@@ -377,8 +377,8 @@ static int __dmabounce_sync_for_cpu(struct device *dev, dma_addr_t addr,
 
 	BUG_ON(buf->direction != dir);
 
-	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
-		__func__, buf->ptr, virt_to_dma(dev, buf->ptr),
+	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x off=%#lx) mapped to %p (dma=%#x)\n",
+		__func__, buf->ptr, virt_to_dma(dev, buf->ptr), off,
 		buf->safe, buf->safe_dma_addr);
 
 	DO_STATS(dev->archdata.dmabounce->bounce_count++);
@@ -406,8 +406,8 @@ static int __dmabounce_sync_for_device(struct device *dev, dma_addr_t addr,
 	struct safe_buffer *buf;
 	unsigned long off;
 
-	dev_dbg(dev, "%s(dma=%#x,off=%#lx,sz=%zx,dir=%x)\n",
-		__func__, addr, off, sz, dir);
+	dev_dbg(dev, "%s(dma=%#x,sz=%zx,dir=%x)\n",
+		__func__, addr, sz, dir);
 
 	buf = find_safe_buffer_dev(dev, addr, __func__);
 	if (!buf)
@@ -417,8 +417,8 @@ static int __dmabounce_sync_for_device(struct device *dev, dma_addr_t addr,
 
 	BUG_ON(buf->direction != dir);
 
-	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x) mapped to %p (dma=%#x)\n",
-		__func__, buf->ptr, virt_to_dma(dev, buf->ptr),
+	dev_dbg(dev, "%s: unsafe buffer %p (dma=%#x off=%#lx) mapped to %p (dma=%#x)\n",
+		__func__, buf->ptr, virt_to_dma(dev, buf->ptr), off,
 		buf->safe, buf->safe_dma_addr);
 
 	DO_STATS(dev->archdata.dmabounce->bounce_count++);
-- 
1.7.1.569.g6f426
