From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 16 Apr 2014 09:43:30 +0100
Subject: [PATCH RFC 2/5] ata: ahci_imx: avoid reprobing ahci_imx driver when
 using DT
In-Reply-To: <20140416084227.GD24070@n2100.arm.linux.org.uk>
References: <20140416084227.GD24070@n2100.arm.linux.org.uk>
Message-ID: <E1WaLRK-0002yJ-T1@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid matching our child platform device, which can happen as we copy the
DT node to the child device.  This allows the child platform device to be
matched against the ahci-imx driver and should this happen, it will cause
another platform device to be allocated, resulting in failure.

Ideally, we shouldn't be copying the of_node, but this is unavoidable as
prevents ahci_platform() obtaining its resources.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/ata/ahci_imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 6a56a561a80b..26ee412127b3 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -213,6 +213,10 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	unsigned int reg_val;
 	int ret;
 
+	/* Prevent our child ahci device coming back to us */
+	if (!strcmp(dev_name(&pdev->dev), "ahci"))
+		return -ENODEV;
+
 	of_id = of_match_device(imx_ahci_of_match, dev);
 	if (!of_id)
 		return -EINVAL;
-- 
1.8.3.1
