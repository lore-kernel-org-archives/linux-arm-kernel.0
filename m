From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Tue, 27 Mar 2018 16:08:18 +0200
Subject: [PATCH v3 5/6] PCI: aardvark: fix PCIe max read request size setting
In-Reply-To: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
References: <20180327140819.23501-1-thomas.petazzoni@bootlin.com>
Message-ID: <20180327140819.23501-13-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Evan Wang <xswang@marvell.com>

There is an obvious typo issue in the definition of the PCIe maximum
read request size: a bit shift is directly used as a value, while it
should be used to shift the correct value.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Evan Wang <xswang@marvell.com>
Reviewed-by: Victor Gu <xigu@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-aardvark.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index c6cd7b17868f..d0688dc6b6d9 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -29,6 +29,7 @@
 #define     PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT	5
 #define     PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE		(0 << 11)
 #define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT	12
+#define     PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ		0x2
 #define PCIE_CORE_LINK_CTRL_STAT_REG				0xd0
 #define     PCIE_CORE_LINK_L0S_ENTRY				BIT(0)
 #define     PCIE_CORE_LINK_TRAINING				BIT(5)
@@ -295,7 +296,8 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg = PCIE_CORE_DEV_CTRL_STATS_RELAX_ORDER_DISABLE |
 		(7 << PCIE_CORE_DEV_CTRL_STATS_MAX_PAYLOAD_SZ_SHIFT) |
 		PCIE_CORE_DEV_CTRL_STATS_SNOOP_DISABLE |
-		PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT;
+		(PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SZ <<
+		 PCIE_CORE_DEV_CTRL_STATS_MAX_RD_REQ_SIZE_SHIFT);
 	advk_writel(pcie, reg, PCIE_CORE_DEV_CTRL_STATS_REG);
 
 	/* Program PCIe Control 2 to disable strict ordering */
-- 
2.14.3
