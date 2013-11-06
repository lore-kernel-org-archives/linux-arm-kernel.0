From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 6 Nov 2013 13:07:09 -0700
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <527A9AB9.2050903@keymile.com>
References: <527A1983.6020603@keymile.com>
 <20131106173649.GA25515@obsidianresearch.com>
 <527A9AB9.2050903@keymile.com>
Message-ID: <20131106200709.GB26881@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 08:38:33PM +0100, Gerlando Falauto wrote:

> So let me get this straight.
> First of all (though slightly unrelated), I looked at
> drivers/gpio/gpio-generic.c and found no reference whatsoever to the
> of_* infrastructure.

Yes, I have a patch to enable that:
https://github.com/jgunthorpe/linux/commit/da2881f55c094338f3b76617962e6af6c15f9cb9

People didn't like the DT binding, so I'm just sitting on it.

> So I realized of_device_alloc() populates the resource table of the
> platform_device automatically -- I wasn't aware of that.

Yes, in most cases platform drivers should not call of functions to get
resources 

> Second of all, if I understand it correctly (guessing the values for
> #size-cells and #address-cells), your translation scheme works as
> follows (let's say for the first register 0x8 of gpio3):
> 
> gpio3 (0x8)
> -> range 0 of fpga at 0       ==> 0x00000000 0x82000000 0x00000000
> -> range 0 of pcie at 1,0     ==> 0x82000000 0x1 0
> -> range 1 of pex at e0000000 ==> MBUS_ID(0x04, 0xe8) 0
> -> range 0 of mbus         ==> 0xe0000000
> 
> so you end up accessing @0xe0000008, is that right?

Almost:
 -> reg 0x8 pf gpio3
 -> range 0 of fpga at 0       ==> 0x82000000 0x00000000 0x00000008
 -> range 0 of pcie at 1,0     ==> 0x82000000 0x1 8
 -> range 1 of pex at e0000000 ==> MBUS_ID(0x04, 0xe8) 8
 -> range 0 of mbus         ==> 0xe0000008

Each translation represents something concrete:
 0x8 -> 0x82000000 0x00000000 0x00000008
    This is the BAR 0 decoder of the PCI device
 0x82000000 0x00000000 0x00000008 -> 0x82000000 0x1 8
    This is the PCI bridge's memory window decoder
  0x82000000 0x1 8 -> MBUS_ID(0x04, 0xe8) 8
    This is the MBUS window associated with the PEX
 MBUS_ID(0x04, 0xe8) 8 -> 0xe0000008
    This is the physical CPU BUS address associated with the MBUS
    window

> Looks like it ends up at the beginning of the memory region for
> PCIe, and that's no wonder since you only have a single device with
> a single BAR... right?

The mapping of the FPGA bus into a BAR is done by a single ranges:

> >                                 fpga at 0 {
> >                                         reg = <0x8 0 0  0 0>;
> >                                         ranges = <0x00000000  0x82000000 0x00000000 0x00000000  0x8000000>;
> >                                         gpio3: fpga_gpio at 8 {

That ranges says 'put address 0 of the child bus at 0x82000000
0x00000000 0x00000000', which is the BAR 0 address, relative to the
bridge's memory window.

> So suppose you also had a bigger BAR1 which would then shift your
> GPIO block at @0xe8000000.
> Until we get that figured out, where would you hardcode such offset then?

Since your BAR layout of your device is fixed you can adjust the
single ranges:

  ranges = <0x00000000  0x82000000 0x00000000 0x08000000  0x8000000>;

It is possible as well to do this in code in the FPGA driver.

> How would you also deal with a second (let's say identical) device on BAR1?

  ranges = <0x00000000  0x82000000 0x00000000 0x08000000  0x8000000  //  BAR 0
            0x10000000  0x82000000 0x00000000 0x08000000  0x8000000> // BAR 1

Use reg <0x10000abc xxx> to refer to the 2nd BAR. There are other ways
to organize things.

> I guess I could live with hardcoded values in the DT, as long as
> they're easy to spot and there's only one per BAR/device.
> Then it's easy to do a comparison with whatever gets assigned during
> probing.

I'd see it as an interm step, pending on some kind of core support for
this sort of stuff.

> >I use code like this in the FPGA PCI driver to load the DT nodes:
> >
> >         struct of_device_id match_table[2] = {};
> >         struct device_node *child;
> >         int rc = 0;
> >
> >         for_each_child_of_node(root, child) {
> >                 /* Can't just create a single device.. */
> >                 strlcpy(match_table[0].name, child->name,
> >                         sizeof(match_table[0].name));
> >                 strlcpy(match_table[0].type, child->type,
> >                         sizeof(match_table[0].type));
> >                 rc = of_platform_bus_probe(child, match_table,
> >                                            parent);
> >                 if (rc)
> >                         break;
> >         }
> >(root would be the of_node of the FPGA)
> 
> Stupid question... why not the following:
> 
> rc = of_platform_populate(root, NULL, NULL, parent);

Yes, that probably works. My version of the above has an additional
bit of code that I removed which filters the children to
create. Basically FPGA version 1.0 has a different list of devices
than version 1.1, etc.

Jason
