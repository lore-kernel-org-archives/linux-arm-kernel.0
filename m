From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Wed, 14 Oct 2015 09:54:26 +0200
Subject: [PATCH v2 2/4] dmaengine: Add STM32 DMA driver
In-Reply-To: <561D1689.90703@linaro.org>
References: <1444745127-1105-1-git-send-email-cedric.madianga@gmail.com>
 <1444745127-1105-3-git-send-email-cedric.madianga@gmail.com>
 <561D1689.90703@linaro.org>
Message-ID: <CAOAejn1N=dFZ3nQ_hNznJQX1-fkP3r=vdYuWY4OMH65PrW3xVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

2015-10-13 16:34 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
> On 13/10/15 15:05, M'boumba Cedric Madianga wrote:
>>
>> This patch adds support for the STM32 DMA controller.
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> ---
>>   drivers/dma/Kconfig     |   12 +
>>   drivers/dma/Makefile    |    1 +
>>   drivers/dma/stm32-dma.c | 1175
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 1188 insertions(+)
>>   create mode 100644 drivers/dma/stm32-dma.c
>
>
>> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
>> new file mode 100644
>> index 0000000..031bab7
>> --- /dev/null
>> +++ b/drivers/dma/stm32-dma.c
>
>
>> +enum stm32_dma_width {
>> +       STM32_DMA_BYTE,
>> +       STM32_DMA_HALF_WORD,
>> +       STM32_DMA_WORD,
>> +};
>> +
>> +enum stm32_dma_burst_size {
>> +       STM32_DMA_BURST_SINGLE,
>> +       STM32_DMA_BURST_INCR4,
>> +       STM32_DMA_BURST_INCR8,
>> +       STM32_DMA_BURST_INCR16,
>> +};
>> +
>> +enum stm32_dma_channel_id {
>> +       STM32_DMA_CHANNEL0,
>> +       STM32_DMA_CHANNEL1,
>> +       STM32_DMA_CHANNEL2,
>> +       STM32_DMA_CHANNEL3,
>> +       STM32_DMA_CHANNEL4,
>> +       STM32_DMA_CHANNEL5,
>> +       STM32_DMA_CHANNEL6,
>> +       STM32_DMA_CHANNEL7,
>> +};
>
>
> Why have (unused) enumerations to map numeric symbols to their own natural
> values? Using normal integers would be better.

Good point. I will remove these in the next version.
Thanks.

>
>
>> +enum stm32_dma_request_id {
>> +       STM32_DMA_REQUEST0,
>> +       STM32_DMA_REQUEST1,
>> +       STM32_DMA_REQUEST2,
>> +       STM32_DMA_REQUEST3,
>> +       STM32_DMA_REQUEST4,
>> +       STM32_DMA_REQUEST5,
>> +       STM32_DMA_REQUEST6,
>> +       STM32_DMA_REQUEST7,
>> +};
>
>
> Ditto.

As above, I will remove it in the next version. Thanks.

>
>
>> +static void stm32_dma_dump_reg(struct stm32_dma_chan *chan)
>> +{
>> +       struct stm32_dma_device *dmadev = stm32_dma_chan_get_dev(chan);
>> +
>> +       dev_dbg(chan2dev(chan), "SCR:   0x%08x\n",
>> +               stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id)));
>> +       dev_dbg(chan2dev(chan), "NDTR:  0x%08x\n",
>> +               stm32_dma_read(dmadev, STM32_DMA_SNDTR(chan->id)));
>> +       dev_dbg(chan2dev(chan), "SPAR:  0x%08x\n",
>> +               stm32_dma_read(dmadev, STM32_DMA_SPAR(chan->id)));
>> +       dev_dbg(chan2dev(chan), "SM0AR: 0x%08x\n",
>> +               stm32_dma_read(dmadev, STM32_DMA_SM0AR(chan->id)));
>> +       dev_dbg(chan2dev(chan), "SM1AR: 0x%08x\n",
>> +               stm32_dma_read(dmadev, STM32_DMA_SM1AR(chan->id)));
>> +       dev_dbg(chan2dev(chan), "SFCR:  0x%08x\n",
>> +               stm32_dma_read(dmadev, STM32_DMA_SFCR(chan->id)));
>> +}
>
>
> Even at dev_dbg() this looks like log spam. This debug info gets issued
> every time we set up a transfer!

Yes, this info will be logged after each transfer.
But it will complete other debug info print when DMADEVICES_DEBUG is set.

>
>
>> +static int stm32_dma_alloc_chan_resources(struct dma_chan *c)
>> +{
>> +       struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
>> +       struct stm32_dma_device *dmadev = stm32_dma_chan_get_dev(chan);
>> +       int ret;
>> +
>> +       chan->config_init = false;
>> +       ret = clk_prepare_enable(dmadev->clk);
>> +       if (ret < 0) {
>> +               dev_err(chan2dev(chan), "clk_prepare_enable failed: %d\n",
>> ret);
>> +               return ret;
>> +       }
>> +
>> +       ret = stm32_dma_disable_chan(chan);
>> +
>> +       return ret;
>> +}
>
>
> The error path here looks like it will leak clock references.

Sorry I didn't catch it. What does it mean ?

>
>
>
>> +static int stm32_dma_probe(struct platform_device *pdev)
>> +{
>> +       struct stm32_dma_chan *chan;
>> +       struct stm32_dma_device *dmadev;
>> +       struct dma_device *dd;
>> +       const struct of_device_id *match;
>> +       unsigned int i;
>> +       struct resource *res;
>> +       int ret;
>> +
>> +       match = of_match_device(stm32_dma_of_match, &pdev->dev);
>> +       if (!match) {
>> +               dev_err(&pdev->dev, "Error: No device match found\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       dmadev = devm_kzalloc(&pdev->dev, sizeof(*dmadev), GFP_KERNEL);
>> +       if (!dmadev)
>> +               return -ENOMEM;
>> +
>> +       dd = &dmadev->ddev;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       dmadev->base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(dmadev->base))
>> +               return PTR_ERR(dmadev->base);
>> +
>> +       dmadev->clk = devm_clk_get(&pdev->dev, NULL);
>> +       if (IS_ERR(dmadev->clk)) {
>> +               dev_err(&pdev->dev, "Error: Missing controller clock\n");
>> +               return PTR_ERR(dmadev->clk);
>> +       }
>> +
>> +       dmadev->mem2mem = of_property_read_bool(pdev->dev.of_node,
>> +                                               "st,mem2mem");
>> +
>> +       dmadev->rst = devm_reset_control_get(&pdev->dev, NULL);
>> +       if (!IS_ERR(dmadev->rst)) {
>> +               reset_control_assert(dmadev->rst);
>> +               udelay(2);
>> +               reset_control_deassert(dmadev->rst);
>> +       }
>> +
>> +       dma_cap_set(DMA_SLAVE, dd->cap_mask);
>> +       dma_cap_set(DMA_PRIVATE, dd->cap_mask);
>> +       dma_cap_set(DMA_CYCLIC, dd->cap_mask);
>> +       dd->device_alloc_chan_resources = stm32_dma_alloc_chan_resources;
>> +       dd->device_free_chan_resources = stm32_dma_free_chan_resources;
>> +       dd->device_tx_status = stm32_dma_tx_status;
>> +       dd->device_issue_pending = stm32_dma_issue_pending;
>> +       dd->device_prep_slave_sg = stm32_dma_prep_slave_sg;
>> +       dd->device_prep_dma_cyclic = stm32_dma_prep_dma_cyclic;
>> +       dd->device_config = stm32_dma_slave_config;
>> +       dd->device_terminate_all = stm32_dma_terminate_all;
>> +       dd->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>> +               BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>> +               BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>> +       dd->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>> +               BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>> +               BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>> +       dd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>> +       dd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>> +       dd->dev = &pdev->dev;
>> +       INIT_LIST_HEAD(&dd->channels);
>> +
>> +       if (dmadev->mem2mem) {
>> +               dma_cap_set(DMA_MEMCPY, dd->cap_mask);
>> +               dd->device_prep_dma_memcpy = stm32_dma_prep_dma_memcpy;
>> +               dd->directions |= BIT(DMA_MEM_TO_MEM);
>> +       }
>> +
>> +       for (i = 0; i < STM32_DMA_MAX_CHANNELS; i++) {
>> +               chan = &dmadev->chan[i];
>> +               chan->id = i;
>> +               chan->vchan.desc_free = stm32_dma_desc_free;
>> +               vchan_init(&chan->vchan, dd);
>> +       }
>> +
>> +       ret = dma_async_device_register(dd);
>> +       if (ret)
>> +               return ret;
>> +
>> +       for (i = 0; i < STM32_DMA_MAX_CHANNELS; i++) {
>> +               chan = &dmadev->chan[i];
>> +               res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
>> +               if (!res) {
>> +                       ret = -EINVAL;
>> +                       dev_err(&pdev->dev, "No irq resource for chan
>> %d\n", i);
>> +                       goto err_unregister;
>> +               }
>> +               chan->irq = res->start;
>> +               ret = devm_request_irq(&pdev->dev, chan->irq,
>> +                                      stm32_dma_chan_irq, 0,
>> +                                      dev_name(chan2dev(chan)), chan);
>> +               if (ret) {
>> +                       dev_err(&pdev->dev,
>> +                               "request_irq failed with err %d channel
>> %d\n",
>> +                               ret, i);
>> +                       goto err_unregister;
>> +               }
>> +       }
>> +
>> +       ret = of_dma_controller_register(pdev->dev.of_node,
>> +                                        stm32_dma_of_xlate, dmadev);
>> +       if (ret < 0) {
>> +               dev_err(&pdev->dev,
>> +                       "STM32 DMA DMA OF registration failed %d\n", ret);
>> +               goto err_unregister;
>> +       }
>> +
>> +       platform_set_drvdata(pdev, dmadev);
>> +
>> +       dev_info(&pdev->dev, "STM32 DMA driver registered\n");
>> +
>> +       return 0;
>> +
>> +err_unregister:
>> +       dma_async_device_unregister(dd);
>> +
>> +       return ret;
>> +}
>> +
>> +static int stm32_dma_remove(struct platform_device *pdev)
>> +{
>> +       struct stm32_dma_device *dmadev = platform_get_drvdata(pdev);
>> +
>> +       of_dma_controller_free(pdev->dev.of_node);
>> +
>> +       dma_async_device_unregister(&dmadev->ddev);
>> +
>> +       clk_disable_unprepare(dmadev->clk);
>
>
> What is the purpose of disabling/unpreparing the clock here?
> stm32_dma_alloc_chan_resources() and stm32_dma_free_chan_resources() should
> pair up and the clock should already be stopped.

I agree with you. I will remove it in the next version. Thanks

>
>
> Daniel.

Thanks for your review.

BR,
Cedric
