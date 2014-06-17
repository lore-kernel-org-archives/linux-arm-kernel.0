From: davem@davemloft.net (David Miller)
Date: Tue, 17 Jun 2014 13:20:24 -0700 (PDT)
Subject: [PATCH v6 4/4] drivers: net: Add APM X-Gene SoC ethernet
 driver support.
In-Reply-To: <CAKh23F=2undAW=nWibOreAM8DJiQKpLx=OboCX=fNZE+OU=AbA@mail.gmail.com>
References: <1402964326-11147-5-git-send-email-isubramanian@apm.com>
 <20140616.214247.1154200670003936158.davem@davemloft.net>
 <CAKh23F=2undAW=nWibOreAM8DJiQKpLx=OboCX=fNZE+OU=AbA@mail.gmail.com>
Message-ID: <20140617.132024.1213369771856463527.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Tue, 17 Jun 2014 12:21:08 -0700

> On Mon, Jun 16, 2014 at 9:42 PM, David Miller <davem@davemloft.net> wrote:
>> From: Iyappan Subramanian <isubramanian@apm.com>
>> Date: Mon, 16 Jun 2014 17:18:46 -0700
>>
>>> +static netdev_tx_t xgene_enet_start_xmit(struct sk_buff *skb,
>>> +                                      struct net_device *ndev)
>>> +{
>>> +     struct xgene_enet_pdata *pdata = netdev_priv(ndev);
>>> +     struct xgene_enet_desc_ring *tx_ring = pdata->tx_ring;
>>> +     struct xgene_enet_desc_ring *cp_ring = tx_ring->cp_ring;
>>> +     u32 tx_level, cq_level;
>>> +
>>> +     tx_level = xgene_enet_ring_len(tx_ring);
>>> +     cq_level = xgene_enet_ring_len(cp_ring);
>>> +     if (unlikely(tx_level > pdata->tx_qcnt_hi ||
>>> +                  cq_level > pdata->cp_qcnt_hi)) {
>>> +             netif_stop_queue(ndev);
>>> +             return NETDEV_TX_BUSY;
>>> +     }
>>> +
>>> +     if (xgene_enet_setup_tx_desc(tx_ring, skb))
>>> +             return NETDEV_TX_OK;
>>
>> If you return NETDEV_TX_OK, it is your responsibility to deal with the
>> SKB, because you own it.
>>
>> In particular, you have to free the packet.
> 
> skb freeing happens in xgene_enet_tx_completion().

You're not queueing up the packet when DMA mapping the packet fails,
which is the only condition that causes xgene_enet_setup_tx_desc() to
return an error, so xgene_enet_tx_completion() will not be called.

Can you really not see this?
