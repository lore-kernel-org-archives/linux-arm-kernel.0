From: dhdang@apm.com (Duc Dang)
Date: Thu,  9 Jul 2015 14:20:12 -0700
Subject: [PATCH v3 2/2] pci: xgene: Fix driver to handle multiple memory ranges
In-Reply-To: <cover.1436476099.git.dhdang@apm.com>
References: <cover.1436476099.git.dhdang@apm.com>
Message-ID: <844cb76fe55ce4ce45411281500bdb93e0d6932a.1436476100.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X-Gene PCIe controller has registers to support multiple memory ranges.
This patch implement addtional register configuration required for the
driver to support 1 additional huge 64-bit prefetch memory window.

Signed-off-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/pci-xgene.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index a9dfb70..55fe865 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -321,8 +321,16 @@ static int xgene_pcie_map_ranges(struct xgene_pcie_port *port,
 				return ret;
 			break;
 		case IORESOURCE_MEM:
-			xgene_pcie_setup_ob_reg(port, res, OMR1BARL, res->start,
-						res->start - window->offset);
+			if (res->flags & IORESOURCE_PREFETCH)
+				xgene_pcie_setup_ob_reg(port, res, OMR2BARL,
+							res->start,
+							res->start -
+							window->offset);
+			else
+				xgene_pcie_setup_ob_reg(port, res, OMR1BARL,
+							res->start,
+							res->start -
+							window->offset);
 			break;
 		case IORESOURCE_BUS:
 			break;
-- 
1.9.1
