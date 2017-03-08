From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 8 Mar 2017 16:17:11 +0530
Subject: [PATCH v3 1/7] PCI: dwc: designware: Add new *ops* for cpu addr fixup
In-Reply-To: <1488970037-17740-1-git-send-email-kishon@ti.com>
References: <1488970037-17740-1-git-send-email-kishon@ti.com>
Message-ID: <1488970037-17740-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms (like dra7xx) require only the least 28 bits of the
corresponding 32 bit CPU address to be programmed in the address
translation unit. This modified address is stored in io_base/mem_base/
cfg0_base/cfg1_base in dra7xx_pcie_host_init. While this is okay for
host mode where the address range is fixed, device mode requires
different addresses to be programmed based on the host buffer address.
Add a new ops to get the least 28 bits of the corresponding 32 bit
CPU address and invoke it before programming the address translation
unit.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/dwc/pcie-designware.c |    3 +++
 drivers/pci/dwc/pcie-designware.h |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 7e1fb7d..14ee7a3 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -97,6 +97,9 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 {
 	u32 retries, val;
 
+	if (pp->ops->cpu_addr_fixup)
+		cpu_addr = pp->ops->cpu_addr_fixup(cpu_addr);
+
 	if (pci->iatu_unroll_enabled) {
 		dw_pcie_writel_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
 				      lower_32_bits(cpu_addr));
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index cd3b871..8f3dcb2 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -143,6 +143,7 @@ struct pcie_port {
 };
 
 struct dw_pcie_ops {
+	u64	(*cpu_addr_fixup)(u64 cpu_addr);
 	u32	(*readl_dbi)(struct dw_pcie *pcie, u32 reg);
 	void	(*writel_dbi)(struct dw_pcie *pcie, u32 reg, u32 val);
 	int	(*link_up)(struct dw_pcie *pcie);
-- 
1.7.9.5
