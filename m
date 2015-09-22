From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 18:52:16 +0100
Subject: [PATCH 4/4] irqchip/gic-v3-its: Parse new version of msi-parent
 property
In-Reply-To: <1442944336-11754-1-git-send-email-marc.zyngier@arm.com>
References: <1442944336-11754-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442944336-11754-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that 126b16e2ad98 ("Docs: dt: add generic MSI bindings")
has made it into the tree, the time has come to get rid of the
old hack, and to parse msi-parent in its full glory.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index a865505..5a58a53 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -29,13 +29,25 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 {
 	struct msi_domain_info *msi_info;
 	u32 dev_id;
-	int ret;
+	int ret, index = 0;
 
 	msi_info = msi_get_domain_info(domain->parent);
 
 	/* Suck the DeviceID out of the msi-parent property */
-	ret = of_property_read_u32_index(dev->of_node, "msi-parent",
-					 1, &dev_id);
+	do {
+		struct of_phandle_args args;
+
+		ret = of_parse_phandle_with_opt_args(dev->of_node,
+						     "msi-parent", "#msi-cells",
+						     index, &args);
+		if (args.np == domain->of_node) {
+			if (WARN_ON(args.args_count != 1))
+				return -EINVAL;
+			dev_id = args.args[0];
+			break;
+		}
+	} while (!ret);
+
 	if (ret)
 		return ret;
 
-- 
2.1.4
