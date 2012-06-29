From: andy.green@linaro.org (Andy Green)
Date: Fri, 29 Jun 2012 22:03:29 +0800
Subject: [PATCH 2/3] OMAP2+ devices add mac address allocation register api
In-Reply-To: <201206291345.49878.arnd@arndb.de>
References: <20120629054404.11091.31289.stgit@build.warmcat.com>
 <4FED7E6A.4090207@linaro.org> <20120629120325.GD4202@atomide.com>
 <201206291345.49878.arnd@arndb.de>
Message-ID: <4FEDB5B1.8000703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/12 21:45, the mail apparently from Arnd Bergmann included:
> On Friday 29 June 2012, Tony Lindgren wrote:
>> * Andy Green <andy.green@linaro.org> [120629 03:12]:
>>>> 2. Is this really how we want to pass the board generated mac addresses
>>>>     and other dynamically generated data to the drivers that are device
>>>>     tree based?
>>>
>>> The issue is that both these busses have an async probe, in the case
>>> of USB stack the maintainer was not interested last year in adding
>>> platform data.  Maybe it changed but that's my understanding.
>>
>> OK, I'd like to hear Arnds comments on the #2 above too as this is
>> a more generic issue.
>
> In case we have a device tree, we should just be using the USB binding
> to find the specific device node, and add the property there. Then
> the device driver can use of_get_mac_address() on the usb device itself.
>
> I'm not sure what it takes to add the link for the device node in the
> usb probing code, but my feeling is that it's not too hard.
>
> Right now, USB is probed entirely without DT, so the patch is about
> the best we can do.

Yes none of this was really hard the problem with more generic approach 
was getting comprehension and not auto-reject at the other subsystems. 
To be fair USB is USB and DT is Arm-specific issue.

>>>> 3. What about mac address in board-generic.c when booting panda with
>>>>     device tree?
>>>
>>> I don't mind adapting it for that case.
>>
>> Just to try to think about some alternatives, how about something like
>> this: This all could be a driver called soft-mac or something that does
>> what your patches are doing. Except then it would be completely generic
>> and would be able to take device names and mac addresses from platform
>> data or from devicetree.
>
> That driver would be completely generic to all platforms, but be
> very specific to finding the mac address of a device, as opposed to
> other properties.
>
> I suspect that if we do that, we will still need a way to bind a
> device_node to a usb device for the purpose of finding other
> properties, such as external regulators or clocks that are connected
> to a hardwired USB device.

There's no standardized exposure of logical regulators over USB afaik so 
you won't be able to 'find' them without a VID:PID -bound specific 
driver that already knew about them.

> Normally USB tends to just work because the device is expected to
> be hot-pluggable anyway. If the USB device is soldered to the
> board, the hardware designers can take some shortcuts

Tony's point about modularized host drivers coming in random order seems 
to be a fair one.  We don't build ehci modular so we don't care about it 
but from maintainer pov it's a legit issue.

-Andy

-- 
Andy Green | TI Landing Team Leader
Linaro.org ? Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  - 
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
