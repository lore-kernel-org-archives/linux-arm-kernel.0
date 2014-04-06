From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Sun, 6 Apr 2014 22:57:40 +0100 (BST)
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada
 370)
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
Message-ID: <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Willy,

On Sun, 6 Apr 2014, Willy Tarreau wrote:

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

Good work - I've been doing similar things myself! I can confirm that I 
see exactly the same thing with similar printks:

First port:
[ 1809.452878] igb 0000:01:00.0: enabling bus mastering
[ 1809.453098] igb 0000:01:00.0 (unregistered net_device): hw_addr is 
f1000000, start=e0000000, len=80000, flags=40200
[ 1809.453109] igb 0000:01:00.0 (unregistered net_device): About to read 
from offset 18
[ 1809.453120] igb 0000:01:00.0 (unregistered net_device): Read from 18 
returned 1400c0

Second port:
[ 1809.459445] igb 0000:01:00.1: enabling bus mastering
[ 1809.459563] igb 0000:01:00.1 (unregistered net_device): hw_addr is
f1100000, start=e0100000, len=80000, flags=40200
[ 1809.459573] igb 0000:01:00.1 (unregistered net_device): About to read
from offset 18
[ 1809.459581] Unhandled fault: external abort on non-linefetch (0x1008) 
at 0xf1100018

In the output above, the start= part shows the physical address and 
hw_addr shows the mapped address.

The physical addresses match those given in the lspci -vvv output (see 
https://gist.github.com/ngreatorex/9772195). I don't know enough about 
PCIe, the SoC *or* the Intel card to know if these addresses look correct 
or even sane! I did wonder if there was some issue due to the fact that 
the resources for 01:00.0 and 01:00.1 overlap, but I would guess(!?) that 
it's common in hardware that presents multiple devices.

It is perhaps noteworthy that this is the first access to the hardware for 
the 2nd port - i.e. there are no successful accesses, other than to enable 
the hardware, which AFAICT is simply accessing registers on the PCIe 
controller.

> Thus I suspect something is not behaving correctly in the code which
> configures the emulated bridge and/or the memory areas, resulting in
> the second port not being correctly mapped, thus causing the crash.
>
> But that's the deepest I can go unfortunately, I got lost after that.
>

Same here. I've tried playing around with a few things but not discovered 
anything even close to useful. Hopefully Thomas will be able to debug 
further when he gets the time.

> Regards,
> Willy
>
>

Cheers,
Neil
