From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 11 Apr 2014 14:41:41 -0600
Subject: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when
 possible
In-Reply-To: <CA+mB=1JCjDMzTuctvSQgjNhBnkyUPC2ooAzJOX_PC5L1gAau8w@mail.gmail.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
 <5318B232.2020507@wwwdotorg.org>
 <1394127555.4582.1.camel@weser.hi.pengutronix.de>
 <CA+mB=1JCjDMzTuctvSQgjNhBnkyUPC2ooAzJOX_PC5L1gAau8w@mail.gmail.com>
Message-ID: <20140411204140.GA8967@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 11:10:59PM +0530, Srikanth Thokala wrote:

> I see this error too on my setup (Xilinx PCIe Root Complex Driver),
> https://lkml.org/lkml/2014/3/3/183

> After digging into it, I see I need to override the API
> pcibios_get_phb_of_node()

No, as I pointed out before, the DT node comes in through
pci_scan_root_bus:

+static struct pci_bus __init *xilinx_pcie_scan_bus(int nr,
+				struct pci_sys_data *sys)
+{
+	struct xilinx_pcie_port *port = sys_to_pcie(sys);
+	struct pci_bus *bus;
+
+	if (port) {
+		port->root_busno = sys->busnr;
+		bus = pci_scan_root_bus(NULL, sys->busnr, &xilinx_pcie_ops,
                                       ^^^^^^

You can't pass NULL here and have DT work properly. 

See http://www.spinics.net/lists/arm-kernel/msg312392.html

Jason
