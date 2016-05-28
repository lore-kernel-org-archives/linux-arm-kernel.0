From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 28 May 2016 14:17:05 -0700
Subject: pxa_defconfig runtime failures due to 'ARM: pxa: activate pinctrl
 for device-tree machines'
In-Reply-To: <87a8jah9ok.fsf@belgarion.home>
References: <20160527202715.GA4841@roeck-us.net>
 <87a8jah9ok.fsf@belgarion.home>
Message-ID: <574A0AD1.9000304@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2016 01:24 AM, Robert Jarzmik wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
>
>> Hi,
>>
>> your mainline commit f806dac5938b ("ARM: pxa: activate pinctrl for device-tree
>> machines") causes various non-devicetree systems to fail with the following
>> error messages when running a pxa_defconfig image.
> Ah yes, you're right.
>
>>
>> During boot:
>>
>> Can't request reset_gpio
>>
>> At reboot:
>>
>> reboot: Restarting system
>> ------------[ cut here ]------------
>> kernel BUG at arch/arm/mach-pxa/reset.c:59!
>> ...
>>
>> Added logging shows that the error seen when trying to request the reset gpio
>> is -EPROBE_DEFER, and that the pxa gpio driver is not instantiated.
>>
>> This is seen when attempting to run akita, borzoi, spitz, terrier, or tosa
>> in qemu with pxa_defconfig. Reverting your patch fixes the problem.
>>
>> Is this on purpose ?
> Well no :)
> The real reason behind is that gpio handling for pxa in its current state cannot
> be built for _both_ a devicetree machine (ie. pxa-dt.c) and a non devicetree
> machine (ie. corgi, tosa, ...).
>
> This is turn is because for devicetree a pinctrl is enforced for the machine,
> and a pinctrl driver is required. If it's not available, pxa_gpio_request()
> fails on pinctrl_request_gpio() and returns -EPROBE_DEFER.
>
> Now the true chicken and egg problem is than machine files,
> ie. arch/arm/mach-pxa/xxx.c are using gpio before the drivers are probed, in the
> init_machine() function, and that's why pinctrl/gpio for legacy machine files is
> a bit difficult.
>
>> Unless I am missing something, it effectively means that
>> pxa_defconfig no longer works for pxa3xx systems, since those do not support
>> devicetree (or at least there is no devicetree file which includes
>> pxa3xx.dtsi).
> I'd rather say that pxa_defconfig doesn't work anymore on any legacy system.
> Its first purpose was to ensure compilation coverage of all legacy pxa systems.
> Its second one was to have a single kernel bootable on all legacy pxa systems.
>
> Therefore, would you tell me if the patch in [1] fixes your issue ?
>

Yes, it does. It is actually the workaround I deployed for my test builds,
since I thought that the change was on purpose.

Thanks,
Guenter
