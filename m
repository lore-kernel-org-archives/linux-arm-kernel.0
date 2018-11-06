From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Tue, 6 Nov 2018 13:21:00 +0000
Subject: [PATCH 18/23] PCI: mobiveil: disabled IB and OB windows set by
 bootloader
In-Reply-To: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20181106131807.29951-19-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Disabled all inbound and outbound windows before set up the windows
in kernel, in case transactions match the window set by bootloader.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 .../controller/mobiveil/pcie-mobiveil-host.c   |  7 +++++++
 .../pci/controller/mobiveil/pcie-mobiveil.c    | 18 ++++++++++++++++++
 .../pci/controller/mobiveil/pcie-mobiveil.h    |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 4419179f64bc..de24fedcb92d 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -217,6 +217,13 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 {
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
+	int i;
+
+	/* Disable all inbound/outbound windows */
+	for (i = 0; i < pcie->apio_wins; i++)
+		mobiveil_pcie_disable_ob_win(pcie, i);
+	for (i = 0; i < pcie->ppio_wins; i++)
+		mobiveil_pcie_disable_ib_win(pcie, i);
 
 	/* setup bus numbers */
 	value = csr_readl(pcie, PCI_PRIMARY_BUS);
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
index 71389ebbf229..cd2a7b9a7a2f 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -225,3 +225,21 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
 
 	return -ETIMEDOUT;
 }
+
+void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pci, int win_num)
+{
+	u32 val;
+
+	val = csr_readl(pci, PAB_PEX_AMAP_CTRL(win_num));
+	val &= ~(1 << AMAP_CTRL_EN_SHIFT);
+	csr_writel(pci, val, PAB_PEX_AMAP_CTRL(win_num));
+}
+
+void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pci, int win_num)
+{
+	u32 val;
+
+	val = csr_readl(pci, PAB_AXI_AMAP_CTRL(win_num));
+	val &= ~(1 << WIN_ENABLE_SHIFT);
+	csr_writel(pci, val, PAB_AXI_AMAP_CTRL(win_num));
+}
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index eb4cb61291a8..81685840b378 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -171,6 +171,8 @@ void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
 			u64 pci_addr, u32 type, u64 size);
 void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
 			u64 pci_addr, u32 type, u64 size);
+void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pci, int win_num);
+void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pci, int win_num);
 u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size);
 void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size);
 
-- 
2.17.1
