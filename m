From: noralf@tronnes.org (=?UTF-8?B?Tm9yYWxmIFRyw7hubmVz?=)
Date: Fri, 29 May 2015 05:18:05 +0200
Subject: [PATCH v5 2/3] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <1432858055-8750-2-git-send-email-eric@anholt.net>
References: <1432858055-8750-1-git-send-email-eric@anholt.net>
 <1432858055-8750-2-git-send-email-eric@anholt.net>
Message-ID: <5567DA6D.8080207@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 29.05.2015 02:07, skrev Eric Anholt:
> This gives us a function for making mailbox property channel requests
> of the firmware, which is most notable in that it will let us get and
> set clock rates.
...
> +/**
> + * rpi_firmware_property_list - Submit firmware property list
> + * @of_node:	Pointer to the firmware Device Tree node.

Update kdoc to reflect change:
  * @fw: Pointer to firmware structure

> + * @data:	Buffer holding tags.
> + * @tag_size:	Size of tags buffer.
> + *
> + * Submits a set of concatenated tags to the VPU firmware through the
> + * mailbox property interface.
> + *
> + * The buffer header and the ending tag are added by this function and
> + * don't need to be supplied, just the actual tags for your operation.
> + * See struct rpi_firmware_property_tag_header for the per-tag
> + * structure.
> + */
> +int rpi_firmware_property_list(struct rpi_firmware *fw,
> +			       void *data, size_t tag_size)
> +{
...

> +/**
> + * rpi_firmware_property - Submit single firmware property
> + * @of_node:	Pointer to the firmware Device Tree node.

Same:
  * @fw: Pointer to firmware structure

> + * @tag:	One of enum_mbox_property_tag.
> + * @tag_data:	Tag data buffer.
> + * @buf_size:	Buffer size.
> + *
> + * Submits a single tag to the VPU firmware through the mailbox
> + * property interface.
> + *
> + * This is a convenience wrapper around
> + * rpi_firmware_property_list() to avoid some of the
> + * boilerplate in property calls.
> + */
> +int rpi_firmware_property(struct rpi_firmware *fw,
> +			  u32 tag, void *tag_data, size_t buf_size)
> +{
...

> +/*
> + * Returns the struct rpi_firmware if the firmware device is probed
> + * and available, otherwise NULL.
> + */

kdoc:
/**
  * rpi_firmware_get - Get pointer to rpi_firmware structure.
  * @of_node:    Pointer to the firmware Device Tree node.
  *
  * Returns NULL is the firmware device is not ready.
  */

> +struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
> +{
> +	struct platform_device *pdev = of_find_device_by_node(firmware_node);
> +
> +	if (!pdev)
> +		return NULL;
> +
> +	if (!pdev->dev.driver)
> +		return NULL;
> +
> +	if (!try_module_get(pdev->dev.driver->owner))
> +		return NULL;
> +

Sigh, I think I was wrong about suggesting try_module_get here. A module 
can't be
unloaded if another loaded module depends on one it's exported symbols.
So this firmware module can't be unloaded if a client module is loaded.
So it shouldn't be necessary.

> +	return platform_get_drvdata(pdev);
> +}
> +EXPORT_SYMBOL_GPL(rpi_firmware_get);
> +
> +void rpi_firmware_put(struct rpi_firmware *fw)
> +{
> +	struct device *dev = fw->cl.dev;
> +
> +	module_put(dev->driver->owner);
> +}
> +EXPORT_SYMBOL_GPL(rpi_firmware_put);

So rpi_firmware_put() won't be needed then, sorry.

However the API feels much better now with this change.
