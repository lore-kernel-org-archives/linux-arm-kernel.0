From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Tue, 18 Jun 2013 23:22:52 +0200
Subject: [PATCH v7 1/9] drivers: phy: add generic PHY framework
In-Reply-To: <1371113039-5784-2-git-send-email-kishon@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-2-git-send-email-kishon@ti.com>
Message-ID: <51C0CFAC.9080606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

I've noticed there is a little inconsistency between the code and 
documentation.

On 06/13/2013 10:43 AM, Kishon Vijay Abraham I wrote:
> +3. Creating the PHY
> +
> +The PHY driver should create the PHY in order for other peripheral controllers
> +to make use of it. The PHY framework provides 2 APIs to create the PHY.
> +
> +struct phy *phy_create(struct device *dev, int id, const struct phy_ops *ops,
> +	void *priv);
> +struct phy *devm_phy_create(struct device *dev, int id,
> +	const struct phy_ops *ops, void *priv);

The 'label' argument is missing in those function prototypes. It seems the
labels must be unique, I guess this needs to be documented. And do we allow
NULL labels ? If so, then there is probably a check for NULL label needed
in phy_lookup() and if not, then phy_create() should fail when NULL label
is passed ?

> +The PHY drivers can use one of the above 2 APIs to create the PHY by passing
> +the device pointer, id, phy ops and a driver data.
> +phy_ops is a set of function pointers for performing PHY operations such as
> +init, exit, power_on and power_off.

> +/**
> + * phy_create() - create a new phy
> + * @dev: device that is creating the new phy
> + * @id: id of the phy
> + * @ops: function pointers for performing phy operations
> + * @label: label given to the phy
> + * @priv: private data from phy driver
> + *
> + * Called to create a phy using phy framework.
> + */
> +struct phy *phy_create(struct device *dev, u8 id, const struct phy_ops *ops,
> +	const char *label, void *priv)
> +{
> +	int ret;
> +	struct phy *phy;
> +
> +	if (!dev) {
> +		dev_WARN(dev, "no device provided for PHY\n");
> +		ret = -EINVAL;
> +		goto err0;
> +	}
> +
> +	phy = kzalloc(sizeof(*phy), GFP_KERNEL);
> +	if (!phy) {
> +		ret = -ENOMEM;
> +		goto err0;
> +	}
> +
> +	device_initialize(&phy->dev);
> +
> +	phy->dev.class = phy_class;
> +	phy->dev.parent = dev;
> +	phy->dev.of_node = dev->of_node;
> +	phy->id = id;
> +	phy->ops = ops;
> +	phy->label = label;
> +
> +	dev_set_drvdata(&phy->dev, priv);
> +
> +	ret = dev_set_name(&phy->dev, "%s.%d", dev_name(dev), id);
> +	if (ret)
> +		goto err1;
> +
> +	ret = device_add(&phy->dev);
> +	if (ret)
> +		goto err1;
> +
> +	if (pm_runtime_enabled(dev))
> +		pm_runtime_enable(&phy->dev);
> +
> +	return phy;
> +
> +err1:
> +	put_device(&phy->dev);
> +	kfree(phy);
> +
> +err0:
> +	return ERR_PTR(ret);
> +}

Thanks,
Sylwester
