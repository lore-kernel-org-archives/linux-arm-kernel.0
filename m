From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 17:54:11 -0600
Subject: [PATCH v5 1/6] drivers: phy: add generic PHY framework
In-Reply-To: <1364993634-6378-2-git-send-email-kishon@ti.com>
References: <1364993634-6378-1-git-send-email-kishon@ti.com>
 <1364993634-6378-2-git-send-email-kishon@ti.com>
Message-ID: <515CC123.4060402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 06:53 AM, Kishon Vijay Abraham I wrote:
> The PHY framework provides a set of APIs for the PHY drivers to
> create/destroy a PHY and APIs for the PHY users to obtain a reference to the
> PHY with or without using phandle. To obtain a reference to the PHY without
> using phandle, the platform specfic intialization code (say from board file)
> should have already called phy_bind with the binding information. The binding
> information consists of phy's device name, phy user device name and an index.
> The index is used when the same phy user binds to mulitple phys.
> 
> PHY drivers should create the PHY by passing phy_descriptor that has
> describes the PHY (label, type etc..) and ops like init, exit, suspend, resume,
> power_on, power_off.
> 
> The documentation for the generic PHY framework is added in
> Documentation/phy.txt and the documentation for the sysfs entry is added
> in Documentation/ABI/testing/sysfs-class-phy and the documentation for
> dt binding is can be found at
> Documentation/devicetree/bindings/phy/phy-bindings.txt

> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h

> +extern struct phy *devm_phy_create(struct device *dev, const char *label,
> +	struct device_node *of_node, int type, struct phy_ops *ops,
> +	void *priv);

Can't the function get of_node from dev->of_node?

I wonder if we shouldn't split up the registration a bit though:

A function which registers a PHY object itself. That's the function above.

A function which registers a DT-based PHY provider.

Then, the of_xlate op would be part of the PHY provider, not part of
some random PHY that happens to exist on that node. So:

struct phy {
	struct device *dev;
	struct module *owner;
	int	(*init)(struct phy *phy);
	int	(*exit)(struct phy *phy);
	int	(*suspend)(struct phy *phy);
	int	(*resume)(struct phy *phy);
	int	(*power_on)(struct phy *phy);
	int	(*power_off)(struct phy *phy);
};

int phy_register(struct phy *phy);

All PHY providers would use that API, whether running in a DT-base
system or not.

struct of_phy_provider {
	struct device *dev;
	struct phy * (*of_xlate)(struct of_phy_provider *provider,
			struct of_phandle_args *args);
};

int phy_register_of_provider(struct of_phy_provider *provider);

Only DT-based PHY providers would use that API.

... or something like that?

phy_get() would do something like:

	if dev->of_node:
		# look up using registerd of_phy_providers
		phy = phy_get_of(...)
		if phy: return phy
	# now look up using whatever other mapping table exists
	phy = ...
	return phy
