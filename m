From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Oct 2011 16:14:02 +0200
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <4E9D5F29.1070303@linaro.org>
References: <1318852378-14180-1-git-send-email-lee.jones@linaro.org>
	<20111017161616.GA5108@suse.de> <4E9D5F29.1070303@linaro.org>
Message-ID: <201110181614.02312.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 October 2011, Lee Jones wrote:
> >> +struct device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
> >> +{
> >> +    struct soc_device *soc_dev;
> >> +    static atomic_t soc_device_num = ATOMIC_INIT(0);
> > 
> > No, please don't do this, use the proper kernel interface to dynamically
> > handle numbering devices (hint, if you unload a SOC device, you will
> > never reclaim that device number, which isn't that nice.)
> 
> Again, some help would really be appreciated here. I searched the kernel
> last time you mentioned numbering, but this is all I came up with.

I guess the correct interface to use here would be an "ida", see
linux/idr.h. However, I'm not convinced that's actually worth the
extra space for maintaining it here.

An SoC pretty much has the following properties:

* gets probed very early at boot time,
* can never go away, and
* there is only one of them in the system.

The only reason I even asked for the devices to be enumerated is that
there is the possibility that some device will need to have more than
one and we should design every stable user interface in a way that never
changes in a user visible way.

IMHO, we could also remove the soc_device_unregister() function entirely
and add a comment along the lines of 
/*
 * If you really need to add hot-pluggable soc_devices, add a
 * soc_device_unregister function and turn the number generation
 * into an IDA.
 */

	Arnd
