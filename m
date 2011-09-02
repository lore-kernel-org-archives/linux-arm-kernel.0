From: gregkh@suse.de (Greg KH)
Date: Fri, 2 Sep 2011 09:31:36 -0700
Subject: [PATCH 1/5] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <4E609784.3080507@linaro.org>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
	<20110901233403.GA28176@suse.de> <4E609784.3080507@linaro.org>
Message-ID: <20110902163136.GB5331@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2011 at 09:44:52AM +0100, Lee Jones wrote:
> Comments and questions in-line.

As they should be :)

> On 02/09/11 00:34, Greg KH wrote:
> > On Thu, Sep 01, 2011 at 01:27:19PM +0100, Lee Jones wrote:
> >> +static DEFINE_SPINLOCK(register_lock);
> > 
> > If this is really needed, please make it a mutex as you end up calling
> > code paths that can sleep.
> 
> If I use:
> 
> "the correct kernel interface for providing you with a unique number
> that increments as needed"
> 
> I'm I correct in assuming that I don't need to use locking?

Yes, don't you agree?

You do know what this interface is, right?  :)

> >> +static int soc_count = 0;
> > 
> > This should not be needed.
> > 
> >> +
> >> +static struct device soc_grandparent = {
> >> +	.init_name = "soc",
> >> +};
> > 
> > NEVER create a static struct device, this is totally not needed and
> > completly wrong.
> 
> Noted on the static point, but I believe that it is needed.
> 
> That's how /sys/devices/platform does it, which this essentially replaces.

NO NO NO NO NO NO

Again, no.

This does NOT replace /sys/devices/platform in any shape, manner, or
form.

Platform devices are "special" in that they are the "grab-bag of devices
that no one seems to know how to hook up to a sane bus so we throw them
all in the same heap and try to ignore the ugliness of them."

Never repeat the platform code anywhere else, that's not acceptable at
all.

If you want to make this a "bus" that's probably best, as then you would
get to enumerate over all /sys/bus/soc/ devices just fine, no matter
where in the device tree they live.

> >> +static ssize_t soc_info_get(struct device *dev,
> >> +			struct device_attribute *attr,
> >> +			char *buf)
> >> +{
> >> +	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
> >> +
> >> +	if (!strcmp(attr->attr.name, "machine"))
> >> +		return sprintf(buf, "%s\n", soc_dev->machine);
> >> +	if (!strcmp(attr->attr.name, "family"))
> >> +		return sprintf(buf, "%s\n", soc_dev->family);
> >> +	if (!strcmp(attr->attr.name, "revision"))
> >> +		return sprintf(buf, "%s\n", soc_dev->revision);
> >> +	if (!strcmp(attr->attr.name, "soc_id")) {
> >> +		if (soc_dev->pfn_soc_id)
> >> +			return sprintf(buf, "%s\n", soc_dev->pfn_soc_id());
> >> +		else return sprintf(buf, "N/A \n");
> > 
> > Move this line
> > 
> >> +	}
> >> +
> >> +	return -EINVAL;
> > 
> > To here?
> > 
> 
> I initially had invalid requests return a useful message, but I was told
> to remove it and return -EINVAL instead:
> 
> "Just return -EINVAL or similar here to propogate the error to the user."

No, if a SOC doesn't have one of these attributes, then just don't
create the sysfs file.  Don't return -EINVAL for something that you know
better than to have created in the first place, are you trying to make
it hard for userspace? :)

> >> +int __init soc_device_register(struct device *dev)
> > 
> > Don't pass a struct device in here, why are you making the caller create
> > the device?  This is the function that should create it for you?
> 
> I guess I can just return it instead, so it will become:
> 
> struct device * __init soc_device_register(void)
> 
> Is that more in keeping with what you would expect to see?

no.

How did you pass the attribute data into this core so that it knows how
to get to it?  You didn't, which is a mess.

How about something like:
	struct soc_device *soc_device_create(struct device *parent, struct soc_device_attributes *attr);

That would have the proper way to handle lifetime rules, userspace
notificatation of userpace, placement in sysfs, and all the other good
stuff.

I'm feeling like it would be simpler for me to write this code than to
keep providing review comments like this telling you to rewrite the
whole thing over again each time :)

Anyone want to send me a device that this code is needed for so I can do
it?

> >> +{
> >> +	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
> >> +	int ret;
> >> +
> >> +	spin_lock_irq(&register_lock);
> > 
> > Ok.
> > 
> >> +
> >> +	if (!soc_count) {
> >> +		/* Register top-level SoC device '/sys/devices/soc' */
> >> +		ret = device_register(&soc_grandparent);
> > 
> > device_register can't be called with a spinlock.  You must have gotten
> > lucky in your testing, if you tested this.
> > 
> > Anyway, this is not needed at all, please don't create "dummy" devices
> > in the sysfs tree, properly hook up your new device to where it should
> > be in the device tree.
> 
> We need a /sys/devices/soc, how else can this be done?

No you do not not, why would you think so?

> Would it make you happier if I called it a bus?

Yes, see the other response about creating a bus for these, which would
give you /sys/bus/soc/ where you can properly enumerate your devices,
which is what I think you want to be able to do, right?

thanks,

greg k-h
