From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jun 2012 14:23:21 +0100
Subject: [PATCH 06/14] mfd: Initialise the DB8500 PRCMU driver at
 core_initcall time
In-Reply-To: <201206121259.38807.arnd@arndb.de>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdYoQFhBfRaPMBiVTiD979b+8708oS1qCPm+iyy5OZe2bw@mail.gmail.com>
 <4FD6FF6C.6040500@linaro.org> <201206121259.38807.arnd@arndb.de>
Message-ID: <4FD742C9.7090603@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/12 13:59, Arnd Bergmann wrote:
> On Tuesday 12 June 2012, Lee Jones wrote:
>> On 11/06/12 22:01, Linus Walleij wrote:
>>> Hm what shall we do when we run out of initlevels? I think this was the
>>> kind of thing that deferred probe should solve. Usually changing this kind
>>> of thing has side effects so I'm a bit hesitant.
>>
>> Ah yes, I remember now. The IRQ domain needs to be in place before the
>> Device Tree is parsed by the Open Firmware subsystem. If it's not the
>> error "no irq domain found" is triggered and the IRQs are never mapped.
>>
>> I'd be happy to take a second opinion, but I believe this (and the other
>> core_initcall patch) is required.
>
> It's still just a hack. The real solution that we discussed last time it
> came up is to defer the translation of irq numbers until device driver
> probe time, and bail out with -EPROBE_DEFER if you try to use a device
> whose interrupt is not available yet.

Ah yes, this:

> /*
>  * FIXME: Should we set up the GPIO domain here?
>  *
>  * The problem is that we cannot put the interrupt resources into the platform
>  * device until the irqdomain has been added. Right now, we set the GIC interrupt
>  * domain from init_irq(), then load the gpio driver from
>  * core_initcall(nmk_gpio_init) and add the platform devices from
>  * arch_initcall(customize_machine).
>  *
>  * This feels fragile because it depends on the gpio device getting probed
>  * _before_ any device uses the gpio interrupts.
> */

But your suggestion above involves some heavy refactoring of how Device 
Tree works. Meanwhile the ab8500 will not work as an IRQ controller 
until we either complete the work or use the same solution as we did for 
the Nomadik GPIO controller. I think for now at least we should continue 
to work on enablement and leave the 'nice to have's until last. We are 
doing nothing new here, just bringing the ab8500 IRQ controller into 
line with the Nomadik one.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
