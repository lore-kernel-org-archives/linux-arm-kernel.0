From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 11 Jul 2014 14:03:22 +0200
Subject: [PATCH v3 2/2] can: m_can: add Bosch M_CAN controller support
In-Reply-To: <53BFC6CE.9090408@gmail.com>
References: <1405074557-5519-1-git-send-email-b29396@freescale.com>
 <1405074557-5519-2-git-send-email-b29396@freescale.com>
 <53BFC6CE.9090408@gmail.com>
Message-ID: <53BFD28A.5090202@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2014 01:13 PM, Varka Bhadram wrote:
> On 07/11/2014 03:59 PM, Dong Aisheng wrote:
> 
> (...)
> 
>> +/* m_can private data structure */
>> +struct m_can_priv {
>> +    struct can_priv can;    /* must be the first member */
>> +    struct napi_struct napi;
>> +    struct net_device *dev;
>> +    struct device *device;
>> +    struct clk *hclk;
>> +    struct clk *cclk;
>> +    void __iomem *base;
>> +    u32 irqstatus;
>> +
>> +    /* message ram configuration */
>> +    void __iomem *mram_base;
>> +    struct mram_cfg mcfg[MRAM_CFG_NUM];
>> +};
>> +
> 
> It will be good if we write the comments for the driver private structure
> 
>> +static inline u32 m_can_read(const struct m_can_priv *priv, enum
>> m_can_reg reg)
>> +{
>> +    return readl(priv->base + reg);
>> +}
>> +
> 
> (...)
> 
>> +static void free_m_can_dev(struct net_device *dev)
>> +{
>> +    free_candev(dev);
>> +}
>> +
> 
> Why do we need a separate function which calls a single function...  :-)

To be symetric with alloc_m_can_dev()

> 
>> +static struct net_device *alloc_m_can_dev(void)
>> +{
>> +    struct net_device *dev;
>> +    struct m_can_priv *priv;
>> +
>> +    dev = alloc_candev(sizeof(struct m_can_priv), 1);
> 
> sizeof(*priv)...?
> 
>> +    if (!dev)
>> +        return NULL;
> 
> Return value -ENOMEM ?

I'm okay with NULL, however if we want to return an arror value, it must
be ERR_PTR() wrapped.

> 
>> +
>> +    priv = netdev_priv(dev);
>> +    netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
>> +
>> +    priv->dev = dev;
>> +    priv->can.bittiming_const = &m_can_bittiming_const;
>> +    priv->can.do_set_mode = m_can_set_mode;
>> +    priv->can.do_get_berr_counter = m_can_get_berr_counter;
>> +    priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>> +                    CAN_CTRLMODE_LISTENONLY |
>> +                    CAN_CTRLMODE_BERR_REPORTING;
>> +
>> +    return dev;
>> +}
>> +
>> +static int m_can_open(struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv = netdev_priv(dev);
>> +    int err;
>> +
>> +    err = clk_prepare_enable(priv->hclk);
>> +    if (err)
>> +        return err;
>> +
>> +    err = clk_prepare_enable(priv->cclk);
>> +    if (err)
>> +        goto exit_disable_hclk;
>> +
>> +    /* open the can device */
>> +    err = open_candev(dev);
>> +    if (err) {
>> +        netdev_err(dev, "failed to open can device\n");
>> +        goto exit_disable_cclk;
>> +    }
>> +
>> +    /* register interrupt handler */
>> +    err = request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
>> +              dev);
> 
> why don't we use devm_request_irq()...? If you use this no need to worry
> about freeing the irq

...because the IRQ is allocated during ifup and released during ifdown.

> 
>> +    if (err < 0) {
>> +        netdev_err(dev, "failed to request interrupt\n");
>> +        goto exit_irq_fail;
>> +    }
>> +
>> +    /* start the m_can controller */
>> +    m_can_start(dev);
>> +
>> +    can_led_event(dev, CAN_LED_EVENT_OPEN);
>> +    napi_enable(&priv->napi);
>> +    netif_start_queue(dev);
>> +
>> +    return 0;
>> +
>> +exit_irq_fail:
>> +    close_candev(dev);
>> +exit_disable_cclk:
>> +    clk_disable_unprepare(priv->cclk);
>> +exit_disable_hclk:
>> +    clk_disable_unprepare(priv->hclk);
>> +    return err;
>> +}
>> +
>> +static void m_can_stop(struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv = netdev_priv(dev);
>> +
>> +    /* disable all interrupts */
>> +    m_can_disable_all_interrupts(priv);
>> +
>> +    clk_disable_unprepare(priv->hclk);
>> +    clk_disable_unprepare(priv->cclk);
>> +
>> +    /* set the state as STOPPED */
>> +    priv->can.state = CAN_STATE_STOPPED;
>> +}
>> +
>> +static int m_can_close(struct net_device *dev)
>> +{
>> +    struct m_can_priv *priv = netdev_priv(dev);
>> +
>> +    netif_stop_queue(dev);
>> +    napi_disable(&priv->napi);
>> +    m_can_stop(dev);
>> +    free_irq(dev->irq, dev);
> 
> not required when you use devm_request_irq()

No....see above.

> 
>> +    close_candev(dev);
>> +    can_led_event(dev, CAN_LED_EVENT_STOP);
>> +
>> +    return 0;
>> +}
>> +
> 
> (...)
> 
>> +
>> +static const struct of_device_id m_can_of_table[] = {
>> +    { .compatible = "bosch,m_can", .data = NULL },
> 
> we can simply give '0' . No need of .data = NULL. Things should be
> simple right....  :-)

.data should be a pointer, while "0" isn't. (Although 0 is valid C, we
don't want a integer 0 to initialize a pointer.) However, you can omit
.data = NULL completely. When initialzing via C99, any omited members of
the struct will automatically be initialized with 0x0. I like to see the
.data = NULL because it documents that there isn't any data (yet), once
another compatible is added, we need the .data anyways.

> 
>> +    { /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, m_can_of_table);
>> +
>> +static int m_can_of_parse_mram(struct platform_device *pdev,
>> +                   struct m_can_priv *priv)
>> +{
>> +    struct device_node *np = pdev->dev.of_node;
>> +    struct resource *res;
>> +    void __iomem *addr;
>> +    u32 out_val[MRAM_CFG_LEN];
>> +    int ret;
>> +
>> +    /* message ram could be shared */
>> +    res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> "message_ram");
>> +    if (!res)
>> +        return -ENODEV;
>> +
>> +    addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
>> +    if (!addr)
>> +        return -ENODEV;
> 
> Is this err return is appropriate ... ?

-ENOMEM seems to be more commonly used.

> 
>> +
>> +    /* get message ram configuration */
>> +    ret = of_property_read_u32_array(np, "mram-cfg",
>> +                     out_val, sizeof(out_val) / 4);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "can not get message ram configuration\n");
>> +        return -ENODEV;
>> +    }
>> +
> 
> Is this err return is appropriate ... ?

Whay do you suggest?

> 
>> +    priv->mram_base = addr;
>> +    priv->mcfg[MRAM_SIDF].off = out_val[0];
>> +    priv->mcfg[MRAM_SIDF].num = out_val[1];
>> +    priv->mcfg[MRAM_XIDF].off = priv->mcfg[MRAM_SIDF].off +
>> +            priv->mcfg[MRAM_SIDF].num * SIDF_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_XIDF].num = out_val[2];
>> +    priv->mcfg[MRAM_RXF0].off = priv->mcfg[MRAM_XIDF].off +
>> +            priv->mcfg[MRAM_XIDF].num * XIDF_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_RXF0].num = out_val[3] & RXFC_FS_MASK;
>> +    priv->mcfg[MRAM_RXF1].off = priv->mcfg[MRAM_RXF0].off +
>> +            priv->mcfg[MRAM_RXF0].num * RXF0_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_RXF1].num = out_val[4] & RXFC_FS_MASK;
>> +    priv->mcfg[MRAM_RXB].off = priv->mcfg[MRAM_RXF1].off +
>> +            priv->mcfg[MRAM_RXF1].num * RXF1_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_RXB].num = out_val[5];
>> +    priv->mcfg[MRAM_TXE].off = priv->mcfg[MRAM_RXB].off +
>> +            priv->mcfg[MRAM_RXB].num * RXB_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_TXE].num = out_val[6];
>> +    priv->mcfg[MRAM_TXB].off = priv->mcfg[MRAM_TXE].off +
>> +            priv->mcfg[MRAM_TXE].num * TXE_ELEMENT_SIZE;
>> +    priv->mcfg[MRAM_TXB].num = out_val[7] & TXBC_NDTB_MASK;
>> +
>> +    dev_dbg(&pdev->dev, "mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0
>> 0x%x %d rxf1 0x%x %d rxb 0x%x %d txe 0x%x %d txb 0x%x %d\n",
>> +        priv->mram_base,
>> +        priv->mcfg[MRAM_SIDF].off, priv->mcfg[MRAM_SIDF].num,
>> +        priv->mcfg[MRAM_XIDF].off, priv->mcfg[MRAM_XIDF].num,
>> +        priv->mcfg[MRAM_RXF0].off, priv->mcfg[MRAM_RXF0].num,
>> +        priv->mcfg[MRAM_RXF1].off, priv->mcfg[MRAM_RXF1].num,
>> +        priv->mcfg[MRAM_RXB].off, priv->mcfg[MRAM_RXB].num,
>> +        priv->mcfg[MRAM_TXE].off, priv->mcfg[MRAM_TXE].num,
>> +        priv->mcfg[MRAM_TXB].off, priv->mcfg[MRAM_TXB].num);
>> +
> 
> dev_dbg() will insert the new lines in b/w. It wont print the values as
> you expected.
> Check this by enabling debug ...

What do you mean by b/w?

> 
>> +    return 0;
>> +}
>> +
> 
> (...)
> 
>> +
>> +static void unregister_m_can_dev(struct net_device *dev)
>> +{
>> +    unregister_candev(dev);
>> +}
>> +
> 
> again a function which calls a single func.
> 
>> +static int m_can_plat_remove(struct platform_device *pdev)
>> +{
>> +    struct net_device *dev = platform_get_drvdata(pdev);
>> +
>> +    unregister_m_can_dev(dev);
>> +    platform_set_drvdata(pdev, NULL);
>> +
>> +    free_m_can_dev(dev);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct dev_pm_ops m_can_pmops = {
>> +    SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
>> +};
>> +
>> +static struct platform_driver m_can_plat_driver = {
>> +    .driver = {
>> +        .name = KBUILD_MODNAME,
>> +        .owner = THIS_MODULE,
> 
> No need to update .owner. module_platform_driver() will do for you.
> see:http://lxr.free-electrons.com/source/include/linux/platform_device.h#L190

Oh, right.

>> +        .of_match_table = of_match_ptr(m_can_of_table),
>> +        .pm     = &m_can_pmops,
>> +    },
>> +    .probe = m_can_plat_probe,
>> +    .remove = m_can_plat_remove,
>> +};
>> +
>> +module_platform_driver(m_can_plat_driver);
>> +
>> +MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");
> 
> 
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/4d33bd33/attachment.sig>
