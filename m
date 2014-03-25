From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 25 Mar 2014 16:35:10 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140325222404.GC14718@obsidianresearch.com>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
 <20140325202249.GA10378@obsidianresearch.com>
 <20140325213638.5aba54b6@skate>
 <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
Message-ID: <20140325223510.GD14718@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 04:24:04PM -0600, Jason Gunthorpe wrote:
> On Tue, Mar 25, 2014 at 10:03:29PM +0000, Neil Greatorex wrote:
> 
> > I then replaced it with mdelay(1000) out of interest, and it succeeded
> > in detecting the card at boot. It then proceeded exactly as described
> > by Willy in his later e-mail (it successfully registers an MSI-X
> > interrupt for one port, and then proceeds to implode).
> 
> Seem to confirm not enough time after reset..
> 
> Try this (untested) debugging patch:

Sorry, it has a mistake, that is not how you detect CRS on this chip..

CRS might be something the driver has to emulate as well.....

This is better.. CRS will be bit 19 in the ICR

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index b8f2fc9..658a33f 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -999,6 +999,36 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 		mvebu_pcie_set_local_dev_nr(port, 1);
 
+		/* Wait for the link to come up */
+		if (!mvebu_pcie_link_up(port)) {
+			unsigned int I;
+
+			dev_info(&pdev->dev, "Waiting for link up\n");
+			for (I = 0; I != 100; I++) {
+				udelay(100);
+				if (mvebu_pcie_link_up(port))
+					break;
+			}
+			dev_info(&pdev->dev, "Link is %u\n",
+				 mvebu_pcie_link_up(port));
+		}
+
+		/* Clear and report the ICR */
+		mvebu_writel(port, 0, 0x1900);
+		dev_info(&pdev->dev, "ICR is %x\n", mvebu_readl(port, 0x1900));
+
+		/* Read the vendor ID from the connected device */
+		mvebu_writel(port, PCIE_CONF_ADDR(1, 0, 0), PCIE_CONF_ADDR_OFF);
+		dev_info(&pdev->dev, "Vendor ID is %x\n",
+			 mvebu_readl(port, PCIE_CONF_DATA_OFF));
+		dev_info(&pdev->dev, "ICR is %x\n", mvebu_readl(port, 0x1900));
+		msleep(1000);
+		mvebu_writel(port, PCIE_CONF_ADDR(1, 0, 0), PCIE_CONF_ADDR_OFF);
+		dev_info(&pdev->dev, "Try 2: Vendor ID is %x\n",
+			 mvebu_readl(port, PCIE_CONF_DATA_OFF));
+		dev_info(&pdev->dev, "ICR is %x\n", mvebu_readl(port, 0x1900));
+
+
 		port->dn = child;
 		spin_lock_init(&port->conf_lock);
 		mvebu_sw_pci_bridge_init(port);
