From: joe@perches.com (Joe Perches)
Date: Fri, 10 Jul 2015 03:49:25 -0700
Subject: [PATCH v7 3/9] nvmem: Add nvmem_device based consumer apis.
In-Reply-To: <1436521505-10779-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1436521427-10568-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1436521505-10779-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1436525365.24866.36.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-07-10 at 10:45 +0100, Srinivas Kandagatla wrote:
> This patch adds read/write apis which are based on nvmem_device.

More trivia:

> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c

> +static struct nvmem_device *nvmem_find(const char *name)
> +{
> +	struct device *d;
> +
> +	d = bus_find_device(&nvmem_bus_type, NULL, (void *)name, nvmem_match);
> +
> +	return d ? to_nvmem_device(d) : NULL;

Maybe:
	d = bus_find_device(...);
	if (!d)
		return NULL;

	return to_nvmem_device(d);

> +struct nvmem_device *of_nvmem_device_get(struct device_node *np, const char *id)
> +{
[]
> +	return __nvmem_device_get(nvmem_np, NULL, NULL);
> +

odd blank line
> +}
> +EXPORT_SYMBOL_GPL(of_nvmem_device_get);

> +struct nvmem_device *nvmem_device_get(struct device *dev, const char *dev_name)
> +{
[]
> +	return nvmem_find(dev_name);
> +

here too

> +}
> +EXPORT_SYMBOL_GPL(nvmem_device_get);

[]

> +void devm_nvmem_device_put(struct device *dev, struct nvmem_device *nvmem)
> +{
> +	int ret;
> +
> +	ret = devres_release(dev, devm_nvmem_device_release,
> +			     devm_nvmem_device_match, nvmem);
> +
> +	WARN_ON(ret);
> +

Last unnecessary blank line I'll mention
(it seems to be the last one anyway)

> +}
> +EXPORT_SYMBOL_GPL(devm_nvmem_device_put);
