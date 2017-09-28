From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Sep 2017 14:58:36 +0200
Subject: [PATCH v2 5/7] PCI: aardvark: disable LOS state by default
In-Reply-To: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20170928125838.11887-6-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Gu <xigu@marvell.com>

Some PCIe devices do not support LOS, and will cause timeouts if the
root complex forces the LOS state. This patch disables the LOS state
by default.

This is part of fixing bug
https://bugzilla.kernel.org/show_bug.cgi?id=196339, this commit was
reported as the user to be important to get a Intel 7260 mini-PCIe
WiFi card working.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Signed-off-by: Victor Gu <xigu@marvell.com>
Reviewed-by: Evan Wang <xswang@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-aardvark.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 23e243135ebe..a173f31853df 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -368,8 +368,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	advk_pcie_wait_for_link(pcie);
 
-	reg = PCIE_CORE_LINK_L0S_ENTRY |
-		(1 << PCIE_CORE_LINK_WIDTH_SHIFT);
+	reg = (1 << PCIE_CORE_LINK_WIDTH_SHIFT);
 	advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
 
 	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
-- 
2.13.5
