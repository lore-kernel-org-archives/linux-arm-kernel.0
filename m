From: po.liu@nxp.com (Po Liu)
Date: Mon, 29 Aug 2016 15:26:58 +0800
Subject: [PATCH v2] arm64:pci: fix the IOV device access config space valid
 condition
In-Reply-To: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
References: <1471932072-6980-1-git-send-email-po.liu@nxp.com>
Message-ID: <1472455618-17892-1-git-send-email-po.liu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When echo a number to /sys/bus/pci/devices/xxx/sriov_numvfs to enable the
VF devices. A crash log occurred. This found to be access the IOV devices
config space failure issue.

The read/write config space from host would judge the pcie device plugin
or not by(Designware platform as example):

if (bus->primary == pp->root_bus_nr && dev > 0)
    return 0;

Although all PCIe devices for dev(coming from the device and function
number) is zero. But the dev is not zero for VF devices. So remove the
condition.

These PCI hosts were changed: designware, altera, xilinx.

Signed-off-by: Po Liu <po.liu@nxp.com>
---
changes for v2:
	- add pci hosts: altera, xilinx;

 drivers/pci/host/pcie-altera.c     | 7 -------
 drivers/pci/host/pcie-designware.c | 7 -------
 drivers/pci/host/pcie-xilinx.c     | 7 -------
 3 files changed, 21 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 2b78376..edbe0a7 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -171,13 +171,6 @@ static bool altera_pcie_valid_config(struct altera_pcie *pcie,
 	if (bus->number == pcie->root_bus_nr && dev > 0)
 		return false;
 
-	/*
-	 * Do not read more than one device on the bus directly attached
-	 * to root port, root port can only attach to one downstream port.
-	 */
-	if (bus->primary == pcie->root_bus_nr && dev > 0)
-		return false;
-
 	 return true;
 }
 
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 12afce1..dd20eb2 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -670,13 +670,6 @@ static int dw_pcie_valid_config(struct pcie_port *pp,
 	if (bus->number == pp->root_bus_nr && dev > 0)
 		return 0;
 
-	/*
-	 * do not read more than one device on the bus directly attached
-	 * to RC's (Virtual Bridge's) DS side.
-	 */
-	if (bus->primary == pp->root_bus_nr && dev > 0)
-		return 0;
-
 	return 1;
 }
 
diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index a30e016..75c89db 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -168,13 +168,6 @@ static bool xilinx_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 	if (bus->number == port->root_busno && devfn > 0)
 		return false;
 
-	/*
-	 * Do not read more than one device on the bus directly attached
-	 * to RC.
-	 */
-	if (bus->primary == port->root_busno && devfn > 0)
-		return false;
-
 	return true;
 }
 
-- 
2.1.0.27.g96db324
