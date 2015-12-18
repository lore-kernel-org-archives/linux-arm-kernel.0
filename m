From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Fri, 18 Dec 2015 14:38:55 +0200
Subject: [PATCH v5 1/5] PCI: designware: ensure ATU is enabled before IO/conf
 space accesses
In-Reply-To: <1450442339-18765-1-git-send-email-stanimir.varbanov@linaro.org>
References: <1450442339-18765-1-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <1450442339-18765-2-git-send-email-stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no guarantees that enabling ATU will hit the hardware
immediately, and subsequent accesses to configuration / IO spaces
are reliable. So fixing this by read back PCIE_ATU_CR2 register
just after writing.

Without such a fix the PCI device enumeration during kernel boot
is not reliable, and reading configuration space for particular
PCI device on the bus returns zero aka no device.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/pci/host/pcie-designware.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 02a7452bdf23..7880de63895d 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -154,6 +154,8 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
 static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 		int type, u64 cpu_addr, u64 pci_addr, u32 size)
 {
+	u32 val;
+
 	dw_pcie_writel_rc(pp, PCIE_ATU_REGION_OUTBOUND | index,
 			  PCIE_ATU_VIEWPORT);
 	dw_pcie_writel_rc(pp, lower_32_bits(cpu_addr), PCIE_ATU_LOWER_BASE);
@@ -164,6 +166,11 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 	dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
 	dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
 	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+	/*
+	 * ensure that the ATU enable has been happaned before accessing
+	 * pci configuration/io spaces through dw_pcie_cfg_[read|write].
+	 */
+	dw_pcie_readl_rc(pp, PCIE_ATU_CR2, &val);
 }
 
 static struct irq_chip dw_msi_irq_chip = {
-- 
1.7.9.5
