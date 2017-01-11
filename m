From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Jan 2017 23:06:36 +0800
Subject: [PATCH v7 12/15] msi: platform: make
 platform_msi_create_device_domain() ACPI aware
In-Reply-To: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1484147199-4267-13-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_msi_create_device_domain() is used to ctreate
irqdomain for the device such as irqchip mbigen generating
the MSIs, it's almost ready for ACPI use except
of_node_to_fwnode() is for dt only, make it ACPI aware then
things will work in both DTS and ACPI.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg KH <gregkh@linuxfoundation.org>
---
 drivers/base/platform-msi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index be6a599..035ca3b 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -345,8 +345,7 @@ struct irq_domain *
 
 	data->host_data = host_data;
 	domain = irq_domain_create_hierarchy(dev->msi_domain, 0, nvec,
-					     of_node_to_fwnode(dev->of_node),
-					     ops, data);
+					     dev->fwnode, ops, data);
 	if (!domain)
 		goto free_priv;
 
-- 
1.9.1
