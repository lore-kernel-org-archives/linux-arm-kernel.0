From: gregkh@suse.de (Greg KH)
Date: Tue, 18 Oct 2011 07:43:09 -0700
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <4E9D5F29.1070303@linaro.org>
References: <1318852378-14180-1-git-send-email-lee.jones@linaro.org>
	<1318852378-14180-3-git-send-email-lee.jones@linaro.org>
	<20111017161616.GA5108@suse.de> <4E9D5F29.1070303@linaro.org>
Message-ID: <20111018144309.GC19561@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 12:12:41PM +0100, Lee Jones wrote:
> > If you move around things a bit here, you can save 4 lines of code,
> > please do so.
> 
> Telepathy has never been my Fort?. Would you mind alluding to which
> lines I can trim please?
> 
> If you mean the placing the DEVICE_ATTR's after soc_info_get and
> removing its prototype; I had that already, but I was told to do it this
> way as it would make the binary smaller.

Yes, you are correct, I am wrong here, nevermind.

> >> +
> >> +struct bus_type soc_bus_type = {
> >> +	.name  = "soc",
> >> +};
> >> +
> >> +static int __init soc_bus_register(void)
> >> +{
> >> +	return bus_register(&soc_bus_type);
> >> +}
> >> +core_initcall(soc_bus_register);
> > 
> > No unregister?
> 
> The unregister is contained in soc_device_unregister, but as you point
> out in your other email this should be removed. I'm guessing we should
> either count the number of SoCs and unregister as the last one leaves,
> or not unregister at all?

No, make it a module exit function and you will be fine.

> >> +struct attribute *soc_attr[] = {
> >> +	&dev_attr_machine.attr,
> >> +	&dev_attr_family.attr,
> >> +	&dev_attr_soc_id.attr,
> >> +	&dev_attr_revision.attr,
> >> +	NULL,
> >> +};
> >> +
> >> +struct attribute_group soc_attr_group = {
> >> +	.attrs = soc_attr,
> >> +};
> >> +
> >> +struct device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
> >> +{
> >> +	struct soc_device *soc_dev;
> >> +	static atomic_t soc_device_num = ATOMIC_INIT(0);
> > 
> > No, please don't do this, use the proper kernel interface to dynamically
> > handle numbering devices (hint, if you unload a SOC device, you will
> > never reclaim that device number, which isn't that nice.)
> 
> Again, some help would really be appreciated here. I searched the kernel
> last time you mentioned numbering, but this is all I came up with.

ida

> >> +struct soc_device_attribute {
> >> +	const char *machine;
> >> +	const char *family;
> >> +	const char *revision;
> >> +	const char *soc_id;
> >> +};
> > 
> > What happens if one of these attributes is NULL?  Please check for that
> > when you create the attributes so that you don't create an attribute you
> > don't want to.
> 
> By shifting around "struct attribute *soc_attr[]"?
> 
> If one of them is NULL the file will just be empty, is that such a bad
> thing?

Yes.  sysfs files show that if the file is present, then there should be
data in it.  If it isn't present, then that attribute isn't there for
that device.  It is easier for userspace to handle this than by having
to open files and test for a null entry or not.

> >> +
> >> +struct soc_device {
> >> +	struct device dev;
> >> +	struct soc_device_attribute *attr;
> >> +};
> > 
> > Why is this needed to be defined here?  It should be in the .c file as
> > no external code needs to know what it looks like.
> 
> If you want me to pass back a "struct soc_device" instead of a "raw"
> struct device, the calling code will need to know how to separate out
> "struct device dev" won't it?

It depends on what it wants to do with that struct device.  Why would
the caller code care about it?

thanks,

greg k-h
