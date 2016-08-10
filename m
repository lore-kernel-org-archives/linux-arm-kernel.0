From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Aug 2016 17:37:29 +0200
Subject: [PATCH 1/2] ahci: st: Add ports-implemented property in support
In-Reply-To: <1470843450-20068-1-git-send-email-patrice.chotard@st.com>
References: <1470843450-20068-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1470843450-20068-2-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Despite ST AHCI version = 1.3, reading HOST_PORTS_IMPL
returns 0. So force_port_map to 1 by using ports-implemented
DT property.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/ata/ahci_st.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index 8ff428f..bc345f2 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -147,6 +147,7 @@ static struct scsi_host_template ahci_platform_sht = {
 
 static int st_ahci_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct st_ahci_drv_data *drv_data;
 	struct ahci_host_priv *hpriv;
 	int err;
@@ -170,6 +171,9 @@ static int st_ahci_probe(struct platform_device *pdev)
 
 	st_ahci_configure_oob(hpriv->mmio);
 
+	of_property_read_u32(dev->of_node,
+			     "ports-implemented", &hpriv->force_port_map);
+
 	err = ahci_platform_init_host(pdev, hpriv, &st_ahci_port_info,
 				      &ahci_platform_sht);
 	if (err) {
-- 
1.9.1
