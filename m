From: cmetcalf@tilera.com (Chris Metcalf)
Date: Fri, 29 Aug 2014 14:43:13 -0400
Subject: [PATCH 2/5] char: tile-srom: Remove reference to platform_bus
In-Reply-To: <1407515691.31897.26.camel@hornet>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>	
 <1406298233-27876-2-git-send-email-pawel.moll@arm.com>	
 <53DAA605.2030500@tilera.com> <1406913678.22529.46.camel@hornet>	
 <53E139C8.9000502@tilera.com> <1407515691.31897.26.camel@hornet>
Message-ID: <5400C9C1.4060904@tilera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Resending with text/plain.)

First, sorry for the delayed response, with summer vacation and then
trying to catch up.  :-)

On 8/8/2014 12:34 PM, Pawel Moll wrote:
> On Tue, 2014-08-05 at 21:08 +0100, Chris Metcalf wrote:
>>>> In addition, we also have user binaries
>>>> in the wild that know to look for /sys/devices/platform/srom/ paths,
>>>> so I'm pretty reluctant to change this path without good reason.
>>> So what is the srom class for then if not for device discovery? And why
>>> do they look for them in the first place? To get relevant character
>>> device's data, if I understand it right?
>>>
>>> Maybe you could just register a simple "proper" platform device for all
>>> the sroms and then hang the class devices from it? I can type some code
>>> doing this if it sound reasonably?
>> By "device discovery" I meant the way you find the way in your devices
>> in /sysfs. You seem to be traversing /sys/devices/... tree, while you've
>> got almost direct access to them through /sys/class/srom and you can (I
>> believe, correct me if I'm wrong, Greg) rely on this path being stable.

Yes, this is an excellent point.  I will change the user tool to use
/sys/class instead and then it will work with the existing kernel as well
as with future kernels that incorporate your suggested change.

>> The
>> subdirectories under /sys/devices/platform/srom/ correspond to partitions
>> in the SPI-ROM, which are software constructs created by the Tilera hypervisor.
>> By default we have three, where the first holds boot data that the chip
>> can use to boot out of hardware, and the other two are smaller partitions
>> for boot- and user-specific data.  We use the /sys files primarily to get the
>> page size and sector size for the sroms, and also export other interesting
>> information like the total size of the particular srom device.
>>
>> Thank you for volunteering to write a bit of code; if that's the best
>> way to clarify this for us, fantastic, or else pointing us at existing
>> good practices or documentation would be great too.
> [...]
> @@ -350,7 +351,7 @@ static int srom_setup_minor(struct srom_dev *srom, int index)
>  		       SROM_PAGE_SIZE_OFF, sizeof(srom->page_size)) < 0)
>  		return -EIO;
>
> -	dev = device_create(srom_class, &platform_bus,
> +	dev = device_create(srom_class, srom_parent,
>  			    MKDEV(srom_major, index), srom, "%d", index);
>  	return PTR_ERR_OR_ZERO(dev);
>  }

The second argument should be &srom_parent.dev though, I think.  Right?

> Would that work for you? Note that it will move the srom class devices
> one level deeper in /sys/devices/... hierarchy.

Yes, that seems slightly unfortunately but not too problematic.  If the
consensus is that this is the way to go, I can certainly take this change
into the Tile tree.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
