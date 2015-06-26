From: majun258@huawei.com (majun (F))
Date: Fri, 26 Jun 2015 14:31:41 +0800
Subject: [PATCH v2 2/3] IRQ/Gic-V3: Change arm-gic-its to support the
 Mbigen interrupt
In-Reply-To: <1434077399-32200-3-git-send-email-majun258@huawei.com>
References: <1434077399-32200-1-git-send-email-majun258@huawei.com>
 <1434077399-32200-3-git-send-email-majun258@huawei.com>
Message-ID: <558CF1CD.5020200@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas:

? 2015/6/12 10:49, Ma Jun ??:

> +static int its_mbigen_prepare(struct irq_domain *domain, struct mbi_desc *desc,
> +								int hwirq, struct mbi_alloc_info *arg)
> +{
> +	struct its_node *its = domain->parent->host_data;
> +	struct its_device *its_dev;
> +	u32 dev_id;
> +
> +	dev_id = desc->msg_id;
> +
> +	its_dev = its_find_device(its, dev_id);
> +	if (!its_dev) {
> +		its_dev = its_create_device(its, dev_id, desc->lines);
> +		if (!its_dev)
> +			return -ENOMEM;
> +	}
> +
> +	arg->scratchpad[0].ptr = its_dev;
> +	arg->scratchpad[1].ptr = NULL;
> +
> +	arg->desc = desc;
> +	arg->hwirq = hwirq;
> +	return 0;
> +}
> +
> +static struct mbigen_domain_ops its_mbigen_ops = {
> +	.mbigen_prepare		= its_mbigen_prepare,
> +};
> +
> +static struct mbigen_domain_info its_mbigen_domain_info = {
> +	.ops	= &its_mbigen_ops,
> +};
> +

what's you opinion about the function 'its_mbigen_prepare' ?
put this function in irq-gic-v3-its.c or move to mbigen driver ?

If I move this function to mbigen driver, some its fuctions
(ex. its_find_device, its_create_device) and struct data (ex its_node)
would be used in mbigen driver.

Now, all these functions and data structure are defined as static.
to use them, I have to remove the 'static' definition and put them
in a head file ? create a new head file).

I'm not sure which way is better .
