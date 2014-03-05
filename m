From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  5 Mar 2014 14:25:47 +0100
Subject: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when possible
In-Reply-To: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the recommended method of doing the IRQ
mapping. For old devicetrees we fall back to the
previous practice.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-tegra.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 330f7e3a32dd..083cf37ca047 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -639,10 +639,15 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
 	struct tegra_pcie *pcie = sys_to_pcie(pdev->bus->sysdata);
+	int irq;
 
 	tegra_cpuidle_pcie_irqs_in_use();
 
-	return pcie->irq;
+	irq = of_irq_parse_and_map_pci(pdev, slot, pin);
+	if (!irq)
+		irq = pcie->irq;
+
+	return irq;
 }
 
 static void tegra_pcie_add_bus(struct pci_bus *bus)
-- 
1.9.0
