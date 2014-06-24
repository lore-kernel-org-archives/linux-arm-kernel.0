From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Jun 2014 16:18:27 -0300
Subject: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
Message-ID: <1403637507-9424-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When the mx6 PCI conctroller is initialized in the bootloader we see a kernel 
hang inside imx6_add_pcie_port().

Adding a 30ms delay allows the kernel to boot.

Suggested-by: David M?ller <d.mueller@elsoft.ch>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
I am happy to get feedback on how to properly fix this.

Thanks

 drivers/pci/host/pci-imx6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index a568efa..669f771 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -507,6 +507,8 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
 	pp->root_bus_nr = -1;
 	pp->ops = &imx6_pcie_host_ops;
 
+	usleep_range(25000, 30000);
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize host\n");
-- 
1.8.3.2
