From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Oct 2015 14:10:04 +0200
Subject: [PATCH] RDMA/cxgb4: re-fix 32-bit build warning
Message-ID: <13543971.LQ3Q8CCxhL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Casting a pointer to __be64 produces a warning on 32-bit architectures:

drivers/infiniband/hw/cxgb4/mem.c:147:20: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    req->wr.wr_lo = (__force __be64)&wr_wait;

This was fixed at least twice for this driver in different places,
and accidentally reverted once more. This puts the correct version
back in place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6198dd8d7a6a7 ("iw_cxgb4: 32b platform fixes")

diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index 026b91ebd5e2..140415d31bcc 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -144,7 +144,7 @@ static int _c4iw_write_mem_inline(struct c4iw_rdev *rdev, u32 addr, u32 len,
 		if (i == (num_wqe-1)) {
 			req->wr.wr_hi = cpu_to_be32(FW_WR_OP_V(FW_ULPTX_WR) |
 						    FW_WR_COMPL_F);
-			req->wr.wr_lo = (__force __be64)&wr_wait;
+			req->wr.wr_lo = (__force __be64)(unsigned long)&wr_wait;
 		} else
 			req->wr.wr_hi = cpu_to_be32(FW_WR_OP_V(FW_ULPTX_WR));
 		req->wr.wr_mid = cpu_to_be32(
