From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 7 Apr 2014 11:41:06 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
References: <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140406185833.GI29787@1wt.eu>
 <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
Message-ID: <20140407174106.GD9952@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 06, 2014 at 10:57:40PM +0100, Neil Greatorex wrote:
> Willy,
> 
> On Sun, 6 Apr 2014, Willy Tarreau wrote:
> 
> >As you can see, the sequence is exactly the same for both ports. The
> >first one has no problem performing the readl(), but the second one
> >cannot. Both of them got the memory address returned by a call to
> >pci_iomap(dev, 0, 0). I could verify that the pci_resource_len() for
> >both is 524288 (0x80000).
> >
> >The last "hwaddr=f0400000" is printed just before calling rd32() and
> >shows that it was still OK there. Since the resource flags are 0x40200,
> >we only have IORESOURCE_MEM so pci_iomap() calls ioremap_nocache().
> >
> 
> Good work - I've been doing similar things myself! I can confirm
> that I see exactly the same thing with similar printks:
> 
> First port:
> [ 1809.452878] igb 0000:01:00.0: enabling bus mastering
> [ 1809.453098] igb 0000:01:00.0 (unregistered net_device): hw_addr
> is f1000000, start=e0000000, len=80000, flags=40200
> [ 1809.453109] igb 0000:01:00.0 (unregistered net_device): About to
> read from offset 18
> [ 1809.453120] igb 0000:01:00.0 (unregistered net_device): Read from
> 18 returned 1400c0
> 
> Second port:
> [ 1809.459445] igb 0000:01:00.1: enabling bus mastering
> [ 1809.459563] igb 0000:01:00.1 (unregistered net_device): hw_addr is
> f1100000, start=e0100000, len=80000, flags=40200
> [ 1809.459573] igb 0000:01:00.1 (unregistered net_device): About to read
> from offset 18
> [ 1809.459581] Unhandled fault: external abort on non-linefetch
> (0x1008) at 0xf1100018
> 
> In the output above, the start= part shows the physical address and
> hw_addr shows the mapped address.

This is very similar to what Matthew Minter
<matthew_minter@xyratex.com> is seeing on Hot Plug with AHCI. (See
'Armada XP (mvebu) PCIe memory (BAR/window) re-allocation' thread)

That probably says it is somehow mbus related - dumping the mbus
registers when the fault happens should clarify that point. The size
would a good place to check first.

> The physical addresses match those given in the lspci -vvv output
> (see https://gist.github.com/ngreatorex/9772195). I don't know
> enough about PCIe, the SoC *or* the Intel card to know if these
> addresses look correct or even sane! I did wonder if there was some
> issue due to the fact that the resources for 01:00.0 and 01:00.1
> overlap, but I would guess(!?) that it's common in hardware that
> presents multiple devices.

Which overlap?

To be very clear, PCI BARs, should never overlap.

The bridge windows should fully contain downstream bars:

00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) (prog-if 00 [Normal decode])
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
	Memory behind bridge: e0000000-e02fffff
01:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [disabled] [size=512K]
01:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
	Region 0: Memory at e0100000 (32-bit, non-prefetchable) [disabled] [size=512K]

Looks good to me.

HOWEVER, looking now very closely:

00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) (prog-if 00 [Normal decode])
   Memory behind bridge: e0000000-e02fffff
00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) (prog-if 00 [Normal decode])
   Memory behind bridge: e0300000-e03fffff

This is certainly wrong, MBUS requires special alignment and sizing.
0x300000 is not a size which is a power of two, and the next window
starts right after.

We need to see the first bridge use e0000000-e03fffff

Just to confirm, what does something like the below say for you guys?

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 2ac754e..dfeb0dd 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -56,6 +56,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/debugfs.h>
+#include <linux/log2.h>
 
 /*
  * DDR target is the same on all platforms.
@@ -266,6 +267,8 @@ static int mvebu_mbus_setup_window(struct mvebu_mbus_state *mbus,
                mbus->soc->win_cfg_offset(win);
        u32 ctrl, remap_addr;
 
+       WARN_ON(!is_power_of_2(size));
+
        ctrl = ((size - 1) & WIN_CTRL_SIZE_MASK) |
                (attr << WIN_CTRL_ATTR_SHIFT)    |
                (target << WIN_CTRL_TGT_SHIFT)   |


Regards,
Jason
