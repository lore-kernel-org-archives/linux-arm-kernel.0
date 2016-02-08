From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 8 Feb 2016 10:32:08 +0000
Subject: [PATCH 1/6] irqchip: add the Alpine MSIX interrupt controller
In-Reply-To: <20160208102656.GA4117@kwain>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922971-17405-2-git-send-email-antoine.tenart@free-electrons.com>
 <56B86391.1030609@arm.com> <20160208102656.GA4117@kwain>
Message-ID: <56B86EA8.9070306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/16 10:26, Antoine Tenart wrote:
>>> +static int alpine_msix_init(struct device_node *node,
>>> +			    struct device_node *parent)
>>> +{
>>> +	struct alpine_msix_data *priv;
>>> +	struct resource res;
>>> +	int ret;
>>> +
>>> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	spin_lock_init(&priv->msi_map_lock);
>>> +
>>> +	ret = of_address_to_resource(node, 0, &res);
>>> +	if (ret) {
>>> +		pr_err("Failed to allocate resource\n");
>>> +		goto err_priv;
>>> +	}
>>> +
>>> +	priv->addr_high = upper_32_bits((u64)res.start);
>>> +	priv->addr_low = lower_32_bits(res.start) + ALPINE_MSIX_SPI_TARGET_CLUSTER0;
>>
>> This is a bit odd. If you always set bit 16, why isn't that reflected in
>> the base address coming from the DT?
> 
> The 20 least significant bits of addr_low provide direct information
> regarding the interrupt destination, so I thought it would be clearer
> to have this explicitly in the driver so that we know what those bits
> mean.

So what is this information? TARGET_CLUSTER0 is not very expressive, and
doesn't show what the alternatives are. Could you please elaborate a bit
on that front?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
