From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  8 Sep 2017 11:53:43 +0200
Subject: [PATCH 2/7] PCI: aardvark: set PIO_ADDR_LS correctly in
 advk_pcie_rd_conf()
In-Reply-To: <20170908095348.16578-1-thomas.petazzoni@free-electrons.com>
References: <20170908095348.16578-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20170908095348.16578-3-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Gu <xigu@marvell.com>

When setting the PIO_ADDR_LS register during a configuration read, we
were properly passing the device number, function number and register
number, but not the bus number, causing issues when reading the
configuration of PCIe devices.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Victor Gu <xigu@marvell.com>
Reviewed-by: Wilson Ding <dingwei@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 582d75f864e3..68ff10e17c74 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -460,7 +460,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
 	advk_writel(pcie, reg, PIO_CTRL);
 
 	/* Program the address registers */
-	reg = PCIE_BDF(devfn) | PCIE_CONF_REG(where);
+	reg = PCIE_CONF_ADDR(bus->number, devfn, where);
 	advk_writel(pcie, reg, PIO_ADDR_LS);
 	advk_writel(pcie, 0, PIO_ADDR_MS);
 
-- 
2.13.5
