From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Tue, 18 May 2010 16:31:45 +0300 (EEST)
Subject: [PATCH v2 00/17] omap: mailbox: reorganize init
In-Reply-To: <AANLkTim5SxEb64QbBQgBhufhgpQ33MNFBhuHixfUeVKp@mail.gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
	<20100518.114642.35020415.Hiroshi.DOYU@nokia.com>
	<AANLkTim5SxEb64QbBQgBhufhgpQ33MNFBhuHixfUeVKp@mail.gmail.com>
Message-ID: <20100518.163145.232774311.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 00/17] omap: mailbox: reorganize init
Date: Tue, 18 May 2010 14:03:26 +0200

> On Tue, May 18, 2010 at 11:46 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>> From: ext Felipe Contreras <felipe.contreras@gmail.com>
>> Subject: [PATCH v2 00/17] omap: mailbox: reorganize init
>> Date: Fri, 14 May 2010 17:01:33 +0200
>>
>>> Hi,
>>>
>>> The main purpose of this patch series is to be able to compile mach platform
>>> data as built-in. Otherwise, client modules such as bridgedriver will load the
>>> platform code, but not the mach code when mailbox is built as a module.
>>
>> I think that this is the *udev* responsibility. The udev should take
>> care of loading mailbox_mach.ko since the mailbox platform device was
>> registered by devices.ko at bootup. devices.ko is built in earlier
>> than dspbridge.ko, so the mailbox platform device is registered
>> earlier than the dsp device, "C6410". this registration ordering
>> should take care of the dependency if the udevd works correctly.
> 
> I'm not familiar with this kind of module loading, but certainly not
> all systems have udev.
> 
> I realized the problem because I have a bare-bones system in my
> beagleboard where I had to manually load mailbox_mach.

With udev or something equivalent, it should work fine.

> 
>>> Unfortunately, there's no easy way to do that since plat and mach code are
>>> deepely interrelated. So the first patches try to separate the mailbox
>>> registering through a defined omap_mbox_platform_data.
>>>
>>> Also, it's worth noting that mailboxes are not a one-to-one mapping to
>>> resources; that is, some resources belong to multiple mboxes. So it's best to
>>> think of mailboxes as fake devices. That is why custom platform_data
>>> is required.
>>
>> Actually there were logical mailbox devices/instances implemented, but
>> it was broken partially when dropping mailbox class support by
>> accident(*1). This is the reason whey omap_mbox struct has unused dev
>> pointer now. At that time, the sysfs interface was not necessary but
>> the device creation itself should not have been removed. I'll get this
>> code back again soon.
>>
>> The role of each modules were/should be:
>>
>> ?- devices.ko: ? ? ? ? a platform device, based on its resource.
>> ?- mailbox_mach.ko: ? ?a platform driver to register multiple logical mboxes/devices.
>> ?- mailbox.ko: ? ? ? ? a kind of framework which holds multiple logical mboxes/devices.
>>
>> The sysfs structure is like below:
>>
>> ?~# tree -d -L 2 /sys/devices/platform/omap2-mailbox/
> 
> I don't see the point of having 'omap2' there, at best it should be
> 'omap-mailbox', or perhaps even just 'mailbox'.

Sounds nice.

>> The platform device omap2-mailbox accomodatess logical mboxes.
> 
> Wouldn't it be better the way my patches handle them?
>  * devices.ko:  doesn't care about mbox
>  * mach_omap1/mailbox.ko:  registers "omap-mailbox" platform device
> with a list of logical mboxes for OMAP1
>  * mach_omap2/mailbox.ko:  registers "omap-mailbox" platform device
> with a list of logical mboxes for OMAP2
>  * plat-omap/mailbox.ko: creates platform driver based on logical list
> of mboxes from platform device and handles the list internally
> 
> The end result would be the exactly same, except that there's no hard
> dependency between the mach, and plat code.

With the attachemnt, which is just 17 lines of code, you will get the
structure of logical mbox devices, which are located under the single
platform device, "omap2-mailbox". This is more _descriptive_ since
it displays the connection of a platform device and logical devices,
IOW, where these logical ones come. I don't see any point of not using
this struture.

> 
>>> Finally, a bunch of cleaning up is done in the very first patches, specially for
>>> OMAP1.
>>
>> Most of the cleanups are quite ok.
>>
>> Would it be possible to rebase them on the top of my coming patch to
>> get back logical device entry?
> 
> Where is that?

Attached. Would it be possible to rebase the cleanups on this one?

> 
>> Sorry for the late reply, it took some time to recall my bad memory...
> 
> No worries.
> 
> Cheers.
> 
> -- 
> Felipe Contreras
