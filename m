From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sat, 29 Nov 2014 18:40:31 +0100
Subject: [PATCH v8 2/4] ARM: mediatek: Add sysirq interrupt polarity
 support
In-Reply-To: <1416902662-19281-3-git-send-email-yingjoe.chen@mediatek.com>
References: <1416902662-19281-1-git-send-email-yingjoe.chen@mediatek.com>
 <1416902662-19281-3-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <20141129174030.GA4696@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 04:04:20PM +0800, Yingjoe Chen wrote:
> Mediatek SoCs have interrupt polarity support in sysirq which
> allows to invert polarity for given interrupt. Add this support
> using hierarchy irq domain.
>
> [...]
> 
> +static int __init mtk_sysirq_of_init(struct device_node *node,
> +				     struct device_node *parent)
> +{
> +	struct irq_domain *domain, *domain_parent;
> +	struct mtk_sysirq_chip_data *chip_data;
> +	int ret = 0;
> +
> +	domain_parent = irq_find_host(parent);
> +	if (!domain_parent) {
> +		pr_err("mtk_sysirq: interrupt-parent not found\n");
> +		return -EINVAL;
> +	}
> +
> +	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
> +	if (!chip_data)
> +		return -ENOMEM;
> +
> +	chip_data->intpol_base = of_io_request_and_map(node, 0, "intpol");
> +	if (!chip_data->intpol_base) {

Hi,

you should use IS_ERR() to check the return value here.

Beniamino
