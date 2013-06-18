From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 12:38:29 +0300
Subject: [PATCH v7 1/9] drivers: phy: add generic PHY framework
In-Reply-To: <1371113039-5784-2-git-send-email-kishon@ti.com>
References: <1371113039-5784-1-git-send-email-kishon@ti.com>
 <1371113039-5784-2-git-send-email-kishon@ti.com>
Message-ID: <20130618093829.GP5461@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 13, 2013 at 02:13:51PM +0530, Kishon Vijay Abraham I wrote:
> +struct phy_provider *of_phy_provider_register(struct device *dev,
> +	struct module *owner, struct phy * (*of_xlate)(struct device *dev,
> +	struct of_phandle_args *args))

I would rename this to __of_phy_provider_register() and in a header
have:

#define of_phy_provider_register(dev, xlate)	\
	__of_phy_provider_register((dev), THIS_MODULE, (xlate))

then your users don't need to remember always passing THIS_MODULE
argument.

> +struct phy_provider *devm_of_phy_provider_register(struct device *dev,
> +	struct module *owner, struct phy * (*of_xlate)(struct device *dev,
> +	struct of_phandle_args *args))

likewise.

> +/**
> + * phy_release() - release the phy
> + * @dev: the dev member within phy
> + *
> + * When the last reference to the device is removed, it is called
> + * from the embedded kobject as release method.
> + */
> +static void phy_release(struct device *dev)
> +{
> +	struct phy *phy;
> +
> +	phy = container_of(dev, struct phy, dev);

I would have a:

#define to_phy(dev)	(container_of((dev), struct phy dev))

somewhere in a header, just for the sake of brevity :-p

> +	dev_dbg(dev, "releasing '%s'\n", dev_name(dev));

make it dev_vdbg() instead.

> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> new file mode 100644
> index 0000000..df0c98a
> --- /dev/null
> +++ b/include/linux/phy/phy.h

[ ... ]

> +static inline int phy_init(struct phy *phy)
> +{
> +	int ret = -ENOTSUPP;
> +
> +	if (!pm_runtime_enabled(&phy->dev))
> +		goto no_pm_runtime;
> +
> +	ret = pm_runtime_get_sync(&phy->dev);
> +	if (ret < 0) {
> +		dev_err(&phy->dev, "get sync failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +no_pm_runtime:

you can avoid this goto if you code as below, note that I'm also solving
a possible unbalanced PM runtime call which would prevent actual
*runtime* suspend of the PHY:

	ret = phy_pm_runtime_get_sync(phy);
	if (ret < 0 && ret != -ENOTSUPP)
		return ret;

	if (phy->ops->init) {
		ret = phy->ops->init(phy);
		if (ret < 0) {
			dev_err(&phy->dev, "failed to initialize --> %d\n", ret);
			goto out;
		}
	}

out:
	/*
	 * In order to avoid unbalanced PM runtime calls, let's make
	 * sure to disable what we might have enabled when entering this
	 * function.
	 */
	 phy_pm_runtime_put(phy);

	return ret;


> +}
> +
> +static inline int phy_exit(struct phy *phy)
> +{
> +	int ret = -ENOTSUPP;
> +
> +	if (phy->ops->exit)
> +		ret = phy->ops->exit(phy);
> +
> +	if (!pm_runtime_enabled(&phy->dev))
> +		goto no_pm_runtime;
> +
> +	ret = pm_runtime_put_sync(&phy->dev);

move your pm runtime wrappers before these calls and you can use them.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/79f608c3/attachment.sig>
