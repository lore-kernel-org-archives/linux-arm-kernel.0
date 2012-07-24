From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2012 15:42:41 +0000
Subject: [PATCH 1/3] dmaengine: mmp-pdma support
In-Reply-To: <1342763164-19208-2-git-send-email-zhangfei.gao@marvell.com>
References: <1342763164-19208-1-git-send-email-zhangfei.gao@marvell.com>
 <1342763164-19208-2-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <201207241542.42198.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 July 2012, Zhangfei Gao wrote:

> diff --git a/Documentation/devicetree/bindings/dma/mmp-dma.txt b/Documentation/devicetree/bindings/dma/mmp-dma.txt
> new file mode 100644
> index 0000000..42cd134
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mmp-dma.txt
> @@ -0,0 +1,30 @@
> +* MARVELL MMP DMA controller
> +
> +For driver/dma/mmp-pdma.c

The binding document should normally not refer to a Linux device driver,
but rather to a specific hardware, because the binding is OS-independent.
Better list here which chips have this specific hardware.

> +Required properties:
> +- compatible: Should be "mrvl,mmp-pdma"

We have recently changed all the Marvell strings to "marvel," instead
of "mrvl,". We used to have a mix of both, but it's better to use
just one.

> +- reg: Should contain DMA registers location and length.
> +- interrupts: Either contain all of the per-channel DMA interrupts
> +		or one irq for pdma device
> +- chancnt: Should be channel number in the soc

There is ongoing work to specify the generic dma engine bindings.
The current proposal is to use 

    - #dma-channels: Number of DMA channels supported by the controller.
    - #dma-requests: Number of DMA requests signals supported by the controller.

instead of the chancnt. You can provide just one or both, depending
on what you need.

It is not entirely clear what the difference between having one IRQ
or lots of them is:

> +/* One irq for all channels */
> +pdma: dma-controller at d4000000 {
> +	      compatible = "mrvl,mmp-pdma";
> +	      reg = <0xd4000000 0x10000>;
> +	      interrupts = <47>;
> +	      chancnt = <16>;
> +      };
> +

Would this be the same as saying

		interrupts = <47 47 47 47 47 47 47 47 47 47 47 47 47 47 47 47>;

with 16 channels?


> +static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
>               unsigned long arg)
> +{
> +       struct mmp_pdma_chan *chan = to_mmp_pdma_chan(dchan);
> +       struct dma_slave_config *cfg = (void *)arg;
> +       struct mmp_dma_slave_config *mmp_cfg;
> +       unsigned long flags;
> +       int ret = 0;
> +       u32 maxburst = 0, addr = 0;
> +       enum dma_slave_buswidth width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
> +
> +       if (!dchan)
> +               return -EINVAL;
> +       mmp_cfg = container_of(cfg, struct mmp_dma_slave_config, slave_config);

Encapsulating the slave config like this requires that the slave driver
knows what the master is, which is not how this is designed to be used.
What is actually the data you encode in there?

> +static struct of_device_id mmp_pdma_dt_ids[] = {
> +	{ .compatible = "mrvl,mmp-pdma", .data = (void *)MMP_PDMA},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mmp_pdma_dt_ids);

You don't actually use the data field afaict, so that can be removed.

> +	of_id = of_match_device(mmp_pdma_dt_ids, pdev->dev);
> +	if (of_id)

It is already matched here, so just do

	if (pdev->dev->of_node)

> +
> +struct mmp_dma_platdata {
> +	int chancnt;
> +};

It this actually necessary?

I think it would be better in the long run to only provide the DT based
configuration interface here. There are no in-tree users of the
platform-data, and I would hope that we can avoid adding them. Any
board files that are kept out of tree can of course add support for this
back. If you can make a reasonable argument for keeping it, you can
probably convince me otherwise in this case, but generally I would
prefer new stuff to be DT-only.

	Arnd
