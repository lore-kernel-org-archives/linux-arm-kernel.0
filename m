From: marex@denx.de (Marek Vasut)
Date: Thu, 20 Mar 2014 00:05:56 +0100
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <20140319225137.GM7528@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <201403192252.32443.marex@denx.de>
 <20140319225137.GM7528@n2100.arm.linux.org.uk>
Message-ID: <201403200005.56334.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 19, 2014 at 11:51:38 PM, Russell King - ARM Linux wrote:
> On Wed, Mar 19, 2014 at 10:52:32PM +0100, Marek Vasut wrote:

[...]

> > Speaking of FEC and slightly off-topic, have you ever seen this on your
> > box [1]/[2]/[3] ? I wonder if this might be cache-related as well, since
> > I saw similar issue on MX6 with PCIe-connected ethernet. I cannot put a
> > finger on this though.
> 
> I think I've seen something similar once or twice.

Nice, thanks for confirming this.

> Let me just pull up the transmit function.  This is the code which
> writes to the descriptors (which frankly is pretty horrid):

Yes.

>         bdp->cbd_datlen = skb->len;
>         bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, bufaddr,
>                         skb->len, DMA_TO_DEVICE); <-- barrier inside
>                 ebdp->cbd_bdu = 0;
>                         ebdp->cbd_esc = BD_ENET_TX_INT;
>                                 ebdp->cbd_esc |= BD_ENET_TX_PINS;
>         bdp->cbd_sc = status;
>         writel(0, fep->hwp + FEC_X_DES_ACTIVE); <-- barrier before write
> 
> A couple of points here:
> 
> 1. The hardware operates in a ring - it can read the next ring if it
>    sees the BD_ENET_TX_READY bit set if has just finished processing
>    the previous descriptor - this can happen before the write to
>    FEC_X_DES_ACTIVE.
> 
> 2. The ARM can re-order writes.  The writes it can re-order are:
> 
> 	bdp->cbd_bufaddr
> 	ebdp->cbd_bdu
> 	ebdp->cbd_esc
> 	ebdp->cbd_sc
> 
> Hence, it's entirely possible for the FEC to see the updated descriptor
> status before the rest of the descriptor has been written.  What's missing
> is a barrier between the descriptor writes, and the final write to
> bdp->cbd_sc.

I think there might even be another thing at play here, but please correct me if 
I am wrong. If you look at fb8ef788680d48523321e5f150b23700a1caf980 , this patch 
actually has no functional impact on the driver , right ?

It does no functional change at all, but it changed something for Fugang. This 
makes me also believe there might clearly be something afoot with the DMA 
descriptors. Reading Documentation/DMA-API.txt , I noticed the ring with the 
descriptors is allocated with dma_alloc_coherent() . Yet, DMA-API.txt , section 
I, states:

"
 29 Consistent memory is memory for which a write by either the device or
 30 the processor can immediately be read by the processor or device
 31 without having to worry about caching effects.  (You may however need
 32 to make sure to flush the processor's write buffers before telling
 33 devices to read that memory.)
"

So the writes into the descriptor from the CPU might even be stuck in the CPU's 
write buffer when this code below from fec_main.c is called:

 438         /* Trigger transmission start */
 439         writel(0, fep->hwp + FEC_X_DES_ACTIVE);

Does this also make sense or is my idea completely flawed please ?

> Had I not got distracted by the L2 issues, I'd have posted my FEC patches
> by now... in any case, my current xmit function looks a little different -
> I've organised it such that:
> 
> 1. We don't modify anything until we're past the point where things can
>    error out.
> 
> 2. Writes to the descriptor are localised in one area.
> 
> 3. There's a wmb() barrier between cbd_sc and the previous writes - I
>    discussed this with Will Deacon, which resulted in this documentation
>    for the barrier:
> 
>         /*
>          * We need the preceding stores to the descriptor to complete
>          * before updating the status field, which hands it over to the
>          * hardware.  The corresponding rmb() is "in the hardware".
>          */
> 
> The second thing that causes the transmit timeouts is the horrid way
> NAPI has been added to the driver - it's racy.  NAPI itself isn't the
> problem, it's this (compressed a bit to show only the relevant bits):

I fully agree there are multiple race conditions in the driver as it is now.

[...]

> That all said - with the patch below I haven't seen problems since.
> (which is the quickest way I can think of to get you a copy of what
> I'm presently running - I've killed a number of debug bits denoted by
> all the blank lines - and this is against -rc7.)  You may notice that
> I added some TX ring dumping code to the driver - always useful in
> these situations. ;-)

I will test this ASAP on multiple MX6es and let you know of the result.

> This patch is of course the consolidated version: individually, this
> would be at least 19 patches with nice commit messages describing
> each change...

Please keep me on CC of those, I'd be very interested to test them.

> As far as the 600Mbps receive - you need the right conditions for that.
> I select the performance cpufreq governor after boot, and let the boot
> quiesce.  It doesn't take much for it to drop back to 460Mbps - another
> running process other than iperf -s is sufficient to do that.
> 
> Let me know how you get on with this.

Roger that, will do, thank you very much !
