From: joe@perches.com (Joe Perches)
Date: Fri, 10 Jul 2015 03:29:05 -0700
Subject: [PATCH v7 1/9] nvmem: Add a simple NVMEM framework for nvmem
 providers
In-Reply-To: <1436521486-10682-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1436521427-10568-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1436521486-10682-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1436524145.24866.21.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-07-10 at 10:44 +0100, Srinivas Kandagatla wrote:
> This patch adds just providers part of the framework just to enable easy
> review.

Trivial notes:

> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c

> +struct nvmem_device {
> +	const char		*name;
> +	struct regmap		*regmap;
[]
> +struct nvmem_cell {
> +	const char *name;
> +	int			offset;
> +	int			bytes;

It'd be nicer to use consistent indentation for *name
in nvmem_cell

> +static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
> +				    struct bin_attribute *attr,
> +				    char *buf, loff_t pos, size_t count)
> +{
[]
> +	count = count/nvmem->word_size * nvmem->word_size;

maybe rounddown() ?

> +static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
> +				     struct bin_attribute *attr,
> +				     char *buf, loff_t pos, size_t count)
> +{

> +	count = count/nvmem->word_size * nvmem->word_size;

and rounddown() here too ?

> +static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
> +{
> +	struct device *d;
> +
> +	if (!nvmem_np)
> +		return NULL;
> +
> +	d = bus_find_device(&nvmem_bus_type, NULL, nvmem_np, of_nvmem_match);
> +
> +	return d ? to_nvmem_device(d) : NULL;
> +}

Perhaps more common as

	d = bus_find_device(&nvmem_bus_type, NULL, nvmem_np, of_nvmem_match);
	if (!d)
		return NULL;

	return to_nvmem_device(d);
}

> +struct nvmem_device *nvmem_register(struct nvmem_config *config)
> +{
[]
> +	nvmem->read_only = nvmem->dev.of_node ?
> +				of_property_read_bool(nvmem->dev.of_node,
> +				"read-only") :
> +				config->read_only;

odd indentation.
Normally, "read-only" would be aligned with nvmem->dev.of_node,

> +	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n",
> +		dev_name(&nvmem->dev));

Isn't this going to have duplicated dev_name prefix and postfix?

> +	if (device_create_bin_file(&nvmem->dev,
> +				nvmem->read_only ? &bin_attr_ro_nvmem :
> +				&bin_attr_rw_nvmem))
> +		dev_info(&nvmem->dev, "Failed to create sysfs binary file\n");

Is the KERN_LEVEL correct?
Maybe dev_err/notice/warn/dbg?
