From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Sat, 1 Mar 2014 11:30:59 -0700
Subject: [PATCH 0/7] PCI irq mapping fixes and cleanups
In-Reply-To: <CAJ+vNU2VN5haOU2GN5o7UUg9vgYh06pAhvDaoGw6EzTBEbD0mg@mail.gmail.com>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <CAJ+vNU2VN5haOU2GN5o7UUg9vgYh06pAhvDaoGw6EzTBEbD0mg@mail.gmail.com>
Message-ID: <20140301183059.GA6315@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 04:53:33PM -0800, Tim Harvey wrote:

> In testing this on IMX6 I'm finding that 'of_irq_parse_and_map_pci()'
> always returns -EINVAL because it can't find a dt node for the host
> bridge: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/of/of_pci_irq.c#n60.

There may be some kind of issue in the pcie-designware.c:

static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
{
        struct pci_bus *bus;
        struct pcie_port *pp = sys_to_pcie(sys);

        if (pp) {
                pp->root_bus_nr = sys->busnr;
                bus = pci_scan_root_bus(NULL, sys->busnr, &dw_pcie_ops,
                                     ^^^^^^^^^^^
                                     Shouldn't be null for DT cases.

Perhaps since the driver doesn't pass in a parent pointer, no parent
device is associated with the struct pci_bus that gets created, so
pci_bus_to_OF_node will always fail and the DT PCI mechanisms become
broken.

Jason
