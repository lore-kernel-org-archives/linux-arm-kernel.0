From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 20 Jun 2013 10:58:09 +0530
Subject: [PATCH v7 1/9] drivers: phy: add generic PHY framework
In-Reply-To: <51C1D30D.1050907@samsung.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-2-git-send-email-kishon@ti.com>
 <51C1D30D.1050907@samsung.com>
Message-ID: <51C292E9.2010904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 19 June 2013 09:19 PM, Sylwester Nawrocki wrote:
> Hi,
>
> On 06/13/2013 10:43 AM, Kishon Vijay Abraham I wrote:
>> +/**
>> + * phy_create() - create a new phy
>> + * @dev: device that is creating the new phy
>> + * @id: id of the phy
>> + * @ops: function pointers for performing phy operations
>> + * @label: label given to the phy
>> + * @priv: private data from phy driver
>> + *
>> + * Called to create a phy using phy framework.
>> + */
>> +struct phy *phy_create(struct device *dev, u8 id, const struct phy_ops *ops,
>> +	const char *label, void *priv)
>> +{
>> +	int ret;
>> +	struct phy *phy;
>> +
>> +	if (!dev) {
>> +		dev_WARN(dev, "no device provided for PHY\n");
>> +		ret = -EINVAL;
>> +		goto err0;
>> +	}
>> +
>> +	phy = kzalloc(sizeof(*phy), GFP_KERNEL);
>> +	if (!phy) {
>> +		ret = -ENOMEM;
>> +		goto err0;
>> +	}
>> +
>> +	device_initialize(&phy->dev);
>> +
>> +	phy->dev.class = phy_class;
>> +	phy->dev.parent = dev;
>> +	phy->dev.of_node = dev->of_node;
>> +	phy->id = id;
>> +	phy->ops = ops;
>> +	phy->label = label;
>
> Perhaps we could make it:
>
> 	phy->label = kstrdup(label, GFP_KERNEL);
>
> and free the label in phy_destroy() ?

yeah.. Fixed.
>
> That way the users would't need to keep the label around. It might
> be useful when PHY provider generates the labels dynamically. I guess
> it is OK for PHY providers to hard code the labels and having the PHY
> user drivers passed labels in platform data ?

yeah. But the only concern here is there is no way to enforce the
labels are passed in platform data. The PHY user driver can also
hard code the labels while getting the reference to the PHY and we can
catch such cases only by review.

>
>> +	dev_set_drvdata(&phy->dev, priv);
>> +
>> +	ret = dev_set_name(&phy->dev, "%s.%d", dev_name(dev), id);
>> +	if (ret)
>> +		goto err1;
>> +
>> +	ret = device_add(&phy->dev);
>> +	if (ret)
>> +		goto err1;
>> +
>> +	if (pm_runtime_enabled(dev))
>> +		pm_runtime_enable(&phy->dev);
>> +
>> +	return phy;
>> +
>> +err1:
>> +	put_device(&phy->dev);
>> +	kfree(phy);
>> +
>> +err0:
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(phy_create);
>
>> +/**
>> + * phy_destroy() - destroy the phy
>> + * @phy: the phy to be destroyed
>> + *
>> + * Called to destroy the phy.
>> + */
>> +void phy_destroy(struct phy *phy)
>> +{
>> +	pm_runtime_disable(&phy->dev);
>> +	device_unregister(&phy->dev);
>
> Isn't kfree(phy); missing here ?

Not actually. Its done in phy_release (class's dev_release method)

Thanks
Kishon
