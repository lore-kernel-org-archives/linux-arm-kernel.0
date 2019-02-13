Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C44C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:02:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD86D20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KC07raJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD86D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=72Fl4/y1qxQ8851J6OUKs+1qbj30xMNw2Fw9+PzD0DA=; b=KC07raJnEcmNOMFrz/XTaK+Wi9
	lsx54ReZYWbrjSsjg6feXAfAwlBv7miqEUHNV2gcb7P77sFayghSqf2DzmCdPrSMcDcgAGcpcbumt
	4iL45g+15BUsHlaHEg1vIOVyep9LQVMO79wRTYQYOjbL1Ty4Sk1dHM3FYDvqxaE+H8SL3QfNTYVc7
	+vEaSymtO/jpa89M5dX7WK3Dn4eg29UVBYjgCE7HmdJ87RnPXsfwCD+p7+gdX8CBdDVrQowZl2A6I
	S4Q9qPrqFphodfhsiRbbdJ3hFZ4eS+Co9MvSb1ZMO7c5VWeejp+9KvjeiUZJmJ7eWXtGoGSV1bDoJ
	5sbEBweA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsJX-0001KE-KM; Wed, 13 Feb 2019 11:02:51 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsJC-0000pP-4a
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:02:33 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 13AB41A0110;
 Wed, 13 Feb 2019 12:02:27 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 06EA61A0018;
 Wed, 13 Feb 2019 12:02:27 +0100 (CET)
Received: from fsr-ub1664-016.ea.freescale.net
 (fsr-ub1664-016.ea.freescale.net [10.171.71.216])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9FDF42060A;
 Wed, 13 Feb 2019 12:02:26 +0100 (CET)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 "David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next 3/3] enetc: Add ENETC PF level external MDIO support
Date: Wed, 13 Feb 2019 13:02:23 +0200
Message-Id: <1550055743-15542-4-git-send-email-claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
References: <1550055743-15542-1-git-send-email-claudiu.manoil@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_030230_455073_CC86367A 
X-CRM114-Status: GOOD (  17.13  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, alexandru.marginean@nxp.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Each ENETC PF has its own MDIO interface, the corresponding
MDIO registers are mapped in the ENETC's Port register block.
The current patch adds a driver for these PF level MDIO buses,
so that each PF can manage directly its own external link.

Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Makefile     |   3 +-
 drivers/net/ethernet/freescale/enetc/enetc_mdio.c | 196 ++++++++++++++++++++++
 drivers/net/ethernet/freescale/enetc/enetc_pf.c   |  13 ++
 drivers/net/ethernet/freescale/enetc/enetc_pf.h   |   6 +
 4 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_mdio.c

diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 6976602..7139e41 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
-fsl-enetc-$(CONFIG_FSL_ENETC) += enetc.o enetc_cbdr.o enetc_ethtool.o
+fsl-enetc-$(CONFIG_FSL_ENETC) += enetc.o enetc_cbdr.o enetc_ethtool.o \
+				 enetc_mdio.o
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-objs := enetc_pf.o $(fsl-enetc-y)
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
new file mode 100644
index 0000000..e71b4fd
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* Copyright 2019 NXP */
+
+#include <linux/mdio.h>
+#include <linux/of_mdio.h>
+
+#include "enetc_pf.h"
+
+struct enetc_mdio_regs {
+	u32	mdio_cfg;	/* MDIO configuration and status */
+	u32	mdio_ctl;	/* MDIO control */
+	u32	mdio_data;	/* MDIO data */
+	u32	mdio_addr;	/* MDIO address */
+};
+
+#define bus_to_enetc_regs(bus)	(struct enetc_mdio_regs __iomem *)((bus)->priv)
+
+#define ENETC_MDIO_REG_OFFSET	0x1c00
+#define ENETC_MDC_DIV		258
+#define MDIO_CFG_CLKDIV(x)	((((x) >> 1) & 0xff) << 8)
+#define MDIO_CFG_BSY		BIT(0)
+#define MDIO_CFG_RD_ER		BIT(1)
+#define MDIO_CFG_ENC		BIT(6)
+#define MDIO_CFG_NEG		BIT(23)
+#define MDIO_CTL_DEV_ADDR(x)	((x) & 0x1f)
+#define MDIO_CTL_PORT_ADDR(x)	(((x) & 0x1f) << 5)
+#define MDIO_CTL_READ		BIT(15)
+#define MDIO_DATA(x)		((x) & 0xffff)
+
+#define TIMEOUT	1000
+static int enetc_wait_complete(struct device *dev,
+			       struct enetc_mdio_regs __iomem *regs)
+{
+	unsigned int timeout;
+
+	timeout = TIMEOUT;
+	while ((enetc_rd_reg(&regs->mdio_cfg) & MDIO_CFG_BSY) && timeout) {
+		cpu_relax();
+		timeout--;
+	}
+
+	if (!timeout) {
+		dev_err(dev, "timeout waiting for bus to be free\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int enetc_mdio_write(struct mii_bus *bus, int phy_id, int regnum,
+			    u16 value)
+{
+	struct enetc_mdio_regs __iomem *regs = bus_to_enetc_regs(bus);
+	u32 mdio_ctl, mdio_cfg;
+	u16 dev_addr;
+	int ret;
+
+	mdio_cfg = MDIO_CFG_CLKDIV(ENETC_MDC_DIV) | MDIO_CFG_NEG;
+	if (regnum & MII_ADDR_C45) {
+		/* clause 45 */
+		dev_addr = (regnum >> 16) & 0x1f;
+		mdio_cfg |= MDIO_CFG_ENC;
+	} else {
+		/* clause 22 (ie 1G) */
+		dev_addr = regnum & 0x1f;
+		mdio_cfg &= ~MDIO_CFG_ENC;
+	}
+
+	enetc_wr_reg(&regs->mdio_cfg, mdio_cfg);
+
+	ret = enetc_wait_complete(&bus->dev, regs);
+	if (ret)
+		return ret;
+
+	/* set port and dev addr */
+	mdio_ctl = MDIO_CTL_PORT_ADDR(phy_id) | MDIO_CTL_DEV_ADDR(dev_addr);
+	enetc_wr_reg(&regs->mdio_ctl, mdio_ctl);
+
+	/* set the register address */
+	if (regnum & MII_ADDR_C45) {
+		enetc_wr_reg(&regs->mdio_addr, regnum & 0xffff);
+
+		ret = enetc_wait_complete(&bus->dev, regs);
+		if (ret)
+			return ret;
+	}
+
+	/* write the value */
+	enetc_wr_reg(&regs->mdio_data, MDIO_DATA(value));
+
+	ret = enetc_wait_complete(&bus->dev, regs);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int enetc_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
+{
+	struct enetc_mdio_regs __iomem *regs = bus_to_enetc_regs(bus);
+	u32 mdio_ctl, mdio_cfg;
+	u16 dev_addr, value;
+	int ret;
+
+	mdio_cfg = MDIO_CFG_CLKDIV(ENETC_MDC_DIV) | MDIO_CFG_NEG;
+	if (regnum & MII_ADDR_C45) {
+		dev_addr = (regnum >> 16) & 0x1f;
+		mdio_cfg |= MDIO_CFG_ENC;
+	} else {
+		dev_addr = regnum & 0x1f;
+		mdio_cfg &= ~MDIO_CFG_ENC;
+	}
+
+	enetc_wr_reg(&regs->mdio_cfg, mdio_cfg);
+
+	ret = enetc_wait_complete(&bus->dev, regs);
+	if (ret)
+		return ret;
+
+	/* set port and device addr */
+	mdio_ctl = MDIO_CTL_PORT_ADDR(phy_id) | MDIO_CTL_DEV_ADDR(dev_addr);
+	enetc_wr_reg(&regs->mdio_ctl, mdio_ctl);
+
+	/* set the register address */
+	if (regnum & MII_ADDR_C45) {
+		enetc_wr_reg(&regs->mdio_addr, regnum & 0xffff);
+
+		ret = enetc_wait_complete(&bus->dev, regs);
+		if (ret)
+			return ret;
+	}
+
+	/* initiate the read */
+	enetc_wr_reg(&regs->mdio_ctl, mdio_ctl | MDIO_CTL_READ);
+
+	ret = enetc_wait_complete(&bus->dev, regs);
+	if (ret)
+		return ret;
+
+	/* return all Fs if nothing was there */
+	if (enetc_rd_reg(&regs->mdio_cfg) & MDIO_CFG_RD_ER) {
+		dev_err(&bus->dev,
+			"Error while reading PHY%d reg at %d.%hhu\n",
+			phy_id, dev_addr, regnum);
+		return 0xffff;
+	}
+
+	value = enetc_rd_reg(&regs->mdio_data) & 0xffff;
+
+	return value;
+}
+
+int enetc_mdio_probe(struct enetc_pf *pf)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_mdio_regs __iomem *regs;
+	struct mii_bus *bus;
+	int ret;
+
+	bus = mdiobus_alloc_size(sizeof(regs));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "Freescale ENETC MDIO Bus";
+	bus->read = enetc_mdio_read;
+	bus->write = enetc_mdio_write;
+	bus->parent = dev;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+
+	/* store the enetc mdio base address for this bus */
+	regs = pf->si->hw.port + ENETC_MDIO_REG_OFFSET;
+	bus->priv = regs;
+
+	ret = of_mdiobus_register(bus, dev->of_node);
+	if (ret) {
+		dev_err(dev, "cannot register MDIO bus\n");
+		goto err_registration;
+	}
+
+	pf->mdio = bus;
+
+	return 0;
+
+err_registration:
+	mdiobus_free(bus);
+
+	return ret;
+}
+
+void enetc_mdio_remove(struct enetc_pf *pf)
+{
+	if (pf->mdio) {
+		mdiobus_unregister(pf->mdio);
+		mdiobus_free(pf->mdio);
+	}
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 7d28f5e..27838ed 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -746,6 +746,7 @@ static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 static int enetc_of_get_phy(struct enetc_ndev_priv *priv)
 {
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct device_node *np = priv->dev->of_node;
 	int err;
 
@@ -770,12 +771,23 @@ static int enetc_of_get_phy(struct enetc_ndev_priv *priv)
 		priv->phy_node = of_node_get(np);
 	}
 
+	if (!of_phy_is_fixed_link(np)) {
+		err = enetc_mdio_probe(pf);
+		if (err) {
+			dev_err(priv->dev, "MDIO bus registration failed\n");
+			of_node_put(priv->phy_node);
+			return err;
+		}
+	}
+
 	priv->if_mode = of_get_phy_mode(np);
 	if (priv->if_mode < 0) {
 		dev_err(priv->dev, "missing phy type\n");
 		of_node_put(priv->phy_node);
 		if (of_phy_is_fixed_link(np))
 			of_phy_deregister_fixed_link(np);
+		else
+			enetc_mdio_remove(pf);
 
 		return -EINVAL;
 	}
@@ -898,6 +910,7 @@ static void enetc_pf_remove(struct pci_dev *pdev)
 
 	unregister_netdev(si->ndev);
 
+	enetc_mdio_remove(pf);
 	enetc_of_put_phy(priv);
 
 	enetc_free_msix(priv);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 2061ae5..10dd1b5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -42,8 +42,14 @@ struct enetc_pf {
 	char vlan_promisc_simap; /* bitmap of SIs in VLAN promisc mode */
 	DECLARE_BITMAP(vlan_ht_filter, ENETC_VLAN_HT_SIZE);
 	DECLARE_BITMAP(active_vlans, VLAN_N_VID);
+
+	struct mii_bus *mdio; /* saved for cleanup */
 };
 
 int enetc_msg_psi_init(struct enetc_pf *pf);
 void enetc_msg_psi_free(struct enetc_pf *pf);
 void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
+
+/* MDIO */
+int enetc_mdio_probe(struct enetc_pf *pf);
+void enetc_mdio_remove(struct enetc_pf *pf);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
