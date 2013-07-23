From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 23 Jul 2013 10:31:16 -0300
Subject: [PATCH v8 12/28] PCI: mvebu: Check valid base address before port
 setup
In-Reply-To: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1374586292-4941-13-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver does not fail to probe when it cannot obtain
a port base address. Therefore, add a check for NULL base address
before setting up the port, which prevents a kernel panic in such
cases.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 424a7b8..338691b 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -662,6 +662,8 @@ static int __init mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
 
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
+		if (!port->base)
+			continue;
 		mvebu_pcie_setup_hw(port);
 	}
 
-- 
1.8.1.5
