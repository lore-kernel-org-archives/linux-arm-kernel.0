From: stigge@antcom.de (Roland Stigge)
Date: Tue, 16 Oct 2012 14:53:45 +0200
Subject: [PATCH RFC 02/11 v4] gpio: Add sysfs support to block GPIO API
In-Reply-To: <20121015235720.GA3132@kroah.com>
References: <1350343887-7344-1-git-send-email-stigge@antcom.de>
 <1350343887-7344-3-git-send-email-stigge@antcom.de>
 <20121015235720.GA3132@kroah.com>
Message-ID: <507D58D9.2040607@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2012 01:57 AM, Greg KH wrote:
> On Tue, Oct 16, 2012 at 01:31:18AM +0200, Roland Stigge wrote:
>> +int gpio_block_export(struct gpio_block *block)
>> +{
>> +	int		status;
>> +	struct device	*dev;
>> +
>> +	/* can't export until sysfs is available ... */
>> +	if (!gpio_class.p) {
>> +		pr_debug("%s: called too early!\n", __func__);
>> +		return -ENOENT;
>> +	}
>> +
>> +	mutex_lock(&sysfs_lock);
>> +	dev = device_create(&gpio_class, NULL, MKDEV(0, 0), block,
>> +			    block->name);
>> +	if (!IS_ERR(dev))
>> +		status = sysfs_create_group(&dev->kobj, &gpio_block_attr_group);
>> +	else
>> +		status = PTR_ERR(dev);
>> +	mutex_unlock(&sysfs_lock);
> 
> You just raced with userspace telling it that the device was present,
> yet the attributes are not there.  Don't do that, use the default class
> attributes for the class and then the driver core will create them
> automagically without needing to this "by hand" at all.

I guess you mean class attributes like gpio_class_attrs[] of gpio_class?
Aren't class attributes specific to a class only (i.e. only one
attribute at the root for all devices)? What I needed above are
attributes for the block itself (of which there can be several). So we
need device attributes for each block, not class attributes here.

Maybe there's some other kind of locking/atomicity available for this task?

Further, current gpio and gpiochip devices are also doing this way:
creating the device and subsequently their attrs, even though there may
be a better way but I'm still wondering how this would be.

Any hint appreciated.

Thanks in advance,

Roland
