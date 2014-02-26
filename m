From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 26 Feb 2014 16:43:14 +0100
Subject: [PATCH v4] can: xilinx CAN controller support.
In-Reply-To: <678ca296-8687-4e7c-9014-ae69d886a068@CO9EHSMHS014.ehs.local>
References: <74d607e9-ac9c-4a9b-ac49-e84ae49d20c2@TX2EHSMHS031.ehs.local>
 <530D0A9C.5090402@pengutronix.de>
 <cd00fb2d-c8a7-423d-8aa0-2b413e9ac101@CO9EHSMHS017.ehs.local>
 <530DEA7C.6010609@pengutronix.de>
 <678ca296-8687-4e7c-9014-ae69d886a068@CO9EHSMHS014.ehs.local>
Message-ID: <530E0B92.5010903@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2014 03:46 PM, Appana Durga Kedareswara Rao wrote:
> Hi Marc,
> 
> 
>> -----Original Message-----
>> From: Marc Kleine-Budde [mailto:mkl at pengutronix.de]
>> Sent: Wednesday, February 26, 2014 6:52 PM
>> To: Appana Durga Kedareswara Rao; wg at grandegger.com; Michal Simek;
>> grant.likely at linaro.org; robh+dt at kernel.org; linux-can at vger.kernel.org
>> Cc: netdev at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
>> kernel at vger.kernel.org; devicetree at vger.kernel.org
>> Subject: Re: [PATCH v4] can: xilinx CAN controller support.
>>
>> On 02/26/2014 02:07 PM, Appana Durga Kedareswara Rao wrote:
>>>> This loop looks broken. Can you explain how it works.
>>>>
>>>> What it shoud do is:
>>>> We have put (priv->tx_head - priv->tx_tail) CAN frames into the FIFO.
>>>> This means at maximum there could be this amount of CAN frames which
>>>> have been successfully transmitted. For every cycle in this while
>>>> loop you
>>>> should:
>>>> a) check if a CAN frame has successfully been transmitted
>>>>    (as this CAN core uses a FIFO it should be "oldest")
>>>>    A read_reg() of some kind is missing in your loop.
>>>> b) if needed, remove this event from the FIFO or
>>>>    mark the interrupt as done. Whatever you hardware needs.
>>>> c) update your statistics
>>>> d) Use can_get_echo_skb to push this frame into the networking stack
>>>> e) As a CAN frame has been transmitted successfully, wake the tx_queue.
>>>>
>>>>> +   while (priv->tx_head - priv->tx_tail > 0) {
>>>>> +           if (isr & XCAN_IXR_TXFLL_MASK) {
>>>>> +                   priv->write_reg(priv, XCAN_ICR_OFFSET,
>>>>> +                                   XCAN_IXR_TXFLL_MASK);
>>>>> +                   netif_stop_queue(ndev);
>>>>
>>>> Why do you stop the queue here? A CAN frame has successfully been
>>>> transmitted, there should be room in the FIFO.
>>>>
>>>>> +                   break;
>>>>> +           }
>>>>> +           can_get_echo_skb(ndev, priv->tx_tail %
>>>>> +                                   priv->xcan_echo_skb_max_tx);
>>>>> +           priv->tx_tail++;
>>>>> +   }
>>>>> +
>>>
>>> The below are the bit fields available for the Transmit FIFO.
>>> 1) In the ISR(interrupt status register)  Tx Ok interrupt and Tx fifo full
>> interrupt.
>>> 2) in the SR(Status Register) Tx fifo full condition.
>>>
>>>
>>> I am modifying the entire tx interrupt logic to like below.
>>>
>>> static void xcan_tx_interrupt(struct net_device *ndev, u32 isr) {
>>>         struct xcan_priv *priv = netdev_priv(ndev);
>>>         struct net_device_stats *stats = &ndev->stats;
>>>
>>>             while (priv->tx_head - priv->tx_tail > 0) {
>>>                 if (isr & XCAN_IXR_TXFLL_MASK) {
>>>                         priv->write_reg(priv, XCAN_ICR_OFFSET,
>>>                                         XCAN_IXR_TXFLL_MASK);
>>>                           break;
>>>                 }
>>>                 can_get_echo_skb(ndev, priv->tx_tail %
>>>                                         priv->xcan_echo_skb_max_tx);
>>>                 priv->tx_tail++;
>>>          stats->tx_packets++;
>>>         netif_wake_queue(ndev);
>>>               can_led_event(ndev, CAN_LED_EVENT_TX);
>>>
>>>         }
>>
>> You just need to wake the queue once.
> 
> Ok
>>
>>> }
>>>
>>>
>>> Are you Ok with the above logic?
>>
>> No, how can you tell how many frames have been transmitted?
> 
> There is no register to read how many can frames are transmitted.
> The only way to know Is by reading this parameter (stats->tx_packets++;) through ip command

stats->tx_packets is calculated in the above loop and the loop is
broken. Let me illustrate the problem:

- xmit is called 10 times in a row
- this means you have 10 CAN frames in the TX FIFO
- a single CAN frame gets transmitted
- you get an interrupt
- you enter the above routine and loop 10 times and echo the CAN frame
  back into the stack

Now every application sees 10 transmitted packages, but there is only
one transmitted. Every time you loop you have to check if the CAN frame
has already been transmitted or not. Is that possible with the hardware?

> ip -d -s link show can
> Or using ifconfig command.
> 
> At the h/w level it can transmit Max upto 64 packets (Max fifo depth)
> We need to monitor the Tx fifo full bit in the ISR(Interrupt Status Register)  or Tx fifo full bit in the SR(Status Register) and if it is full we need to stop the queue that is
> I am doing in the _xmit by reading the status register before proceeding the   packet transmission.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/cfd6c174/attachment-0001.sig>
