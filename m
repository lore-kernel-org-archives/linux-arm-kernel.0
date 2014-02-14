From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 14 Feb 2014 10:59:47 +0100
Subject: [PATCH v2] can: xilinx CAN controller support.
In-Reply-To: <ad62e4f0-fe91-4dac-9a74-ffe9c9128cb2@CH1EHSMHS024.ehs.local>
References: <\> <0dc128ac-e5cd-47bd-9ab1-3a545c3e2043@CO9EHSMHS012.ehs.local>
 <52FD1B16.6020600@pengutronix.de>
 <ad62e4f0-fe91-4dac-9a74-ffe9c9128cb2@CH1EHSMHS024.ehs.local>
Message-ID: <52FDE913.30106@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2014 10:36 AM, Appana Durga Kedareswara Rao wrote:
>>> +/* CAN register bit masks - XCAN_<REG>_<BIT>_MASK */
>>> +#define XCAN_SRR_CEN_MASK          0x00000002 /* CAN enable */
>>> +#define XCAN_SRR_RESET_MASK                0x00000001 /* Soft Reset the
>> CAN core */
>>> +#define XCAN_MSR_LBACK_MASK                0x00000002 /* Loop back
>> mode select */
>>> +#define XCAN_MSR_SLEEP_MASK                0x00000001 /* Sleep mode
>> select */
>>> +#define XCAN_BRPR_BRP_MASK         0x000000FF /* Baud rate
>> prescaler */
>>> +#define XCAN_BTR_SJW_MASK          0x00000180 /* Synchronous
>> jump width */
>>> +#define XCAN_BTR_TS2_MASK          0x00000070 /* Time segment
>> 2 */
>>> +#define XCAN_BTR_TS1_MASK          0x0000000F /* Time segment
>> 1 */
>>> +#define XCAN_ECR_REC_MASK          0x0000FF00 /* Receive error
>> counter */
>>> +#define XCAN_ECR_TEC_MASK          0x000000FF /* Transmit error
>> counter */
>>> +#define XCAN_ESR_ACKER_MASK                0x00000010 /* ACK error */
>>> +#define XCAN_ESR_BERR_MASK         0x00000008 /* Bit error */
>>> +#define XCAN_ESR_STER_MASK         0x00000004 /* Stuff error */
>>> +#define XCAN_ESR_FMER_MASK         0x00000002 /* Form error */
>>> +#define XCAN_ESR_CRCER_MASK                0x00000001 /* CRC error */
>>> +#define XCAN_SR_TXFLL_MASK         0x00000400 /* TX FIFO is full
>> */
>>> +#define XCAN_SR_ESTAT_MASK         0x00000180 /* Error status */
>>> +#define XCAN_SR_ERRWRN_MASK                0x00000040 /* Error warning
>> */
>>> +#define XCAN_SR_NORMAL_MASK                0x00000008 /* Normal mode
>> */
>>> +#define XCAN_SR_LBACK_MASK         0x00000002 /* Loop back
>> mode */
>>> +#define XCAN_SR_CONFIG_MASK                0x00000001 /* Configuration
>> mode */
>>> +#define XCAN_IXR_TXFEMP_MASK               0x00004000 /* TX FIFO Empty
>> */
>>> +#define XCAN_IXR_WKUP_MASK         0x00000800 /* Wake up
>> interrupt */
>>> +#define XCAN_IXR_SLP_MASK          0x00000400 /* Sleep
>> interrupt */
>>> +#define XCAN_IXR_BSOFF_MASK                0x00000200 /* Bus off
>> interrupt */
>>> +#define XCAN_IXR_ERROR_MASK                0x00000100 /* Error interrupt
>> */
>>> +#define XCAN_IXR_RXNEMP_MASK               0x00000080 /* RX FIFO
>> NotEmpty intr */
>>> +#define XCAN_IXR_RXOFLW_MASK               0x00000040 /* RX FIFO
>> Overflow intr */
>>> +#define XCAN_IXR_RXOK_MASK         0x00000010 /* Message
>> received intr */
>>> +#define XCAN_IXR_TXOK_MASK         0x00000002 /* TX successful
>> intr */
>>> +#define XCAN_IXR_ARBLST_MASK               0x00000001 /* Arbitration
>> lost intr */
>>> +#define XCAN_IDR_ID1_MASK          0xFFE00000 /* Standard msg
>> identifier */
>>> +#define XCAN_IDR_SRR_MASK          0x00100000 /* Substitute
>> remote TXreq */
>>> +#define XCAN_IDR_IDE_MASK          0x00080000 /* Identifier
>> extension */
>>> +#define XCAN_IDR_ID2_MASK          0x0007FFFE /* Extended
>> message ident */
>>> +#define XCAN_IDR_RTR_MASK          0x00000001 /* Remote TX
>> request */
>>> +#define XCAN_DLCR_DLC_MASK         0xF0000000 /* Data length
>> code */
>>> +
> 
> Need to use BIT() Macro for the Masks?

You can, but it IMHO only makes sense where only a single bit is set.

[...]

>>> +   int waiting_ech_skb_num;
>>> +   int xcan_echo_skb_max_tx;
>>> +   int xcan_echo_skb_max_rx;
>>> +   struct napi_struct napi;
>>> +   spinlock_t ech_skb_lock;
>>> +   u32 (*read_reg)(const struct xcan_priv *priv, int reg);
>>> +   void (*write_reg)(const struct xcan_priv *priv, int reg, u32 val);
>>
>> Please remove read_reg, write_reg, as long as there isn't any BE support in
>> the driver, call them directly.
>>
> 
> 
> As per yours and Michal discussion I am keeping this here (endianess
> of the IP is not fixed at compile time).

Ok.

[...]

>>> +/**
>>> + * xcan_start_xmit - Starts the transmission
>>> + * @skb:   sk_buff pointer that contains data to be Txed
>>> + * @ndev:  Pointer to net_device structure
>>> + *
>>> + * This function is invoked from upper layers to initiate
>>> +transmission. This
>>> + * function uses the next available free txbuff and populates their
>>> +fields to
>>> + * start the transmission.
>>> + *
>>> + * Return: 0 on success and failure value on error  */ static int
>>> +xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev) {
>>> +   struct xcan_priv *priv = netdev_priv(ndev);
>>> +   struct net_device_stats *stats = &ndev->stats;
>>> +   struct can_frame *cf = (struct can_frame *)skb->data;
>>> +   u32 id, dlc, data[2] = {0, 0}, rtr = 0;
>>
>> I think you can drop the rtr varibale and use cf->can_id & CAN_RTR_FLAG
>> instead.
>>
> 
> OK
>>> +   unsigned long flags;
>>> +
>>> +   if (can_dropped_invalid_skb(ndev, skb))
>>> +           return NETDEV_TX_OK;
>>> +
>>> +   /* Watch carefully on the bit sequence */
>>> +   if (cf->can_id & CAN_EFF_FLAG) {
>>> +           /* Extended CAN ID format */
>>> +           id = ((cf->can_id & CAN_EFF_MASK) << XCAN_IDR_ID2_SHIFT)
>> &
>>> +                   XCAN_IDR_ID2_MASK;
>>> +           id |= (((cf->can_id & CAN_EFF_MASK) >>
>>> +                   (CAN_EFF_ID_BITS-CAN_SFF_ID_BITS)) <<
>>> +                   XCAN_IDR_ID1_SHIFT) & XCAN_IDR_ID1_MASK;
>>> +
>>> +           /* The substibute remote TX request bit should be "1"
>>> +            * for extended frames as in the Xilinx CAN datasheet
>>> +            */
>>> +           id |= XCAN_IDR_IDE_MASK | XCAN_IDR_SRR_MASK;
>>> +
>>> +           if (cf->can_id & CAN_RTR_FLAG) {
>>> +                   /* Extended frames remote TX request */
>>> +                   id |= XCAN_IDR_RTR_MASK;
>>> +                   rtr = 1;
>>> +           }
>>> +   } else {
>>> +           /* Standard CAN ID format */
>>> +           id = ((cf->can_id & CAN_SFF_MASK) << XCAN_IDR_ID1_SHIFT)
>> &
>>> +                   XCAN_IDR_ID1_MASK;
>>> +
>>> +           if (cf->can_id & CAN_RTR_FLAG) {
>>> +                   /* Extended frames remote TX request */
>>> +                   id |= XCAN_IDR_SRR_MASK;
>>> +                   rtr = 1;
>>> +           }
>>> +   }
>>> +
>>> +   dlc = (cf->can_dlc & 0xf) << XCAN_DLCR_DLC_SHIFT;
>>
>> No need to mask dlc, it's valid.
>>
> OK
> 
>>> +
>>> +   if (dlc > 0)
>>
>> You've copied my speudo code :)
>> But you have to use (cf->can_dlc > 0) here, as dlc is the shifted value.
> 
> Yes :) I missed it will change
> 
>>
>>> +           data[0] = be32_to_cpup((__be32 *)(cf->data + 0));
>>> +   if (dlc > 4)
>>> +           data[1] = be32_to_cpup((__be32 *)(cf->data + 4));
>>> +
>>> +   can_put_echo_skb(skb, ndev, priv->ech_skb_next);
>>
>>       can_put_echo_skb(skb, ndev,
>>               priv->tx_head % priv->xcan_echo_skb_max_tx);
>>
>>       priv->tx_head++;
>>
> 
> Ok
>>> +
>>> +   /* Write the Frame to Xilinx CAN TX FIFO */
>>> +   priv->write_reg(priv, XCAN_TXFIFO_ID_OFFSET, id);
>>> +   priv->write_reg(priv, XCAN_TXFIFO_DLC_OFFSET, dlc);
>>> +   if (!rtr) {
>>> +           priv->write_reg(priv, XCAN_TXFIFO_DW1_OFFSET, data[0]);
>>> +           priv->write_reg(priv, XCAN_TXFIFO_DW2_OFFSET, data[1]);
>>> +           stats->tx_bytes += cf->can_dlc;
>>
>> Please add a comment which write triggers the tx. What in case of the rtr?
>> Which write triggers the tx then?
>>
> 
> Ok  Will Add
> 
>  In RTR Case  the below write triggers the trasmission
> priv->write_reg(priv, XCAN_TXFIFO_DLC_OFFSET, dlc);
> In Normal case  this write
> priv->write_reg(priv, XCAN_TXFIFO_DW2_OFFSET, data[1]);
> Triggers the transmission.
> 
> In Btw: Due to the limitations in the IP( Tx DLC register is a write only Register)
> I can't put this stats->tx_bytes += cf->can_dlc; in the tx interrupt routine.

No problem.

[...]

>>> +   if (work_done < quota) {
>>> +           napi_complete(napi);
>>> +           ier = priv->read_reg(priv, XCAN_IER_OFFSET);
>>> +           ier |= (XCAN_IXR_RXOK_MASK |
>> XCAN_IXR_RXNEMP_MASK);
>>> +           priv->write_reg(priv, XCAN_IER_OFFSET, ier);
>>
>> Is this a read-modify-write register? I mean will an interrupt get disabled, if
>> you write a 0-bit in the IER register? What does the ICR register?
> 
> ISR- Interrupt Status Register (Read only register)
> IER- Interrupt Enable Register(R/w register)
> ICR- Interrupt Clear Register.(write only register)
> 
> 
> The Interrupt Status Register (ISR) contains bits that are set when a particular interrupt condition occurs. If
> the corresponding mask bit in the Interrupt Enable Register is set, an interrupt is generated.
> Interrupt bits in the ISR can be cleared by writing to the Interrupt Clear Register

Thanks.

[...]

>>> +/**
>>> + * xcan_open - Driver open routine
>>> + * @ndev:  Pointer to net_device structure
>>> + *
>>> + * This is the driver open routine.
>>> + * Return: 0 on success and failure value on error  */ static int
>>> +xcan_open(struct net_device *ndev) {
>>> +   struct xcan_priv *priv = netdev_priv(ndev);
>>> +   int ret;
>>> +
>>> +   ret = request_irq(ndev->irq, xcan_interrupt, priv->irq_flags,
>>> +                   ndev->name, (void *)ndev);
>>> +   if (ret < 0) {
>>> +           netdev_err(ndev, "Irq allocation for CAN failed\n");
>>> +           return ret;
>>> +   }
>>> +
>>> +   /* Set chip into reset mode */
>>> +   ret = set_reset_mode(ndev);
>>> +   if (ret < 0)
>>> +           netdev_err(ndev, "mode resetting failed failed!\n");
>>
>> Is this critical?
> 
> This condition usually won't fail.
> But if the controller has a problems at the h/w level in that case putted this err print.
> If you want me to change it as a warning will do

If there is a hardware level problem, is it better to return here with
an error (and free the IRQ)?

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
>>> +   int ret, fifodep;
>>> +
>>> +   /* Create a CAN device instance */
>>> +   ndev = alloc_candev(sizeof(struct xcan_priv),
>> XCAN_ECHO_SKB_MAX);
>>> +   if (!ndev)
>>> +           return -ENOMEM;
>>> +
>>> +   priv = netdev_priv(ndev);
>>> +   priv->dev = ndev;
>>> +   priv->can.bittiming_const = &xcan_bittiming_const;
>>> +   priv->can.do_set_bittiming = xcan_set_bittiming;
>>> +   priv->can.do_set_mode = xcan_do_set_mode;
>>> +   priv->can.do_get_berr_counter = xcan_get_berr_counter;
>>> +   priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>>> +                                   CAN_CTRLMODE_BERR_REPORTING;
>>> +
>>> +   /* Get IRQ for the device */
>>> +   ndev->irq = platform_get_irq(pdev, 0);
>>> +
>>> +   spin_lock_init(&priv->ech_skb_lock);
>>> +   ndev->flags |= IFF_ECHO;        /* We support local echo */
>>> +
>>> +   platform_set_drvdata(pdev, ndev);
>>> +   SET_NETDEV_DEV(ndev, &pdev->dev);
>>> +   ndev->netdev_ops = &xcan_netdev_ops;
>>> +
>>> +   /* Get the virtual base address for the device */
>>> +   res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +   priv->reg_base = devm_ioremap_resource(&pdev->dev, res);
>>> +   if (IS_ERR(priv->reg_base)) {
>>> +           ret = PTR_ERR(priv->reg_base);
>>> +           goto err_free;
>>> +   }
>>> +   ndev->mem_start = res->start;
>>> +   ndev->mem_end = res->end;
>>> +
>>> +   priv->write_reg = xcan_write_reg;
>>> +   priv->read_reg = xcan_read_reg;
>>> +
>>> +   ret = of_property_read_u32(pdev->dev.of_node, "tx-fifo-depth",
>>> +                           &fifodep);
>>> +   if (ret < 0)
>>> +           goto err_free;
>>> +   priv->xcan_echo_skb_max_tx = fifodep;
>>> +
>>> +   ret = of_property_read_u32(pdev->dev.of_node, "rx-fifo-depth",
>>> +                           &fifodep);
>>> +   if (ret < 0)
>>> +           goto err_free;
>>> +   priv->xcan_echo_skb_max_rx = fifodep;
>>> +
>>> +   /* Getting the CAN devclk info */
>>> +   priv->devclk = devm_clk_get(&pdev->dev, "ref_clk");
>>> +   if (IS_ERR(priv->devclk)) {
>>> +           dev_err(&pdev->dev, "Device clock not found.\n");
>>> +           ret = PTR_ERR(priv->devclk);
>>> +           goto err_free;
>>> +   }
>>> +
>>> +   /* Check for type of CAN device */
>>> +   if (of_device_is_compatible(pdev->dev.of_node,
>>> +                               "xlnx,zynq-can-1.00.a")) {
>>> +           priv->aperclk = devm_clk_get(&pdev->dev, "aper_clk");
>>> +           if (IS_ERR(priv->aperclk)) {
>>> +                   dev_err(&pdev->dev, "aper clock not found\n");
>>> +                   ret = PTR_ERR(priv->aperclk);
>>> +                   goto err_free;
>>> +           }
>>> +   } else {
>>> +           priv->aperclk = priv->devclk;
>>> +   }
>>> +
>>> +   ret = clk_prepare_enable(priv->devclk);
>>> +   if (ret) {
>>> +           dev_err(&pdev->dev, "unable to enable device clock\n");
>>> +           goto err_free;
>>> +   }
>>> +
>>> +   ret = clk_prepare_enable(priv->aperclk);
>>> +   if (ret) {
>>> +           dev_err(&pdev->dev, "unable to enable aper clock\n");
>>> +           goto err_unprepar_disabledev;
>>> +   }
>>
>> Can you keep your clocks disaled if the interface is not up?
> 
> I didn't get it will you please explain?

This feature s optional, but a a good practice.

This function gets called when the driver is loaded, i.e. during boot.
So the complete CAN core will be enabled and powered, even if the
interface is down. To reduce power consumption it's better to enable the
clocks in the open() function and disable in close(). If you access some
CAN registers during probe you have to enable the clock and you probably
have to enable it in the do_get_berr_counter callback, as it may be
called if the interface is still down.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140214/05ad9f6c/attachment-0001.sig>
