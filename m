From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 29 Nov 2016 21:39:36 +0800
Subject: [PATCH v4 08/11] ACPI: ARM64: IORT: rework iort_node_get_id()
In-Reply-To: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
References: <1480426779-31387-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1480426779-31387-9-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

iort_node_get_id() has two output, one is the mapped ids,
the other is the referenced parent node which is returned
from the function.

For now we need a API just return its parent node for
single mapping, so just update this function slightly then
reuse it later.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/acpi/arm64/iort.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 7b78282a..788f445 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -347,7 +347,8 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	if (map[index].flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
-			*id_out = map[index].output_base;
+			if (id_out)
+				*id_out = map[index].output_base;
 			return parent;
 		}
 	}
-- 
1.7.12.4
