From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed, 06 Nov 2013 20:38:33 +0100
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <20131106173649.GA25515@obsidianresearch.com>
References: <527A1983.6020603@keymile.com>
 <20131106173649.GA25515@obsidianresearch.com>
Message-ID: <527A9AB9.2050903@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

thank you for your feeback.

On 11/06/2013 06:36 PM, Jason Gunthorpe wrote:
> On Wed, Nov 06, 2013 at 11:27:15AM +0100, Gerlando Falauto wrote:
>> Hi everyone,
>>
>> I am currently trying to describe an external device within a device
>> tree in a Kirkwood design.
>
> Here is what works for me:
>
>          mbus {
>                  compatible = "marvell,kirkwood-mbus", "simple-bus";
>                  ranges = <MBUS_ID(0x04, 0xe8) 0 0xe0000000 0x8000000  /* PEX 0 MEM */
>                            MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000     /* internal-regs */
>                            MBUS_ID(0x01, 0x2f) 0 0xf4000000 0x10000      /* nand flash */
>                            MBUS_ID(0x01, 0x1d) 0 0xffe00000 0x10000      /* boot rom */
>                            MBUS_ID(0x01, 0x1e) 0 0xfff00000 0x10000      /* spi */
>                            >;
>                  pcie-mem-aperture = <0xe0000000 0x10000000>; /* 256 MiB memory space */
>                  pex at e0000000 {
>                          compatible = "marvell,kirkwood-pcie";
>                          device_type = "pci";
>                          ranges = <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000 /* Controller regs */
>                                    0x82000000 1 0       MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
>                                    >;
>
>                          bus-range = <0x0 0xFF>;
>                          pcie at 1,0 {
>                                  device_type = "pci";
>                                  assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
>                                  reg = <0x0800 0 0 0 0>;
>                                  ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>                                            0x81000000 0 0 0x81000000 0x1 0 1 0>;
>                                  fpga at 0 {
>                                          reg = <0x8 0 0  0 0>;
>                                          ranges = <0x00000000  0x82000000 0x00000000 0x00000000  0x8000000>;
>                                          gpio3: fpga_gpio at 8 {
>                                                  #gpio-cells = <2>;
>                                                  compatible = "linux,basic-mmio-gpio";
>                                                  gpio-controller;
>                                                  reg-names = "dat", "set", "dirin";
>                                                  reg = <0x8 4>,
>                                                        <0xc 4>,
>                                                        <0x10 4>;
>                                          };
>
> (some hopefully irrelevant items omitted for brevity)

So let me get this straight.
First of all (though slightly unrelated), I looked at 
drivers/gpio/gpio-generic.c and found no reference whatsoever to the 
of_* infrastructure.
So I realized of_device_alloc() populates the resource table of the 
platform_device automatically -- I wasn't aware of that.

Second of all, if I understand it correctly (guessing the values for 
#size-cells and #address-cells), your translation scheme works as 
follows (let's say for the first register 0x8 of gpio3):

gpio3 (0x8)
-> range 0 of fpga at 0       ==> 0x00000000 0x82000000 0x00000000
-> range 0 of pcie at 1,0     ==> 0x82000000 0x1 0
-> range 1 of pex at e0000000 ==> MBUS_ID(0x04, 0xe8) 0
-> range 0 of mbus         ==> 0xe0000000

so you end up accessing @0xe0000008, is that right?

Looks like it ends up at the beginning of the memory region for PCIe, 
and that's no wonder since you only have a single device with a single 
BAR... right?

So suppose you also had a bigger BAR1 which would then shift your GPIO 
block at @0xe8000000.
I believe we've established (in other followup mails) it would be nice 
to have a dynamic translation mechanism, which is not in place yet.
Until we get that figured out, where would you hardcode such offset then?
How would you also deal with a second (let's say identical) device on BAR1?
I guess I could live with hardcoded values in the DT, as long as they're 
easy to spot and there's only one per BAR/device.
Then it's easy to do a comparison with whatever gets assigned during 
probing.

(Apologies in advance if I'm talking nonsense, but I only see a bunch of 
numbers in the above tree, I'm having a really hard time figuring out 
how this whole translation works...)

> I use code like this in the FPGA PCI driver to load the DT nodes:
>
>          struct of_device_id match_table[2] = {};
>          struct device_node *child;
>          int rc = 0;
>
>          for_each_child_of_node(root, child) {
>                  /* Can't just create a single device.. */
>                  strlcpy(match_table[0].name, child->name,
>                          sizeof(match_table[0].name));
>                  strlcpy(match_table[0].type, child->type,
>                          sizeof(match_table[0].type));
>                  rc = of_platform_bus_probe(child, match_table,
>                                             parent);
>                  if (rc)
>                          break;
>          }
> (root would be the of_node of the FPGA)

Stupid question... why not the following:

rc = of_platform_populate(root, NULL, NULL, parent);

I've been using this in several places, though I've always wondered 
whether there was indeed something wrong it...

[...]
>> But I found no way to describe which BAR it should refer to, for instance.
>>
>> Perhaps the "rrrrrrrr" part of phys.hi, using BAR0=0x10, BAR1=0x14,
>> and so on?  Or else I should define a new instance of of bus (i.e.
>> "pci_lbus_bridge") and invent yet another address encoding syntax?
>
> I do feel there is some missing dynamic elements in this scheme, eg
> the ranges value at the FPGA node should be dynamic based on the BAR
> offset, but that is a generality that isn't important if you have only
> one PCI device.

Right, which is my case... except, I have several BARs within it, which 
does complicate things quite a bit, I'm afraid.

Thanks again Jason!
Gerlando
