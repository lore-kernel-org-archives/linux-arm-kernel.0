From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2011 13:03:03 +0200
Subject: [PATCH 1/3] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <4DAFFC6B.80708@linaro.org>
References: <1302792592-17484-1-git-send-email-lee.jones@linaro.org>
	<201104172036.45052.arnd@arndb.de> <4DAFFC6B.80708@linaro.org>
Message-ID: <201104211303.04043.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2011, Lee Jones wrote:

> >> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> >> new file mode 100644
> >> index 0000000..5e4d6ef
> >> --- /dev/null
> >> +++ b/drivers/base/soc.c
> >> @@ -0,0 +1,127 @@
> >> +/*
> >> + * Copyright (C) ST-Ericsson SA 2011
> >> + *
> >> + * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson.
> >> + * License terms:  GNU General Public License (GPL), version 2
> >> + */
> > 
> > (I believe this would be Copyright Linaro Ltd, not ST-Ericsson SA,
> > but better ask internally in ST-Ericsson about what your rules are)
> 
> We've had internal discussions about this. I believe this is the correct
> thing to do. The Copyright should stay with ST-Ericsson.

Ok, in that case, I'd suggest you use your ST-Ericsson address for
Signed-off-by and the author statement above.

> >> +int __init soc_device_register(struct device_attribute *soc_attrs[],
> >> +                               int soc_count)
> > 
> > This needs to return the soc device, otherwise there is nothing that
> > a platform can do with the device.
> 
> What do you think the platform would want to do with the device?

Add the child devices, or add more attributes.

> > Passing the soc_count the way you do won't work when you have different
> > SoCs, 
> 
> Why won't the platform know how many SoCs are on a given platform?
>
> > so better require the user to call the register function repeatedly.
> 
> ... and if it truly doesn't know, how will it know how many times to
> call the register function?

You could have a platform that has several SOCs, some of which are optional,
E.g. one SoC for that contains the main CPU, and then another SOC of
a different vendor plugged into an external bus.

> > I think a nicer interface would be to pass a data structure into it
> > with the data you always want to export, and then have the soc
> > core create the necessary attributes, instead of requiring every
> > user to duplicate that code.
> > 
> > A possible interface might be
> > 
> > struct soc_device {
> > 	const char *machine;
> > 	const char *family;
> > 	/* ... */
> > 	struct device dev;
> > };
> 
> Either way, the probing functions would have to be called in order to
> populate the structure. Why is using the struct device_attribute
> show|store callbacks to call them a bad thing to do in this case?

Code is more complex than data, and we want to have the complexity
in a central location, not copied over all subarchitectures. When
you use a flattened device tree, the strings can simply point to
properties of the root device, so there would be very little to
do other than assign them.

> > struct soc_device *soc_device_register(const char *machine, const char *family);
> > 
> > For the nonstandard attributes, I would recommend having the individual
> > drivers call device_create_file, in order to discourage the use of 
> > device specific attribute names.
> 
> I'm not entirely sure what you mean here. I'm assuming you mean calling
> device_create_file from platform code once the device has been
> registered and a pointer passed back.

Right.

> If that's the case then surely the
> driver could set the attribute names to _any_ value still?
> 
> I really like the:
> 
> struct device_attribute soc_one_attrs[] = {
> 	__ATTR(machine,  S_IRUGO, ux500_get_machine,  NULL),
> 	__ATTR(family,   S_IRUGO, ux500_get_family,   NULL),
> 	__ATTR(soc_id,   S_IRUGO, ux500_get_soc_id,   NULL),
> 	/* ... */
> 	__ATTR_NULL,
> };

> ... interface. I think it's neat, and easy to read. Are you suggesting I
> should remove this altogether and replace it with passing const
> arguments for common attributes and insisting the platform code calls
> device_create_file for all non-standard ones? If so, if you would be
> kind enough to explain why this is better, I'd appreciate it.

I would prefer to standardise the attributes as much as possible. Ideally,
all SOCs should export the same set of attributes, and in no case should
there be multiple SOCs that have the same attribute name but with a
slightly different interface (e.g. one writable, or one root-only readable),
or the same contents in attributes of different names.

The best way to ensure this is to give less flexiblity to the person
implementing the individual SOC code. All attributes that are documented
to be available across SOCs can simply be automatically created and
filled with the data provided by the platform.

Having interfaces specific to one SOC should be the absolute exception,
so I'd try to make that as hard as possible.

	Arnd
