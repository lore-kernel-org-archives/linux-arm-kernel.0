From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 14 May 2016 11:50:50 +0200
Subject: [RFC PATCH 2/7] ALSA: ac97: add an ac97 bus
In-Reply-To: <s5hk2j38tmf.wl-tiwai@suse.de> (Takashi Iwai's message of "Mon,
 09 May 2016 11:31:52 +0200")
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-3-git-send-email-robert.jarzmik@free.fr>
 <s5hk2j38tmf.wl-tiwai@suse.de>
Message-ID: <87twi1hssl.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Takashi Iwai <tiwai@suse.de> writes:

> On Sat, 30 Apr 2016 23:15:34 +0200,
> Robert Jarzmik wrote:
>> 
>> diff --git a/include/sound/ac97/codec.h b/include/sound/ac97/codec.h
>> new file mode 100644
>> index 000000000000..4b8b3e570892
>> --- /dev/null
>> +++ b/include/sound/ac97/codec.h
>> @@ -0,0 +1,98 @@
>> +/*
>> + *  Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +#ifndef AC97_CODEC_H
>> +#define AC97_CODEC_H
>
> Let's be careful about the choice of the guard.
Ok, would _SND_AC97_CODEC_H be better ?

>> +#define AC97_ID(vendor_id1, vendor_id2) \
>> +	(((vendor_id1 & 0xffff) << 16) | (vendor_id2 & 0xffff))
>> +#define AC97_DRIVER_ID(vendor_id1, vendor_id2, mask_id1, mask_id2, _data) \
>> +	{ .id = ((vendor_id1 & 0xffff) << 16) | (vendor_id2 & 0xffff), \
>> +	  .mask = ((mask_id1 & 0xffff) << 16) | (mask_id2 & 0xffff), \
>> +	  .data = _data }
>
> Give parentheses around the macro arguments.
Right, for RFC v2.

>> +struct ac97_codec_device {
>> +	struct device		dev;	/* Must stay first member */
>
> This doesn't have to be the first element as long as you use container_of().
Ah yes, that's a leftover from a former idea, I'll remove that comment.

In the initial code I'd done "struct ac97_codec_device" was hidden from this
file (ie. there was only a "struct ac97_codec_device;" statement), the body of
the struct was contained in sound/ac97/ac97_core.h.

The only provided macro to access the "struct device" inside "struct
ac97_codec_device" was relying on this "trick" (that's a bit like in the
video4linux area).

Anyway, good point, I'll remove that.

>> +struct ac97_codec_driver {
>> +	struct device_driver	driver;
>> +	int			(*probe)(struct ac97_codec_device *);
>> +	int			(*remove)(struct ac97_codec_device *);
>> +	int			(*suspend)(struct ac97_codec_device *);
>> +	int			(*resume)(struct ac97_codec_device *);
>> +	void			(*shutdown)(struct ac97_codec_device *);
>> +	struct ac97_id		*id_table;
>
> Missing const?
Ah no, unfortunately not, or rather not yet.

I tried that one, not very hard, but at least ac97_bus_match() with the pair
"struct ac97_id *id = adrv->id_table" and "do { } while (++id->id);" is not
possible AFAIK with a const.

I will see if I can come up with something better for ac97_bus_match, such as
array usage instead of pointer arithmetics.

>> +};
>> +
>> +int ac97_codec_driver_register(struct ac97_codec_driver *drv);
>> +void ac97_codec_driver_unregister(struct ac97_codec_driver *drv);
>> +
>> +static inline struct device *
>> +ac97_codec_dev2dev(const struct ac97_codec_device *adev)
>> +{
>> +	return (struct device *)(adev);
>
> What's wrong with the simple &adev->dev ?  Cast looks scary.
The same leftover than above, I'll change that for RFC v2.

>> +struct ac97_controller {
>> +	const struct ac97_controller_ops *ops;
>> +	struct list_head controllers;
>> +	struct device *dev;
>> +	int bus_idx;
>
> What is this bus_idx for?
Initially it was to distinguish 2 different AC97 controllers. In the current
patchset state, it's not usefull anymore AFAICS.
So let's remove it.

>> +	int bound_codecs;
The same comment would apply here. I don't think that information is important
anymore. I thought I would use that to prevent AC97 controler removal while
codecs are still bound.

In a second thought what would be better is to have get_device() called for each
bound codec which will prevent ac97_digital_controller_unregister() to succeed
(-EBUSY).

>> +	struct list_head codecs;
>> +};
>> +
>> +int ac97_digital_controller_register(const struct ac97_controller_ops *ops,
>> +				     struct device *dev);
>> +int ac97_digital_controller_unregister(const struct device *dev);
>> +
>> +#endif
>> diff --git a/sound/ac97/Kconfig b/sound/ac97/Kconfig
>> new file mode 100644
>> index 000000000000..fd2c2d031e62
>> --- /dev/null
>> +++ b/sound/ac97/Kconfig
>> @@ -0,0 +1,9 @@
>> +#
>> +# PCI configuration
>> +#
>  
> Still only for PCI? :)
Ouch ;) I'll amend that for RFC v2.
>
>> +
>> +config AC97
>> +	bool "AC97 bus"
>> +	help
>> +	   Say Y here if you want to have AC97 devices, which are sound oriented
>> +	   devices around an AC-Link.
>> diff --git a/sound/ac97/Makefile b/sound/ac97/Makefile
>> new file mode 100644
>> index 000000000000..5575909d46e2
>> --- /dev/null
>> +++ b/sound/ac97/Makefile
>> @@ -0,0 +1,5 @@
>> +#
>> +# make for AC97 bus drivers
>> +#
>> +
>> +obj-y	+= bus.o codec.o snd_ac97_compat.o
>
> No possibility for modules?
There should be, so I'll put that on my TODO list for RFC v2.

>> +static struct ac97_codec_device *
>> +ac97_codec_find(struct ac97_controller *ac97_ctrl, int codec_num)
>> +{
>> +	struct ac97_codec_device *codec;
>> +
>> +	list_for_each_entry(codec, &ac97_ctrl->codecs, list)
>> +		if (codec->num == codec_num)
>> +			return codec;
>> +
>> +	return NULL;
>> +}
>
> It's a question whether we need to manage the codecs in the linked
> list.  There can be at most 4 codecs, so it fits in an array well,
> too.  Then some codes like this would be simpler. (And it'll even
> reduce the footprint, too.)
Agreed. For RFC v2.

>> +unsigned int ac97_bus_scan_one(struct ac97_controller *ac97,
>> +				      int codec_num)
>> +{
>> +	struct ac97_codec_device codec;
>> +	unsigned short vid1, vid2;
>> +	int ret;
>> +
>> +	codec.dev = *ac97->dev;
>> +	codec.num = codec_num;
>> +	ret = ac97->ops->read(&codec, AC97_VENDOR_ID1);
>> +	vid1 = (ret & 0xffff);
>> +	if (ret < 0)
>> +		return 0;
>
> Hmm.  This looks pretty hackish and dangerous.
You mean returning 0 even if the read failed, right ?
A better prototype would probably be (for RFC v2):
  int ac97_bus_scan_one(struct ac97_controller *ac97, int codec_num,
                        unsigned int *vendor_id);

>> +static int ac97_bus_scan(struct ac97_controller *ac97_ctrl)
>> +{
>> +	int ret, i;
>> +	unsigned int vendor_id;
>> +
>> +	for (i = 0; i < AC97_BUS_MAX_CODECS; i++) {
>> +		if (ac97_codec_find(ac97_ctrl, i))
>> +			continue;
>> +		vendor_id = ac97_bus_scan_one(ac97_ctrl, i);
>> +		if (!vendor_id)
>> +			continue;
>> +
>> +		ret = ac97_codec_add(ac97_ctrl, i, vendor_id);
>> +		if (ret < 0)
>> +			return ret;
>
> This is one of concerns: we don't know whether the device really
> reacts well if you access to a non-existing slot.  At least, it'd be
> safer to have the masks for the devices we already know the slots.

Ah you mean upon ac97 controller registration, the
ac97_digital_controller_register() should provide the information for each of
the 4 slots :
 - does the controller enable this slot (default yes)
 - does the controller support auto-scan for this slot (default yes)
   I'm not sure this "feature" is required, it looks a bit over-engineered.

That could be a matter of 1 or 2 masks as input parameters to
ac97_digital_controller_register().

>> +static int ac97_bus_reset(struct ac97_controller *ac97_ctrl)
>> +{
>> +	struct ac97_codec_device codec;
>> +
>> +	memset(&codec, 0, sizeof(codec));
>> +	codec.dev = *ac97_ctrl->dev;
>> +
>> +	ac97_ctrl->ops->reset(&codec);
>
> So, this assumes that reset ops is mandatory?  Then document it at
> least.
Ok, for RFC v2.

Thanks for your review and feedbacks Takashi, I'll work on both Mark and your
comments in the next weeks.

Cheers.

-- 
Robert
