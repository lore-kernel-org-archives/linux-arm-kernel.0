From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 03 Mar 2014 17:11:37 +0900
Subject: [PATCH 0/7] PCI irq mapping fixes and cleanups
In-Reply-To: <20140301183059.GA6315@obsidianresearch.com>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <CAJ+vNU2VN5haOU2GN5o7UUg9vgYh06pAhvDaoGw6EzTBEbD0mg@mail.gmail.com>
 <20140301183059.GA6315@obsidianresearch.com>
Message-ID: <000601cf36b8$330b3a90$9921afb0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, March 02, 2014 3:31 AM, Jason Gunthorpe wrote:
> On Fri, Feb 28, 2014 at 04:53:33PM -0800, Tim Harvey wrote:
> 
> > In testing this on IMX6 I'm finding that 'of_irq_parse_and_map_pci()'
> > always returns -EINVAL because it can't find a dt node for the host
> > bridge:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/of/of_pci_irq.c#n60.
> 
> There may be some kind of issue in the pcie-designware.c:
> 
> static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
> {
>         struct pci_bus *bus;
>         struct pcie_port *pp = sys_to_pcie(sys);
> 
>         if (pp) {
>                 pp->root_bus_nr = sys->busnr;
>                 bus = pci_scan_root_bus(NULL, sys->busnr, &dw_pcie_ops,
>                                      ^^^^^^^^^^^
>                                      Shouldn't be null for DT cases.
> 
> Perhaps since the driver doesn't pass in a parent pointer, no parent
> device is associated with the struct pci_bus that gets created, so
> pci_bus_to_OF_node will always fail and the DT PCI mechanisms become
> broken.

Jason,
Thank you for your advice. :-)

Tim,
I tested the following as Jason guided.
You can test i.MX PCIe with this.

./drivers/pci/host/pcie-designware.c
@@ -726,7 +727,7 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)

        if (pp) {
                pp->root_bus_nr = sys->busnr;
-               bus = pci_scan_root_bus(NULL, sys->busnr, &dw_pcie_ops,
+               bus = pci_scan_root_bus(pp->dev, sys->busnr, &dw_pcie_ops,
                                        sys, &sys->resources);
        } else {
                bus = NULL;

However, I think that we may need to replace 'pci_common_init()'
with 'pci_common_init_dev()'.

Best regards,
Jingoo Han
