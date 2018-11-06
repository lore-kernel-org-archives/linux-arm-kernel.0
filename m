From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 6 Nov 2018 13:21:12 +0000
Subject: [PATCH 20/23] PCI: mobiveil: change prototype of function
 mobiveil_host_init
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181106131807.29951-21-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add a parameter 'bool reinit' to identify re-initializing the
host controller, and export it.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 .../pci/controller/mobiveil/pcie-mobiveil-host.c | 16 +++++++++-------
 drivers/pci/controller/mobiveil/pcie-mobiveil.h  |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index de24fedcb92d..b1d67a697ecc 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -213,7 +213,7 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
 	writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
 }
 
-static int mobiveil_host_init(struct mobiveil_pcie *pcie)
+int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
 {
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
@@ -225,11 +225,13 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	for (i = 0; i < pcie->ppio_wins; i++)
 		mobiveil_pcie_disable_ib_win(pcie, i);
 
-	/* setup bus numbers */
-	value = csr_readl(pcie, PCI_PRIMARY_BUS);
-	value &= 0xff000000;
-	value |= 0x00ff0100;
-	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+	if (!reinit) {
+		/* setup bus numbers */
+		value = csr_readl(pcie, PCI_PRIMARY_BUS);
+		value &= 0xff000000;
+		value |= 0x00ff0100;
+		csr_writel(pcie, value, PCI_PRIMARY_BUS);
+	}
 
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
@@ -570,7 +572,7 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 	 * configure all inbound and outbound windows and prepare the RC for
 	 * config access
 	 */
-	ret = mobiveil_host_init(pcie);
+	ret = mobiveil_host_init(pcie, false);
 	if (ret) {
 		dev_err(dev, "Failed to initialize host\n");
 		goto error;
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 933c2f34bc52..51195db09347 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -165,6 +165,7 @@ struct mobiveil_pcie {
 };
 
 int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
+int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit);
 bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
 int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
 void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
-- 
2.17.1
