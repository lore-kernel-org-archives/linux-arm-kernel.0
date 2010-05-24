From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 24 May 2010 09:36:25 +0300 (EEST)
Subject: [PATCH v2t2 00/17] omap: mailbox:
In-Reply-To: <20100522.081415.258113387.Hiroshi.DOYU@nokia.com>
References: <20100521221557.GM11042@n2100.arm.linux.org.uk>
	<AANLkTinMFJTlbXYiS9G87VSQyRuGxJfJGHkVejOEfgVQ@mail.gmail.com>
	<20100522.081415.258113387.Hiroshi.DOYU@nokia.com>
Message-ID: <20100524.093625.241440026.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v2t2 00/17] omap: mailbox:
Date: Sat, 22 May 2010 08:14:15 +0300 (EEST)

> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: Re: [PATCH v2t2 00/17] omap: mailbox:
> Date: Sat, 22 May 2010 01:34:52 +0200
> 
>> On Sat, May 22, 2010 at 1:15 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Sat, May 22, 2010 at 01:09:12AM +0300, Felipe Contreras wrote:
>>>> On Sat, May 22, 2010 at 12:57 AM, Russell King - ARM Linux
>>>> <linux@arm.linux.org.uk> wrote:
>>>> > The only reason 3 would be loaded due to that dependency is if 2 were
>>>> > being modprobed, which means it's going to be inserted after 3 anyway.
>>>> >
>>>> > I don't see anything else in 3 which would trigger it to be loaded.
>>>> >
>>>> > The "platform:omap2-mailbox" module alias of 2 should result in 2
>>>> > being modprobed,
>>>>
>>>> I see, at initialization?
>>>
>>> That's the theory - and it should be that same mechanism which allows
>>> things like already plugged in PCMCIA and the like cards to be properly
>>> dealt with at boot time.
>>>
>>>> > causing 3 to be loaded to satisfy the dependency.
>>>> > As already pointed out, this should happen as a result of udev or
>>>> > (older) hotplug initialization.
>>>>
>>>> Well, in the minimal system I have in my beagleboard it doesn't
>>>> happen. I load bridgedriver, which loads mailbox, but fails
>>>> immediately because mailbox_mach is not there.
>>>
>>> I assume that having the MMC host driver built in, but the MMC block
>>> driver as a module also doesn't work on your setup?
>> 
>> I wouldn't know because my file-system is on the MMC.
> 
> I guess that your other platform drivers wouldn't work as dynamic module.
> 
>>> I don't see this as something that should be worked around in the
>>> kernel by making things non-modular - I view the missing userspace
>>> functionality causing the problem.
>> 
>> First of all, most of the cleanups are independent of the built-in
>> option, although that was my motivation, the patches are good by
> 
> Your cleanup patches are ok.
> 
>> themselves: there's no need to export
>> omap_mbox_register()/_unregister() unnecessarily when the platform
>> data can be used, right?
> 
> This is not the point.
> 
>> Now, regarding the built-in mode; for the iommu case you said it
>> should be built-in:
>> http://article.gmane.org/gmane.linux.ports.arm.kernel/58555
> 
> Right.
> 
>> Apparently it's not, so it's not clear to me how omap3-iommu would be
>> loaded since there's no "platform:" alias.
> 
> This alias is only necessary for platform drivers.
> 
>> Moreover, Tony says that anything that registers platform devices
>> should be built-in, but omap3-iommu does register devices and is not
>> built-in.
> 
> It seems that this makes you confused. It should have been
> build-in;). This is going to be integrated into omap hwmod framework
> soon.

For built-in part, it could be something like:
