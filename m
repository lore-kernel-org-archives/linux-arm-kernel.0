From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Wed, 24 Sep 2014 09:41:40 -0300
Subject: [PATCH 2/4] [media] s5p_mfc_opr_v5: fix smatch warnings
In-Reply-To: <cover.1411562226.git.mchehab@osg.samsung.com>
References: <cover.1411562226.git.mchehab@osg.samsung.com>
Message-ID: <84586d08ea9e2bb8af59d2c79acea5da504b5db7.1411562226.git.mchehab@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c:266:23: warning: incorrect type in argument 2 (different modifiers)
drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c:266:23:    expected void volatile [noderef] <asn:2>*addr
drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c:266:23:    got void const volatile [noderef] <asn:2>*<noident>
drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c:274:36: warning: incorrect type in argument 1 (different address spaces)
drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c:274:36:    expected void const volatile [noderef] <asn:2>*addr
drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c:274:36:    got void *

Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
index 96ac14e2fc6e..6234e4d70596 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
@@ -263,7 +263,7 @@ static void s5p_mfc_release_dev_context_buffer_v5(struct s5p_mfc_dev *dev)
 static void s5p_mfc_write_info_v5(struct s5p_mfc_ctx *ctx, unsigned int data,
 			unsigned int ofs)
 {
-	writel(data, (ctx->shm.virt + ofs));
+	writel(data, (volatile void __iomem *)(ctx->shm.virt + ofs));
 	wmb();
 }
 
@@ -271,7 +271,7 @@ static unsigned int s5p_mfc_read_info_v5(struct s5p_mfc_ctx *ctx,
 				unsigned int ofs)
 {
 	rmb();
-	return readl(ctx->shm.virt + ofs);
+	return readl((volatile void __iomem *)(ctx->shm.virt + ofs));
 }
 
 static void s5p_mfc_dec_calc_dpb_size_v5(struct s5p_mfc_ctx *ctx)
-- 
1.9.3
