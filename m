From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 26 Mar 2014 14:12:43 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
 <20140325202249.GA10378@obsidianresearch.com>
 <20140325213638.5aba54b6@skate>
 <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
Message-ID: <20140326201243.GA1536@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 07:31:12PM +0000, Neil Greatorex wrote:
> > Sorry, it has a mistake, that is not how you detect CRS on this chip..
> >
> > CRS might be something the driver has to emulate as well.....
> >
> > This is better.. CRS will be bit 19 in the ICR

> I ran your patch. The dmesg output is available at
> https://gist.github.com/ngreatorex/9790164
> 
> I'm afraid the output doesn't mean much to me :-)

This is the relevant bit:

[    0.136040] mvebu-pcie pcie-controller.3: ICR is 0
[    0.161162] mvebu-pcie pcie-controller.3: Vendor ID is ffffffff
[    0.161170] mvebu-pcie pcie-controller.3: ICR is 800200
[    1.170071] mvebu-pcie pcie-controller.3: Try 2: Vendor ID is ffffffff
[    1.170083] mvebu-pcie pcie-controller.3: ICR is 808200 

#1 The ICR indicates PexLinkFail and NFErrDet after the first vendor
   read. I think PexLinkFail is very surprising, documentation says it
   means there was an error on the link and it re-trained. Perhaps it
   is a side effect of #2..

#2 It looks like I botched the format of the configuration since the NIC
   didn't respond, I think I see why.

#3 After sleeping the PEX detected a UR or CA TLP, which is not
   necessarily surprising, considering #2..

So, we need a result that actually reads the vendor id..

Here is a revision, I suspect the error with the debugging was not
calling mvebu_pcie_set_local_bus_nr, so a type 1 transaction was being
produced. I am looking for the 2nd Vendor ID to return 80861521.

Also, are you using the "reset-gpios" DT property?

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index b8f2fc9..6da4983 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -999,6 +999,38 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
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
+		mvebu_pcie_set_local_bus_nr(port, 1);
+		mvebu_writel(port, PCIE_CONF_ADDR(1, 0, 0), PCIE_CONF_ADDR_OFF);
+		dev_info(&pdev->dev, "Vendor ID is %x\n",
+			 mvebu_readl(port, PCIE_CONF_DATA_OFF));
+		dev_info(&pdev->dev, "ICR is %x\n", mvebu_readl(port, 0x1900));
+		mvebu_writel(port, 0, 0x1900);
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
