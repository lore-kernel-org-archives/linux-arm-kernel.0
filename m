From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 16 Oct 2012 09:43:26 -0700
Subject: [PATCH RFC 02/11 v4] gpio: Add sysfs support to block GPIO API
In-Reply-To: <507D58D9.2040607@antcom.de>
References: <1350343887-7344-1-git-send-email-stigge@antcom.de>
 <1350343887-7344-3-git-send-email-stigge@antcom.de>
 <20121015235720.GA3132@kroah.com> <507D58D9.2040607@antcom.de>
Message-ID: <20121016164326.GA4858@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 02:53:45PM +0200, Roland Stigge wrote:
> On 10/16/2012 01:57 AM, Greg KH wrote:
> > On Tue, Oct 16, 2012 at 01:31:18AM +0200, Roland Stigge wrote:
> >> +int gpio_block_export(struct gpio_block *block)
> >> +{
> >> +	int		status;
> >> +	struct device	*dev;
> >> +
> >> +	/* can't export until sysfs is available ... */
> >> +	if (!gpio_class.p) {
> >> +		pr_debug("%s: called too early!\n", __func__);
> >> +		return -ENOENT;
> >> +	}
> >> +
> >> +	mutex_lock(&sysfs_lock);
> >> +	dev = device_create(&gpio_class, NULL, MKDEV(0, 0), block,
> >> +			    block->name);
> >> +	if (!IS_ERR(dev))
> >> +		status = sysfs_create_group(&dev->kobj, &gpio_block_attr_group);
> >> +	else
> >> +		status = PTR_ERR(dev);
> >> +	mutex_unlock(&sysfs_lock);
> > 
> > You just raced with userspace telling it that the device was present,
> > yet the attributes are not there.  Don't do that, use the default class
> > attributes for the class and then the driver core will create them
> > automagically without needing to this "by hand" at all.
> 
> I guess you mean class attributes like gpio_class_attrs[] of gpio_class?

Yes.

> Aren't class attributes specific to a class only (i.e. only one
> attribute at the root for all devices)? What I needed above are
> attributes for the block itself (of which there can be several). So we
> need device attributes for each block, not class attributes here.

Yes, that is what the dev_attrs field in 'struct class' is for.

> Maybe there's some other kind of locking/atomicity available for this task?
> 
> Further, current gpio and gpiochip devices are also doing this way:
> creating the device and subsequently their attrs, even though there may
> be a better way but I'm still wondering how this would be.

Then the existing code is broken and should be fixed to use dev_attrs.
I guess it's time to audit the tree and find all places that get this
wrong...

greg k-h
