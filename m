From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 22 Apr 2014 13:11:31 +0200
Subject: [PATCH v7 1/2] can: xilinx CAN controller support
In-Reply-To: <9f70ceca-c6fd-4d57-a54a-8cbf9d888137@CH1EHSMHS016.ehs.local>
References: <3e750ec3-9d47-4b4e-8173-56698ab19786@CH1EHSMHS029.ehs.local>
 <53562E7D.7090509@pengutronix.de>
 <957b07ca-f74c-47fb-963a-084710d48c5a@AM1EHSMHS014.ehs.local>
 <535643D9.3070601@pengutronix.de>
 <9f70ceca-c6fd-4d57-a54a-8cbf9d888137@CH1EHSMHS016.ehs.local>
Message-ID: <53564E63.4010803@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 01:08 PM, Appana Durga Kedareswara Rao wrote:
> Hi Marc,
> 
>> -----Original Message-----
>> From: Marc Kleine-Budde [mailto:mkl at pengutronix.de]
>> Sent: Tuesday, April 22, 2014 3:57 PM
>> To: Appana Durga Kedareswara Rao; wg at grandegger.com; Michal Simek;
>> grant.likely at linaro.org; robh+dt at kernel.org
>> Cc: linux-can at vger.kernel.org; netdev at vger.kernel.org; linux-arm-
>> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
>> devicetree at vger.kernel.org
>> Subject: Re: [PATCH v7 1/2] can: xilinx CAN controller support
>>
>> On 04/22/2014 12:06 PM, Appana Durga Kedareswara Rao wrote:
>>
>>>> Meanwhile Thomas Gleixner put some effort into the c_can driver and
>>>> found some problems in most of the can driver. See comments inline.
>>>>
>>> Ok will look into that patches
>>
>> I've commented the relevant parts of your patch. Although more
>> background information can be found in the c_can patches.
>>
> Ok
> 
>>>>> +/**
>>>>> + * xcan_tx_interrupt - Tx Done Isr
>>>>> + * @ndev:  net_device pointer
>>>>> + * @isr:   Interrupt status register value
>>>>> + */
>>>>> +static void xcan_tx_interrupt(struct net_device *ndev, u32 isr) {
>>>>> +   struct xcan_priv *priv = netdev_priv(ndev);
>>>>> +   struct net_device_stats *stats = &ndev->stats;
>>>>> +
>>>>> +   while (priv->tx_head - priv->tx_tail > 0) {
>>>>> +           priv->write_reg(priv, XCAN_ICR_OFFSET,
>>>> XCAN_IXR_TXOK_MASK);
>>>>> +           if (!(isr & XCAN_IXR_TXOK_MASK))
>>>>> +                   break;
>>>>
>>>> This looks broken. I assume you have to issue the
>> XCAN_IXR_TXOK_MASK-
>>>> write once per tx-completed CAN frame. If you enter this loop you
>>>> write once, then isr is read, then you write again and may exit this
>>>> loop if XCAN_IXR_TXOK_MASK is not set anymore.
>>
>> Let's assume you have put 3 CAN frames into the TX-queue and we're into
>> tx-complete interrupt for the first frame and the other 2 are still not
>> completed.
>>
>> This means the while() loop is not terminated by (priv->tx_head -
>> priv->tx_tail > 0), as it can loop 3 times.
>>
>> What happens is:
>>
>> - priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
>> - if (!(isr & XCAN_IXR_TXOK_MASK)) -> no break
>> - can_get_echo_skb()
>> - ...
>> - isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
>> - loop ->
>> - priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
>> - if (!(isr & XCAN_IXR_TXOK_MASK)) -> break
>>
>> So you have 2x write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK),
>> but only a single TX completed CAN frame.
>>
> 
> Ok now got it :). Thanks for the explanation.
> Will modify the loop logic like below.
> 
> while (priv->tx_head - priv->tx_tail > 0) {
>                  if ((isr & XCAN_IXR_TXOK_MASK)) {
>                 priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
>                         can_get_echo_skb(ndev, priv->tx_tail %
>                                                 priv->tx_max);
>                         priv->tx_tail++;
>                         stats->tx_packets++;
>                 } else {
>                 break;
>         }
>                 
>   }
> Are you ok with this?

what about this:

while ((priv->tx_head - priv->tx_tail > 0) &&
	(isr & XCAN_IXR_TXOK_MASK)) {

	[...]

	isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
}

or even

while ((priv->tx_head - priv->tx_tail > 0) &&
	(priv->read_reg(priv, XCAN_ISR_OFFSET) & XCAN_IXR_TXOK_MASK)) {

	[...]

}

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140422/e6cfc107/attachment.sig>
