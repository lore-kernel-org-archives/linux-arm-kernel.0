From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 26 Nov 2013 11:02:53 -0700
Subject: [PATCH] PCI: mvebu - Return a value for the INTERRUPT_LINE/PIN
 register
In-Reply-To: <1385488975-27694-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1385488975-27694-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <1385488975-27694-2-git-send-email-jgunthorpe@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The emulated bridge does not support interrupts so it should return the
value 0 for interrupt line, 0 for pin. This indicates that interrupts
are not supported.

Since max lat and min gnt are also in the same 32 bit word we return
0 for them, which means 'do not care'.

This corrects an error message from the kernel:

pci 0000:00:01.0: of_irq_parse_pci() failed with rc=135

Which is due to the default return of 0xFFFFFFFF indicating that
interrupts are supported.

The error message regression was caused by 16b84e5a505
'of/irq: Create of_irq_parse_and_map_pci() to consolidate arch code.'
So this patch should head toward 3.13

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/pci/host/pci-mvebu.c | 5 +++++
 1 file changed, 5 insertions(+)

Thomas: This is needed for 3.13, can you Ack it so Bjorn can pick it up?
Thanks

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 6f5a20f..327ee2f 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -447,6 +447,11 @@ static int mvebu_sw_pci_bridge_read(struct mvebu_pcie_port *port,
 		*value = 0;
 		break;
 
+	case PCI_INTERRUPT_LINE:
+		/* LINE PIN MIN_GNT MAX_LAT */
+		*value = 0;
+		break;
+
 	default:
 		*value = 0xffffffff;
 		return PCIBIOS_BAD_REGISTER_NUMBER;
-- 
1.8.1.2
