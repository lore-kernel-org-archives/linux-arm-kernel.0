From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Nov 2013 10:36:49 -0700
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <527A1983.6020603@keymile.com>
References: <527A1983.6020603@keymile.com>
Message-ID: <20131106173649.GA25515@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 11:27:15AM +0100, Gerlando Falauto wrote:
> Hi everyone,
> 
> I am currently trying to describe an external device within a device
> tree in a Kirkwood design.

Here is what works for me:

        mbus {
                compatible = "marvell,kirkwood-mbus", "simple-bus";
                ranges = <MBUS_ID(0x04, 0xe8) 0 0xe0000000 0x8000000  /* PEX 0 MEM */
                          MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000     /* internal-regs */
                          MBUS_ID(0x01, 0x2f) 0 0xf4000000 0x10000      /* nand flash */
                          MBUS_ID(0x01, 0x1d) 0 0xffe00000 0x10000      /* boot rom */
                          MBUS_ID(0x01, 0x1e) 0 0xfff00000 0x10000      /* spi */
                          >;
                pcie-mem-aperture = <0xe0000000 0x10000000>; /* 256 MiB memory space */
                pex at e0000000 {
                        compatible = "marvell,kirkwood-pcie";
                        device_type = "pci";
                        ranges = <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000 /* Controller regs */
                                  0x82000000 1 0       MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
                                  >;

                        bus-range = <0x0 0xFF>;
                        pcie at 1,0 {
                                device_type = "pci";
                                assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
                                reg = <0x0800 0 0 0 0>;
                                ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
                                          0x81000000 0 0 0x81000000 0x1 0 1 0>;
                                fpga at 0 {
                                        reg = <0x8 0 0  0 0>;
                                        ranges = <0x00000000  0x82000000 0x00000000 0x00000000  0x8000000>;
                                        gpio3: fpga_gpio at 8 {
                                                #gpio-cells = <2>;
                                                compatible = "linux,basic-mmio-gpio";
                                                gpio-controller;
                                                reg-names = "dat", "set", "dirin";
                                                reg = <0x8 4>,
                                                      <0xc 4>,
                                                      <0x10 4>;
                                        };

(some hopefully irrelevant items omitted for brevity)

I use code like this in the FPGA PCI driver to load the DT nodes:

        struct of_device_id match_table[2] = {};
        struct device_node *child;
        int rc = 0;

        for_each_child_of_node(root, child) {
                /* Can't just create a single device.. */
                strlcpy(match_table[0].name, child->name,
                        sizeof(match_table[0].name));
                strlcpy(match_table[0].type, child->type,
                        sizeof(match_table[0].type));
                rc = of_platform_bus_probe(child, match_table,
                                           parent);
                if (rc)
                        break;
        }
(root would be the of_node of the FPGA)

My system hot plugs the FPGA in and out, so I use this in the FPGA
remove function to tear it all down:

        struct device_node *child;
        struct platform_device *devs[100];
        unsigned int cur = 0;

        /* We need to remove the platform devices in the reverse of the order
           we created them. The DT is topo sorted in dependency order. */
        for_each_child_of_node(pdev->dev.of_node, child) {
                struct platform_device *dev = of_find_device_by_node(child);
                if (dev)
                        devs[cur++] = dev;
        }

        while (cur != 0) {
                cur--;
                platform_device_unregister(devs[cur]);
        }

Which is a bit tricky and suboptimal.

Thomas: There is one buglet here that I haven't had time to do
anything about. Notice the DT is listing the PEX memory window in its
ranges. I've done this for two reasons
 - The bootloader sets this address range up, so it is correct to
   include in the DT
 - The address translation machinery requires it, otherwise we can't
   translate addreses of the non-PCI sub devices (eg gpio3)

The latter is a kernel issue. As we discussed when mbus was first put
together something needs to make the ranges consistent with the actual
mapping so that address translation works. IIRC people objected to
actually changing the ranges at runtime, so the alternate mechanism of
hooking the address translation seems necessary?

Unfortunately if you add the ranges then the mbus driver throws a
warning that it is trying to overwrite existing windows, but otherwise
things work OK.

> But I found no way to describe which BAR it should refer to, for instance.
> 
> Perhaps the "rrrrrrrr" part of phys.hi, using BAR0=0x10, BAR1=0x14,
> and so on?  Or else I should define a new instance of of bus (i.e.
> "pci_lbus_bridge") and invent yet another address encoding syntax?

I do feel there is some missing dynamic elements in this scheme, eg
the ranges value at the FPGA node should be dynamic based on the BAR
offset, but that is a generality that isn't important if you have only
one PCI device.

Jason
