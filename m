From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 24 Jul 2015 22:38:37 -0400
Subject: [PATCH v2 07/25] intel_iommu: fix leaked ioremap mapping
In-Reply-To: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20150725023837.8664.41845.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iommu_load_old_irte() appears to leak the old_irte mapping after use.

Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/iommu/intel_irq_remapping.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index f15692a410c7..27cdfa84ec5b 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -426,6 +426,8 @@ static int iommu_load_old_irte(struct intel_iommu *iommu)
 			bitmap_set(iommu->ir_table->bitmap, i, 1);
 	}
 
+	iounmap(old_ir_table);
+
 	return 0;
 }
 
