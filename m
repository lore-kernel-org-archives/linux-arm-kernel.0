From: emilio.lopez@collabora.co.uk (=?UTF-8?Q?Emilio_L=c3=b3pez?=)
Date: Tue, 15 Sep 2015 16:16:04 -0300
Subject: [PATCH v2 2/3] platform/chrome: Support reading/writing the vboot
 context
In-Reply-To: <CABxcv=m23sfK=jOCswirQRB1SbP70VnomKp6hhwFhRLHiabq4w@mail.gmail.com>
References: <1442234049-18637-1-git-send-email-emilio.lopez@collabora.co.uk>
 <1442234049-18637-3-git-send-email-emilio.lopez@collabora.co.uk>
 <CABxcv=m23sfK=jOCswirQRB1SbP70VnomKp6hhwFhRLHiabq4w@mail.gmail.com>
Message-ID: <55F86E74.9010907@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

Thanks for the review. You'll find my answers inline

On 15/09/15 10:47, Javier Martinez Canillas wrote:
> Hello Emilio,
>
> Patch looks mostly good to me, I just have a few comments.
>
> On Mon, Sep 14, 2015 at 2:34 PM, Emilio L?pez
> <emilio.lopez@collabora.co.uk> wrote:
>> Some EC implementations include a small nvram space used to store
>> verified boot context data. This patch offers a way to expose this
>> data to userspace.
>>
>> Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
>> ---
>> Changes from v1:
>>   - Use is_bin_visible instead of is_visible
>>
>>   Documentation/devicetree/bindings/mfd/cros-ec.txt |   4 +
>>   drivers/platform/chrome/Makefile                  |   5 +-
>>   drivers/platform/chrome/cros_ec_dev.c             |   1 +
>>   drivers/platform/chrome/cros_ec_vbc.c             | 137 ++++++++++++++++++++++
>>   include/linux/mfd/cros_ec.h                       |   1 +
>>   5 files changed, 147 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/platform/chrome/cros_ec_vbc.c
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/cros-ec.txt b/Documentation/devicetree/bindings/mfd/cros-ec.txt
>> index 1777916..136e0c2 100644
>> --- a/Documentation/devicetree/bindings/mfd/cros-ec.txt
>> +++ b/Documentation/devicetree/bindings/mfd/cros-ec.txt
>> @@ -34,6 +34,10 @@ Required properties (LPC):
>>   - compatible: "google,cros-ec-lpc"
>>   - reg: List of (IO address, size) pairs defining the interface uses
>>
>> +Optional properties (all):
>> +- google,has-vbc-nvram: Some implementations of the EC include a small
>> +  nvram space used to store verified boot context data. This boolean flag
>> +  is used to specify whether this nvram is present or not.
>>
>>   Example for I2C:
>>
>
> I would split the DT binding part from the actual implementation, see
> Documentation/devicetree/bindings/submitting-patches.txt.

Ok, I'll do

>> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
>> index 4a11b01..787be61 100644
>> --- a/drivers/platform/chrome/Makefile
>> +++ b/drivers/platform/chrome/Makefile
>> @@ -1,7 +1,10 @@
>>
>>   obj-$(CONFIG_CHROMEOS_LAPTOP)  += chromeos_laptop.o
>>   obj-$(CONFIG_CHROMEOS_PSTORE)  += chromeos_pstore.o
>> -cros_ec_devs-objs               := cros_ec_dev.o cros_ec_sysfs.o cros_ec_lightbar.o
>> +cros_ec_devs-objs               := cros_ec_dev.o
>> +cros_ec_devs-objs               += cros_ec_lightbar.o
>> +cros_ec_devs-objs               += cros_ec_sysfs.o
>> +cros_ec_devs-objs               += cros_ec_vbc.o
>
> Why are you changing the Makefile? AFAIK += is usually used when the
> compilation is conditional based on a Kconfig symbol but since these
> are build unconditionally, I'll just keep it as foo := bar baz

As far as I'm aware, += is append[0]. It's used for stuff like
obj-$(CONFIG_CHROMEOS_LAPTOP)  += chromeos_laptop.o
because the left part will resolve to "obj-y" or similar, and you want 
to add to it, not replace it. I only changed the Makefile here because 
the line was growing too long, and I thought it looked neater this way; 
it shouldn't cause any functional change apart from the intended one.

[0] https://www.gnu.org/software/make/manual/html_node/Appending.html

> Which makes me think, do we need a Kconfig option for this feature
> since not all machines have it?

Not all machines have a lightbar either; both of the features are 
runtime-conditional. IMO, it makes more sense this way when you consider 
a kernel will likely support multiple platforms.

>>   obj-$(CONFIG_CROS_EC_CHARDEV)   += cros_ec_devs.o
>>   obj-$(CONFIG_CROS_EC_LPC)       += cros_ec_lpc.o
>>   obj-$(CONFIG_CROS_EC_PROTO)    += cros_ec_proto.o
>> diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
>> index e8fcdc2..d19263f 100644
>> --- a/drivers/platform/chrome/cros_ec_dev.c
>> +++ b/drivers/platform/chrome/cros_ec_dev.c
>> @@ -32,6 +32,7 @@ static int ec_major;
>>   static const struct attribute_group *cros_ec_groups[] = {
>>          &cros_ec_attr_group,
>>          &cros_ec_lightbar_attr_group,
>> +       &cros_ec_vbc_attr_group,
>>          NULL,
>>   };
>>
>> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
>> new file mode 100644
>> index 0000000..a0e8d38
>> --- /dev/null
>> +++ b/drivers/platform/chrome/cros_ec_vbc.c
>> @@ -0,0 +1,137 @@
>> +/*
>> + * cros_ec_vbc - Expose the vboot context nvram to userspace
>> + *
>> + * Copyright (C) 2015 Collabora Ltd.
>> + *
>> + * based on vendor driver,
>> + *
>> + * Copyright (C) 2012 The Chromium OS Authors
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/mfd/cros_ec.h>
>> +#include <linux/mfd/cros_ec_commands.h>
>> +#include <linux/slab.h>
>> +
>> +static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
>> +                                 struct bin_attribute *att, char *buf,
>> +                                 loff_t pos, size_t count)
>> +{
>> +       struct device *dev = container_of(kobj, struct device, kobj);
>> +       struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
>> +                                             class_dev);
>> +       struct cros_ec_device *ecdev = ec->ec_dev;
>> +       struct ec_params_vbnvcontext *params;
>> +       struct cros_ec_command *msg;
>> +       int err;
>> +       const size_t para_sz = sizeof(struct ec_params_vbnvcontext);
>> +       const size_t resp_sz = sizeof(struct ec_response_vbnvcontext);
>> +       const size_t payload = max(para_sz, resp_sz);
>> +
>> +       msg = kmalloc(sizeof(*msg) + payload, GFP_KERNEL);
>> +       if (!msg)
>> +               return -ENOMEM;
>> +
>> +       params = (struct ec_params_vbnvcontext *)msg->data;
>> +       params->op = EC_VBNV_CONTEXT_OP_READ;
>> +
>> +       msg->version = EC_VER_VBNV_CONTEXT;
>> +       msg->command = EC_CMD_VBNV_CONTEXT;
>> +       msg->outsize = sizeof(params->op);
>
> Shouldn't this be para_sz ? Since you are sending to the EC the whole
> struct ec_params_vbnvcontext and not only the op field.
>
> Or if the EC only expects to get the u32 op field, then I think your
> max payload calculation is not correct.

The params struct is the same for both read and write ops, so it has the 
op flag and a buffer for the write op. During the read op I believe 
there's no need to send this potentially-garbage-filled buffer to the 
EC, so outsize is set accordingly here.

The vendor tree does it this way, but I can change it to send the full 
buffer if you prefer so.

ec code is at 
https://chromium.googlesource.com/chromiumos/platform/ec/+/master/common/system.c 
L1086+ if you want to take a look

>> +       msg->insize = resp_sz;
>> +
>> +       err = cros_ec_cmd_xfer(ecdev, msg);
>> +       if (err < 0) {
>> +               dev_err(dev, "Error sending read request: %d\n", err);
>> +               kfree(msg);
>> +               return err;
>> +       }
>> +
>> +       BUILD_BUG_ON(resp_sz > PAGE_SIZE);
>
> Why you need this? struct ec_response_vbnvcontext is really small AFAICT.

This is just me being paranoid about memcpy :) Indeed, the struct should 
be way smaller than a page. I can drop it if you think it's too much.

>> +       memcpy(buf, msg->data, resp_sz);
>> +
>> +       kfree(msg);
>> +       return resp_sz;
>> +}
>> +

Thanks!
Emilio
