From: cmetcalf@tilera.com (Chris Metcalf)
Date: Tue, 5 Aug 2014 16:08:40 -0400
Subject: [PATCH 2/5] char: tile-srom: Remove reference to platform_bus
In-Reply-To: <1406913678.22529.46.camel@hornet>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>	
 <1406298233-27876-2-git-send-email-pawel.moll@arm.com>	
 <53DAA605.2030500@tilera.com> <1406913678.22529.46.camel@hornet>
Message-ID: <53E139C8.9000502@tilera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/1/2014 1:21 PM, Pawel Moll wrote:
> On Thu, 2014-07-31 at 21:24 +0100, Chris Metcalf wrote:
>> On 7/25/2014 10:23 AM, Pawel Moll wrote:
>>> The code was creating "srom" class devices using
>>> platform_bus as a parent. As they are not really
>>> platform devices, make them virtual, using NULL instead.
>>>
>>> Cc: Chris Metcalf<cmetcalf@tilera.com>
>>> Signed-off-by: Pawel Moll<pawel.moll@arm.com>
>>> ---
>>>    drivers/char/tile-srom.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>> Can you clarify the point of this change a bit?
> Theoretically speaking there shouldn't be any need to export the
> platform bus root, as all devices should be registered via the platform
> API (platform_device_register & co.)

So, perhaps the right fix is to just use platform_device_register()
etc for this device, rather than making it virtual?

I think what I'm missing is why the platform bus isn't the right bus
for this device.  The driver-model/platform.txt doc says it's "used to
integrate peripherals on many system-on-chip processors", which is
how it's being used here.  It's directly addressable via MMIO from
the cores.

I grant you there's some confusion about our use of hypervisor calls
here, but effectively this is just a consequence of our use of the
Tilera hypervisor for kernel isolation; it's more like invoking the
BIOS on an Intel box, than it is about modern virtualization.

The current tilegx series hardware always contains this device, so
there's no FDT-like model for discovering it dynamically; we just always
enable it on tilegx hardware.

>> In addition, we also have user binaries
>> in the wild that know to look for /sys/devices/platform/srom/ paths,
>> so I'm pretty reluctant to change this path without good reason.
> So what is the srom class for then if not for device discovery? And why
> do they look for them in the first place? To get relevant character
> device's data, if I understand it right?
>
> Maybe you could just register a simple "proper" platform device for all
> the sroms and then hang the class devices from it? I can type some code
> doing this if it sound reasonably?

I'm not sure exactly what you mean by device discovery here.  The
subdirectories under /sys/devices/platform/srom/ correspond to partitions
in the SPI-ROM, which are software constructs created by the Tilera hypervisor.
By default we have three, where the first holds boot data that the chip
can use to boot out of hardware, and the other two are smaller partitions
for boot- and user-specific data.  We use the /sys files primarily to get the
page size and sector size for the sroms, and also export other interesting
information like the total size of the particular srom device.

Thank you for volunteering to write a bit of code; if that's the best
way to clarify this for us, fantastic, or else pointing us at existing
good practices or documentation would be great too.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
