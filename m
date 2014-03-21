From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Mar 2014 17:12:17 +0000
Subject: PL310 errata workarounds
In-Reply-To: <CAHrpEqSaV951SGctNdHGtbX-ksv=OEv2KSY_QBpZ_Qu2c_Ka-Q@mail.gmail.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <CAL_JsqLDun2VkCFK9Fec6n38bNz2w9mscPdXcGYeLiZtiXkVDg@mail.gmail.com>
 <20140318172615.GX21483@n2100.arm.linux.org.uk>
 <201403192252.32443.marex@denx.de>
 <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <CAHrpEqSaV951SGctNdHGtbX-ksv=OEv2KSY_QBpZ_Qu2c_Ka-Q@mail.gmail.com>
Message-ID: <20140321171217.GK7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 10:50:41AM -0500, Frank Li wrote:
> On Wed, Mar 19, 2014 at 5:51 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > 2. The ARM can re-order writes.  The writes it can re-order are:
> >
> >         bdp->cbd_bufaddr
> >         ebdp->cbd_bdu
> >         ebdp->cbd_esc
> >         ebdp->cbd_sc
> >
> > Hence, it's entirely possible for the FEC to see the updated descriptor
> > status before the rest of the descriptor has been written.  What's missing
> > is a barrier between the descriptor writes, and the final write to
> > bdp->cbd_sc.
> 
> Possible. I also consider this when debug the other issues.
> Just bdp->bufaddr and bdp->buflen is important.
> bdu, hardware don't care it.
> esc is the same for each BD.  When software go though BD ring once,
> esc will be not changed again, even though we write.

If you assume that all you're sending is traffic which needs the headers
checksummed (in other words, only IP traffic and nothing else) then you're
correct.  Reality is that other traffic gets included, such as ARPs which
have skb->ip_summed = CHECKSUM_NONE.

In any case, you are wrong about cbd_esc.  For this code:

			ebdp->cbd_esc = BD_ENET_TX_INT;
 
			/* Enable protocol checksum flags
			 * We do not bother with the IP Checksum bits as they
			 * are done by the kernel
			 */
			if (skb->ip_summed == CHECKSUM_PARTIAL)
				ebdp->cbd_esc |= BD_ENET_TX_PINS;

this is the assembly which the compiler will generate:

     820:       e3a03101        mov     r3, #1073741824 ; 0x40000000
     824:       e5863008        str     r3, [r6, #8]
     828:       e5d53064        ldrb    r3, [r5, #100]  ; 0x64
     82c:       e203300c        and     r3, r3, #12
     830:       e353000c        cmp     r3, #12
     834:       03a03205        moveq   r3, #1342177280 ; 0x50000000
     838:       05863008        streq   r3, [r6, #8]

That's a write to cbd_esc with BD_ENET_TX_INT set and BD_ENET_TX_PINS
clear, followed by another write with both set if the packet has been
partially checksummed.

Depending on the CPU and timing, that could be visible to the device.
Thankfully, fb8ef788680 fixed it for CPUs which are strongly ordered.
However, with a weakly ordered CPU, all it would take is an interrupt
between those two writes to make them visible as separate writes, and
without the following barrier, the order of cbd_esc and cbd_sc
becoming visible is uncertain.

> but if sc write before buffaddr and bullen, there will be issue.
> Add memory barre here is better before  ebdp->cbd_sc.
> 
> I also want to add it before, But I have not found a test case to
> verify it is necessary.

In these situations, knowledge and theory is better than test-and-verify,
especially when we're talking about trying to hit a small window with
timings.

We know ARMv6 and ARMv7 are weakly ordered.  We know we see problems
with transmit on these devices.  We know that the specification calls
for the TX ready bit to be set last.  We know on these CPUs that
writes can be reordered.  Therefore... a barrier is definitely
required.

> > The result is the handler is entered, FEC_IEVENT contains TXF and MII
> > events.  Both these events are cleared down, (and thus no longer exist
> > as interrupt-causing events.)  napi_schedule_prep() returns false as
> > the NAPI rx function is still running, and doesn't mark it for a re-run.
> > We then do the MII interrupt.  Loop again, and int_events is zero,
> > we exit.
> >
> > Meanwhile, the NAPI rx function calls napi_complete() and re-enables
> > the receive interrupt.  If you're unlucky enough that the RX ring is
> > also full... no RXF interrupt.  So no further interrupts except maybe
> > MII interrupts.
> >
> > NAPI never gets scheduled.  RX ring never gets emptied.  TX ring never
> > gets reaped.  The result is a timeout with a completely full TX ring.
> 
> Do you see RX ring full?

I haven't added any debug for the RX ring, so I don't know for certain.
What I do know is that I've had the situation where the TX ring is
completely full of packets which have been sent and the TX ring hasn't
been reaped, which leads to the timeout, and that is down to the NAPI
functions not being scheduled.

When that happens, the three sets of flood pings thumping away at the
iMX6Q don't get any response until the timeout occurs.

In that scenario, if a packet were to be received (and there's many
packets hitting the interface) then it _would_ trigger reaping of the
TX ring.

> > +       do {
> > +               index = (index + 1) & (fep->tx_ring_size - 1);
> > +               bdp = fec_enet_tx_get(index, fep);
> >
> > -       while (((status = bdp->cbd_sc) & BD_ENET_TX_READY) == 0) {
> > +               status = bdp->bd.cbd_sc;
> > +               if (status & BD_ENET_TX_READY)
> > +                       break;

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
In answer to your question below, here.

> >
> >                 /* current queue is empty */
> > -               if (bdp == fep->cur_tx)
> > +               if (index == fep->tx_next)
> >                         break;

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
and here.

> >
> > -               if (fep->bufdesc_ex)
> > -                       index = (struct bufdesc_ex *)bdp -
> > -                               (struct bufdesc_ex *)fep->tx_bd_base;
> > -               else
> > -                       index = bdp - fep->tx_bd_base;
> > +               fec_enet_tx_unmap(&bdp->bd, fep);
> >
> >                 skb = fep->tx_skbuff[index];
> > -               dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr, skb->len,
> > -                               DMA_TO_DEVICE);
> > -               bdp->cbd_bufaddr = 0;
> > +               fep->tx_skbuff[index] = NULL;
> >
> >                 /* Check for errors. */
> >                 if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
> > @@ -797,19 +826,18 @@ fec_enet_tx(struct net_device *ndev)
> >                                 ndev->stats.tx_carrier_errors++;
> >                 } else {
> >                         ndev->stats.tx_packets++;
> > -                       ndev->stats.tx_bytes += bdp->cbd_datlen;
> > +                       ndev->stats.tx_bytes += bdp->bd.cbd_datlen;
> >                 }
> >
> >                 if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS) &&
> >                         fep->bufdesc_ex) {
> >                         struct skb_shared_hwtstamps shhwtstamps;
> >                         unsigned long flags;
> > -                       struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
> >
> >                         memset(&shhwtstamps, 0, sizeof(shhwtstamps));
> >                         spin_lock_irqsave(&fep->tmreg_lock, flags);
> >                         shhwtstamps.hwtstamp = ns_to_ktime(
> > -                               timecounter_cyc2time(&fep->tc, ebdp->ts));
> > +                               timecounter_cyc2time(&fep->tc, bdp->ebd.ts));
> >                         spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> >                         skb_tstamp_tx(skb, &shhwtstamps);
> >                 }
> > @@ -825,45 +853,252 @@ fec_enet_tx(struct net_device *ndev)
> >
> >                 /* Free the sk buffer associated with this last transmit */
> >                 dev_kfree_skb_any(skb);
> > -               fep->tx_skbuff[index] = NULL;
> > -
> > -               fep->dirty_tx = bdp;
> > -
> > -               /* Update pointer to next buffer descriptor to be transmitted */
> > -               bdp = fec_enet_get_nextdesc(bdp, fep);
> >
> >                 /* Since we have freed up a buffer, the ring is no longer full
> >                  */
> > -               if (fep->dirty_tx != fep->cur_tx) {
> > -                       if (netif_queue_stopped(ndev))
> > -                               netif_wake_queue(ndev);
> > +               if (netif_queue_stopped(ndev)) {
> > +
> > +
> > +
> > +
> > +
> > +                       netif_wake_queue(ndev);
> > +
> >                 }
> > -       }
> > +
> > +               fep->tx_dirty = index;
> > +       } while (1);
> 
> where break this while(1);

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
