From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 26 May 2014 15:12:45 +0530
Subject: [PATCH 1/5] phy: add support for USB cluster on the Armada 375 SoC
In-Reply-To: <537FC2BE.1040501@free-electrons.com>
References: <1400257376-13251-1-git-send-email-gregory.clement@free-electrons.com>
 <537F12F5.2030102@ti.com> <537FC2BE.1040501@free-electrons.com>
Message-ID: <53830C95.2030202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hI,

On Saturday 24 May 2014 03:20 AM, Gregory CLEMENT wrote:
> On 23/05/2014 11:20, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Friday 16 May 2014 09:52 PM, Gregory CLEMENT wrote:
>>> The Armada 375 SoC comes with an USB2 host and device controller and
>>> an USB3 controller. The USB cluster control register allows to manage
>>> common features of both USB controllers.
>>>
>>> This commit adds a driver integrated in the generic PHY framework to
>>> control this USB cluster feature.
>>>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>> ---
>>>  drivers/phy/Kconfig                              |   6 +
>>>  drivers/phy/Makefile                             |   1 +
>>>  drivers/phy/phy-armada375-usb2.c                 | 140 +++++++++++++++++++++++
>>>  include/dt-bindings/phy/armada-375-usb-cluster.h |  18 +++
> [...]
> 
>>> +static struct phy_ops armada375_usb_phy_ops = {
>>> +	.init = armada375_usb_phy_init,
>>> +	.owner		= THIS_MODULE,
>>
>> nitpick: unnecessary tab.
> 
> OK
> 
>>> +};
>>> +
>>> +/*
>>> + * Only one controller can use this PHY. We shouldn't have the case
>>> + * when two controllers want to use this PHY. But if this case occurs
>>> + * then we provide a phy to the first one and return an error for the
>>> + * next one. This error has also to be an error returned by
>>> + * devm_phy_optional_get() so different from ENODEV for USB2. In the
>>> + * USB3 case it still optional and we use ENODEV.
>>> + */
>>> +static struct phy *armada375_usb_phy_xlate(struct device *dev,
>>> +					struct of_phandle_args *args)
>>> +{
>>> +	if (WARN_ON(usb_cluster_phy.phy_provided)) {
>>> +		dev_err(dev, "This PHY has already been provided!\n");
>>> +		dev_err(dev, "Check your device tree, only one controller can use it\n.");
>>> +		if (args->args[0] == PHY_USB2)
>>> +			return ERR_PTR(-EBUSY);
>>> +		else
>>> +			return ERR_PTR(-ENODEV);
>>> +	}
>>> +
>>> +	if (args->args[0] == PHY_USB2)
>>> +		usb_cluster_phy.use_usb3 = false;
>>> +	else if (args->args[0] == PHY_USB3)
>>> +		usb_cluster_phy.use_usb3 = true;
>>> +	else {
>>> +		dev_err(dev, "Invalid PHY mode\n");
>>> +		return ERR_PTR(-ENODEV);
>>> +	}
>>
>> how will this behave if there is a phy_put and then a phy_get?
> 
> Badly I think :(
> 
> I have to think about a better solution then.
> 
>>> +
>>> +	usb_cluster_phy.phy_provided = true;
>>> +
>>> +	return usb_cluster_phy.phy;
>>> +}
>>> +
>>> +static int armada375_usb_phy_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct phy *phy;
>>> +	struct phy_provider *phy_provider;
>>> +	void __iomem *usb_cluster_base;
>>> +	struct resource *res;
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	usb_cluster_base = devm_ioremap_resource(&pdev->dev, res);
>>> +	if (!usb_cluster_base)
>>> +		return -ENOMEM;
>>> +
>>> +	phy = devm_phy_create(dev, &armada375_usb_phy_ops, NULL);
>>> +	if (IS_ERR(phy)) {
>>> +		dev_err(dev, "failed to create PHY \n");
>>> +		return PTR_ERR(phy);
>>> +	}
>>> +
>>> +	usb_cluster_phy.phy = phy;
>>> +	usb_cluster_phy.reg = usb_cluster_base;
>>> +	phy_set_drvdata(phy, &usb_cluster_phy);
>>> +
>>> +	phy_provider = devm_of_phy_provider_register(&pdev->dev,
>>> +						     armada375_usb_phy_xlate);
>>> +	if (IS_ERR(phy_provider))
>>> +		return PTR_ERR(phy_provider);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct of_device_id of_usb_cluster_table[] = {
>>> +	{ .compatible = "marvell,armada-375-usb-cluster", },
>>> +	{ /* end of list */ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, of_usb_cluster_table);
>>> +
>>> +static struct platform_driver armada375_usb_phy_driver = {
>>> +	.probe	= armada375_usb_phy_probe,
>>> +	.driver = {
>>> +		.of_match_table	= of_usb_cluster_table,
>>> +		.name  = "armada-375-usb-cluster",
>>> +		.owner = THIS_MODULE,
>>> +	}
>>> +};
>>> +module_platform_driver(armada375_usb_phy_driver);
>>> +
>>> +MODULE_DESCRIPTION("Armada 375 USB cluster driver");
>>> +MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
>>> +MODULE_LICENSE("GPL");
>>
>> GPL v2?
> 
> See the header, I chose "GNU General Public License version 2 or later."
> so "GPL" match it.

Indeed! Just figured it's documented in include/linux/module.h.

Thanks
Kishon
