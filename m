From: adam.cottrel@veea.com (Adam Cottrel)
Date: Fri, 12 Oct 2018 11:06:06 +0000
Subject: DMA remote memcpy requests
In-Reply-To: <b56bf98f-5055-fb85-7807-e45d495369f3@arm.com>
References: <DM6PR04MB405938028EC04FBD07F3D96AF2E10@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181012090937.GA12289@arm.com>
 <DM6PR04MB4059742D494D96FC11674A50F2E20@DM6PR04MB4059.namprd04.prod.outlook.com>
 <b56bf98f-5055-fb85-7807-e45d495369f3@arm.com>
Message-ID: <DM6PR04MB4059F0317DDBC221B5F751CCF2E20@DM6PR04MB4059.namprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Thank you for taking the time to reply.

> >>> I am using the ATH10K on Linux 14.4 with an Arm Cavium processor.
> >>> During heavy loading, I am seeing that target initiated DMA requests
> >>> are being silently dropped under extreme IO memory pressure and it
> >>> is proving very difficult to isolate the root cause.
> >>
> >> Is this ThunderX 1 or 2 or something else? Can you reproduce the
> >> issue with mainline?
> > I am using:-
> >          model = "Cavium ThunderX CN81XX board";
> >          compatible = "cavium,thunder-81xx";
> >
> > Yes - the issue can be reproduced on the mainline, but here is a link
> > to the code branch that I am using:-
> > https://elixir.bootlin.com/linux/v4.14.4/source/drivers/net/wireless/a
> > th/ath10k
> >
> >>> The ATH10K firmware uses the DMA API to set up phy_addr_t pointers
> >>> (32-bit) which are then copied to a shared ring buffer. The target
> 
> That's the first alarm bell - phys_addr_t is still going to be 64-bit on any arm64
> platform. If the device is expecting 32-bit addresses but somehow doesn't
> have its DMA mask set appropriately, then if you have more than 3GB or so
> of RAM there's the potential for addresses to get truncated such that the
> DMA *does* happen, but to the wrong place.

The firmware is setting the mask to be 32-bit. This was the first thing that I checked, but it is a good observation - the ATH10K hardware is limited to 32-bit.

> However, with SMMU translation enabled (i.e. not just passthrough), then
> I'd expect that same situation to cause more or less all DMA to fail, so if
> you've successfully tested that setup it must be something much more
> subtle :/

Agreed - like I said, under normal conditions (fair weather) there is no issue with DMA.

> 
> >>> then initiates the memcpy operation (for target-to-host reads), but
> >>> I do not have any means of debugging the target directly, and so I
> >>> am looking for software hooks on the host that might help debug this
> >>> complex
> >> problem.
> >>
> >> How does the firmware use the DMA API, or are you referring to a
> >> driver? If the latter, could you point us to the code, please? Is it
> >> using the streaming API, or is this a coherent allocation?
> > The code is using the ARM64 DMA API. It cuts corners in places (!!) but for
> the most part, it follows the rules. In local tests, I have added memory
> barriers (e.g. dmb(SY)) and even put in low-level flush/invalidate calls (DC
> CIVAC) to try and eliminate cache-coherency type problems.
> >
> > The receive fault can be observed in the Rx handler which can be found
> > on line 528 of ce.c:-
> > https://elixir.bootlin.com/linux/v4.14.4/source/drivers/net/wireless/a
> > th/ath10k/ce.c
> >
> > The memory is allocated by the Rx post buffer function which is on
> > line 760 of pci.c:-
> > https://elixir.bootlin.com/linux/v4.14.4/source/drivers/net/wireless/a
> > th/ath10k/pci.c
> >
> > To better observe the fault, I made the following change:-
> >   + On allocation, I use memset to clear the skb->data (pci.c::770)
> >   + On receive, I check that the data is not zero (ce.c::555)
> >   + If the data is not yet written, I exit the Rx IRQ handler and try again.
> >
> > In tests, the code works as expected under normal operation, however
> once I start to simulate a heavy memory pressure situation then the Rx
> handler starts to fail. This failure (if allowed to continue) will eventually tear
> down the entire module and crash the target firmware because presumably
> they are seeing similar dropouts on the transmit path.
> >
> > When the fault is happening, if I poll the target registers (e.g. write
> counters over MMIO) I can see that they are still sending us new messages.
> In other words, they have silently failed to send the data, or rather we have
> silently failed to accept the memory copy. I am not able to access the target
> firmware directly, but I have been reliably informed that the DMA memcpy
> operation is initiated by the target.
> >
> > My memory pressure test uses a large dd copy to create a lot of dirty
> memory pages. This always creates the fault, however without any memory
> pressure the code runs beautifully...
> 
> Are you able to characterise whether it's actually the memory pressure itself
> that changes the behaviour (e.g. difficulty in allocating new SKBs), or is it just
> that there's suddenly a lot more work going on in general? Those aren't
> exactly the most powerful CPU cores, and with only
> 2 or 4 of them it doesn't seem impossible that the system could simply get
> loaded to the point where it can't keep up and starts dropping things on the
> floor.

I have done many tests, so hopefully I can help to characterise the fault in detail.

The fault happens when I read or write a large file to Flash. For example, if I run the following:-
+ Running: dd bs=1M count=1700 if=/dev/zero of=/tmp.bin
 
However, the fault does not happen with the following tests:-
 + Overloaded CPU cores (e.g. stress)
 + Stressing userspace RAM
 + Running: dd bs=1M count=1700 if=/dev/zero oflag=direct of=/tmp.bin      <<-- this dd will limit the cache size by writing to the Flash direct
 + Running: dd bs=1M count=1700 if=/dev/zero of=/mnt/usbflash                   <<-- this dd writes to my USB Flash which does is not cached

I can reduce the likelihood of the crash with the following:-
 + Remounting the rootfs (MMC) with the SYNC flag
 + Increasing vm.free_mem_kbytes to 200MB
 + Regularly calling vm.drop_cache to force cache memory to be freed

However, when the fault condition occurs, I do not see page allocation faults.
The code (in so far as I can tell) does try to report memory allocation failures e.g. returns from the DMA API and skt_buf code are all checked

Best,
Adam
