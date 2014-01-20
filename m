From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 20 Jan 2014 17:44:54 +0100
Subject: [PATCH RFC v4 01/10] libahci: Allow drivers to override start_engine
In-Reply-To: <1390236303-22538-1-git-send-email-hdegoede@redhat.com>
References: <1390236303-22538-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1390236303-22538-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A10 and A20 ARM SoCs have an AHCI sata controller which needs a
special register to be poked before starting the DMA engine.

This register gets reset on an ahci_stop_engine call, so there is no other
place then ahci_start_engine where this poking can be done.

This commit allows drivers to override ahci_start_engine behavior for use by
the Allwinner AHCI driver (and potentially other drivers in the future).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/ata/ahci.c          |  6 ++++--
 drivers/ata/ahci.h          |  3 ++-
 drivers/ata/libahci.c       | 27 ++++++++++++++++++---------
 drivers/ata/sata_highbank.c |  3 ++-
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c0ed4f27..bb4c903 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -559,6 +559,7 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 				 unsigned long deadline)
 {
 	struct ata_port *ap = link->ap;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	bool online;
 	int rc;
 
@@ -569,7 +570,7 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
 				 deadline, &online, NULL);
 
-	ahci_start_engine(ap);
+	hpriv->start_engine(ap);
 
 	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 
@@ -584,6 +585,7 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 {
 	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
 	bool online;
@@ -599,7 +601,7 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
 				 deadline, &online, NULL);
 
-	ahci_start_engine(ap);
+	hpriv->start_engine(ap);
 
 	/* The pseudo configuration device on SIMG4726 attached to
 	 * ASUS P5W-DH Deluxe doesn't send signature FIS after
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 2289efd..2c04211 100644
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
@@ -357,7 +359,6 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 		      int (*check_ready)(struct ata_link *link));
 
 int ahci_stop_engine(struct ata_port *ap);
-void ahci_start_engine(struct ata_port *ap);
 int ahci_check_ready(struct ata_link *link);
 int ahci_kick_engine(struct ata_port *ap);
 int ahci_port_resume(struct ata_port *ap);
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c482f8c..96d128c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -69,6 +69,7 @@ static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 
 static int ahci_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
 static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
+static void ahci_start_engine(struct ata_port *ap);
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 static bool ahci_qc_fill_rtf(struct ata_queued_cmd *qc);
 static int ahci_port_start(struct ata_port *ap);
@@ -500,6 +501,9 @@ void ahci_save_initial_config(struct device *dev,
 	hpriv->cap = cap;
 	hpriv->cap2 = cap2;
 	hpriv->port_map = port_map;
+
+	if (!hpriv->start_engine)
+		hpriv->start_engine = ahci_start_engine;
 }
 EXPORT_SYMBOL_GPL(ahci_save_initial_config);
 
@@ -565,7 +569,7 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
 	return -EINVAL;
 }
 
-void ahci_start_engine(struct ata_port *ap)
+static void ahci_start_engine(struct ata_port *ap)
 {
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;
@@ -576,7 +580,6 @@ void ahci_start_engine(struct ata_port *ap)
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
 }
-EXPORT_SYMBOL_GPL(ahci_start_engine);
 
 int ahci_stop_engine(struct ata_port *ap)
 {
@@ -766,7 +769,7 @@ static void ahci_start_port(struct ata_port *ap)
 
 	/* enable DMA */
 	if (!(hpriv->flags & AHCI_HFLAG_DELAY_ENGINE))
-		ahci_start_engine(ap);
+		hpriv->start_engine(ap);
 
 	/* turn on LEDs */
 	if (ap->flags & ATA_FLAG_EM) {
@@ -1234,7 +1237,7 @@ int ahci_kick_engine(struct ata_port *ap)
 
 	/* restart engine */
  out_restart:
-	ahci_start_engine(ap);
+	hpriv->start_engine(ap);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_kick_engine);
@@ -1426,6 +1429,7 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
 	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
 	bool online;
@@ -1443,7 +1447,7 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 	rc = sata_link_hardreset(link, timing, deadline, &online,
 				 ahci_check_ready);
 
-	ahci_start_engine(ap);
+	hpriv->start_engine(ap);
 
 	if (online)
 		*class = ahci_dev_classify(ap);
@@ -2007,10 +2011,12 @@ static void ahci_thaw(struct ata_port *ap)
 
 void ahci_error_handler(struct ata_port *ap)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
 		ahci_stop_engine(ap);
-		ahci_start_engine(ap);
+		hpriv->start_engine(ap);
 	}
 
 	sata_pmp_error_handler(ap);
@@ -2031,6 +2037,7 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 
 static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	struct ata_device *dev = ap->link.device;
 	u32 devslp, dm, dito, mdat, deto;
@@ -2094,7 +2101,7 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 		   PORT_DEVSLP_ADSE);
 	writel(devslp, port_mmio + PORT_DEVSLP);
 
-	ahci_start_engine(ap);
+	hpriv->start_engine(ap);
 
 	/* enable device sleep feature for the drive */
 	err_mask = ata_dev_set_feature(dev,
@@ -2106,6 +2113,7 @@ static void ahci_set_aggressive_devslp(struct ata_port *ap, bool sleep)
 
 static void ahci_enable_fbs(struct ata_port *ap)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 fbs;
@@ -2134,11 +2142,12 @@ static void ahci_enable_fbs(struct ata_port *ap)
 	} else
 		dev_err(ap->host->dev, "Failed to enable FBS\n");
 
-	ahci_start_engine(ap);
+	hpriv->start_engine(ap);
 }
 
 static void ahci_disable_fbs(struct ata_port *ap)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 fbs;
@@ -2166,7 +2175,7 @@ static void ahci_disable_fbs(struct ata_port *ap)
 		pp->fbs_enabled = false;
 	}
 
-	ahci_start_engine(ap);
+	hpriv->start_engine(ap);
 }
 
 static void ahci_pmp_attach(struct ata_port *ap)
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index ea3b3dc..30aa9c1 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -404,6 +404,7 @@ static int ahci_highbank_hardreset(struct ata_link *link, unsigned int *class,
 	static const unsigned long timing[] = { 5, 100, 500};
 	struct ata_port *ap = link->ap;
 	struct ahci_port_priv *pp = ap->private_data;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
 	bool online;
@@ -432,7 +433,7 @@ static int ahci_highbank_hardreset(struct ata_link *link, unsigned int *class,
 			break;
 	} while (!online && retry--);
 
-	ahci_start_engine(ap);
+	hpriv->start_engine(ap);
 
 	if (online)
 		*class = ahci_dev_classify(ap);
-- 
1.8.5.3
