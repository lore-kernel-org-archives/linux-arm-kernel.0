From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 23 Sep 2015 18:17:26 +0100
Subject: [PATCH 1/6] pci: mvebu: provide a compliant PCI configuration space
In-Reply-To: <20150923171706.GL21084@n2100.arm.linux.org.uk>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
Message-ID: <E1Zenfa-0004cy-WE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI requires reads to reserved or unimplemented configuration space to
return zero and complete normally.  However, the root port software
implementation was returning 0xfffffff and PCIBIOS_BAD_REGISTER_NUMBER.
Fix this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 67ec5e1c99db..b6a096bc9422 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -515,8 +515,13 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
 		break;
 
 	default:
-		*value = 0xffffffff;
-		return PCIBIOS_BAD_REGISTER_NUMBER;
+		/*
+		 * PCI defines configuration read accesses to reserved or
+		 * unimplemented registers to read as zero and complete
+		 * normally.
+		 */
+		*value = 0;
+		return PCIBIOS_SUCCESSFUL;
 	}
 
 	if (size == 2)
-- 
2.1.0
