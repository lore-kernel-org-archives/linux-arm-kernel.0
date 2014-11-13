From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 13 Nov 2014 12:46:45 +0100
Subject: [PATCH v3 4/6] phy: add support for USB cluster on the Armada
 375 SoC
In-Reply-To: <54644C92.8000900@ti.com>
References: <1415786237-21985-1-git-send-email-gregory.clement@free-electrons.com>
 <1415786237-21985-5-git-send-email-gregory.clement@free-electrons.com>
 <54644C92.8000900@ti.com>
Message-ID: <54649A25.6050304@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[...]
>> +
>> +static struct armada375_cluster_phy usb_cluster_phy;
> 
> don't use global variables.
>> +
>> +static int armada375_usb_phy_init(struct phy *phy)
>> +{
>> +	struct armada375_cluster_phy *cluster_phy = phy_get_drvdata(phy);
>> +	u32 reg;
>> +
>> +	reg = readl(cluster_phy->reg);
>> +	if (cluster_phy->use_usb3)
>> +		reg |= USB2_PHY_CONFIG_DISABLE;
>> +	else
>> +		reg &= ~USB2_PHY_CONFIG_DISABLE;
>> +	writel(reg, cluster_phy->reg);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct phy_ops armada375_usb_phy_ops = {
>> +	.init = armada375_usb_phy_init,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +/*
>> + * Only one controller can use this PHY. We shouldn't have the case
>> + * when two controllers want to use this PHY. But if this case occurs
>> + * then we provide a phy to the first one and return an error for the
>> + * next one. This error has also to be an error returned by
>> + * devm_phy_optional_get() so different from ENODEV for USB2. In the
>> + * USB3 case it still optional and we use ENODEV.
>> + */
>> +static struct phy *armada375_usb_phy_xlate(struct device *dev,
>> +					struct of_phandle_args *args)
>> +{
>> +
>> +    /*
>> +     * Either the phy had never been requested and then the first usb
>> +     * claiming it can get it, or it had already been requested in
>> +     * this case, we only allow to use it with the same configuration.
>> +     */
> 
> You can dynamically create usb_cluster_phy in probe and then invoke
> platform_set_drvdata by passing *usb_cluster_phy. Then you can invoke
> platform_get_drvdata here to get *usb_cluster_phy.
> 
> While fixing this also add yourself as Maintainer of this file.

I am taking into account your comment and I am going to send a new version soon.

Thanks,

Gregory


> 
> Thanks
> Kishon
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
