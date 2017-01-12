From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 12 Jan 2017 15:55:51 +0530
Subject: [PATCH 02/37] PCI: dwc: designware: Add new *ops* for cpu addr fixup
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
Message-ID: <1484216786-17292-3-git-send-email-kishon@ti.com>
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
index bed1999..d68bc7b 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -195,6 +195,9 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 {
 	u32 retries, val;
 
+	if (pp->ops->cpu_addr_fixup)
+		cpu_addr = pp->ops->cpu_addr_fixup(cpu_addr);
+
 	if (pp->iatu_unroll_enabled) {
 		dw_pcie_writel_unroll(pp, index, PCIE_ATU_UNR_LOWER_BASE,
 			lower_32_bits(cpu_addr));
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index a567ea2..32f4602 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -54,6 +54,7 @@ struct pcie_port {
 };
 
 struct pcie_host_ops {
+	u64 (*cpu_addr_fixup)(u64 cpu_addr);
 	u32 (*readl_rc)(struct pcie_port *pp, u32 reg);
 	void (*writel_rc)(struct pcie_port *pp, u32 reg, u32 val);
 	int (*rd_own_conf)(struct pcie_port *pp, int where, int size, u32 *val);
-- 
1.7.9.5
