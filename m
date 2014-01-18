From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 00:48:43 +0100
Subject: [RFC v3 01/13] libahci: Allow drivers to override start_engine
In-Reply-To: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390088935-7193-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oliver Schinagl <oliver@schinagl.nl>

Allwinner A10 and A20 ARM SoCs have an AHCI sata controller which needs a
special register to be poked before starting the DMA engine.

This register gets reset on an ahci_stop_engine call, so there is no other
place then ahci_start_engine where this poking can be done.

This commit allows drivers to override ahci_start_engine behavior for use by
the Allwinner AHCI driver (and potentially other drivers in the future).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci.h    | 2 ++
 drivers/ata/libahci.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 2289efd..8f60f33 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -323,6 +323,8 @@ struct ahci_host_priv {
 	u32			em_msg_type;	/* EM message type */
 	struct clk		*clk;		/* Only for platforms supporting clk */
 	void			*plat_data;	/* Other platform data */
+	/* Optional ahci_start_engine override */
+	void			(*start_engine)(struct ata_port *ap);
 };
 
 extern int ahci_ignore_sss;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c482f8c..f6eabbc 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -568,8 +568,14 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
 void ahci_start_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	u32 tmp;
 
+	if (hpriv->start_engine) {
+		hpriv->start_engine(ap);
+		return;
+	}
+
 	/* start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
 	tmp |= PORT_CMD_START;
-- 
1.8.4.2
