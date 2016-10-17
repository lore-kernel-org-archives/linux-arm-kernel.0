From: atull@opensource.altera.com (atull)
Date: Mon, 17 Oct 2016 15:25:15 -0500
Subject: [PATCH v20 06/10] fpga: add fpga bridge framework
In-Reply-To: <20161017160941.4205-7-atull@opensource.altera.com>
References: <20161017160941.4205-1-atull@opensource.altera.com>
 <20161017160941.4205-7-atull@opensource.altera.com>
Message-ID: <alpine.DEB.2.02.1610171513080.8724@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Oct 2016, Alan Tull wrote:

> +/**
> + * of_fpga_bridge_get - get an exclusive reference to a fpga bridge
> + *
> + * @np: node pointer of a FPGA bridge
> + * @info: fpga image specific information
> + *
> + * Return fpga_bridge struct if successful.
> + * Return -EBUSY if someone already has a reference to the bridge.
> + * Return -ENODEV if @np is not a FPGA Bridge.
> + */
> +struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
> +				       struct fpga_image_info *info)
> +
> +{
> +	struct device *dev;
> +	struct fpga_bridge *bridge;
> +	int ret = -ENODEV;
> +
> +	of_node_get(np);

I thought I had fixed this.  This of_node_get is unmatched,
never called in fpga_bridge_put.  And it's not necessary
since class_find_device will do kobject_get on the child
device anyway.  So I should remove this of_node_get
and the of_node_put below.

> +
> +	dev = class_find_device(fpga_bridge_class, NULL, np,
> +				fpga_bridge_of_node_match);
> +	if (!dev)
> +		goto err_dev;
> +
> +	bridge = to_fpga_bridge(dev);
> +	if (!bridge)
> +		goto err_dev;
> +
> +	bridge->info = info;
> +
> +	if (!mutex_trylock(&bridge->mutex)) {
> +		ret = -EBUSY;
> +		goto err_dev;
> +	}
> +
> +	if (!try_module_get(dev->parent->driver->owner))
> +		goto err_ll_mod;
> +
> +	dev_dbg(&bridge->dev, "get\n");
> +
> +	return bridge;
> +
> +err_ll_mod:
> +	mutex_unlock(&bridge->mutex);
> +err_dev:
> +	put_device(dev);
> +	of_node_put(np);

Remove of_node_put.

> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(of_fpga_bridge_get);
> +
> +/**
> + * fpga_bridge_put - release a reference to a bridge
> + *
> + * @bridge: FPGA bridge
> + */
> +void fpga_bridge_put(struct fpga_bridge *bridge)
> +{
> +	dev_dbg(&bridge->dev, "put\n");
> +
> +	bridge->info = NULL;
> +	module_put(bridge->dev.parent->driver->owner);
> +	mutex_unlock(&bridge->mutex);
> +	put_device(&bridge->dev);
> +}
> +EXPORT_SYMBOL_GPL(fpga_bridge_put);
