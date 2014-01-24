From: sthokal@xilinx.com (Srikanth Thokala)
Date: Fri, 24 Jan 2014 16:46:05 +0530
Subject: [PATCH v2] dma: Add Xilinx AXI Video Direct Memory Access Engine
 driver support
In-Reply-To: <52E0FC22.8060903@metafoo.de>
References: <1390409565-4200-1-git-send-email-sthokal@xilinx.com>
 <1390409565-4200-2-git-send-email-sthokal@xilinx.com>
 <52E0FC22.8060903@metafoo.de>
Message-ID: <CA+mB=1L6yvCwA3mKCwz83LQbXiVau110REV64rYrSzUhGE4ucA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars,

On Thu, Jan 23, 2014 at 4:55 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 01/22/2014 05:52 PM, Srikanth Thokala wrote:
> [...]
>> +/**
>> + * xilinx_vdma_device_control - Configure DMA channel of the device
>> + * @dchan: DMA Channel pointer
>> + * @cmd: DMA control command
>> + * @arg: Channel configuration
>> + *
>> + * Return: '0' on success and failure value on error
>> + */
>> +static int xilinx_vdma_device_control(struct dma_chan *dchan,
>> +                                   enum dma_ctrl_cmd cmd, unsigned long arg)
>> +{
>> +     struct xilinx_vdma_chan *chan = to_xilinx_chan(dchan);
>> +
>> +     switch (cmd) {
>> +     case DMA_TERMINATE_ALL:
>> +             xilinx_vdma_terminate_all(chan);
>> +             return 0;
>> +     case DMA_SLAVE_CONFIG:
>> +             return xilinx_vdma_slave_config(chan,
>> +                                     (struct xilinx_vdma_config *)arg);
>
> You really shouldn't be overloading the generic API with your own semantics.
> DMA_SLAVE_CONFIG should take a dma_slave_config and nothing else.

Ok.  The driver needs few additional configuration from the slave
device like Vertical
Size, Horizontal Size,  Stride etc., for the DMA transfers, in that case do you
suggest me to define a separate dma_ctrl_cmd like the one FSLDMA_EXTERNAL_START
defined for Freescale drivers?

>
>> +     default:
>> +             return -ENXIO;
>> +     }
>> +}
>> +
> [...]
>> +
>> +     /* Request the interrupt */
>> +     chan->irq = irq_of_parse_and_map(node, 0);
>> +     err = devm_request_irq(xdev->dev, chan->irq, xilinx_vdma_irq_handler,
>> +                            IRQF_SHARED, "xilinx-vdma-controller", chan);
>
> This is a clasic example of where to not use devm_request_irq. 'chan' is
> accessed in the interrupt handler, but if you use devm_request_irq 'chan'
> will be freed before the interrupt handler has been released, which means
> there is now a race condition where the interrupt handler can access already
> freed memory.

Ok, thank you for the clarification on this thread.  I will fix it in v3.

>
>> +     if (err) {
>> +             dev_err(xdev->dev, "unable to request IRQ\n");
>> +             return err;
>> +     }
>> +
>> +     /* Initialize the DMA channel and add it to the DMA engine channels
>> +      * list.
>> +      */
>> +     chan->common.device = &xdev->common;
>> +
>> +     list_add_tail(&chan->common.device_node, &xdev->common.channels);
>> +     xdev->chan[chan->id] = chan;
>> +
>> +     /* Reset the channel */
>> +     err = xilinx_vdma_chan_reset(chan);
>> +     if (err < 0) {
>> +             dev_err(xdev->dev, "Reset channel failed\n");
>> +             return err;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>> + * struct of_dma_filter_xilinx_args - Channel filter args
>> + * @dev: DMA device structure
>> + * @chan_id: Channel id
>> + */
>> +struct of_dma_filter_xilinx_args {
>> +     struct dma_device *dev;
>> +     u32 chan_id;
>> +};
>> +
>> +/**
>> + * xilinx_vdma_dt_filter - VDMA channel filter function
>> + * @chan: DMA channel pointer
>> + * @param: Filter match value
>> + *
>> + * Return: true/false based on the result
>> + */
>> +static bool xilinx_vdma_dt_filter(struct dma_chan *chan, void *param)
>> +{
>> +     struct of_dma_filter_xilinx_args *args = param;
>> +
>> +     return chan->device == args->dev && chan->chan_id == args->chan_id;
>> +}
>> +
>> +/**
>> + * of_dma_xilinx_xlate - Translation function
>> + * @dma_spec: Pointer to DMA specifier as found in the device tree
>> + * @ofdma: Pointer to DMA controller data
>> + *
>> + * Return: DMA channel pointer on success and NULL on error
>> + */
>> +static struct dma_chan *of_dma_xilinx_xlate(struct of_phandle_args *dma_spec,
>> +                                             struct of_dma *ofdma)
>> +{
>> +     struct of_dma_filter_xilinx_args args;
>> +     dma_cap_mask_t cap;
>> +
>> +     args.dev = ofdma->of_dma_data;
>> +     if (!args.dev)
>> +             return NULL;
>> +
>> +     if (dma_spec->args_count != 1)
>> +             return NULL;
>> +
>> +     dma_cap_zero(cap);
>> +     dma_cap_set(DMA_SLAVE, cap);
>> +
>> +     args.chan_id = dma_spec->args[0];
>> +
>> +     return dma_request_channel(cap, xilinx_vdma_dt_filter, &args);
>
> There is a new helper function called dma_get_slave_channel, which makes
> this much easier. Take a look at the k3dma.c driver for an example.

Ok.  I will check and fix it in v3.

Srikanth

>> +}
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
