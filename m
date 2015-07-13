From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 13 Jul 2015 18:50:29 +0200
Subject: [PATCH v7 1/9] nvmem: Add a simple NVMEM framework for nvmem
 providers
In-Reply-To: <1436521486-10682-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1436521427-10568-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1436521486-10682-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1436806229.11945.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

Am Freitag, den 10.07.2015, 10:44 +0100 schrieb Srinivas Kandagatla:
> This patch adds just providers part of the framework just to enable easy
> review.
[...]
> +/**
> + * nvmem_register() - Register a nvmem device for given nvmem_config.
> + * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
> + *
> + * @config: nvmem device configuration with which nvmem device is created.
> + *
> + * The return value will be an ERR_PTR() on error or a valid pointer
> + * to nvmem_device.
> + */
> +
> +struct nvmem_device *nvmem_register(struct nvmem_config *config)
> +{
[...]
> +	nvmem->read_only = nvmem->dev.of_node ?
> +				of_property_read_bool(nvmem->dev.of_node,
> +				"read-only") :
> +				config->read_only;

I think read_only should be set if any of the device node property or
nvmem_config->read_only request it. That way, even if the nvmem is
theoretically writeable (no read-only property in DT), the driver still
can make it read-only if writing isn't implemented:

+	nvmem->read_only = nvmem->dev.of_node ?
+				of_property_read_bool(nvmem->dev.of_node,
+				"read-only") : 0;
+	nvmem->read_only |= config->read_only;

[...]
> new file mode 100644
> index 0000000..f589d3b
> --- /dev/null
> +++ b/include/linux/nvmem-provider.h
[...]
> +struct nvmem_config {
> +	struct device		*dev;
> +	const char		*name;
> +	int			id;
> +	struct module		*owner;
> +	struct nvmem_cell_info	*cells;

Should that be const?

> +	int			ncells;
> +	bool			read_only;
> +};
> +
> +#if IS_ENABLED(CONFIG_NVMEM)
> +
> +struct nvmem_device *nvmem_register(struct nvmem_config *cfg);

Then that could be made const, too.

best regards
Philipp
