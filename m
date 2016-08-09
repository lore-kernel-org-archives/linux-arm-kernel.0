From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 9 Aug 2016 15:06:02 +0800
Subject: [RFC PATCH 06/10] msi: platform: make
 platform_msi_create_device_domain() ACPI aware
In-Reply-To: <1470726366-40809-1-git-send-email-guohanjun@huawei.com>
References: <1470726366-40809-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1470726366-40809-7-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

With the platform msi domain created for ITS, irqchip such as
mbi-gen connecting ITS, which needs ctreate its own irqdomain.

Fortunately with the platform msi support upstreamed by Marc,
we just need to add minor code to make it run properly.

platform_msi_create_device_domain() is almost ready for ACPI use
except of_node_to_fwnode() is for dt only, make it ACPI aware then
things will work in both DTS and ACPI.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/base/platform-msi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index d8b28d3..5603756 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -339,16 +339,17 @@ platform_msi_create_device_domain(struct device *dev,
 {
 	struct platform_msi_priv_data *data;
 	struct irq_domain *domain;
+	struct fwnode_handle *fwnode;
 	int err;
 
 	data = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
 	if (IS_ERR(data))
 		return NULL;
 
+	fwnode = dev->of_node ? &dev->of_node->fwnode : dev->fwnode;
 	data->host_data = host_data;
 	domain = irq_domain_create_hierarchy(dev->msi_domain, 0, nvec,
-					     of_node_to_fwnode(dev->of_node),
-					     ops, data);
+					     fwnode, ops, data);
 	if (!domain)
 		goto free_priv;
 
-- 
1.7.12.4
