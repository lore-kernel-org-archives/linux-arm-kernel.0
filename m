From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Feb 2017 21:45:15 +0100
Subject: [PATCH 1/2] ARM: add ARM_SINGLE_ARMV7 as config option
In-Reply-To: <20170210163908.GL27312@n2100.armlinux.org.uk>
References: <20170209033044.19513-1-chris.brandt@renesas.com>
 <5d90aff5-63b7-83a8-7529-2ac61ef82021@gmail.com>
 <SG2PR06MB11650C805DD754EE5C9E56C78A450@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <25202835.AdbHsoUg0y@wuerfel> <20170210163908.GL27312@n2100.armlinux.org.uk>
Message-ID: <CAK8P3a352qqynDUGPXVFfn3Yu2+qZr9F1WkWCEqpj_YM61WgJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 5:39 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

>
>> - Some (few) platforms actually have separate top-level Kconfig options
>>   but are actually very closely related and you could have a kernel
>>   for all of them even with !MMU and XIP_KERNEL. The most important
>>   one here is ARM Versatile/Realview/Integrator/Vexpress that have
>>   more in common than things we put behind a common Kconfig option in
>>   other platforms.
>
> If you think that Versatile + Realview + Integrator + Vexpress should
> be lumped into one kernel image for !MMU and XIP_KERNEL then you're
> wrong - from what I remember, their RAM and flash locations are quite
> different which rules it out.

They are not all the same, but the locations are not split according to
the platform names either. The early realview platforms are like versatile
here, while later realview platforms have the alias plus more, and vexpress
has it in two other places depending on the generation.

I misremembered vexpress and thought that it was like the later
realview, but at least versatile and realview are basically the same
thing (the story with NOR flash is similar).

>> - CONFIG_DEBUG_UNCOMPRESS has a very similar requirements to
>>   XIP_KERNEL and !MMU, and we currently allow it for any machine,
>>   with a lot of flexibility in configuring that always breaks
>>   running on any machine other than the one you are targetting.
>
> Right, but that's debug, not core kernel configuration.

I have not yet seen any argument why that is an important distinction, i.e.
what is the downside of letting users just turn the MMU and XIP options
on and off without changing everything else, other than this having been
the default in the past?

Obviously you won't be able to boot on machines when configured for
a different physical address (for RAM, flash or uart), but even that is
no change from what we have on the NOMMU platforms: on any of them
you have to manually type the address when configuring your kernel
for a given target and change it again when you want to run on another
board that doesn't share the exact address.

     Arnd
