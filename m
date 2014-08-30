From: zhangfei.gao@linaro.org (zhangfei)
Date: Sat, 30 Aug 2014 21:58:22 +0800
Subject: [PATCH v3 2/3] rc: Introduce hix5hd2 IR transmitter driver
In-Reply-To: <53FFF675.7020702@gmail.com>
References: <1409238977-19444-1-git-send-email-zhangfei.gao@linaro.org>
 <1409238977-19444-3-git-send-email-zhangfei.gao@linaro.org>
 <53FFF675.7020702@gmail.com>
Message-ID: <5401D87E.6000804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/29/2014 11:41 AM, Varka Bhadram wrote:
> On 08/28/2014 08:46 PM, Zhangfei Gao wrote:
>> From: Guoxiong Yan <yanguoxiong@huawei.com>
>>
>> IR transmitter driver for Hisilicon hix5hd2 soc
>>
>> By default all protocols are disabled.
>> For example nec decoder can be enabled by either
>> 1. ir-keytable -p nec
>> 2. echo nec > /sys/class/rc/rc0/protocols
>> See see Documentation/ABI/testing/sysfs-class-rc
>>
> (...)
>
>> +static irqreturn_t hix5hd2_ir_rx_interrupt(int irq, void *data)
>> +{
>> +    u32 symb_num, symb_val, symb_time;
>> +    u32 data_l, data_h;
>> +    u32 irq_sr, i;
>> +    struct hix5hd2_ir_priv *priv = data;
>> +
>> +    irq_sr = readl_relaxed(priv->base + IR_INTS);
>> +    if (irq_sr & INTMS_OVERFLOW) {
>> +        /*
>> +         * we must read IR_DATAL first, then we can clean up
>> +         * IR_INTS availably since logic would not clear
>> +         * fifo when overflow, drv do the job
>> +         */
>> +        ir_raw_event_reset(priv->rdev);
>> +        symb_num = readl_relaxed(priv->base + IR_DATAH);
>> +        for (i = 0; i < symb_num; i++)
>> +            readl_relaxed(priv->base + IR_DATAL);
>> +
>> +        writel_relaxed(INT_CLR_OVERFLOW, priv->base + IR_INTC);
>> +        dev_info(priv->dev, "overflow, level=%d\n",
>> +             IR_CFG_INT_THRESHOLD);
>> +    }
>> +
>> +    if ((irq_sr & INTMS_SYMBRCV) || (irq_sr & INTMS_TIMEOUT)) {
>> +        DEFINE_IR_RAW_EVENT(ev);
>> +
>> +        symb_num = readl_relaxed(priv->base + IR_DATAH);
>> +        for (i = 0; i < symb_num; i++) {
>> +            symb_val = readl_relaxed(priv->base + IR_DATAL);
>> +            data_l = ((symb_val & 0xffff) * 10);
>> +            data_h =  ((symb_val >> 16) & 0xffff) * 10;
>> +            symb_time = (data_l + data_h) / 10;
>> +
>> +            ev.duration = US_TO_NS(data_l);
>> +            ev.pulse = true;
>> +            ir_raw_event_store(priv->rdev, &ev);
>> +
>> +            if (symb_time < IR_CFG_SYMBOL_MAXWIDTH) {
>> +                ev.duration = US_TO_NS(data_h);
>> +                ev.pulse = false;
>> +                ir_raw_event_store(priv->rdev, &ev);
>> +            } else {
>> +                hix5hd2_ir_send_lirc_timeout(priv->rdev);
>> +            }
>> +        }
>> +
>> +        if (irq_sr & INTMS_SYMBRCV)
>> +            writel_relaxed(INT_CLR_RCV, priv->base + IR_INTC);
>> +        if (irq_sr & INTMS_TIMEOUT)
>> +            writel_relaxed(INT_CLR_TIMEOUT, priv->base + IR_INTC);
>> +    }
>> +
>> +    /* Empty software fifo */
>> +    ir_raw_event_handle(priv->rdev);
>> +    return IRQ_HANDLED;
>> +}
>> +
>
> It looks good if the entire ISR() above the probe()/remove()
> functionalities
> of the driver. Maximum of the developers follows this structure.
>
> (...)
>
>> +static struct of_device_id hix5hd2_ir_table[] = {
>> +    { .compatible = "hisilicon,hix5hd2-ir", },
>> +    {},
>> +};
>> +MODULE_DEVICE_TABLE(of, hix5hd2_ir_table);
>> +
>
> Every driver put these device ids above *struct platform_driver*
> definition.
> So that we can see the of_match_table....
>
>> +static int hix5hd2_ir_probe(struct platform_device *pdev)
>> +{
>> +    int ret;
>> +    struct rc_dev *rdev;
>> +    struct device *dev = &pdev->dev;
>> +    struct resource *res;
>> +    struct hix5hd2_ir_priv *priv;
>> +    struct device_node *node = pdev->dev.of_node;
>> +
>> +    priv = devm_kzalloc(dev, sizeof(struct hix5hd2_ir_priv),
>> GFP_KERNEL);
>
> sizeof(*priv)...?
>
>> +    if (!priv)
>> +        return -ENOMEM;
>> +
>
> (...)
>
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(hix5hd2_ir_pm_ops, hix5hd2_ir_suspend,
>> +             hix5hd2_ir_resume);
>> +
>
> We can move the device ids here....

Thanks Varka, will change sequence accordingly.
