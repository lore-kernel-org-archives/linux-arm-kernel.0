From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 1 Feb 2017 11:09:44 +0000
Subject: [PATCH net-next 5/6] drivers: net: xgene-v2: Add transmit and
 receive
In-Reply-To: <fb8fcd33-4b5b-5999-7662-4165aeb179e1@gmail.com>
References: <1485889401-13909-1-git-send-email-isubramanian@apm.com>
 <1485889401-13909-6-git-send-email-isubramanian@apm.com>
 <fb8fcd33-4b5b-5999-7662-4165aeb179e1@gmail.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0277BB0@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From Florian Fainelli
> Sent: 31 January 2017 20:33
> On 01/31/2017 11:03 AM, Iyappan Subramanian wrote:
> > This patch adds,
> >     - Transmit
> >     - Transmit completion poll
> >     - Receive poll
> >     - NAPI handler
> >
> > and enables the driver.
> >
> > Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> > Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
> > ---
> 
> > +
> > +	tx_ring = pdata->tx_ring;
> > +	tail = tx_ring->tail;
> > +	len = skb_headlen(skb);
> > +	raw_desc = &tx_ring->raw_desc[tail];
> > +
> > +	/* Tx descriptor not available */
> > +	if (!GET_BITS(E, le64_to_cpu(raw_desc->m0)) ||
> > +	    GET_BITS(PKT_SIZE, le64_to_cpu(raw_desc->m0)))
> > +		return NETDEV_TX_BUSY;

Aren't you supposed to detect 'ring full' and stop the code
giving you packets to transmit.

> > +
> > +	/* Packet buffers should be 64B aligned */

Is that really a requirement of the hardware?
Almost all ethernet frames are 4n+2 aligned.

> > +	pkt_buf = dma_alloc_coherent(dev, XGENE_ENET_STD_MTU, &dma_addr,
> > +				     GFP_ATOMIC);
> > +	if (unlikely(!pkt_buf))
> > +		goto out;
> 
> Can't you obtain a DMA-API mapping for skb->data and pass it down to the
> hardware? This copy here is inefficient.
> 
> > +
> > +	memcpy(pkt_buf, skb->data, len);

You really need to verify that the len <= XGENE_ENET_STD_MTU.

Isn't this code only transmitting the 'head' of the packet?
What about the fragments??
...
	David
