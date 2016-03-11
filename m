From: joe@perches.com (Joe Perches)
Date: Fri, 11 Mar 2016 10:55:05 -0800
Subject: [PATCH v2] bsp: add SoC driver to brcmstb
In-Reply-To: <1457721579-9646-1-git-send-email-justinpopo6@gmail.com>
References: <1457721579-9646-1-git-send-email-justinpopo6@gmail.com>
Message-ID: <1457722505.4654.8.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-03-11 at 10:39 -0800, Justin Chen wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> Value of soc_dev_attributes:
> family = chip family id
> soc_id = product id
> revision = product revision
[]
> diff --git a/drivers/soc/brcmstb/common.c b/drivers/soc/brcmstb/common.c
[]
> +static int __init brcmstb_soc_device_init(void)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct soc_device *soc_dev;
> +	struct device_node *sun_top_ctrl;
> +	void __iomem *sun_top_ctrl_base;
> +
> +	sun_top_ctrl = of_find_matching_node(NULL, sun_top_ctrl_match);
> +	if (!sun_top_ctrl)
> +		return -ENODEV;
> +
> +	sun_top_ctrl_base = of_iomap(sun_top_ctrl, 0);
> +	if (!sun_top_ctrl_base)
> +		return -ENODEV;
> +
> +	family_id = readl(sun_top_ctrl_base);
> +	product_id = readl(sun_top_ctrl_base + 0x4);
> +
> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return -ENOMEM;
> +
> +	soc_dev_attr->family = kasprintf(GFP_KERNEL, "%x",
> +					family_id >> 28 ?
> +					family_id >> 16 : family_id >> 8);
> +	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%x",
> +					product_id >> 28 ?
> +					product_id >> 16 : product_id >> 8);
> +	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%c%d",
> +				????(char)(((product_id & 0xff) >> 4) + 65),
> +				?????product_id & 0xf);

This might be easier to read as:

	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%c%d"
					   ((product_id & 0xf0) >> 4) + 'A',
					   product_id & 0xf);
> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev)) {
> +		kfree(soc_dev_attr->family);
> +		kfree(soc_dev_attr->soc_id);
> +		kfree(soc_dev_attr->revision);
> +		kfree(soc_dev_attr);
> +		return -1;

Mixing GENERIC_ERRNO types and fixed values seems odd.
Is -EPERM the correct return here?  Maybe -ENODEV?

> +	}
> +
> +	return 0;
> +}
> +arch_initcall(brcmstb_soc_device_init);
