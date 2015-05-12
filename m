From: wsa@the-dreams.de (wsa at the-dreams.de)
Date: Tue, 12 May 2015 14:58:32 +0200
Subject: [PATCH v7 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <1430901427-65146-3-git-send-email-eddie.huang@mediatek.com>
References: <1430901427-65146-1-git-send-email-eddie.huang@mediatek.com>
 <1430901427-65146-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150512125832.GB4447@schokonusskuchen.bad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/mm.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/scatterlist.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>

Please sort the includes to avoid duplicates.

> +struct mtk_i2c_compatible {
> +	const struct i2c_adapter_quirks *quirks;
> +	unsigned char pmic_i2c;
> +	unsigned char dcm;
> +};

I wonder if the unsigned char options can be bits in a flags variable?

> +static const struct i2c_adapter_quirks mt6577_i2c_quirks = {
> +	.flags = I2C_AQ_COMB_WRITE_THEN_READ,
> +	.max_num_msgs = MAX_MSG_NUM_MT6577,
> +	.max_write_len = MAX_DMA_TRANS_SIZE_MT6577,
> +	.max_read_len = MAX_DMA_TRANS_SIZE_MT6577,
> +	.max_comb_1st_msg_len = MAX_DMA_TRANS_SIZE_MT6577,
> +	.max_comb_2nd_msg_len = MAX_WRRD_TRANS_SIZE_MT6577,
> +};

I would think plain numbers are much more readable than defines here.
They are used only once, too.

> +static const struct of_device_id mtk_i2c_of_match[] = {
> +	{ .compatible = "mediatek,mt6577-i2c", .data = (void *)&mt6577_compat },
> +	{ .compatible = "mediatek,mt6589-i2c", .data = (void *)&mt6589_compat },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);

No need for casts.

> +static inline void mtk_i2c_writew(u16 value, struct mtk_i2c *i2c, u8 offset)
> +{
> +	writew(value, i2c->base + offset);
> +}
> +
> +static inline u16 mtk_i2c_readw(struct mtk_i2c *i2c, u8 offset)
> +{
> +	return readw(i2c->base + offset);
> +}

I am not a big fan of such extremly thin wrappers, but if you like them...

> +		rpaddr = dma_map_single(i2c->adap.dev.parent, msgs->buf,
> +						msgs->len, DMA_FROM_DEVICE);

I think you shouldn't use the adapter device here and later, but the dma
channel device.

> +	/* flush before sending start */
> +	mb();
> +	mtk_i2c_writel_dma(I2C_DMA_START_EN, i2c, OFFSET_EN);

Is mb() really needed when you use writel after that?

> +	if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
> +		dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs->addr);
> +		mtk_i2c_init_hw(i2c);
> +		return -EREMOTEIO;

-ENXIO. Please check Documentation/i2c/fault-codes for a reference and
check all your error values.

> +	ret = of_property_read_u32(np, "clock-div", clk_src_div);
> +	if (ret < 0)
> +		return ret;

Do we need a property for that in the i2c-block? Can't the clock
provider driver deliver a properly divided clock already?


And cppcheck says:

drivers/i2c/busses/i2c-mt65xx.c:133: style: struct or union member 'mtk_i2c_data::clk_frequency' is never used.
drivers/i2c/busses/i2c-mt65xx.c:135: style: struct or union member 'mtk_i2c_data::clk_src_div' is never used.

Rest looks good, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/6e08758c/attachment.sig>
