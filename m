From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 May 2014 09:24:09 +0200
Subject: [PATCH v7 2/3] [media] rc: add sunxi-ir driver
In-Reply-To: <1400104602-16431-3-git-send-email-bay@hackerdom.ru>
References: <1400104602-16431-1-git-send-email-bay@hackerdom.ru>
 <1400104602-16431-3-git-send-email-bay@hackerdom.ru>
Message-ID: <20140515072409.GM29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 03:56:41AM +0600, Alexander Bersenev wrote:
> This patch adds driver for sunxi IR controller.
> It is based on Alexsey Shestacov's work based on the original driver
> supplied by Allwinner.
> 
> Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
> Signed-off-by: Alexsey Shestacov <wingrime@linux-sunxi.org>
> ---
>  drivers/media/rc/Kconfig     |  10 ++
>  drivers/media/rc/Makefile    |   1 +
>  drivers/media/rc/sunxi-cir.c | 334 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 drivers/media/rc/sunxi-cir.c
> 
> diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
> index 8fbd377..9427fad 100644
> --- a/drivers/media/rc/Kconfig
> +++ b/drivers/media/rc/Kconfig
> @@ -343,4 +343,14 @@ config RC_ST
>  
>  	 If you're not sure, select N here.
>  
> +config IR_SUNXI
> +    tristate "SUNXI IR remote control"
> +    depends on RC_CORE
> +    depends on ARCH_SUNXI
> +    ---help---
> +      Say Y if you want to use sunXi internal IR Controller
> +
> +      To compile this driver as a module, choose M here: the module will
> +      be called sunxi-ir.
> +
>  endif #RC_DEVICES
> diff --git a/drivers/media/rc/Makefile b/drivers/media/rc/Makefile
> index f8b54ff..9ee9ee7 100644
> --- a/drivers/media/rc/Makefile
> +++ b/drivers/media/rc/Makefile
> @@ -32,4 +32,5 @@ obj-$(CONFIG_IR_GPIO_CIR) += gpio-ir-recv.o
>  obj-$(CONFIG_IR_IGUANA) += iguanair.o
>  obj-$(CONFIG_IR_TTUSBIR) += ttusbir.o
>  obj-$(CONFIG_RC_ST) += st_rc.o
> +obj-$(CONFIG_IR_SUNXI) += sunxi-cir.o
>  obj-$(CONFIG_IR_IMG) += img-ir/
> diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
> new file mode 100644
> index 0000000..25eb175
> --- /dev/null
> +++ b/drivers/media/rc/sunxi-cir.c
> @@ -0,0 +1,334 @@
> +/*
> + * Driver for Allwinner sunXi IR controller
> + *
> + * Copyright (C) 2014 Alexsey Shestacov <wingrime@linux-sunxi.org>
> + * Copyright (C) 2014 Alexander Bersenev <bay@hackerdom.ru>
> + *
> + * Based on sun5i-ir.c:
> + * Copyright (C) 2007-2012 Daniel Wang
> + * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <media/rc-core.h>
> +
> +#define SUNXI_IR_DEV "sunxi-ir"
> +
> +/* Registers */
> +/* IR Control */
> +#define SUNXI_IR_CTL_REG      0x00
> +/* Rx Config */
> +#define SUNXI_IR_RXCTL_REG    0x10
> +/* Rx Data */
> +#define SUNXI_IR_RXFIFO_REG   0x20
> +/* Rx Interrupt Enable */
> +#define SUNXI_IR_RXINT_REG    0x2C
> +/* Rx Interrupt Status */
> +#define SUNXI_IR_RXSTA_REG    0x30
> +/* IR Sample Config */
> +#define SUNXI_IR_CIR_REG      0x34
> +
> +/* Global Enable for IR_CTL Register */
> +#define REG_CTL_GEN           BIT(0)
> +/* RX block enable for IR_CTL Register */
> +#define REG_CTL_RXEN          BIT(1)
> +/* CIR mode for IR_CTL Register */
> +#define REG_CTL_MD            (BIT(4)|BIT(5))
> +
> +/* IR_RXCTL_REG Register Receiver Pulse Polarity Invert flag */
> +#define REG_RXCTL_RPPI        BIT(2)
> +
> +/* IR_RXINT_REG Register fields */
> +#define REG_RXINT_ROI_EN      BIT(0) /* Rx FIFO Overflow */
> +#define REG_RXINT_RPEI_EN     BIT(1) /* Rx Packet End */
> +#define REG_RXINT_RAI_EN      BIT(4) /* Rx FIFO Data Available */
> +/* Rx FIFO available byte level */
> +#define REG_RXINT_RAL__MASK   (BIT(8)|BIT(9)|BIT(10)|BIT(11))
> +#define REG_RXINT_RAL__SHIFT  8
> +static inline uint32_t REG_RXINT_RAL(uint16_t val)
> +{
> +	return (val << REG_RXINT_RAL__SHIFT) & REG_RXINT_RAL__MASK;
> +}
> +
> +/* CIR_REG register noise threshold */
> +#define REG_CIR_NTHR__MASK   (BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7))
> +#define REG_CIR_NTHR__SHIFT  2
> +static inline uint32_t REG_CIR_NTHR(uint16_t val)
> +{
> +	return (val << REG_CIR_NTHR__SHIFT) & REG_CIR_NTHR__MASK;
> +}
> +/* CIR_REG register idle threshold */
> +#define REG_CIR_ITHR__MASK   (BIT(8)|BIT(9)|BIT(10)|BIT(11)|BIT(12)|BIT(13) \
> +			     |BIT(14)|BIT(15))
> +#define REG_CIR_ITHR__SHIFT  8
> +static inline uint32_t REG_CIR_ITHR(uint16_t val)
> +{
> +	return (val << REG_CIR_ITHR__SHIFT) & REG_CIR_ITHR__MASK;
> +}
> +
> +/* RXSTA_REG Register RX FIFO Available Counter */
> +#define REG_RXSTA_RAC__SHIFT  8
> +#define REG_RXSTA_RAC__MASK   0x3f
> +
> +/* Clear all interrupt status value */
> +#define REG_RXSTA_CLEARALL    0xff
> +
> +/* Hardware supported fifo size */
> +#define SUNXI_IR_FIFO_SIZE    16
> +/* How many messages in FIFO trigger IRQ */
> +#define TRIGGER_LEVEL         8
> +/* Required frequency for IR0 or IR1 clock in CIR mode */
> +#define SUNXI_IR_BASE_CLK     8000000
> +/* Frequency after IR internal divider  */
> +#define SUNXI_IR_CLK          (SUNXI_IR_BASE_CLK / 64)
> +/* Sample period in ns */
> +#define SUNXI_IR_SAMPLE       (1000000000ul / SUNXI_IR_CLK)
> +/* Noise threshold in samples  */
> +#define SUNXI_IR_RXNOISE      1
> +/* Idle Threshold in samples */
> +#define SUNXI_IR_RXIDLE       20
> +/* Time after which device stops sending data in ms */
> +#define SUNXI_IR_TIMEOUT      120
> +
> +struct sunxi_ir {
> +	spinlock_t      ir_lock;
> +	struct rc_dev   *rc;
> +	void __iomem    *base;
> +	int             irq;
> +	struct clk      *clk;
> +	struct clk      *apb_clk;
> +	const char      *map_name;
> +};
> +
> +static irqreturn_t sunxi_ir_irq(int irqno, void *dev_id)
> +{
> +	unsigned long status;
> +	unsigned char dt;
> +	unsigned int cnt, rc;
> +	struct sunxi_ir *ir = dev_id;
> +	DEFINE_IR_RAW_EVENT(rawir);
> +
> +	spin_lock(&ir->ir_lock);
> +
> +	status = readl(ir->base + SUNXI_IR_RXSTA_REG);
> +
> +	/* clean all pending statuses */
> +	writel(status | REG_RXSTA_CLEARALL, ir->base + SUNXI_IR_RXSTA_REG);
> +
> +	if (status & REG_RXINT_RAI_EN) {
> +		/* How many messages in fifo */
> +		rc  = (status >> REG_RXSTA_RAC__SHIFT) & REG_RXSTA_RAC__MASK;
> +		/* Sanity check */
> +		rc = rc > SUNXI_IR_FIFO_SIZE ? SUNXI_IR_FIFO_SIZE : rc;
> +		/* If we have data */
> +		for (cnt = 0; cnt < rc; cnt++) {
> +			/* for each bit in fifo */
> +			dt = readb(ir->base + SUNXI_IR_RXFIFO_REG);
> +			rawir.pulse = (dt & 0x80) != 0;
> +			rawir.duration = (dt & 0x7f) * SUNXI_IR_SAMPLE;
> +			ir_raw_event_store_with_filter(ir->rc, &rawir);
> +		}
> +	}
> +
> +	if (status & REG_RXINT_ROI_EN) {
> +		ir_raw_event_reset(ir->rc);
> +	} else if (status & REG_RXINT_RPEI_EN) {
> +		ir_raw_event_set_idle(ir->rc, true);
> +		ir_raw_event_handle(ir->rc);
> +	}
> +
> +	spin_unlock(&ir->ir_lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static int sunxi_ir_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	unsigned long tmp = 0;
> +
> +	struct device *dev = &pdev->dev;
> +	struct device_node *dn = dev->of_node;
> +	struct resource *res;
> +	struct sunxi_ir *ir;
> +
> +	ir = devm_kzalloc(dev, sizeof(struct sunxi_ir), GFP_KERNEL);
> +	if (!ir)
> +		return -ENOMEM;
> +
> +	/* Clock */
> +	ir->apb_clk = devm_clk_get(dev, "apb");
> +	if (IS_ERR(ir->apb_clk)) {
> +		dev_err(dev, "failed to get a apb clock.\n");
> +		return PTR_ERR(ir->apb_clk);
> +	}
> +	ir->clk = devm_clk_get(dev, "ir");
> +	if (IS_ERR(ir->clk)) {
> +		dev_err(dev, "failed to get a ir clock.\n");
> +		return PTR_ERR(ir->clk);
> +	}
> +
> +	ret = clk_set_rate(ir->clk, SUNXI_IR_BASE_CLK);
> +	if (ret) {
> +		dev_err(dev, "set ir base clock failed!\n");
> +		return ret;
> +	}
> +
> +	if (clk_prepare_enable(ir->apb_clk)) {
> +		dev_err(dev, "try to enable apb_ir_clk failed\n");
> +		return -EINVAL;
> +	}
> +
> +	if (clk_prepare_enable(ir->clk)) {
> +		dev_err(dev, "try to enable ir_clk failed\n");
> +		ret = -EINVAL;
> +		goto exit_clkdisable_apb_clk;
> +	}
> +
> +	/* IO */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	ir->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ir->base)) {
> +		dev_err(dev, "failed to map registers\n");
> +		ret = PTR_ERR(ir->base);
> +		goto exit_clkdisable_clk;
> +	}
> +

You can drop the extra line here

> +	/* IRQ */
> +	ir->irq = platform_get_irq(pdev, 0);
> +	if (ir->irq < 0) {
> +		dev_err(dev, "no irq resource\n");
> +		ret = ir->irq;
> +		goto exit_clkdisable_clk;
> +	}
> +
> +	ret = devm_request_irq(dev, ir->irq, sunxi_ir_irq, 0, SUNXI_IR_DEV, ir);

Starting from here, your handler can be called, and you're far from
ready to handle your interrupts.

> +	if (ret) {
> +		dev_err(dev, "failed request irq\n");
> +		goto exit_clkdisable_clk;
> +	}
> +
> +	ir->rc = rc_allocate_device();
> +

You can drop the extra line here

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/50b11c7e/attachment-0001.sig>
