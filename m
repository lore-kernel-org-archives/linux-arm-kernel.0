From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 6 Apr 2014 21:11:57 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140406185833.GI29787@1wt.eu>
References: <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140406185833.GI29787@1wt.eu>
Message-ID: <20140406211157.4c99a178@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Willy Tarreau,

On Sun, 6 Apr 2014 20:58:33 +0200, Willy Tarreau wrote:

> On Fri, Apr 04, 2014 at 02:19:44PM +0100, Neil Greatorex wrote:
> > With this patch, I can get one port on the card working. With both ports 
> > enabled, I still get an OOPS, so some further work is needed.
> 
> Concerning this point, here's an update on my side. I found where the crash
> happens, but I don't exactly understand why, I suspect that an area is not
> correctly mapped :
> 
> root at xpgp:~# insmod /tmp/igb.ko 
> igb: Intel(R) Gigabit Ethernet Network Driver - version 5.0.5-k
> igb: Copyright (c) 2007-2013 Intel Corporation.
> PCI: enabling device 0000:00:09.0 (0140 -> 0143)
> PCI: enabling device 0000:02:00.0 (0140 -> 0142)
> request_region(pdev=edb21000, 00000049)
> hw_addr = pci_iomap(pdev=edb21000, 0, 0) = f0300000
> mem_start=e0000000 mem_end=e007ffff
> hw_addr = f0300000
> hw_addr=f0300000
> igb 0000:02:00.0: added PHC on eth4
> igb 0000:02:00.0: Intel(R) Gigabit Ethernet Network Connection
> igb 0000:02:00.0: eth4: (PCIe:5.0Gb/s:Width x1) 00:30:18:a6:6c:6a
> igb 0000:02:00.0: eth4: PBA No: FFFFFF-0FF
> igb 0000:02:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
> PCI: enabling device 0000:02:00.1 (0140 -> 0142)
> request_region(pdev=ed99d800, 00000049)
> hw_addr = pci_iomap(pdev=ed99d800, 0, 0) = f0400000
> mem_start=e0100000 mem_end=e017ffff
> hw_addr = f0400000
> hw_addr=f0400000
> Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0400018
> Internal error: : 1008 [#1] SMP THUMB2
> 
> in e1000_82575.o:igb_get_invariants_82575() :
>     123c:       f884 33b4       strb.w  r3, [r4, #948]
>     1240:       f884 33b9       strb.w  r3, [r4, #953]
>     1244:       f8c4 6300       str.w   r6, [r4, #768]
>     1248:       6863            ldr     r3, [r4, #4]
> =>  124a:       f8d3 8018       ldr.w   r8, [r3, #24]
> 
> in e1000_82575.c:igb_get_invariants_82575() :
>         hw->phy.media_type = e1000_media_type_copper;
>         dev_spec->sgmii_active = false;
>         dev_spec->module_plugged = false;
> 
> here=>  ctrl_ext = rd32(E1000_CTRL_EXT);
> 
> according to e1000_hw.h:
> 
>   #define E1000_CTRL_EXT 0x00018      /* Extended Device Control - RW */
> 
> according to e1000_regs.h:
> 
>   #define rd32(reg) (readl(hw->hw_addr + reg))
> 
> ===> ctrl_ext = readl((hw->hw_addr = 0xf0400000) + (reg = 0x18))
> 
> As you can see, the sequence is exactly the same for both ports. The
> first one has no problem performing the readl(), but the second one
> cannot. Both of them got the memory address returned by a call to
> pci_iomap(dev, 0, 0). I could verify that the pci_resource_len() for
> both is 524288 (0x80000).
> 
> The last "hwaddr=f0400000" is printed just before calling rd32() and
> shows that it was still OK there. Since the resource flags are 0x40200,
> we only have IORESOURCE_MEM so pci_iomap() calls ioremap_nocache().
> 
> Thus I suspect something is not behaving correctly in the code which
> configures the emulated bridge and/or the memory areas, resulting in
> the second port not being correctly mapped, thus causing the crash.
> 
> But that's the deepest I can go unfortunately, I got lost after that.

Thanks a lot again for all this investigation. I'm hoping to be able to
look at this PCIe issue this week.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
