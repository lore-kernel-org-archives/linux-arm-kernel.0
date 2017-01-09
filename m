From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  9 Jan 2017 13:45:57 +0000
Subject: [PATCH v7 06/19] iommu: Only map direct mapped regions
In-Reply-To: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1483969570-3154-7-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we introduced new reserved region types which do not require
mapping, let's make sure we only map direct mapped regions.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- use region's type and reword commit message and title
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 927878d..41c1906 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -343,6 +343,9 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 		start = ALIGN(entry->start, pg_size);
 		end   = ALIGN(entry->start + entry->length, pg_size);
 
+		if (entry->type != IOMMU_RESV_DIRECT)
+			continue;
+
 		for (addr = start; addr < end; addr += pg_size) {
 			phys_addr_t phys_addr;
 
-- 
1.9.1
