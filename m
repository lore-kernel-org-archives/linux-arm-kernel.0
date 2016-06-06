From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:05:15 -0500
Subject: [PATCH v1 04/25] PCI: designware: Simplify host bridge window
 iteration
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230515.20936.35308.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The switch is the only statement in the resource_list_for_each_entry()
loop, so remove unnecessary "continue" statements in the switch.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 8304aeb..12afce1 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -465,11 +465,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			pp->io_size = resource_size(pp->io);
 			pp->io_bus_addr = pp->io->start - win->offset;
 			ret = pci_remap_iospace(pp->io, pp->io_base);
-			if (ret) {
+			if (ret)
 				dev_warn(pp->dev, "error %d: failed to map resource %pR\n",
 					 ret, pp->io);
-				continue;
-			}
 			break;
 		case IORESOURCE_MEM:
 			pp->mem = win->res;
@@ -487,8 +485,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		case IORESOURCE_BUS:
 			pp->busn = win->res;
 			break;
-		default:
-			continue;
 		}
 	}
 
