From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Apr 2014 14:19:50 +0200
Subject: [PATCH 4/7] pci: mvebu: fix off-by-one in the computed size of the
 mbus windows
In-Reply-To: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397823593-1932-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Willy Tarreau <w@1wt.eu>

mvebu_pcie_handle_membase_change() and
mvebu_pcie_handle_iobase_change() do not correctly compute the window
size. PCI uses an inclusive start/end address pair, which requires a
+1 when converting to size.

This only worked because a bug in the mbus driver allowed it to
silently accept and round up bogus sizes.

Fix this by adding one to the computed size.

Fixes: 45361a4fe4464180815157654aabbd2afb4848ad ('PCIe driver for Marvell Armada 370/XP systems')
Cc: <stable@vger.kernel.org> # v3.11+
Signed-off-by: Willy Tarreau <w@1wt.eu>
Reviewed-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>
---
 drivers/pci/host/pci-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index d3d1cfd..4829921 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -331,7 +331,7 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 	port->iowin_base = port->pcie->io.start + iobase;
 	port->iowin_size = ((0xFFF | ((port->bridge.iolimit & 0xF0) << 8) |
 			    (port->bridge.iolimitupper << 16)) -
-			    iobase);
+			    iobase) + 1;
 
 	mvebu_mbus_add_window_remap_by_id(port->io_target, port->io_attr,
 					  port->iowin_base, port->iowin_size,
@@ -364,7 +364,7 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 	port->memwin_base  = ((port->bridge.membase & 0xFFF0) << 16);
 	port->memwin_size  =
 		(((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
-		port->memwin_base;
+		port->memwin_base + 1;
 
 	mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
 				    port->memwin_base, port->memwin_size);
-- 
1.9.2
