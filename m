From: w@1wt.eu (Willy Tarreau)
Date: Tue, 8 Apr 2014 08:40:03 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <alpine.DEB.2.10.1404072239050.32332@vroombuntu>
References: <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140406185833.GI29787@1wt.eu>
 <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
 <20140407174106.GD9952@obsidianresearch.com>
 <CAAfodu0kbTspq2QQf0dh3U7LB-q+ECaX9FJ35fCc25UmgPJZSg@mail.gmail.com>
 <20140407204817.GB20736@obsidianresearch.com>
 <alpine.DEB.2.10.1404072239050.32332@vroombuntu>
Message-ID: <20140408064003.GU29787@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oh and BTW, it also fixed another issue I had loading myri10ge on this
board :

Before the patch :

root at xpgp:~# lspci -vvnn |egrep -i '^0|memory'
00:01.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:7846] (rev 02) (prog-if 00 [Normal decode])
        Prefetchable memory behind bridge: 00000000-000fffff
00:09.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:7846] (rev 02) (prog-if 00 [Normal decode])
        Prefetchable memory behind bridge: 00000000-000fffff
00:0a.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:7846] (rev 02) (prog-if 00 [Normal decode])
        Memory behind bridge: e0000000-e17fffff
        Prefetchable memory behind bridge: 00000000-000fffff
03:00.0 Ethernet controller [0200]: MYRICOM Inc. Myri-10G Dual-Protocol NIC [14c1:0008]
        Region 0: Memory at e0000000 (64-bit, prefetchable) [size=16M]
        Region 2: Memory at e1000000 (64-bit, non-prefetchable) [size=1M]

root at xpgp:~# modprobe myri10ge
myri10ge: Version 1.5.3-1.534
PCI: enabling device 0000:00:0a.0 (0140 -> 0143)
myri10ge 0000:03:00.0: PCIE x4 Link
myri10ge 0000:03:00.0: Direct firmware load failed with error -2
myri10ge 0000:03:00.0: Falling back to user helper
myri10ge 0000:03:00.0: Unable to load myri10ge_eth_z8e.dat firmware image via hotplug
myri10ge 0000:03:00.0: hotplug firmware loading failed
myri10ge 0000:03:00.0: Successfully adopted running firmware
myri10ge 0000:03:00.0: Using firmware currently running on NIC.  For optimal
myri10ge 0000:03:00.0: performance consider loading optimized firmware
myri10ge 0000:03:00.0: via hotplug
myri10ge 0000:03:00.0: dummy rdma enable failed
myri10ge 0000:03:00.0: command 44 timed out, result = -1
myri10ge 0000:03:00.0: command 12 timed out, result = -1
myri10ge 0000:03:00.0: failed MXGEFW_CMD_GET_RX_RING_SIZE
myri10ge 0000:03:00.0: failed to load firmware
myri10ge 0000:03:00.0: myri10ge_probe() failed: MAC=00:60:dd:47:63:e1, SN=320225

After the patch, the lspci output is *exactly* the same but it works
much better :

root at xpgp:~# lspci -vvnn |egrep -i '^0|memory'
00:01.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:7846] (rev 02) (prog-if 00 [Normal decode])
        Prefetchable memory behind bridge: 00000000-000fffff
00:09.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:7846] (rev 02) (prog-if 00 [Normal decode])
        Prefetchable memory behind bridge: 00000000-000fffff
00:0a.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:7846] (rev 02) (prog-if 00 [Normal decode])
        Memory behind bridge: e0000000-e17fffff
        Prefetchable memory behind bridge: 00000000-000fffff
03:00.0 Ethernet controller [0200]: MYRICOM Inc. Myri-10G Dual-Protocol NIC [14c1:0008]
        Region 0: Memory at e0000000 (64-bit, prefetchable) [size=16M]
        Region 2: Memory at e1000000 (64-bit, non-prefetchable) [size=1M]

root at xpgp:~# modprobe myri10ge
myri10ge: Version 1.5.3-1.534
PCI: enabling device 0000:00:0a.0 (0140 -> 0143)
myri10ge 0000:03:00.0: PCIE x1 Link
myri10ge 0000:03:00.0: Direct firmware load failed with error -2
myri10ge 0000:03:00.0: Falling back to user helper
myri10ge 0000:03:00.0: Unable to load myri10ge_eth_z8e.dat firmware image via hotplug
myri10ge 0000:03:00.0: hotplug firmware loading failed
myri10ge 0000:03:00.0: Successfully adopted running firmware
myri10ge 0000:03:00.0: Using firmware currently running on NIC.  For optimal
myri10ge 0000:03:00.0: performance consider loading optimized firmware
myri10ge 0000:03:00.0: via hotplug
myri10ge 0000:03:00.0: MSI IRQ 112, tx bndry 2048, fw adopted, WC Disabled
root at xpgp:~#

Thus I guess that the timeout I was seeing above during the modprobe was
caused by the incorrect mbus window.

So +1 on this part of the patch here :

        port->memwin_size = roundup_pow_of_two(port->memwin_size);

Cheers,
Willy
