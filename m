From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 29 Jan 2018 18:32:47 -0600
Subject: [PATCH 6/8] rockchip/rga: fix potential integer overflow in
 rga_buf_map
In-Reply-To: <cover.1517268667.git.gustavo@embeddedor.com>
References: <cover.1517268667.git.gustavo@embeddedor.com>
Message-ID: <715937d1ae955d5e5d531ef93d503177865f4083.1517268668.git.gustavo@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cast p to dma_addr_t in order to avoid a potential integer overflow.
This variable is being used in a context that expects an expression
of type dma_addr_t (u64).

Addresses-Coverity-ID: 1458347 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/platform/rockchip/rga/rga-buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rga/rga-buf.c b/drivers/media/platform/rockchip/rga/rga-buf.c
index 49cacc7..3dd29b2 100644
--- a/drivers/media/platform/rockchip/rga/rga-buf.c
+++ b/drivers/media/platform/rockchip/rga/rga-buf.c
@@ -140,7 +140,7 @@ void rga_buf_map(struct vb2_buffer *vb)
 		address = sg_phys(sgl);
 
 		for (p = 0; p < len; p++) {
-			dma_addr_t phys = address + (p << PAGE_SHIFT);
+			dma_addr_t phys = address + ((dma_addr_t)p << PAGE_SHIFT);
 
 			pages[mapped_size + p] = phys;
 		}
-- 
2.7.4
