From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Mon, 26 Jun 2017 21:38:50 +0800
Subject: [PATCH 5/5] iommu/io-pgtable: delete member tlb_sync_pending of
 struct io_pgtable
In-Reply-To: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1498484330-10840-6-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This member is unused now, because the previous patches ensured that each
unmap will always be followed by tlb sync operation.

By the way, ->tlb_flush_all executes tlb_sync by itself.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/io-pgtable.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 7b3fc04..43ddf1f 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -166,7 +166,6 @@ void free_io_pgtable_ops(struct io_pgtable_ops *ops);
 struct io_pgtable {
 	enum io_pgtable_fmt	fmt;
 	void			*cookie;
-	bool			tlb_sync_pending;
 	struct io_pgtable_cfg	cfg;
 	struct io_pgtable_ops	ops;
 };
@@ -176,22 +175,17 @@ struct io_pgtable {
 static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
 {
 	iop->cfg.tlb->tlb_flush_all(iop->cookie);
-	iop->tlb_sync_pending = true;
 }
 
 static inline void io_pgtable_tlb_add_flush(struct io_pgtable *iop,
 		unsigned long iova, size_t size, size_t granule, bool leaf)
 {
 	iop->cfg.tlb->tlb_add_flush(iova, size, granule, leaf, iop->cookie);
-	iop->tlb_sync_pending = true;
 }
 
 static inline void io_pgtable_tlb_sync(struct io_pgtable *iop)
 {
-	if (iop->tlb_sync_pending) {
-		iop->cfg.tlb->tlb_sync(iop->cookie);
-		iop->tlb_sync_pending = false;
-	}
+	iop->cfg.tlb->tlb_sync(iop->cookie);
 }
 
 /**
-- 
2.5.0
