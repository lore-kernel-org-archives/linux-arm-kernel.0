From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 24 Jun 2015 10:54:30 +0100
Subject: [PATCH v6 1/9] nvmem: Add a simple NVMEM framework for nvmem
 providers
In-Reply-To: <982684639.251832.1435090259373.JavaMail.open-xchange@oxbsltgw00.schlund.de>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435014507-26181-1-git-send-email-srinivas.kandagatla@linaro.org>
 <982684639.251832.1435090259373.JavaMail.open-xchange@oxbsltgw00.schlund.de>
Message-ID: <558A7E56.9060006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/06/15 21:10, Stefan Wahren wrote:
> Hi Srinivas,
>
> sorry for the messed up indention.
>
NP,
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/export.h>
>> +#include <linux/fs.h>
>> +#include <linux/idr.h>
>> +#include <linux/init.h>
>> +#include <linux/regmap.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>
> Sorting alphabetically would by nice
>
Good Idea.

>> + [...]
>> +/**
>> + * nvmem_register() - Register a nvmem device for given nvmem_config.
>> + * Also creates an binary entry in /sys/class/nvmem/dev-name/nvmem
>> + *
>> + * @config: nvmem device configuration with which nvmem device is created.
>> + *
>> + * The return value will be an ERR_PTR() on error or a valid pointer
>> + * to nvmem_device.
>> + */
>> +
>> +struct nvmem_device *nvmem_register(struct nvmem_config *config)
>> +{
>> + struct nvmem_device *nvmem;
>> + struct regmap *rm;
>> + int rval;
>> +
>> + if (!config->dev)
>> + return ERR_PTR(-EINVAL);
>> +
>> + rm = dev_get_regmap(config->dev, NULL);
>> + if (!rm) {
>> + dev_err(config->dev, "Regmap not found\n");
>> + return ERR_PTR(-EINVAL);
>> + }
>> +
>> + nvmem = kzalloc(sizeof(*nvmem), GFP_KERNEL);
>> + if (!nvmem)
>> + return ERR_PTR(-ENOMEM);
>> +
>> + nvmem->id = ida_simple_get(&nvmem_ida, 0, 0, GFP_KERNEL);
>> + if (nvmem->id < 0) {
>> + kfree(nvmem);
>> + return ERR_PTR(nvmem->id);
>> + }
>> +
>> + nvmem->regmap = rm;
>> + nvmem->owner = config->owner;
>> + nvmem->stride = regmap_get_reg_stride(rm);
>> + nvmem->word_size = regmap_get_val_bytes(rm);
>> + nvmem->size = regmap_get_max_register(rm) + nvmem->stride;
>> + nvmem->dev.class = &nvmem_class;
>> + nvmem->dev.parent = config->dev;
>> + nvmem->dev.of_node = config->dev->of_node;
>> + dev_set_name(&nvmem->dev, "%s%d",
>> + config->name ? : "nvmem", config->id);
>> +
>> + nvmem->read_only = nvmem->dev.of_node ?
>> + of_property_read_bool(nvmem->dev.of_node,
>> + "read-only") :
>> + config->read_only;
>> +
>> + device_initialize(&nvmem->dev);
>> +
>> + dev_dbg(&nvmem->dev, "Registering nvmem device %s\n",
>> + dev_name(&nvmem->dev));
>> +
>> + rval = device_add(&nvmem->dev);
>> + if (rval) {
>> + ida_simple_remove(&nvmem_ida, nvmem->id);
>> + kfree(nvmem);
>> + return ERR_PTR(rval);
>> + }
>> +
>> + /* update sysfs attributes */
>> + if (nvmem->read_only)
>> + sysfs_update_group(&nvmem->dev.kobj, &nvmem_bin_ro_group);
>> +
>> + if (config->cells)
>> + nvmem_add_cells(nvmem, config);
>
> I think this would be a better place for the debug message from above.
> Additionally we could add the cell count and so on.
I will give it a try.

thanks,
srini
>
> Stefan
>
