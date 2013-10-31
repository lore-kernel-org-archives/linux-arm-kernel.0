From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 31 Oct 2013 17:32:59 -0600
Subject: [PATCH 1/2] PCI: mvebu - The bridge should obey the MEM and IO
 command bits
Message-ID: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When PCI_COMMAND_MEMORY/PCI_COMMAND_IO are cleared the bridge should not
allocate windows or even look at the window limit/base registers.

Otherwise it can attempt to setup bogus windows that the PCI core code
creates during discovery. The core will leave PCI_COMMAND_IO cleared if
it doesn't need an IO window.

Have mvebu_pcie_handle_*_change respect the bits, and call the change
function whenever the bits changes.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/pci/host/pci-mvebu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 19d77c9..721fca9 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -279,7 +279,8 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 
 	/* Are the new iobase/iolimit values invalid? */
 	if (port->bridge.iolimit < port->bridge.iobase ||
-	    port->bridge.iolimitupper < port->bridge.iobaseupper) {
+	    port->bridge.iolimitupper < port->bridge.iobaseupper ||
+	    !(port->bridge.command & PCI_COMMAND_IO)) {
 
 		/* If a window was configured, remove it */
 		if (port->iowin_base) {
@@ -316,7 +317,8 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 {
 	/* Are the new membase/memlimit values invalid? */
-	if (port->bridge.memlimit < port->bridge.membase) {
+	if (port->bridge.memlimit < port->bridge.membase ||
+	    !(port->bridge.command & PCI_COMMAND_MEMORY)) {
 
 		/* If a window was configured, remove it */
 		if (port->memwin_base) {
@@ -464,8 +466,16 @@ static int mvebu_sw_pci_bridge_write(struct mvebu_pcie_port *port,
 
 	switch (where & ~3) {
 	case PCI_COMMAND:
+	{
+		u32 old = bridge->command;
+
 		bridge->command = value & 0xffff;
+		if ((old ^ bridge->command) & PCI_COMMAND_IO)
+			mvebu_pcie_handle_iobase_change(port);
+		if ((old ^ bridge->command) & PCI_COMMAND_MEMORY)
+			mvebu_pcie_handle_membase_change(port);
 		break;
+	}
 
 	case PCI_BASE_ADDRESS_0 ... PCI_BASE_ADDRESS_1:
 		bridge->bar[((where & ~3) - PCI_BASE_ADDRESS_0) / 4] = value;
-- 
1.8.1.2
