From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 29 Oct 2015 17:24:42 +0000
Subject: arm64: iomem_resource doesn't contain all the region used
In-Reply-To: <20151029163655.GJ3489@olila.local.net-space.pl>
References: <562A4B0F.2020603@citrix.com>
 <1445615112.2374.226.camel@citrix.com> <563106C6.8000603@citrix.com>
 <20151029163655.GJ3489@olila.local.net-space.pl>
Message-ID: <5632565A.8050603@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 29/10/15 16:36, Daniel Kiper wrote:
> On Wed, Oct 28, 2015 at 05:32:54PM +0000, Julien Grall wrote:
>> (Adding David and Daniel)
>>
>> On 23/10/15 16:45, Ian Campbell wrote:
>>> On Fri, 2015-10-23 at 15:58 +0100, Julien Grall wrote:
>>>> Is there any way we could register the IO region used on ARM without
>>>> having to enforce it in all the drivers?
>>>
>>> This seems like an uphill battle to me.
>>
>> I agree about it. However this is how x86 handle memory hotplug for xen
>> ballooning. I'm wondering how this is cannot an problem for x86?
>>
>> Note that the problem is the same if a module is insert after hand.
> 
> Does ARM64 support memory hotplug on bare metal? If yes then check relevant
> code and do what should be done as close as possible to bare metal case
> on Xen guest.

AFAICT, There is no support memory hotplug for ARM64 in Linux today.

[..]

>>> In terms of domU the "potential" RAM is defined by the domain builder
>>> layout (currently the two banks mentioned in Xen's arch-arm.h).
>>
>> ... the DOMU one is more complex (see above). Today the guest layout is
>> static, I wouldn't be surprised to see it becoming dynamic very soon (I
>> have in mind PCI hotplug) and therefore defining static hotplug region
>> would not possible.
> 
> Please do not do that. I think that memory hotplug should not be limited
> by anything but just a given platform limitations. By the way, could you
> explain in details why linux/mm/memory_hotplug.c:register_memory_resource()
> will not work on ARM64 guest?

Sorry I should have CCed you on the first mail where I explained the
problem.

The problem is not register_memory_resource but how the balloon code is
finding a free region in the address patch. With the patch [1] which
should land in Linux 4.4, the balloon code will look for a free region
within the iomem_resource. This means that we expect all the region used
(or will be used in the case the driver is loaded later) by a device are
registered.

However, on ARM64, only a handful of drivers are effectively registering
the I/O region.

Any drivers using directly ioremap* or of_iomap (the ioremap version
using the device tree node in parameter) won't register the I/O region used.

For instance on the board I'm using not even 10% of the I/O region are
registered:

42sh> cat /proc/iomem

10510000-105103ff : /soc/rtc at 10510000
1a400000-1a400fff : /soc/sata at 1a400000
1a800000-1a800fff : /soc/sata at 1a800000
1f220000-1f220fff : /soc/sata at 1a400000
1f227000-1f227fff : /soc/sata at 1a400000
1f22a000-1f22a0ff : /soc/phy at 1f22a000
1f22d000-1f22dfff : /soc/sata at 1a400000
1f22e000-1f22efff : /soc/sata at 1a400000
1f230000-1f230fff : /soc/sata at 1a800000
1f23a000-1f23a0ff : /soc/phy at 1f23a000
1f23d000-1f23dfff : /soc/sata at 1a800000
1f23e000-1f23efff : /soc/sata at 1a800000
1f2b0000-1f2bffff : csr
79000000-798fffff : /soc/msi at 79000000
4100000000-41ffffffff : System RAM
  4100080000-41008b58a3 : Kernel code
  410093c000-41009e9fff : Kernel data
e0d0000000-e0d003ffff : cfg

TBH I don't see why you don't hit this issue on x86. Overall some of the
drivers can be shared between the 2 architectures.

Regards,

[1]
https://git.kernel.org/cgit/linux/kernel/git/xen/tip.git/commit/?h=for-linus-4.4&id=55b3da98a40dbb3776f7454daf0d95dde25c33d2

-- 
Julien Grall
