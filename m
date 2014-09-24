From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Wed, 24 Sep 2014 19:27:15 -0300
Subject: [PATCH 15/18] [media] s5p_mfc_opr: Fix warnings
In-Reply-To: <c8634fac0c56cfaa9bdad29d541e95b17c049c0a.1411597610.git.mchehab@osg.samsung.com>
References: <c8634fac0c56cfaa9bdad29d541e95b17c049c0a.1411597610.git.mchehab@osg.samsung.com>
Message-ID: <ed21f64844bd63573466c2667fd035f9e650a5f9.1411597610.git.mchehab@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  CC      drivers/media//platform/s5p-mfc/s5p_mfc_opr.o
drivers/media//platform/s5p-mfc/s5p_mfc_opr.c: In function ?s5p_mfc_alloc_priv_buf?:
drivers/media//platform/s5p-mfc/s5p_mfc_opr.c:44:2: warning: format ?%d? expects argument of type ?int?, but argument 4 has type ?size_t? [-Wformat=]
  mfc_debug(3, "Allocating priv: %d\n", b->size);
  ^
drivers/media//platform/s5p-mfc/s5p_mfc_opr.c:53:2: warning: format ?%x? expects argument of type ?unsigned int?, but argument 5 has type ?dma_addr_t? [-Wformat=]
  mfc_debug(3, "Allocated addr %p %08x\n", b->virt, b->dma);
  ^

Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
index c9a227428e6a..5d311d6ba8f7 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
@@ -41,7 +41,7 @@ int s5p_mfc_alloc_priv_buf(struct device *dev,
 					struct s5p_mfc_priv_buf *b)
 {
 
-	mfc_debug(3, "Allocating priv: %d\n", b->size);
+	mfc_debug(3, "Allocating priv: %zd\n", b->size);
 
 	b->virt = dma_alloc_coherent(dev, b->size, &b->dma, GFP_KERNEL);
 
@@ -50,7 +50,7 @@ int s5p_mfc_alloc_priv_buf(struct device *dev,
 		return -ENOMEM;
 	}
 
-	mfc_debug(3, "Allocated addr %p %08x\n", b->virt, b->dma);
+	mfc_debug(3, "Allocated addr %p %pad\n", b->virt, &b->dma);
 	return 0;
 }
 
-- 
1.9.3
