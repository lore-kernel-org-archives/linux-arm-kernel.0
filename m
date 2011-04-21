From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Apr 2011 10:44:11 +0100
Subject: [PATCH 1/3] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <201104172036.45052.arnd@arndb.de>
References: <1302792592-17484-1-git-send-email-lee.jones@linaro.org>
	<1302792592-17484-2-git-send-email-lee.jones@linaro.org>
	<201104172036.45052.arnd@arndb.de>
Message-ID: <4DAFFC6B.80708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> On Thursday 14 April 2011, Lee Jones wrote:
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
> 
> This definitely needs a changelog, explaining what the code is there for,
> and why you chose this interface and not the alternatives we discussed
> earlier.

No problem.

>> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
>> new file mode 100644
>> index 0000000..5e4d6ef
>> --- /dev/null
>> +++ b/drivers/base/soc.c
>> @@ -0,0 +1,127 @@
>> +/*
>> + * Copyright (C) ST-Ericsson SA 2011
>> + *
>> + * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson.
>> + * License terms:  GNU General Public License (GPL), version 2
>> + */
> 
> (I believe this would be Copyright Linaro Ltd, not ST-Ericsson SA,
> but better ask internally in ST-Ericsson about what your rules are)

We've had internal discussions about this. I believe this is the correct
thing to do. The Copyright should stay with ST-Ericsson.

>> +struct device *parent_soc;
>> +struct device *soc[MAX_SOCS];
> 
> The array should not be needed here, you can simply iterate all soc
> devices using device_for_each_child() if required.

Joy, another re-write.

(I think you are correct however)

> Global variables should really not have such generic names. Better
> make all variables static and make sure that the code using them
> can at there properly.

Agreed.

>> +int __init soc_device_register(struct device_attribute *soc_attrs[],
>> +                               int soc_count)
> 
> This needs to return the soc device, otherwise there is nothing that
> a platform can do with the device.

What do you think the platform would want to do with the device?

> Passing the soc_count the way you do won't work when you have different
> SoCs, 

Why won't the platform know how many SoCs are on a given platform?

> so better require the user to call the register function repeatedly.

... and if it truly doesn't know, how will it know how many times to
call the register function?

> I think a nicer interface would be to pass a data structure into it
> with the data you always want to export, and then have the soc
> core create the necessary attributes, instead of requiring every
> user to duplicate that code.
> 
> A possible interface might be
> 
> struct soc_device {
> 	const char *machine;
> 	const char *family;
> 	/* ... */
> 	struct device dev;
> };

Either way, the probing functions would have to be called in order to
populate the structure. Why is using the struct device_attribute
show|store callbacks to call them a bad thing to do in this case?

> struct soc_device *soc_device_register(const char *machine, const char *family);
> 
> For the nonstandard attributes, I would recommend having the individual
> drivers call device_create_file, in order to discourage the use of 
> device specific attribute names.

I'm not entirely sure what you mean here. I'm assuming you mean calling
device_create_file from platform code once the device has been
registered and a pointer passed back. If that's the case then surely the
driver could set the attribute names to _any_ value still?

I really like the:

struct device_attribute soc_one_attrs[] = {
	__ATTR(machine,  S_IRUGO, ux500_get_machine,  NULL),
	__ATTR(family,   S_IRUGO, ux500_get_family,   NULL),
	__ATTR(soc_id,   S_IRUGO, ux500_get_soc_id,   NULL),
	/* ... */
	__ATTR_NULL,
};

... interface. I think it's neat, and easy to read. Are you suggesting I
should remove this altogether and replace it with passing const
arguments for common attributes and insisting the platform code calls
device_create_file for all non-standard ones? If so, if you would be
kind enough to explain why this is better, I'd appreciate it.

>> diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
>> new file mode 100644
>> index 0000000..988cf6f
>> --- /dev/null
>> +++ b/include/linux/sys_soc.h
>> @@ -0,0 +1,29 @@
>> +/*
>> + * Copyright (C) ST-Ericsson SA 2011
>> + * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson.
>> + * License terms:  GNU General Public License (GPL), version 2
>> + */
>> +#ifndef __SYS_SOC_H
>> +#define __SYS_SOC_H
>> +
>> +#include <linux/kobject.h>
>> +#include <linux/device.h>
>> +
>> +#define MAX_SOCS 8
> 
> No need to hardcode the maximum.

No problem.

Kind regards,
Lee
