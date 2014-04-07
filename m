From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Mon, 7 Apr 2014 22:58:36 +0100 (BST)
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada
 370)
In-Reply-To: <20140407204817.GB20736@obsidianresearch.com>
References: <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140406185833.GI29787@1wt.eu>
 <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
 <20140407174106.GD9952@obsidianresearch.com>
 <CAAfodu0kbTspq2QQf0dh3U7LB-q+ECaX9FJ35fCc25UmgPJZSg@mail.gmail.com>
 <20140407204817.GB20736@obsidianresearch.com>
Message-ID: <alpine.DEB.2.10.1404072239050.32332@vroombuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Thomas, Willy,

On Mon, 7 Apr 2014, Jason Gunthorpe wrote:

>>> HOWEVER, looking now very closely:
>>>
>>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) (prog-if 00 [Normal decode])
>>>    Memory behind bridge: e0000000-e02fffff
>>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) (prog-if 00 [Normal decode])
>>>    Memory behind bridge: e0300000-e03fffff
>>>
>>> This is certainly wrong, MBUS requires special alignment and sizing.
>>> 0x300000 is not a size which is a power of two, and the next window
>>> starts right after.
>
>> Interesting. Does the PCI code provide a way to specify that the sizes
>> much be a power of 2? I don't fully understand the implications but
>> would it be possible to assign just one MBUS window for the whole of
>> the PCIe memory instead?
>
> I know this has come up before, but I don't recall where things
> settled out.. mvebu_pcie_align_resource is the function to look at,
> the size at that point needs to be rounded up to a power of two and
> communicated back to the caller.
>
> Alternately, I belive Thomas once discussed using multiple mbus
> windows for these non-aligned requests.
>
>>> Just to confirm, what does something like the below say for you guys?
>>
>> See https://gist.github.com/ngreatorex/10025253 for the dmesg output.
>> I have also included the contents of
>> /sys/kernel/debug/mvebu-mbus/devices both before and after the
>> modprobe / oops. As you can see I get a total of 3 WARNINGs - one at
>> boot for the xHCI controller, and two when inserting igb.ko. Note that
>> this time I did this with both ports enabled.
>
> Yep, that is certainly the root problem - most likely for
> everyone. This also explains why Will saw success when he reverted
> that unrelated patch. That change altered the allocation pattern of
> the BARs and it just so happened to make things fall out properly.
>

I have finally managed to get the card working on both ports! Of course, 
to do so I have added some nice kludges to the code that now need to be 
implemented properly, but it is verification of what the problem is and 
how to fix it!

I have included the patch at the end of this e-mail. It probably won't 
apply cleanly for you as I have other dev_dbg calls in pci-mvebu.c.

What I did was to alter mvebu_pcie_align_resource to make the bridge 
memory resource aligned to 4M. This had the effect that the 2nd bridge to 
the xHCI controller was bumped to address 0xe0400000 instead of 
0xe0300000. I then also made it so that when we request the MBUS window to 
be set up we ensure that the size is a power of 2. This has the effect of 
creating the windows and addresses how we want them:

Relevant part of lspci -vvv:

00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) 
(prog-if 00 [Normal decode])
         Memory behind bridge: e0000000-e02fffff

00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) 
(prog-if 00 [Normal decode])
         Memory behind bridge: e0400000-e04fffff

cat /sys/kernel/debug/mvebu-mbus/devices:

[00] 00000000e8010000 - 00000000e8020000 : 0004:00e0 (remap 
0000000000010000)
[01] disabled
[02] disabled
[03] disabled
[04] disabled
[05] disabled
[06] disabled
[07] disabled
[08] 00000000fff00000 - 0000000100000000 : 0001:00e0
[09] 00000000e0400000 - 00000000e0500000 : 0008:00e8
[10] 00000000e0000000 - 00000000e0400000 : 0004:00e8
[11] disabled
[12] disabled
[13] disabled
[14] disabled
[15] disabled
[16] disabled
[17] disabled
[18] disabled
[19] disabled

Now, over to the experts to implement this properly :-)

Thanks to Jason, Thomas and Willy for your help with tracking this down.

Cheers,
Neil


>From e68870135cd54609d0421746ccdc1cb58ebbd4dd Mon Sep 17 00:00:00 2001
From: Neil Greatorex <neil@fatboyfat.co.uk>
Date: Mon, 7 Apr 2014 22:33:22 +0100
Subject: [PATCH] pci: host: mvebu - Test fix for Mirabox PCI issues

Ensure that bridge MBUS window is aligned at 4M to bump up 2nd bridge to address
e0400000 instead of e0300000. Also ensure that when we request the MBUS window,
it's size is a power of 2.
---
  drivers/pci/host/pci-mvebu.c | 5 ++++-
  1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index afd0dce..5e0144c 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -364,6 +364,9 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
  		(((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
  		port->memwin_base;

+	if (!is_power_of_2(port->memwin_size))
+		port->memwin_size = 1 << fls(port->memwin_size);
+
  	mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
  				    port->memwin_base, port->memwin_size);
  }
@@ -728,7 +731,7 @@ static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
  	if (res->flags & IORESOURCE_IO)
  		return round_up(start, max_t(resource_size_t, SZ_64K, size));
  	else if (res->flags & IORESOURCE_MEM)
-		return round_up(start, max_t(resource_size_t, SZ_1M, size));
+		return round_up(start, max_t(resource_size_t, SZ_4M, size));
  	else
  		return start;
  }
-- 
1.8.3.2
