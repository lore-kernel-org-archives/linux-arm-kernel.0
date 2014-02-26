From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 26 Feb 2014 14:22:04 +0100
Subject: [PATCH v4] can: xilinx CAN controller support.
In-Reply-To: <cd00fb2d-c8a7-423d-8aa0-2b413e9ac101@CO9EHSMHS017.ehs.local>
References: <74d607e9-ac9c-4a9b-ac49-e84ae49d20c2@TX2EHSMHS031.ehs.local>
 <530D0A9C.5090402@pengutronix.de>
 <cd00fb2d-c8a7-423d-8aa0-2b413e9ac101@CO9EHSMHS017.ehs.local>
Message-ID: <530DEA7C.6010609@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2014 02:07 PM, Appana Durga Kedareswara Rao wrote:
>> This loop looks broken. Can you explain how it works.
>>
>> What it shoud do is:
>> We have put (priv->tx_head - priv->tx_tail) CAN frames into the FIFO.
>> This means at maximum there could be this amount of CAN frames which
>> have been successfully transmitted. For every cycle in this while loop you
>> should:
>> a) check if a CAN frame has successfully been transmitted
>>    (as this CAN core uses a FIFO it should be "oldest")
>>    A read_reg() of some kind is missing in your loop.
>> b) if needed, remove this event from the FIFO or
>>    mark the interrupt as done. Whatever you hardware needs.
>> c) update your statistics
>> d) Use can_get_echo_skb to push this frame into the networking stack
>> e) As a CAN frame has been transmitted successfully, wake the tx_queue.
>>
>>> +   while (priv->tx_head - priv->tx_tail > 0) {
>>> +           if (isr & XCAN_IXR_TXFLL_MASK) {
>>> +                   priv->write_reg(priv, XCAN_ICR_OFFSET,
>>> +                                   XCAN_IXR_TXFLL_MASK);
>>> +                   netif_stop_queue(ndev);
>>
>> Why do you stop the queue here? A CAN frame has successfully been
>> transmitted, there should be room in the FIFO.
>>
>>> +                   break;
>>> +           }
>>> +           can_get_echo_skb(ndev, priv->tx_tail %
>>> +                                   priv->xcan_echo_skb_max_tx);
>>> +           priv->tx_tail++;
>>> +   }
>>> +
> 
> The below are the bit fields available for the Transmit FIFO.
> 1) In the ISR(interrupt status register)  Tx Ok interrupt and Tx fifo full interrupt.
> 2) in the SR(Status Register) Tx fifo full condition.
> 
> 
> I am modifying the entire tx interrupt logic to like below.
> 
> static void xcan_tx_interrupt(struct net_device *ndev, u32 isr)
> {
>         struct xcan_priv *priv = netdev_priv(ndev);
>         struct net_device_stats *stats = &ndev->stats;
> 
>             while (priv->tx_head - priv->tx_tail > 0) {
>                 if (isr & XCAN_IXR_TXFLL_MASK) {
>                         priv->write_reg(priv, XCAN_ICR_OFFSET,
>                                         XCAN_IXR_TXFLL_MASK);
>                           break;
>                 }
>                 can_get_echo_skb(ndev, priv->tx_tail %
>                                         priv->xcan_echo_skb_max_tx);
>                 priv->tx_tail++;
>          stats->tx_packets++;
>         netif_wake_queue(ndev);
>               can_led_event(ndev, CAN_LED_EVENT_TX);
> 
>         }

You just need to wake the queue once.

> }
> 
> 
> Are you Ok with the above logic?

No, how can you tell how many frames have been transmitted?

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/561a8b47/attachment.sig>
