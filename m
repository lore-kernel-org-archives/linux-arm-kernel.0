From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 24 Aug 2011 15:19:35 +0100
Subject: [PATCH 1/4] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <4E5505EA.6050207@linaro.org>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<20110810132956.GG2680@pulham.picochip.com>
	<4E5505EA.6050207@linaro.org>
Message-ID: <20110824141935.GK23757@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, Aug 24, 2011 at 03:08:42PM +0100, Lee Jones wrote:
[...]
> >> +	return ret;
> >> +}
> >> +
> >> +int __init soc_device_register(struct device *soc_parent,
> >> +			struct soc_device *soc_dev)
> >> +{
> >> +	int ret;
> >> +
> >> +	spin_lock_irq(&register_lock);
> >> +
> >> +	if (!soc_count) {
> >> +		/* Register top-level SoC device '/sys/devices/soc' */
> >> +		ret = device_register(&soc_grandparent);
> >> +		if (ret)
> >> +		{
> >> +			spin_unlock_irq(&register_lock);
> >> +			return ret;
> >> +		}
> >> +	}
> >> +
> >> +	soc_count++;
> >> +	soc_parent->parent = &soc_grandparent;
> >> +	dev_set_name(soc_parent, "%i", soc_count);
> >> +	soc_parent->platform_data = soc_dev;
> > 
> > I don't think platform_data is the right place for this.  
> 
> I agree with you, but I was unsure how else to get the data back.
> 
> > It's not clear
> > what soc_parent and soc_dev do here as soc_dev never gets registered.
> >
> > Should this be:
> > 
> > 	soc_dev->parent = &soc_grandparent;
> > 	dev_set_name(soc_dev, "%i", soc_count);
> > 	device_register(soc_dev);
> 
> AFAIK soc_dev can't be registered. It's just a container which holds
> each SoW's information to be exported in the way of const char *'s.

Sorry, that should have been:

	dev_set_name(&soc_dev->dev, "%i", soc_count);
	device_register(&soc_dev->dev);

You should probably also set soc_dev->dev->release to something that'll 
kfree() the device on removal (even though they are unlikely to be 
removed).

> struct soc_device {
> 	struct device dev;
> 	const char *machine;
> 	const char *family;
> 	const char *soc_id;
> 	const char *revision;
> };
> 
> I don't believe that the "struct device dev;" is required either, but
> this is something I was advised to put in.
> 
> Can you think of a better way to store these values other than in
> platform_data then?

You can get the struct soc_device from the struct device with:

	#define to_soc_device(__dev) \
		container_of((__dev), struct soc_device, dev)

Then in the code:

	static ssize_t soc_info_get(struct device *dev,                                                                                                                                                                                                                                  
				    struct device_attribute *attr,                                                                                                                                                                                                                            
				    char *buf)                                                                                                                                                                                                                                                
	{                                                                                                                                                                                                                                                                                
		struct soc_device *soc_dev = to_soc_device(dev);
		...

struct platform_device is probably a good reference for this.

Jamie
