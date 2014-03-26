From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 26 Mar 2014 15:42:59 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
 <20140325202249.GA10378@obsidianresearch.com>
 <20140325213638.5aba54b6@skate>
 <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
Message-ID: <20140326214259.GA12330@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 08:34:19PM +0000, Neil Greatorex wrote:
> Thanks. Here's the relevant output with that patch:
> 
> [    0.135772] mvebu-pcie pcie-controller.3: ICR is 0
> [    0.160889] mvebu-pcie pcie-controller.3: Vendor ID is ffffffff
> [    0.160897] mvebu-pcie pcie-controller.3: ICR is 800200
> [    1.170215] mvebu-pcie pcie-controller.3: Try 2: Vendor ID is 15218086
> [    1.170228] mvebu-pcie pcie-controller.3: ICR is 0

Okay, this looks better..

Thomas: Can you verify the decoding of the ICR register (offset
0x1900)?

My Kirkwood manual says 0x800200 is 'Non-Fatal Error Detected' and 'Link
Failure Indication' - the latter seems very strange.

Could there be a doc error or change in the 370 version?

I checked on my board here with the link down and I get:

mvebu-pcie pex.1: Link is 0
mvebu-pcie pex.1: ICR is 0
mvebu-pcie pex.1: Vendor ID is ffffffff
mvebu-pcie pex.1: ICR is 201

Which makes sense - NF Error + Tx while in Link down Error.

In any event, lets try this.

>From 859a60617e050c51dc6bb83b2ed745d38a029b0d Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Wed, 26 Mar 2014 15:38:44 -0600
Subject: [PATCH] PCI: mvebu - Repeat the ID read if there is a CRS reply

Some PCI-E peers take a long time before they will respond to config
transactions. In this case the spec says they should return a
CRS status in the configuration read completion and the host should
retry.

mvebu docs say it sets a bit in the interrupt cause register when
CRS is received. In-circuit testing with a 8086:1521 NIC suggests
this might not be true, so we also monitor the non-fatal error bit,
which does get set.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/pci/host/pci-mvebu.c | 50 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index b8f2fc9..789cdb2 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -49,6 +49,10 @@
 	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where) | \
 	 PCIE_CONF_ADDR_EN)
 #define PCIE_CONF_DATA_OFF	0x18fc
+#define PCIE_ICR		0x1900
+#define  PCIE_ICR_TX_IN_DOWN		BIT(0)
+#define  PCIE_ICR_NFERR_DET		BIT(9)
+#define  PCIE_ICR_CRS			BIT(19)
 #define PCIE_MASK_OFF		0x1910
 #define  PCIE_MASK_ENABLE_INTS          0x0f000000
 #define PCIE_CTRL_OFF		0x1a00
@@ -256,10 +260,44 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
 				 struct pci_bus *bus,
 				 u32 devfn, int where, int size, u32 *val)
 {
-	mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
-		     PCIE_CONF_ADDR_OFF);
-
-	*val = mvebu_readl(port, PCIE_CONF_DATA_OFF);
+	unsigned int tries = 0;
+
+	while (1) {
+		if (where == 0)
+			mvebu_writel(port, ~(PCIE_ICR_TX_IN_DOWN |
+					     PCIE_ICR_NFERR_DET | PCIE_ICR_CRS),
+				     PCIE_ICR);
+
+		mvebu_writel(port, PCIE_CONF_ADDR(bus->number, devfn, where),
+			     PCIE_CONF_ADDR_OFF);
+
+		*val = mvebu_readl(port, PCIE_CONF_DATA_OFF);
+
+		if (where == 0) {
+			u32 icr = mvebu_readl(port, PCIE_ICR);
+			if (icr & PCIE_ICR_TX_IN_DOWN)
+				goto err_out;
+
+			/*
+			 * Implement Configuration Request Retry. If the
+			 * configuration requst for the ID fails with a CRS or
+			 * Non-Fatal status we try again for 100 ms. NFERR_DET
+			 * is checked too, because CRS doesn't seem
+			 * reliable */
+			if (icr & (PCIE_ICR_NFERR_DET | PCIE_ICR_CRS)) {
+				if (tries >= 100)
+					goto err_out;
+				mdelay(1);
+				tries++;
+				continue;
+			}
+		}
+		break;
+	}
+	if (tries != 0)
+		dev_info(&port->pcie->pdev->dev,
+			 "Port %u repeated ID read %u times\n", port->port,
+			 tries);
 
 	if (size == 1)
 		*val = (*val >> (8 * (where & 3))) & 0xff;
@@ -267,6 +305,10 @@ static int mvebu_pcie_hw_rd_conf(struct mvebu_pcie_port *port,
 		*val = (*val >> (8 * (where & 3))) & 0xffff;
 
 	return PCIBIOS_SUCCESSFUL;
+
+err_out:
+	*val = 0xffffffff;
+	return PCIBIOS_DEVICE_NOT_FOUND;
 }
 
 static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
-- 
1.8.1.2
