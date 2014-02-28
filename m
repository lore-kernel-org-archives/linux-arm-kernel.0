From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 28 Feb 2014 13:27:37 +0000
Subject: [PATCH v4] can: xilinx CAN controller support.
In-Reply-To: <53108BEF.1020308@pengutronix.de>
References: <74d607e9-ac9c-4a9b-ac49-e84ae49d20c2@TX2EHSMHS031.ehs.local>
 <530D0A9C.5090402@pengutronix.de>
 <cd00fb2d-c8a7-423d-8aa0-2b413e9ac101@CO9EHSMHS017.ehs.local>
 <530DEA7C.6010609@pengutronix.de>
 <678ca296-8687-4e7c-9014-ae69d886a068@CO9EHSMHS014.ehs.local>
 <530E0B92.5010903@pengutronix.de>
 <2e3bfd38-37d5-4102-af79-821196c6c732@CH1EHSMHS006.ehs.local>
 <53104995.4010305@pengutronix.de>
 <48409965-e214-43b7-8b6a-08bf075707e1@CO9EHSMHS001.ehs.local>
 <53108798.7090902@pengutronix.de>
 <4902b8d8-139a-4fd0-9e6e-a30ce7e6683b@CH1EHSMHS019.ehs.local>
 <53108BEF.1020308@pengutronix.de>
Message-ID: <f7b303dd-bf23-40f2-bbd4-4594cba8f345@CO9EHSMHS026.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


> -----Original Message-----
> From: Marc Kleine-Budde [mailto:mkl at pengutronix.de]
> Sent: Friday, February 28, 2014 6:45 PM
> To: Appana Durga Kedareswara Rao; wg at grandegger.com; Michal Simek;
> grant.likely at linaro.org; robh+dt at kernel.org; linux-can at vger.kernel.org
> Cc: netdev at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; devicetree at vger.kernel.org
> Subject: Re: [PATCH v4] can: xilinx CAN controller support.
>
> On 02/28/2014 02:07 PM, Appana Durga Kedareswara Rao wrote:
> >>>> What happens if the interrupt handler is delayed? For example in a
> >>>> RT enabled system the interrupt handler runs as a thread. There
> >>>> might be other threads with higher priority. The hardware will
> >>>> probably send all CAN frames in the FIFO, so you want to reduce the
> >>>> overhead and loop in the tx complete handler.
> >>>>
> >>> Yes I agree with your comment.
> >>> It will be good to have a loop in the Tx interrupt handler I am
> >>> modifying the Tx interrupt handler like below.
> >>>
> >>> static void xcan_tx_interrupt(struct net_device *ndev, u32 isr) {
> >>>         struct xcan_priv *priv = netdev_priv(ndev);
> >>>         struct net_device_stats *stats = &ndev->stats;
> >>>
> >>>         while (priv->tx_head - priv->tx_tail > 0) {
> >>>                 if (!(isr & XCAN_IXR_TXOK_MASK)) {
> >>>                         break;
> >>>                 }
> >>>                 can_get_echo_skb(ndev, priv->tx_tail %
> >>>                                         priv->xcan_echo_skb_max_tx);
> >>>                 priv->tx_tail++;
> >>>                 stats->tx_packets++;
> >>>                 can_led_event(ndev, CAN_LED_EVENT_TX);
>
> Probably first clear the interrupt, because you've just handled it, then check
> if it's still present. The question is, do you have to clear the IRQ for each
> transmitted frame, or does one clean of the interrupt clear the bit for more
> then one transmitted frame?
>

We already were clearing it in the interrupt routine (xcan_interrupt). That's why clearing it at the end of the loop.
We have to clear the IRQ (TXOK) for each transmitted frame.

Regards,
Kedar.


> >>>                 isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
> >             --> clear Tx OK interrupt.
>
> >
> >>>         }
> >>>         netif_wake_queue(ndev);
> >>> }
> >>>
> >>> Are you Ok with this?
>
> Were getting there :)
>
> Marc
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
