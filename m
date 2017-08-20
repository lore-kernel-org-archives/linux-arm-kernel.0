From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 20 Aug 2017 03:44:20 +0200
Subject: [RFC 3/3] irqchip: Add Realtek RTD1295 mux driver
In-Reply-To: <20170817101140.32000-4-afaerber@suse.de>
References: <20170817101140.32000-1-afaerber@suse.de>
 <20170817101140.32000-4-afaerber@suse.de>
Message-ID: <32b536aa-36df-33fc-36f0-da974e480fea@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 17.08.2017 um 12:11 schrieb Andreas F?rber:
> This irq mux driver is derived from the RTD1295 vendor DT and assumes a linear
> mapping between intr_en and intr_status registers. Code for RTD119x indicates
> this may not always be the case (i2c_3).
> 
> The register initialization was copied from QNAP's mach-rtk119x/rtk_irq_mux.c
> as a boot fix, without full insights into what exactly this is changing (TODO).
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
[...]
> diff --git a/drivers/irqchip/irq-rtd119x-mux.c b/drivers/irqchip/irq-rtd119x-mux.c
> new file mode 100644
> index 000000000000..c6c1ba126bf3
> --- /dev/null
> +++ b/drivers/irqchip/irq-rtd119x-mux.c
[...]
> +static int __init rtd119x_irq_mux_init(struct device_node *node,
> +				       struct device_node *parent,
> +				       const struct rtd119x_irq_mux_info *info)
> +{
> +	struct rtd119x_irq_mux_data *data;
> +	void __iomem *base;
> +	u32 val;
[...]
> +	/* TODO Investigate why these are necessary (from downstream rtk119x rtk_irq_mux.c) */
> +	val = readl(data->intr_en);
> +	val &= ~BIT(2);
> +	writel(val, data->intr_en);
> +
> +	writel(BIT(2), data->intr_status);

This intr_status write appears to be the fix. The register is 0x00000004
before, but oddly writing it again resolves the observed timer hang.

The intr_en register is 0xe0183924 before, and masking out bit 2 makes
no observable difference.

> +
> +	irq_set_chained_handler_and_data(data->irq, rtd119x_mux_irq_handle, data);
> +
> +	return 0;
> +}
[snip]

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
