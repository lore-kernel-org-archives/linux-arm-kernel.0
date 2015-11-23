From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Mon, 23 Nov 2015 11:28:59 +0200
Subject: [PATCH v3 2/6] PCI: designware: add memory barrier after enabling
 region
In-Reply-To: <cover.1448270813.git.stanimir.varbanov@linaro.org>
References: <cover.1448270813.git.stanimir.varbanov@linaro.org>
Message-ID: <d38a9c1a87c4e40ad6d17fcbe0fd41b33d7d2912.1448270813.git.stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 'write memory' barrier after enable region in PCIE_ATU_CR2
register. The barrier is needed to ensure that the region enable
request has been reached it's destination at time when we
read/write to PCI configuration space.

Without this barrier PCI device enumeration during kernel boot
is not reliable, and reading configuration space for particular
PCI device on the bus returns zero aka no device.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/pci/host/pcie-designware.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 02a7452bdf23..e15a2ae1583f 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -164,6 +164,11 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
 	dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
 	dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
 	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
+	/*
+	 * ensure that the ATU enable has been happaned before accessing
+	 * pci configuration/io spaces through dw_pcie_cfg_[read|write].
+	 */
+	smp_wmb();
 }
 
 static struct irq_chip dw_msi_irq_chip = {
-- 
1.7.9.5
