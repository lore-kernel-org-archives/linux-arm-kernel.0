From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 May 2010 17:29:54 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <20100513203423.GQ18984@mvista.com>
References: <20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
	<20100512184852.GC22371@n2100.arm.linux.org.uk>
	<20100512185903.GD22371@n2100.arm.linux.org.uk>
	<1273699275.16677.10.camel@e102109-lin.cambridge.arm.com>
	<093A0EAA-42DF-4C72-BAC2-617B25A9165F@marvell.com>
	<1273739217.30713.6.camel@e102109-lin.cambridge.arm.com>
	<20100513135456.GH18984@mvista.com>
	<1273760120.30713.67.camel@e102109-lin.cambridge.arm.com>
	<20100513203423.GQ18984@mvista.com>
Message-ID: <1273854594.28312.82.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-13 at 21:34 +0100, George G. Davis wrote:
> On Thu, May 13, 2010 at 03:15:20PM +0100, Catalin Marinas wrote:
> > On Thu, 2010-05-13 at 14:54 +0100, George G. Davis wrote:
> > > On Thu, May 13, 2010 at 09:26:57AM +0100, Catalin Marinas wrote:
> > > > On Thu, 2010-05-13 at 06:27 +0100, Ronen Shitrit wrote:
> > > > > Our ARM v6 does have speculative prefetch...
> > > >
> > > > That's the I-cache and we should be ok with it. What may affect this
> > > > patch is speculative fetches into the D-cache.
> > >
> > > prefetch()?
> >
> > Drivers should not use prefetch (PLD) on memory handed over to a device
> > for DMA transfers. To me this is like explicitly accessing such memory
> > during a DMA transfer.
> 
> I agree and was merely speculating that prefetch() may be a case where
> D-Cache lines are explicitly prefetched and may be the cause of this
> problem, e.g. from e1000_clean_rx_irq() in drivers/net/e1000e/netdev.c:
> 
>         while (rx_desc->status & E1000_RXD_STAT_DD) {
>                 struct sk_buff *skb;
>                 u8 status;
> 
>                 if (*work_done >= work_to_do)
>                         break;
>                 (*work_done)++;
> 
>                 status = rx_desc->status;
>                 skb = buffer_info->skb;
>                 buffer_info->skb = NULL;
> 
>                 prefetch(skb->data - NET_IP_ALIGN);
> 
>                 i++;
>                 if (i == rx_ring->count)
>                         i = 0;
>                 next_rxd = E1000_RX_DESC(*rx_ring, i);
>                 prefetch(next_rxd);
> 
>                 next_buffer = &rx_ring->buffer_info[i];
> 
>                 cleaned = 1;
>                 cleaned_count++;
>                 pci_unmap_single(pdev,
>                                  buffer_info->dma,
>                                  adapter->rx_buffer_len,
>                                  PCI_DMA_FROMDEVICE);

If the prefetch is done after the DMA transfer has completed, then there
shouldn't be any problem. I suspect that's the case in this interrupt
routine.

What I think I missed in my patch (and didn't show up with a sata drive)
is the "sync" operations. The dma_sync_single_for_device(FROMDEVICE)
corrupts the existing buffer.

I'll post an updated patch shortly.

-- 
Catalin
