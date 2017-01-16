From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 16 Jan 2017 12:11:42 +0100
Subject: [PATCH] PCI: mvebu: change delay after reset to the PCIe spec
 mandated 100ms
Message-ID: <20170116111142.6866-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current default of 20ms cause some devices, which are slow to initialize,
to not show up during the bus scanning. Change this to the PCIe spec mandated
100ms and document this in the DT binding.

>From PCIe base spec rev 3.0, chapter "6.6.1. Conventional Reset":

"To allow components to perform internal initialization, system software must
wait a specified minimum period following the end of a Conventional Reset of
one or more devices before it is permitted to issue Configuration Requests to
those devices.

With a Downstream Port that does not support Link speeds greater than
5.0 GT/s, software must wait a minimum of 100 ms before sending a
Configuration Request to the device immediately below that Port."

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 Documentation/devicetree/bindings/pci/mvebu-pci.txt | 3 ++-
 drivers/pci/host/pci-mvebu.c                        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
index 08c716b2c6b6..2de6f65ecfb1 100644
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@ -78,7 +78,8 @@ and the following optional properties:
   multiple lanes. If this property is not found, we assume that the
   value is 0.
 - reset-gpios: optional gpio to PERST#
-- reset-delay-us: delay in us to wait after reset de-assertion
+- reset-delay-us: delay in us to wait after reset de-assertion, if not
+  specified will default to 100ms, as required by the PCIe specification.
 
 Example:
 
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 45a89d969700..0c9dd47ce74d 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1162,7 +1162,7 @@ static int mvebu_pcie_powerup(struct mvebu_pcie_port *port)
 		return ret;
 
 	if (port->reset_gpio) {
-		u32 reset_udelay = 20000;
+		u32 reset_udelay = 100000;
 
 		of_property_read_u32(port->dn, "reset-delay-us",
 				     &reset_udelay);
-- 
2.11.0
