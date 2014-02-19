From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Feb 2014 10:26:58 +0100
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <53046D98.6020801@keymile.com>
References: <51DD88A4.1030506@keymile.com> <20130710185706.72b124a4@skate>
 <51DD9A8C.10608@keymile.com> <20130711163220.2b3adf38@skate>
 <53039894.10905@keymile.com> <20140218212751.07c2aeb5@skate>
 <53046D98.6020801@keymile.com>
Message-ID: <20140219102658.76eec91e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gerlando Falauto,

On Wed, 19 Feb 2014 09:38:48 +0100, Gerlando Falauto wrote:

> >> pci 0000:01:00.0: BAR 3: assigned [mem 0xe8000000-0xe87fffff]
> >> pci 0000:01:00.0: BAR 4: assigned [mem 0xe8800000-0xe8801fff]
> >> pci 0000:01:00.0: BAR 0: assigned [mem 0xe8802000-0xe8802fff]
> >> pci 0000:01:00.0: BAR 2: assigned [mem 0xe8803000-0xe8803fff]
> >> pci 0000:01:00.0: BAR 5: assigned [mem 0xe8804000-0xe8804fff]
> >
> > So in total, for the device 0000:01:00, the memory region should go
> > from 0xe0000000 to 0xe8804fff. This means that a 256 MB window is
> > needed for this device, because only power of two sizes are possible
> > for MBus windows.
> >
> > Can you give me the output of /sys/kernel/debug/mvebu-mbus/devices ? It
> > will tell us how the MBus windows are configured, as I suspect the
> > problem might be here.
> 
> Here it goes:
> 
> [00] disabled
> [01] disabled
> [02] disabled
> [03] disabled
> [04] 00000000ff000000 - 00000000ff010000 : nand
> [05] 00000000f4000000 - 00000000f8000000 : vpcie
> [06] 00000000fe000000 - 00000000fe010000 : dragonite
> [07] 00000000e0000000 - 00000000ec000000 : pcie0.0
> 
> So there's something wrong: a 256MB window should go all the way up to 
> 0xf0000000, and we have 192MB instead and I don't know how that would be 
> interpreted.

My understanding is that a 192 MB window is illegal, because the window
size should be encoded as a sequence of 1s followed by a sequence of 0s
from the LSB to the MSB. To me, this means that only power of two
window sizes are possible.

> I couldn't figure out where this range comes from though, as in the 
> device tree I now have a size of 256MB (I stupidly set it to 192MB at 
> some point, but I now changed it):
> 
> # hexdump -C /proc/device-tree/ocp at f1000000/pcie-controller/ranges
>   | cut -c1-58
> 00000000  82 00 00 00 00 00 00 00  00 04 00 00 00 04 00 00
> 00000010  00 00 00 00 00 00 20 00  82 00 00 00 00 00 00 00
> 00000020  e0 00 00 00 e0 00 00 00  00 00 00 00 10 00 00 00
>                                                 ^^^^^^^^^^^

Wow, that's an old DT representation that you have here :)

But ok, let me try to explain. The 256 MB value that you define in the
DT is the global PCIe memory aperture: it is the maximum amount of
memory that we allow the PCIe driver to allocate for PCIe windows. But
depending on which PCIe devices you have plugged in, and how large
their BARs are, not necessarily all of these 256 MB will be used.

So, you can very well have a 256 MB global PCIe memory aperture, and
still have only one 1 MB PCIe memory window for PCIe 0.0 and a 256 KB
PCIe memory window for PCIe 1.0, and that's it.

Now, the 192 MB comes from the enumeration of your device. Linux
enumerates the BAR of your device:

pci 0000:01:00.0: BAR 1: assigned [mem 0xe0000000-0xe7ffffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xe8000000-0xe87fffff]
pci 0000:01:00.0: BAR 4: assigned [mem 0xe8800000-0xe8801fff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe8802000-0xe8802fff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xe8803000-0xe8803fff]
pci 0000:01:00.0: BAR 5: assigned [mem 0xe8804000-0xe8804fff]

and then concludes that at the emulated bridge level, the memory region
to be created is:

pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xebffffff]

which corresponds to the 192 MB window that we see created.

But I believe a 192 MB memory window cannot work with MBus, it should
be rounded up to the next power of 2. Can you try the below patch (not
tested, not even compiled, might need some tweaks to apply to your 3.10
kernel) :

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 13478ec..002229a 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -372,6 +372,11 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
                (((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
                port->memwin_base;
 
+       pr_info("PCIE %d.%d: creating window at 0x%x, size 0x%x rounded up to 0x%x\n",
+               port->port, port->lane, port->memwin_base,
+               port->memwin_size, roundup_pow_of_two(port->memwin_size));
+       port->memwin_size = roundup_pow_of_two(port->memwin_size);
+
        mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
                                    port->memwin_base, port->memwin_size);
 }

I'm obviously interested in seeing the message that gets shown, as well
as the new mvebu-mbus debugfs output.

For good measure, if you could also dump the registers of the PCIe
window. In your case, it was window 7, so dumping 0xf1020070 and
0xf1020074 would be useful.

> But apart from that, what I still don't understand is how that could 
> have anything to do with my problem. The memory area I'm not able to 
> access starts at 0xe4000000.
> BAR0, on the other hand, spawns 0xe8802000-0xe8802fff and seems to work 
> fine.

I am not sure, but since we are configuring an invalid memory size,
maybe the MBus behavior is undefined, and we get some completely funky
behavior, where parts of the 192 MB window are actually work, but parts
of it are not.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
