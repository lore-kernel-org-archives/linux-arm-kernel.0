From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 22 Apr 2014 12:26:33 +0200
Subject: [PATCH v7 1/2] can: xilinx CAN controller support
In-Reply-To: <957b07ca-f74c-47fb-963a-084710d48c5a@AM1EHSMHS014.ehs.local>
References: <3e750ec3-9d47-4b4e-8173-56698ab19786@CH1EHSMHS029.ehs.local>
 <53562E7D.7090509@pengutronix.de>
 <957b07ca-f74c-47fb-963a-084710d48c5a@AM1EHSMHS014.ehs.local>
Message-ID: <535643D9.3070601@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 12:06 PM, Appana Durga Kedareswara Rao wrote:

>> Meanwhile Thomas Gleixner put some effort into the c_can driver and
>> found some problems in most of the can driver. See comments inline.
>>
> Ok will look into that patches

I've commented the relevant parts of your patch. Although more
background information can be found in the c_can patches.

>>> +/**
>>> + * xcan_tx_interrupt - Tx Done Isr
>>> + * @ndev:  net_device pointer
>>> + * @isr:   Interrupt status register value
>>> + */
>>> +static void xcan_tx_interrupt(struct net_device *ndev, u32 isr) {
>>> +   struct xcan_priv *priv = netdev_priv(ndev);
>>> +   struct net_device_stats *stats = &ndev->stats;
>>> +
>>> +   while (priv->tx_head - priv->tx_tail > 0) {
>>> +           priv->write_reg(priv, XCAN_ICR_OFFSET,
>> XCAN_IXR_TXOK_MASK);
>>> +           if (!(isr & XCAN_IXR_TXOK_MASK))
>>> +                   break;
>>
>> This looks broken. I assume you have to issue the XCAN_IXR_TXOK_MASK-
>> write once per tx-completed CAN frame. If you enter this loop you write
>> once, then isr is read, then you write again and may exit this loop if
>> XCAN_IXR_TXOK_MASK is not set anymore.

Let's assume you have put 3 CAN frames into the TX-queue and we're into
tx-complete interrupt for the first frame and the other 2 are still not
completed.

This means the while() loop is not terminated by (priv->tx_head -
priv->tx_tail > 0), as it can loop 3 times.

What happens is:

- priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
- if (!(isr & XCAN_IXR_TXOK_MASK)) -> no break
- can_get_echo_skb()
- ...
- isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
- loop ->
- priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
- if (!(isr & XCAN_IXR_TXOK_MASK)) -> break

So you have 2x write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK), but
only a single TX completed CAN frame.

>>
> 
> I am entering into this Api only when I successfully transferred a frame
> I didn't understand why the loop is broken?
> Could you please explain me a little bit in detail.
> I am clearing this interrupt XCAN_IXR_TXOK_MASK once I entered into this api
> And I am doing the rest of the thing what you explained above.

[...]

>>> +/**
>>> + * xcan_probe - Platform registration call
>>> + * @pdev:  Handle to the platform device structure
>>> + *
>>> + * This function does all the memory allocation and registration for
>>> +the CAN
>>> + * device.
>>> + *
>>> + * Return: 0 on success and failure value on error  */ static int
>>> +xcan_probe(struct platform_device *pdev) {
>>> +   struct resource *res; /* IO mem resources */
>>> +   struct net_device *ndev;
>>> +   struct xcan_priv *priv;
>>> +   void __iomem *addr;
>>> +   int ret, rx_max, tx_max;
>>> +
>>> +   /* Get the virtual base address for the device */
>>> +   res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +   addr = devm_ioremap_resource(&pdev->dev, res);
>>> +   if (IS_ERR(addr)) {
>>> +           ret = PTR_ERR(addr);
>>> +           goto err;
>>> +   }
>>> +
>>> +   ret = of_property_read_u32(pdev->dev.of_node, "tx-fifo-depth",
>> &tx_max);
>>> +   if (ret < 0)
>>> +           goto err;
>>> +
>>> +   ret = of_property_read_u32(pdev->dev.of_node, "rx-fifo-depth",
>> &rx_max);
>>> +   if (ret < 0)
>>> +           goto err;
>>> +
>>> +   /* Create a CAN device instance */
>>> +   ndev = alloc_candev(sizeof(struct xcan_priv), tx_max);
>>> +   if (!ndev)
>>> +           return -ENOMEM;
>>> +
>>> +   priv = netdev_priv(ndev);
>>> +   priv->dev = ndev;
>>> +   priv->can.bittiming_const = &xcan_bittiming_const;
>>> +   priv->can.do_set_mode = xcan_do_set_mode;
>>> +   priv->can.do_get_berr_counter = xcan_get_berr_counter;
>>> +   priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>>> +                                   CAN_CTRLMODE_BERR_REPORTING;
>>> +   priv->reg_base = addr;
>>> +   priv->tx_max = tx_max;
>>> +
>>> +   /* Get IRQ for the device */
>>> +   ndev->irq = platform_get_irq(pdev, 0);
>>> +   ndev->flags |= IFF_ECHO;        /* We support local echo */
>>> +
>>> +   platform_set_drvdata(pdev, ndev);
>>> +   SET_NETDEV_DEV(ndev, &pdev->dev);
>>> +   ndev->netdev_ops = &xcan_netdev_ops;
>>> +
>>> +   /* Getting the CAN can_clk info */
>>> +   priv->can_clk = devm_clk_get(&pdev->dev, "can_clk");
>>> +   if (IS_ERR(priv->can_clk)) {
>>> +           dev_err(&pdev->dev, "Device clock not found.\n");
>>> +           ret = PTR_ERR(priv->can_clk);
>>> +           goto err_free;
>>> +   }
>>> +   /* Check for type of CAN device */
>>> +   if (of_device_is_compatible(pdev->dev.of_node,
>>> +                               "xlnx,zynq-can-1.0")) {
>>> +           priv->bus_clk = devm_clk_get(&pdev->dev, "pclk");
>>
>> I think it makes sense to have a single name for the second clock, so that
>> this if...else... is't needed at all.
>>
>  One of the comments I got from the Soren is the clocks name should match the name's in the device datasheet.
> 
> For axi_can case the clock names is can_clk and s_axi_aclk
> For canps case the clock names  is can_clk and pclk.
> 
> If you want me to put a unique for the both I will do.

In an ideal world the data sheet of the IP will have a unique name for
its clock inputs, regardless the version of the IP core and the design
(processor, softcore, etc...) it is integrated into.

The first clock is named "can_clk", so we only need a single name for
the second clock. Any opinions from the devicetree people?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140422/404cc0f2/attachment.sig>
