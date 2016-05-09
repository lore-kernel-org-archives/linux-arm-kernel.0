From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 09 May 2016 11:31:52 +0200
Subject: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
In-Reply-To: <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
Message-ID: <s5hk2j38tmf.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 30 Apr 2016 23:15:34 +0200,
Robert Jarzmik wrote:
> 
> diff --git a/include/sound/ac97/codec.h b/include/sound/ac97/codec.h
> new file mode 100644
> index 000000000000..4b8b3e570892
> --- /dev/null
> +++ b/include/sound/ac97/codec.h
> @@ -0,0 +1,98 @@
> +/*
> + *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef AC97_CODEC_H
> +#define AC97_CODEC_H

Let's be careful about the choice of the guard.


> +
> +#include <linux/device.h>
> +
> +#define AC97_ID(vendor_id1, vendor_id2) \
> +	(((vendor_id1 & 0xffff) << 16) | (vendor_id2 & 0xffff))
> +#define AC97_DRIVER_ID(vendor_id1, vendor_id2, mask_id1, mask_id2, _data) \
> +	{ .id = ((vendor_id1 & 0xffff) << 16) | (vendor_id2 & 0xffff), \
> +	  .mask = ((mask_id1 & 0xffff) << 16) | (mask_id2 & 0xffff), \
> +	  .data = _data }

Give parentheses around the macro arguments.


> +
> +#define to_ac97_device(d) container_of(d, struct ac97_codec_device, dev)
> +#define to_ac97_driver(d) container_of(d, struct ac97_codec_driver, driver)
> +
> +struct ac97_controller;
> +
> +/**
> + * struct ac97_id - matches a codec device and driver on an ac97 bus
> + * @id: The significant bits if the codec vendor ID1 and ID2
> + * @mask: Bitmask specifying which bits of the id field are significant when
> + *	  matching. A driver binds to a device when :
> + *        ((vendorID1 << 8 | vendorID2) & (mask_id1 << 8 | mask_id2)) == id.
> + * @data: Private data used by the driver.
> + */
> +struct ac97_id {
> +	unsigned int		id;
> +	unsigned int		mask;
> +	void			*data;
> +};
> +
> +/**
> + * ac97_codec_device - a ac97 codec
> + * @dev: the code device
> + * @vendor_id: the vendor_id of the codec, as sensed on the AC-link
> + * @num: the codec number, 0 is primary, 1 is first slave, etc ...
> + * @ac97_ctrl: ac97 digital controller on the same AC-link
> + *
> + * This is the device instanciated for each codec living on a AC-link. There are
> + * normally 0 to 4 codec devices per AC-link, and all of them are controlled by
> + * an AC97 digital controller.
> + */
> +struct ac97_codec_device {
> +	struct device		dev;	/* Must stay first member */

This doesn't have to be the first element as long as you use container_of().


> +	unsigned int		vendor_id;
> +	unsigned int		num;
> +	struct list_head	list;
> +	struct ac97_controller	*ac97_ctrl;
> +};
> +
> +/**
> + * ac97_codec_driver - a ac97 codec driver
> + * @driver: the device driver structure
> + * @probe: the function called when a ac97_codec_device is matched
> + * @remove: the function called when the device is unbound/removed
> + * @suspend: suspend function (might be NULL)
> + * @resume: resume function (might be NULL)
> + * @shutdown: shutdown function (might be NULL)
> + * @id_table: ac97 vendor_id match table, { } member terminated
> + */
> +struct ac97_codec_driver {
> +	struct device_driver	driver;
> +	int			(*probe)(struct ac97_codec_device *);
> +	int			(*remove)(struct ac97_codec_device *);
> +	int			(*suspend)(struct ac97_codec_device *);
> +	int			(*resume)(struct ac97_codec_device *);
> +	void			(*shutdown)(struct ac97_codec_device *);
> +	struct ac97_id		*id_table;

Missing const?

> +};
> +
> +int ac97_codec_driver_register(struct ac97_codec_driver *drv);
> +void ac97_codec_driver_unregister(struct ac97_codec_driver *drv);
> +
> +static inline struct device *
> +ac97_codec_dev2dev(const struct ac97_codec_device *adev)
> +{
> +	return (struct device *)(adev);

What's wrong with the simple &adev->dev ?  Cast looks scary.

> +}
> +
> +static inline void *ac97_get_drvdata(const struct ac97_codec_device *adev)
> +{
> +	return dev_get_drvdata(ac97_codec_dev2dev(adev));
> +}
> +
> +static inline void ac97_set_drvdata(const struct ac97_codec_device *adev,
> +				    void *data)
> +{
> +	dev_set_drvdata(ac97_codec_dev2dev(adev), data);
> +}
> +
> +#endif
> diff --git a/include/sound/ac97/compat.h b/include/sound/ac97/compat.h
> new file mode 100644
> index 000000000000..bf611f572f2d
> --- /dev/null
> +++ b/include/sound/ac97/compat.h
> @@ -0,0 +1,21 @@
> +/*
> + *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This file is for backward compatibility with snd_ac97 structure and its
> + * multiple usages, such as the snd_ac97_bus and snd_ac97_build_ops.
> + *
> + */
> +#ifndef AC97_COMPAT_H
> +#define AC97_COMPAT_H
> +
> +#include <sound/ac97_codec.h>
> +#include <sound/soc.h>
> +
> +struct snd_ac97 *compat_alloc_snd_ac97_codec(struct snd_soc_codec *codec);
> +void compat_release_snd_ac97_codec(struct snd_ac97 *ac97);
> +
> +#endif
> diff --git a/include/sound/ac97/controller.h b/include/sound/ac97/controller.h
> new file mode 100644
> index 000000000000..f1e5e645f5ef
> --- /dev/null
> +++ b/include/sound/ac97/controller.h
> @@ -0,0 +1,39 @@
> +/*
> + *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef AC97_CONTROLLER_H
> +#define AC97_CONTROLLER_H
> +
> +#include <linux/list.h>
> +
> +struct device;
> +struct ac97_codec_device;
> +
> +struct ac97_controller_ops {
> +	void (*reset)(struct ac97_codec_device *ac97);
> +	void (*warm_reset)(struct ac97_codec_device *ac97);
> +	int (*write)(struct ac97_codec_device *ac97, unsigned short reg,
> +		     unsigned short val);
> +	int (*read)(struct ac97_codec_device *ac97, unsigned short reg);
> +	void (*wait)(struct ac97_codec_device *ac97);
> +	void (*init)(struct ac97_codec_device *ac97);
> +};
> +
> +struct ac97_controller {
> +	const struct ac97_controller_ops *ops;
> +	struct list_head controllers;
> +	struct device *dev;
> +	int bus_idx;

What is this bus_idx for?


> +	int bound_codecs;
> +	struct list_head codecs;
> +};
> +
> +int ac97_digital_controller_register(const struct ac97_controller_ops *ops,
> +				     struct device *dev);
> +int ac97_digital_controller_unregister(const struct device *dev);
> +
> +#endif
> diff --git a/sound/ac97/Kconfig b/sound/ac97/Kconfig
> new file mode 100644
> index 000000000000..fd2c2d031e62
> --- /dev/null
> +++ b/sound/ac97/Kconfig
> @@ -0,0 +1,9 @@
> +#
> +# PCI configuration
> +#
 
Still only for PCI? :)


> +
> +config AC97
> +	bool "AC97 bus"
> +	help
> +	   Say Y here if you want to have AC97 devices, which are sound oriented
> +	   devices around an AC-Link.
> diff --git a/sound/ac97/Makefile b/sound/ac97/Makefile
> new file mode 100644
> index 000000000000..5575909d46e2
> --- /dev/null
> +++ b/sound/ac97/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# make for AC97 bus drivers
> +#
> +
> +obj-y	+= bus.o codec.o snd_ac97_compat.o

No possibility for modules?


> diff --git a/sound/ac97/ac97_core.h b/sound/ac97/ac97_core.h
> new file mode 100644
> index 000000000000..db6e27288357
> --- /dev/null
> +++ b/sound/ac97/ac97_core.h
> @@ -0,0 +1,10 @@
> +/*
> + * Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +unsigned int ac97_bus_scan_one(struct ac97_controller *ac97,
> +			       int codec_num);
> diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
> new file mode 100644
> index 000000000000..f9bf5632d4aa
> --- /dev/null
> +++ b/sound/ac97/bus.c
> @@ -0,0 +1,330 @@
> +/*
> + * Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <sound/ac97/codec.h>
> +#include <sound/ac97/controller.h>
> +#include <sound/ac97/regs.h>
> +
> +#define AC97_BUS_MAX_CODECS 4
> +
> +/*
> + * Protects ac97_controllers and each ac97_controller structure.
> + */
> +static DEFINE_MUTEX(ac97_controllers_mutex);
> +static LIST_HEAD(ac97_controllers);
> +static int ac97_bus_idx;
> +
> +struct bus_type ac97_bus_type;
> +
> +static struct ac97_codec_device *
> +ac97_codec_find(struct ac97_controller *ac97_ctrl, int codec_num)
> +{
> +	struct ac97_codec_device *codec;
> +
> +	list_for_each_entry(codec, &ac97_ctrl->codecs, list)
> +		if (codec->num == codec_num)
> +			return codec;
> +
> +	return NULL;
> +}

It's a question whether we need to manage the codecs in the linked
list.  There can be at most 4 codecs, so it fits in an array well,
too.  Then some codes like this would be simpler. (And it'll even
reduce the footprint, too.)


> +
> +static void ac97_codec_release(struct device *dev)
> +{
> +	struct ac97_codec_device *codec;
> +
> +	codec = container_of(dev, struct ac97_codec_device, dev);
> +	list_del(&codec->list);
> +	kfree(codec);
> +}
> +
> +static int ac97_codec_add(struct ac97_controller *ac97_ctrl, int idx,
> +		   unsigned int vendor_id)
> +{
> +	struct ac97_codec_device *codec;
> +	char *codec_name;
> +	int ret;
> +
> +	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
> +	if (!codec)
> +		return -ENOMEM;
> +
> +	codec->vendor_id = vendor_id;
> +	codec->dev.release = ac97_codec_release;
> +	codec->dev.bus = &ac97_bus_type;
> +	codec->dev.parent = ac97_ctrl->dev;
> +	codec->num = idx;
> +	codec->ac97_ctrl = ac97_ctrl;
> +	INIT_LIST_HEAD(&codec->list);
> +	list_move_tail(&codec->list, &ac97_ctrl->codecs);
> +
> +	codec_name = kasprintf(GFP_KERNEL, "%s:%d", dev_name(ac97_ctrl->dev),
> +			       idx);
> +	codec->dev.init_name = codec_name;
> +
> +	ret = device_register(&codec->dev);
> +	kfree(codec_name);
> +
> +	return ret;
> +}
> +
> +unsigned int ac97_bus_scan_one(struct ac97_controller *ac97,
> +				      int codec_num)
> +{
> +	struct ac97_codec_device codec;
> +	unsigned short vid1, vid2;
> +	int ret;
> +
> +	codec.dev = *ac97->dev;
> +	codec.num = codec_num;
> +	ret = ac97->ops->read(&codec, AC97_VENDOR_ID1);
> +	vid1 = (ret & 0xffff);
> +	if (ret < 0)
> +		return 0;

Hmm.  This looks pretty hackish and dangerous.



> +	ret = ac97->ops->read(&codec, AC97_VENDOR_ID2);
> +	vid2 = (ret & 0xffff);
> +	if (ret < 0)
> +		return 0;
> +
> +	dev_dbg(&codec.dev, "%s(codec_num=%d): vendor_id=0x%08x\n",
> +		__func__, codec_num, AC97_ID(vid1, vid2));
> +	return AC97_ID(vid1, vid2);
> +}
> +
> +static int ac97_bus_scan(struct ac97_controller *ac97_ctrl)
> +{
> +	int ret, i;
> +	unsigned int vendor_id;
> +
> +	for (i = 0; i < AC97_BUS_MAX_CODECS; i++) {
> +		if (ac97_codec_find(ac97_ctrl, i))
> +			continue;
> +		vendor_id = ac97_bus_scan_one(ac97_ctrl, i);
> +		if (!vendor_id)
> +			continue;
> +
> +		ret = ac97_codec_add(ac97_ctrl, i, vendor_id);
> +		if (ret < 0)
> +			return ret;

This is one of concerns: we don't know whether the device really
reacts well if you access to a non-existing slot.  At least, it'd be
safer to have the masks for the devices we already know the slots.


> +	}
> +	return 0;
> +}
> +
> +void ac97_rescan_all_controllers(void)
> +{
> +	struct ac97_controller *ac97_ctrl;
> +	int ret;
> +
> +	mutex_lock(&ac97_controllers_mutex);
> +	list_for_each_entry(ac97_ctrl, &ac97_controllers, controllers) {
> +		ret = ac97_bus_scan(ac97_ctrl);
> +		if (ret)
> +			dev_warn(ac97_ctrl->dev, "scan failed: %d\n", ret);
> +	}
> +	mutex_unlock(&ac97_controllers_mutex);
> +}
> +EXPORT_SYMBOL(ac97_rescan_all_controllers);
> +
> +static int ac97_bus_reset(struct ac97_controller *ac97_ctrl)
> +{
> +	struct ac97_codec_device codec;
> +
> +	memset(&codec, 0, sizeof(codec));
> +	codec.dev = *ac97_ctrl->dev;
> +
> +	ac97_ctrl->ops->reset(&codec);

So, this assumes that reset ops is mandatory?  Then document it at
least.


thanks,

Takashi

> +	return 0;
> +}
> +
> +/**
> + * ac97_codec_driver_register - register an AC97 codec driver
> + * @dev: AC97 driver codec to register
> + *
> + * Register an AC97 codec driver to the ac97 bus driver, aka. the AC97 digital
> + * controller.
> + *
> + * Returns 0 on success or error code
> + */
> +int ac97_codec_driver_register(struct ac97_codec_driver *drv)
> +{
> +	int ret;
> +
> +	drv->driver.bus = &ac97_bus_type;
> +
> +	ret = driver_register(&drv->driver);
> +	if (!ret)
> +		ac97_rescan_all_controllers();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(ac97_codec_driver_register);
> +
> +/**
> + * ac97_codec_driver_unregister - unregister an AC97 codec driver
> + * @dev: AC97 codec driver to unregister
> + *
> + * Unregister a previously registered ac97 codec driver.
> + */
> +void ac97_codec_driver_unregister(struct ac97_codec_driver *drv)
> +{
> +	driver_unregister(&drv->driver);
> +}
> +EXPORT_SYMBOL(ac97_codec_driver_unregister);
> +
> +static int ac97_dc_codecs_unregister(struct ac97_controller *ac97_ctrl)
> +{
> +	struct ac97_codec_device *codec, *tmp;
> +
> +	list_for_each_entry_safe(codec, tmp, &ac97_ctrl->codecs, list)
> +		put_device(&codec->dev);
> +
> +	return 0;
> +}
> +
> +/**
> + * ac97_digital_controller_register - register an ac97 controller
> + * @ops: the ac97 bus operations
> + * @dev: the device providing the ac97 DC function
> + *
> + * Register a digital controller which can control up to 4 ac97 codecs. This is
> + * the controller side of the AC97 AC-link, while the slave side are the codecs.
> + *
> + * Returns a positive bus index upon success, negative value upon error
> + */
> +int ac97_digital_controller_register(const struct ac97_controller_ops *ops,
> +				     struct device *dev)
> +{
> +	struct ac97_controller *ac97_ctrl;
> +
> +	ac97_ctrl = kzalloc(sizeof(*ac97_ctrl), GFP_KERNEL);
> +	if (!ac97_ctrl)
> +		return -ENOMEM;
> +
> +	mutex_lock(&ac97_controllers_mutex);
> +	ac97_ctrl->ops = ops;
> +	ac97_ctrl->bus_idx = ac97_bus_idx++;
> +	ac97_ctrl->dev = dev;
> +	INIT_LIST_HEAD(&ac97_ctrl->codecs);
> +	list_add(&ac97_ctrl->controllers, &ac97_controllers);
> +	mutex_unlock(&ac97_controllers_mutex);
> +
> +	ac97_bus_reset(ac97_ctrl);
> +	ac97_bus_scan(ac97_ctrl);
> +
> +	return ac97_ctrl->bus_idx;
> +}
> +EXPORT_SYMBOL(ac97_digital_controller_register);
> +
> +/**
> + * ac97_digital_controller_unregister - unregister an ac97 controller
> + * @dev: the device previously provided to ac97_digital_controller_register()
> + *
> + * Returns 0 on success, negative upon error
> + */
> +int ac97_digital_controller_unregister(const struct device *dev)
> +{
> +	struct ac97_controller *ac97_ctrl, *tmp;
> +	int ret = -ENODEV;
> +
> +	mutex_lock(&ac97_controllers_mutex);
> +	list_for_each_entry_safe(ac97_ctrl, tmp, &ac97_controllers,
> +				 controllers) {
> +		if (ac97_ctrl->dev != dev)
> +			continue;
> +		if (ac97_ctrl->bound_codecs)
> +			ret = -EBUSY;
> +		else
> +			ret = ac97_dc_codecs_unregister(ac97_ctrl);
> +		if (!ret)
> +			list_del(&ac97_ctrl->controllers);
> +	}
> +
> +	mutex_unlock(&ac97_controllers_mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ac97_digital_controller_unregister);
> +
> +static const struct dev_pm_ops ac97_pm = {
> +	.suspend	= pm_generic_suspend,
> +	.resume		= pm_generic_resume,
> +	.freeze		= pm_generic_freeze,
> +	.thaw		= pm_generic_thaw,
> +	.poweroff	= pm_generic_poweroff,
> +	.restore	= pm_generic_restore,
> +};
> +
> +static ssize_t vendor_id_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct ac97_codec_device *codec = to_ac97_device(dev);
> +
> +	return sprintf(buf, "%08x", codec->vendor_id);
> +}
> +
> +static struct device_attribute ac97_dev_attrs[] = {
> +	__ATTR_RO(vendor_id),
> +	__ATTR_NULL,
> +};
> +
> +int ac97_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct ac97_codec_device *adev = to_ac97_device(dev);
> +	struct ac97_codec_driver *adrv = to_ac97_driver(drv);
> +	struct ac97_id *id = adrv->id_table;
> +
> +	if (adev->vendor_id == 0x0 || adev->vendor_id == 0xffffffff)
> +		return false;
> +
> +	do {
> +		if ((id->id & id->mask) == (adev->vendor_id & id->mask))
> +			return true;
> +	} while (++id->id);
> +
> +	return false;
> +}
> +
> +static int ac97_bus_probe(struct device *dev)
> +{
> +	struct ac97_codec_device *adev = to_ac97_device(dev);
> +	struct ac97_codec_driver *adrv = to_ac97_driver(dev->driver);
> +
> +	return adrv->probe(adev);
> +}
> +
> +static int ac97_bus_remove(struct device *dev)
> +{
> +	struct ac97_codec_device *adev = to_ac97_device(dev);
> +	struct ac97_codec_driver *adrv = to_ac97_driver(dev->driver);
> +
> +	return adrv->remove(adev);
> +}
> +
> +struct bus_type ac97_bus_type = {
> +	.name		= "ac97",
> +	.dev_attrs	= ac97_dev_attrs,
> +	.match		= ac97_bus_match,
> +	.pm		= &ac97_pm,
> +	.probe		= ac97_bus_probe,
> +	.remove		= ac97_bus_remove,
> +};
> +EXPORT_SYMBOL(ac97_bus_type);
> +
> +static int __init ac97_bus_init(void)
> +{
> +	return bus_register(&ac97_bus_type);
> +}
> +subsys_initcall(ac97_bus_init);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
> diff --git a/sound/ac97/codec.c b/sound/ac97/codec.c
> new file mode 100644
> index 000000000000..a835f03744bf
> --- /dev/null
> +++ b/sound/ac97/codec.c
> @@ -0,0 +1,15 @@
> +/*
> + *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <sound/ac97_codec.h>
> +#include <sound/ac97/codec.h>
> +#include <sound/ac97/controller.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <sound/soc.h>	/* For compat_ac97_* */
> +
> diff --git a/sound/ac97/snd_ac97_compat.c b/sound/ac97/snd_ac97_compat.c
> new file mode 100644
> index 000000000000..7e2f01c96fc9
> --- /dev/null
> +++ b/sound/ac97/snd_ac97_compat.c
> @@ -0,0 +1,104 @@
> +/*
> + *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <sound/ac97/codec.h>
> +#include <sound/ac97/controller.h>
> +#include <sound/soc.h>
> +
> +#include "ac97_core.h"
> +
> +static void compat_ac97_reset(struct snd_ac97 *ac97)
> +{
> +	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
> +	struct ac97_controller *actrl = adev->ac97_ctrl;
> +
> +	if (actrl->ops->reset)
> +		actrl->ops->reset(adev);
> +}
> +
> +static void compat_ac97_warm_reset(struct snd_ac97 *ac97)
> +{
> +	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
> +	struct ac97_controller *actrl = adev->ac97_ctrl;
> +
> +	if (actrl->ops->warm_reset)
> +		actrl->ops->warm_reset(adev);
> +}
> +
> +static void compat_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
> +			      unsigned short val)
> +{
> +	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
> +	struct ac97_controller *actrl = adev->ac97_ctrl;
> +
> +	actrl->ops->write(adev, reg, val);
> +}
> +
> +static unsigned short compat_ac97_read(struct snd_ac97 *ac97,
> +				       unsigned short reg)
> +{
> +	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
> +	struct ac97_controller *actrl = adev->ac97_ctrl;
> +
> +	return actrl->ops->read(adev, reg);
> +}
> +
> +static struct snd_ac97_bus_ops compat_snd_ac97_bus_ops = {
> +	.reset = compat_ac97_reset,
> +	.warm_reset = compat_ac97_warm_reset,
> +	.write = compat_ac97_write,
> +	.read = compat_ac97_read,
> +};
> +
> +static struct snd_ac97_bus compat_soc_ac97_bus = {
> +	.ops = &compat_snd_ac97_bus_ops,
> +};
> +
> +struct snd_ac97 *compat_alloc_snd_ac97_codec(struct snd_soc_codec *codec)
> +{
> +	struct snd_ac97 *ac97;
> +
> +	ac97 = kzalloc(sizeof(struct snd_ac97), GFP_KERNEL);
> +	if (ac97 == NULL)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ac97->dev = *codec->dev;
> +	ac97->private_data = codec->dev;
> +	ac97->bus = &compat_soc_ac97_bus;
> +	return ac97;
> +}
> +EXPORT_SYMBOL_GPL(compat_alloc_snd_ac97_codec);
> +
> +void compat_release_snd_ac97_codec(struct snd_ac97 *ac97)
> +{
> +	kfree(ac97);
> +}
> +EXPORT_SYMBOL_GPL(compat_release_snd_ac97_codec);
> +
> +int snd_ac97_reset(struct snd_ac97 *ac97, bool try_warm, unsigned int id,
> +	unsigned int id_mask)
> +{
> +	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
> +	struct ac97_controller *actrl = adev->ac97_ctrl;
> +
> +	if (try_warm) {
> +		compat_ac97_warm_reset(ac97);
> +		if (ac97_bus_scan_one(actrl, adev->num) == adev->vendor_id)
> +			return 1;
> +	}
> +
> +	compat_ac97_reset(ac97);
> +	compat_ac97_warm_reset(ac97);
> +	if (ac97_bus_scan_one(actrl, adev->num) == adev->vendor_id)
> +		return 0;
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(snd_ac97_reset);
> -- 
> 2.1.4
> 
> 
