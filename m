From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 16 Apr 2014 09:43:25 +0100
Subject: [PATCH RFC 1/5] ata: ahci_imx: warn when disabling ahci link
In-Reply-To: <20140416084227.GD24070@n2100.arm.linux.org.uk>
References: <20140416084227.GD24070@n2100.arm.linux.org.uk>
Message-ID: <E1WaLRF-0002yF-Pj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the AHCI link is disabled, it can't be re-enabled except by
resetting the entire SoC.  Rather than doing this silently print
some kernel messages to inform the user, along with how to avoid
this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/ata/ahci_imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 497c7abe1c7d..6a56a561a80b 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -160,6 +160,10 @@ static void ahci_imx_error_handler(struct ata_port *ap)
 	writel(reg_val | PORT_PHY_CTL_PDDQ_LOC, mmio + PORT_PHY_CTL);
 	imx_sata_disable(hpriv);
 	imxpriv->no_device = true;
+
+	dev_info(ap->dev, "no device found, disabling link.\n");
+	dev_info(ap->dev, "pass " MODULE_PARAM_PREFIX
+		 ".hotplug=1 to enable hotplug\n");
 }
 
 static int ahci_imx_softreset(struct ata_link *link, unsigned int *class,
-- 
1.8.3.1
