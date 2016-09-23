From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Fri, 23 Sep 2016 23:19:01 +0200
Subject: [PATCH] [media] VPU: mediatek: Fix return value in case of error
Message-ID: <1474665541-7454-1-git-send-email-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If 'dma_alloc_coherent()' returns NULL, 'vpu_alloc_ext_mem()' will
return 0 which means success.
Return -ENOMEM instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/platform/mtk-vpu/mtk_vpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index c9bf58c97878..3edb5ed852e6 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -674,7 +674,7 @@ static int vpu_alloc_ext_mem(struct mtk_vpu *vpu, u32 fw_type)
 					       GFP_KERNEL);
 	if (!vpu->extmem[fw_type].va) {
 		dev_err(dev, "Failed to allocate the extended program memory\n");
-		return PTR_ERR(vpu->extmem[fw_type].va);
+		return -ENOMEM;
 	}
 
 	/* Disable extend0. Enable extend1 */
-- 
2.7.4
