From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 29 Sep 2011 20:07:54 -0600
Subject: [PATCH] drivers: create a pin control subsystem v8
In-Reply-To: <1317211419-18472-1-git-send-email-linus.walleij@stericsson.com>
References: <1317211419-18472-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110930020754.GK12606@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 02:03:39PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This creates a subsystem for handling of pin control devices.
> These are devices that control different aspects of package
> pins.

Comments below, some a bit nitpicky, but overall I think it looks
good.  I haven't dug into it nearly deeply enough though.  :-(

[...]
> +/**
> + * Looks up a pin control device matching a certain device name or
> + * pure device pointer.

May as well actually do kerneldoc formatting here on the comment
blocks.

> + */
> +struct pinctrl_dev *get_pctldev_from_dev(struct device *dev,
> +					 const char *devname)
> +{
> +	struct pinctrl_dev *pctldev = NULL;
> +	bool found = false;
> +
> +	mutex_lock(&pinctrldev_list_mutex);
> +	list_for_each_entry(pctldev, &pinctrldev_list, node) {
> +		if (dev &&  &pctldev->dev == dev) {
> +			/* Matched on device pointer */
> +			found = true;
> +			break;
> +		}
> +
> +		if (devname &&
> +		    !strcmp(dev_name(&pctldev->dev), devname)) {
> +			/* Matched on device name */
> +			found = true;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&pinctrldev_list_mutex);
> +
> +	if (found)
> +		return pctldev;
> +
> +	return NULL;
> +}

Nit: I'm not too fond of a single function doing both name and pointer
lookup at the same time.  Presumably the caller would have one or the
other and know what it needs to do.  I'd prefer to see one by-name
function and one by-reference.  I'm not going to make a big deal about
it though.

> +/**
> + * pinctrl_register() - register a pin controller device
> + * @pctldesc: descriptor for this pin controller
> + * @dev: parent device for this pin controller
> + * @driver_data: private pin controller data for this pin controller
> + */
> +struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
> +				    struct device *dev, void *driver_data)
> +{
> +	static atomic_t pinmux_no = ATOMIC_INIT(0);
> +	struct pinctrl_dev *pctldev;
> +	int ret;
> +
> +	if (pctldesc == NULL)
> +		return ERR_PTR(-EINVAL);
> +	if (pctldesc->name == NULL)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* If we're implementing pinmuxing, check the ops for sanity */
> +	if (pctldesc->pmxops) {
> +		ret = pinmux_check_ops(pctldesc->pmxops);
> +		if (ret) {
> +			pr_err("%s pinmux ops lacks necessary functions\n",
> +			       pctldesc->name);
> +			return ERR_PTR(ret);
> +		}
> +	}
> +
> +	pctldev = kzalloc(sizeof(struct pinctrl_dev), GFP_KERNEL);
> +	if (pctldev == NULL)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Initialize pin control device struct */
> +	pctldev->owner = pctldesc->owner;
> +	pctldev->desc = pctldesc;
> +	pctldev->driver_data = driver_data;
> +	INIT_RADIX_TREE(&pctldev->pin_desc_tree, GFP_KERNEL);
> +	spin_lock_init(&pctldev->pin_desc_tree_lock);
> +	INIT_LIST_HEAD(&pctldev->gpio_ranges);
> +	mutex_init(&pctldev->gpio_ranges_lock);
> +
> +	/* Register device with sysfs */
> +	pctldev->dev.parent = dev;
> +	pctldev->dev.bus = &pinctrl_bus;

I don't think there is an actual need for a pinctrl bus type.  There
aren't any drivers that are going to be bound to these things which is
the primary functionality that a bus type provides.  Am I missing
something?

> +	pctldev->dev.type = &pinctrl_type;
> +	dev_set_name(&pctldev->dev, "pinctrl.%d",
> +		     atomic_inc_return(&pinmux_no) - 1);
> +	ret = device_register(&pctldev->dev);
> +	if (ret != 0) {
> +		pr_err("error in device registration\n");
> +		put_device(&pctldev->dev);
> +		kfree(pctldev);
> +		goto out_err;
> +	}
> +	dev_set_drvdata(&pctldev->dev, pctldev);
> +
> +	/* Register all the pins */
> +	pr_debug("try to register %d pins on %s...\n",
> +		 pctldesc->npins, pctldesc->name);
> +	ret = pinctrl_register_pins(pctldev, pctldesc->pins, pctldesc->npins);
> +	if (ret) {
> +		pr_err("error during pin registration\n");
> +		pinctrl_free_pindescs(pctldev, pctldesc->pins,
> +				      pctldesc->npins);
> +		goto out_err;
> +	}
> +
> +	pinctrl_init_device_debugfs(pctldev);
> +	mutex_lock(&pinctrldev_list_mutex);
> +	list_add(&pctldev->node, &pinctrldev_list);
> +	mutex_unlock(&pinctrldev_list_mutex);
> +	pinmux_hog_maps(pctldev);
> +	return pctldev;
> +
> +out_err:
> +	put_device(&pctldev->dev);
> +	kfree(pctldev);

Once a device is initialized, it cannot be kfree()'ed directly.  The
.release method needs to do that.

> +/**
> + * pin_free() - release a single muxed in pin so something else can be muxed in
> + *	instead

Nit: the summary line in kerneldoc should fit on one line.

> +/**
> + * pinmux_register_mappings() - register a set of pinmux mappings
> + * @maps: the pinmux mappings table to register
> + * @num_maps: the number of maps in the mapping table
> + *
> + * Only call this once during initialization of your machine, the function is
> + * tagged as __init and won't be callable after init has completed. The map
> + * passed into this function will be owned by the pinmux core and cannot be
> + * free:d.
> + */
> +int __init
> +pinmux_register_mappings(struct pinmux_map const *maps, unsigned num_maps)

Nit: keep line breaks in the parameter lists.  More grep friendly.

g.
