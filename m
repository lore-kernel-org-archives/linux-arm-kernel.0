From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 10 Aug 2017 15:41:17 +0100
Subject: [PATCH] irqchip/gic-v3-its-platform-msi: Fix msi-parent parsing loop
Message-ID: <20170810144117.17567-1-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While parsing the msi-parent property to chase up the IRQ domain
a given device belongs to, the index into the msi-parent tuple should
be incremented to ensure all properties entries are taken into account.

Current code missed the index update so the parsing loop does not work
in case multiple msi-parent phandles are present and may turn into
an infinite loop in of_pmsi_get_dev_id() if phandle at index 0 does
not correspond to the domain we are actually looking-up.

Fix the code by updating the phandle index at each iteration in
of_pmsi_get_dev_id().

Fixes: deac7fc1c87f ("irqchip/gic-v3-its: Parse new version of msi-parent property")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
Marc,

nothing urgent, I have just bumped into it while checking how ITS
DeviceIDs are handled in DT.

Thanks,
Lorenzo

 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 249240d..833a90f 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -43,6 +43,7 @@ static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
 			*dev_id = args.args[0];
 			break;
 		}
+		index++;
 	} while (!ret);
 
 	return ret;
-- 
2.10.0
