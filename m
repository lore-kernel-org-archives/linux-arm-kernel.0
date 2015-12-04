From: robin.murphy@arm.com (Robin Murphy)
Date: Fri,  4 Dec 2015 17:53:01 +0000
Subject: [PATCH 4/5] iommu/io-pgtable: Make io_pgtable_ops_to_pgtable() macro
 common
In-Reply-To: <cover.1449246988.git.robin.murphy@arm.com>
References: <cover.1449246988.git.robin.murphy@arm.com>
Message-ID: <ef5954ba727840a020b62b0135a1ce9f4a10fb2c.1449246988.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to keep a useful accessor for a public structure hidden
away in a private implementation. Move it out alongside the structure
definition so that other implementations may reuse it.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 3 ---
 drivers/iommu/io-pgtable.h     | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 9088d27..1619681 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -38,9 +38,6 @@
 #define io_pgtable_to_data(x)						\
 	container_of((x), struct arm_lpae_io_pgtable, iop)
 
-#define io_pgtable_ops_to_pgtable(x)					\
-	container_of((x), struct io_pgtable, ops)
-
 #define io_pgtable_ops_to_data(x)					\
 	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
 
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 2e18469..36673c8 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -131,6 +131,8 @@ struct io_pgtable {
 	struct io_pgtable_ops	ops;
 };
 
+#define io_pgtable_ops_to_pgtable(x) container_of((x), struct io_pgtable, ops)
+
 /**
  * struct io_pgtable_init_fns - Alloc/free a set of page tables for a
  *                              particular format.
-- 
1.9.1
