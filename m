From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 30 Mar 2011 10:53:16 +0000
Subject: [PATCH 1/1] ARM: dmabounce: fix dmabounce may cause crash issue
References: <1300965400-28304-1-git-send-email-b29396@freescale.com>
	<20110325083630.GA26481@n2100.arm.linux.org.uk>
	<65EE16ACC360FA4D99C96DC085B3F77214AB97@039-SN1MPN1-001.039d.mgd.msft.net>
	<20110328175858.GA31457@n2100.arm.linux.org.uk>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F77214C050@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Dong Aisheng-B29396
> Sent: Tuesday, March 29, 2011 11:04 AM
> To: 'Russell King - ARM Linux'
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH 1/1] ARM: dmabounce: fix dmabounce may cause crash
> issue
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> > Sent: Tuesday, March 29, 2011 1:59 AM
> > To: Dong Aisheng-B29396
> > Cc: linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH 1/1] ARM: dmabounce: fix dmabounce may cause crash
> > issue
> >
> > On Mon, Mar 28, 2011 at 05:01:31AM +0000, Dong Aisheng-B29396 wrote:
> > > But dma_map_single allows the 'dev' passed in to be NULL, so, may it
> > > be better to also check it for dmabounce in case such a using?
> >
> > Programmers are lazy.  They often have a struct device laying around
> > but they think they'll not bother passing it into the DMA API and end
> > up just passing NULL as that seems to work for them.
> >
> > That doesn't mean it'll always work.  The best thing is to always pass
> > in a struct device if there is one available.
> >
> > I'm not saying don't for the dmabounce code.  I'm saying _also_ fix
> > the driver.
> 
> I totally agree with you.
> 
> But due to current kernel already has many using like this (passing NULL
> dev to DMA API). (see the following grep result) b29396 at shlinux2:~/linux-
> 2.6-imx$ grep -rn "dma_map_single(NULL" .
> ./drivers/net/arm/at91_ether.c:819:             lp->skb_physaddr =
> dma_map_single(NULL, skb->data, skb->len, DMA_TO_DEVICE);
> ./drivers/net/arm/ep93xx_eth.c:509:             d = dma_map_single(NULL,
> page, PAGE_SIZE, DMA_FROM_DEVICE);
> ./drivers/net/arm/ep93xx_eth.c:532:             d = dma_map_single(NULL,
> page, PAGE_SIZE, DMA_TO_DEVICE);
> ./drivers/net/fec.c:555:                bdp->cbd_bufaddr =
> dma_map_single(NULL, data, bdp->cbd_datlen,
> ./drivers/net/meth.c:229:                       dma_map_single(NULL,
> priv->rx_ring[i],
> ./drivers/net/meth.c:447:                       dma_map_single(NULL,
> priv->rx_ring[priv->rx_write],
> ./drivers/net/meth.c:630:       catbuf = dma_map_single(NULL, buffer_data,
> buffer_len,
> ./drivers/net/meth.c:656:       catbuf1 = dma_map_single(NULL,
> buffer1_data, buffer1_len,
> ./drivers/net/meth.c:661:       catbuf2 = dma_map_single(NULL,
> buffer2_data, buffer2_len,
> ./drivers/net/tsi108_eth.c:706:                 data->txring[tx].buf0 =
> dma_map_single(NULL, skb->data,
> ./drivers/net/tsi108_eth.c:810:         data->rxring[rx].buf0 =
> dma_map_single(NULL, skb->data,
> ./drivers/net/pxa168_eth.c:362:         p_used_rx_desc->buf_ptr =
> dma_map_single(NULL,
> ./drivers/net/pxa168_eth.c:1269:        desc->buf_ptr =
> dma_map_single(NULL, skb->data, length, DMA_TO_DEVICE);
> ./drivers/media/video/vino.c:742:
> dma_map_single(NULL,
> ./drivers/media/video/vino.c:829:
> dma_map_single(NULL,
> ./drivers/media/video/vino.c:4199:      dma_dummy_address =
> dma_map_single(NULL,
> ./drivers/parport/parport_ip32.c:604:   parport_ip32_dma.buf =
> dma_map_single(NULL, addr, count, dir);
> ./arch/arm/mach-bcmring/dma.c:1882:
> dma_map_single(NULL, mem, numBytes, memMap->dir);
> ./arch/arm/kernel/dma-isa.c:92:                 dma->buf.dma_address =
> dma_map_single(NULL,
> ./arch/arm/mach-rpc/dma.c:171:                  idma->dma.buf.dma_address
> = dma_map_single(NULL,
> 
> If you want me to fix FEC driver, I can fix it in another patch.
> But for others I'm not familiar with them and not sure all of them are ok
> to fix.
> 
> And in fact, the dma_map_single allows the @dev to be NULL for special
> using.
> /**
>  * dma_map_single - map a single buffer for streaming DMA
>  * @dev: valid struct device pointer, or NULL for ISA and EISA-like
> devices

Hi Russell,
Any more comment about this patch?
