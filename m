From: sarah.a.sharp@linux.intel.com (Sarah Sharp)
Date: Tue, 21 Jan 2014 13:17:41 -0800
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
In-Reply-To: <87vbxhrmea.fsf@natisbad.org>
References: <87sissopaf.fsf@natisbad.org> <20140114170719.GA12126@xanatos>
 <87bnzekz5l.fsf@natisbad.org>
 <063D6719AE5E284EB5DD2968C1650D6D45C5AB@AcuExch.aculab.com>
 <87mwix5anm.fsf@natisbad.org> <20140116185044.GC18392@xanatos>
 <87fvon2khn.fsf@natisbad.org> <87zjmvau23.fsf@nemi.mork.no>
 <20140117205432.GB5618@xanatos> <87vbxhrmea.fsf@natisbad.org>
Message-ID: <20140121211741.GA12657@xanatos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 18, 2014 at 10:49:17PM +0100, Arnaud Ebalard wrote:
> Hi,
> 
> I have added Thomas in the recipients, because I guess he may be of some
> help debugging the issue further. Thomas, the beginning of the thread is
> here: http://thread.gmane.org/gmane.linux.usb.general/101531

...

> I started suspecting the introduction of MSI support in Marvell PCIe
> host controller driver (FL1009 is on the PCIe bus) and compiled a
> a 3.13.0-rc8 w/ CONFIG_PCI_MSI disabled (it was enabled in all my
> previous tests): I did not manage to reproduce the issue with this
> kernel. As a side note, commits 5b4deb6526bd, 31f614edb726 and
> 627dfcc249e2 are
> 
> ATM, I do not know if the problem is related to a bug in introduced MSI
> support or some weird incompatibility of that functionality with the
> FL1009 which would require some quirk in XHCI stack.

We've actually had issues in the past with Fresco Logic hosts not
supporting MSI properly, even though the PCI devices claim to have MSI
support.  So turning off CONFIG_PCI_MSI may actually mean the Fresco
Logic host is to blame, rather than the Marvell patches.  I assume MSI
wouldn't have been turned on for the Fresco Logic host unless the parent
PCI host controller supported it.

Let's see if the Fresco Logic host is really the root cause.  Please
apply the this patch to 3.13.0-rc8 and recompile with CONFIG_PCI_MSI
enabled:

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 6c03584ac15f..74748444c040 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -30,6 +30,7 @@
 /* Device for a quirk */
 #define PCI_VENDOR_ID_FRESCO_LOGIC	0x1b73
 #define PCI_DEVICE_ID_FRESCO_LOGIC_PDK	0x1000
+#define PCI_DEVICE_ID_FRESCO_LOGIC_FL1009	0x1009
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1400	0x1400
 
 #define PCI_VENDOR_ID_ETRON		0x1b6f
@@ -63,6 +64,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 
 	/* Look for vendor-specific quirks */
 	if (pdev->vendor == PCI_VENDOR_ID_FRESCO_LOGIC &&
+			pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_FL1009)
+		xhci->quirks |= XHCI_BROKEN_MSI;
+	if (pdev->vendor == PCI_VENDOR_ID_FRESCO_LOGIC &&
 			(pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_PDK ||
 			 pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_FL1400)) {
 		if (pdev->device == PCI_DEVICE_ID_FRESCO_LOGIC_PDK &&

Sarah Sharp
