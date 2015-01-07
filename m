From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Jan 2015 09:35:57 +0100
Subject: [PATCH 4/4] dma: X-Gene PCIE DMA Driver
In-Reply-To: <1420608537-12296-5-git-send-email-mchitale@apm.com>
References: <1420608537-12296-1-git-send-email-mchitale@apm.com>
 <1420608537-12296-5-git-send-email-mchitale@apm.com>
Message-ID: <4187918.PUaMnn04Vq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 January 2015 10:58:57 Mayuresh Chitale wrote:
> This patch implements DMA engine API for DMA controller on APM
> X-Gene PCIe controller. DMA engine can support up to 4 channels per port
> and up to 2048 outstanding requests per channel.  This is intended
> to be used on ports that are configured in EP mode or to transfer
> data from a RC port that is connected to a X-Gene EP port.

Linux currently does not support PCIe endpoints. Do you plan to submit
a driver for that as well?

> +
> +static void xpdma_setup_dma_dev(struct dma_device *dev)
> +{
> +	dma_cap_zero(dev->cap_mask);
> +	dma_cap_set(DMA_SLAVE, dev->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, dev->cap_mask);
> +
> +	dev->device_alloc_chan_resources = xpdma_alloc_chan_resources;
> +	dev->device_free_chan_resources = xpdma_free_chan_resources;
> +	dev->device_tx_status = xpdma_tx_status;
> +	dev->device_issue_pending = xpdma_issue_pending;
> +	dev->device_prep_slave_sg = xpdma_prep_slave_sg;
> +	dev->device_control = xpdma_device_control;
> +}

You are setting up DMA_SLAVE here but do not use the DT binding
for slave DMA. Can your driver handle slave DMA? If it can,
you should use the appropriate binding, if not then don't
set DMA_SLAVE here.

> +static int xpdma_setup_dma_channel(struct platform_device *pdev,
> +		struct xpdma_port *port)
> +{
> +	int i, ret = 0;
> +	struct xpdma_chan *chan;
> +	resource_size_t dma_base;
> +
> +	dma_base = MAKE_U64(readl(port->cfg + PORT_CFG_HI), readl(port->cfg)) +
> +		CHAN_REG_BASE;
> +	port->dma = devm_ioremap(&pdev->dev, dma_base,
> +			CHAN_REG_SIZE * MAX_DMA_CHAN);
> +	if (port->dma == NULL) {
> +		dev_err(&pdev->dev, "Could not get base addressc$\n");
> +		return -ENOMEM;
> +	}

The registers are not listed in the 'reg' property. Why is that?

You should probably use devm_request_mem_region or devm_ioremap_resource
here to ensure manage the mmio range.

> +static int xpdma_probe(struct platform_device *pdev)
> +{
> +	int err;
> +	u32 mask;
> +	struct resource *res;
> +	struct xpdma_port *port;
> +
> +	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->dma_dev.dev = &pdev->dev;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "No cfg resource\n");
> +		return -EINVAL;
> +	}
> +
> +	port->cfg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (IS_ERR(port->cfg))
> +		return PTR_ERR(port->cfg);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(&pdev->dev, "No intr resource\n");
> +		return -EINVAL;
> +	}

from binding, these two register ranges look like they are part of
another device. Which device is that:

+                       reg = < 0x0 0x1f2b0154 0x0 0xc
+                               0x0 0x1f2b0058 0x0 0x8>;

Is this some kind of syscon node that contains all sorts of
registers munged together, or is this the same register set that
is used for the channels?

In the former case, better use a syscon reference instead of 'reg'
and use syscon_regmap_lookup_by_phandle to get the regmap, in the
second case, just list the entire registers.

> +
> +	xpdma_setup_dma_dev(&port->dma_dev);
> +	/* Setup DMA mask - 32 for 32-bit system and 64 for 64-bit system */
> +	err = dma_set_mask_and_coherent(&pdev->dev,
> +			DMA_BIT_MASK(8*sizeof(void *)));
> +	if (err) {
> +		dev_err(&pdev->dev, "Unable to set dma mask\n");
> +		return err;
> +	}

Just use a 64-bit dma-mask all the time, and fall back to a 32-bit
mask if that doesn't work, the dma mask is completely independent
of the word size of the CPU.

You also have to make sure that the parent of the device contains
a proper dma-ranges property that allows a 64-bit mask. We currently
have a bug in the kernel that makes dma_set_mask_and_coherent
always succeed, and we need to fix that so it fails if you have
a 64-bit dma capable device on a 32-bit wide bus.

> +static const struct of_device_id xpdma_match_table[] = {
> +	{.compatible = "apm,xgene-pciedma",},
> +	{},
> +};

This is a rather generic compatible string. Is this device present
in identical form on all xgene variants?

As xgene is a marketing name and you have now announce the speciifc
model numbers, better use the first model that has this hardware.

	Arnd
