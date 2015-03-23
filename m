From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 23 Mar 2015 19:31:53 +0100
Subject: [PATCH V2 1/3] i2c: busses: add SLIMpro I2C device driver on APM
 X-Gene platform
In-Reply-To: <1424288043-2995-1-git-send-email-fkan@apm.com>
References: <1424288043-2995-1-git-send-email-fkan@apm.com>
Message-ID: <20150323183153.GA1128@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 11:34:01AM -0800, Feng Kan wrote:
> Add SLIMpro I2C device driver on APM X-Gene platform. This I2C
> device driver use the SLIMpro Mailbox driver to tunnel message to
> the SLIMpro coprocessor to do the work of accessing I2C components.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> Signed-off-by: Hieu Le <hnle@apm.com>

Sigh, I lost my first review, so here we go again...
It looks mostly good. Using checkpatch with '--strict' will show some
whitespace issues. Please fix these.

> +config I2C_XGENE_SLIMPRO
> +	tristate "APM X-Gene SoC I2C SLIMpro devices support"
> +	depends on ARCH_XGENE && MAILBOX

COMPILE_TEST?

> +static int start_i2c_msg_xfer(struct slimpro_i2c_dev *ctx)
> +{
> +	if (ctx->mbox_client.tx_block) {
> +		if (!wait_for_completion_timeout(&ctx->rd_complete,
> +						 msecs_to_jiffies
> +						 (MAILBOX_OP_TIMEOUT)))

Don't be too strict with the 80 char limit IMHO. I think it is more
readable to combine the last two lines into one.

> +	msg[0] = SLIMPRO_IIC_ENCODE_MSG(SLIMPRO_IIC_BUS, chip,
> +					SLIMPRO_IIC_READ, protocol, addrlen,
> +					readlen);

ditto

> +	msg[0] = SLIMPRO_IIC_ENCODE_MSG(SLIMPRO_IIC_BUS, chip,
> +					SLIMPRO_IIC_WRITE, protocol, addrlen,
> +					writelen);

ditto

> +	paddr = dma_map_single(ctx->dev, ctx->dma_buffer, readlen,
> +			       DMA_FROM_DEVICE);

The device should be the device of the dma channel.

> +	paddr = dma_map_single(ctx->dev, ctx->dma_buffer, writelen,
> +			       DMA_TO_DEVICE);

ditto

> +	rc = dma_mapping_error(ctx->dev, paddr);
> +	if (dma_mapping_error(ctx->dev, paddr)) {

if (rc)

> +static struct i2c_algorithm xgene_slimpro_i2c_algorithm = {
> +	.smbus_xfer = xgene_slimpro_i2c_xfer,

Might be a tad less confusing to name this function
xgene_slimpro_smbus_xfer. You decide.

> +	rc = i2c_add_adapter(adapter);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Adapter registeration failed\n");
> +		return rc;
> +	}
> +
> +	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (rc)
> +		dev_warn(&pdev->dev, "Unable to set dma mask\n");

Shouldn't that be before i2c_add_adapter?

> +static struct platform_driver xgene_slimpro_i2c_driver = {
> +	.probe	= xgene_slimpro_i2c_probe,
> +	.remove	= xgene_slimpro_i2c_remove,
> +	.driver	= {
> +		.name	= "xgene-slimpro-i2c",
> +		.of_match_table = of_match_ptr(xgene_slimpro_i2c_id)

You are DT only, do we need of_match_ptr?

> +MODULE_DESCRIPTION("APM X-Gene SLIMpro I2C driver");
> +MODULE_LICENSE("GPL");

MODULE_AUTHOR left out intentionally?

Thanks,

   Wolfram
