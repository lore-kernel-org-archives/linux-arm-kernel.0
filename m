From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 9 Feb 2015 18:14:24 +0100
Subject: [PATCH] ARM: shmobile: r8a73a4: Move pfc node to work around
 probe ordering bug
In-Reply-To: <20150209162428.GG25235@atomide.com>
References: <1423254173-31852-1-git-send-email-geert+renesas@glider.be>
 <20150209162428.GG25235@atomide.com>
Message-ID: <CAMuHMdXsbmcgRacg9CT9N7+KjOrog2F8mmGfORu31P3xyoVviA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Mon, Feb 9, 2015 at 5:24 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Geert Uytterhoeven <geert+renesas@glider.be> [150206 12:26]:
>> Currently the pin function controller (which is also a GPIO controller)
>> is instantiated before the interrupt controllers due to the order in the
>> DTS. At that time, the irq domains for the interrupt controllers
>> referenced by its interrupts-extended property cannot be found yet:
>>
>>     irq: no irq domain found for /interrupt-controller at e61c0000 !
>>
>> Nevertheless, the core OF probing code ignores this failure, besides a
>> debug message that's not normally printed:
>>
>>     not all legacy IRQ resources mapped for pfc
>>
>> and continues initialization of the device. Then, the sh-pfc driver
>> cannot find any IRQ resources, and thinks no interrupts are available,
>> causing gpio-keys to fail later:
>>
>>     gpio-keys keyboard: Unable to claim irq 0; error -22
>>     gpio-keys: probe of keyboard failed with error -22
>>
>> Move the pin function controller node after the interrupt controller
>> nodes it references to work around the bug in the core OF probing code.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Notes:
>>   - It seems several people tried to solve this in the core OF probing
>>     code before, but the final solution never went in?
>>   - This can be reproduced on other SoCs (e.g. sh73a0 and r8a7740) by
>>     moving their pfc nodes before their interrupt controller nodes.
>>   - This patch is against my working tree, so it doesn't apply to
>>     Simon's repository, but you get the idea....
>
> No issues with the patch, but here are few comments on the core
> reasons (without looking at the code in this case) that might help
> fix similar issues.
>
> In all the cases I've seen these errors are caused by non-standard
> custom initcall levels for drivers like i2c bus. The real solution
> is to initialize drivers later with standard module_init, and stop
> the race to the bottom with custom initcall levels.
>
> If there is legacy board specific platofrm init code that needs
> i2c gpios early, that code can probably be moved to initialize
> later on.

In this case no i2c is involved. The drivers for both pinctrl
(renesas,pfc-r8a73a4) and irqchip (renesas,irqc) are registered
at the same level:
  - postcore_initcall(sh_pfc_init);
  - postcore_initcall(irqc_init);
Hence the system uses the "natural" order from within the DTS,
and decided to instantiate the pfc before the irqchip.

> Also, there should not be any need for custom driver initcall
> levels from Linux generic framework point of view as for example
> irqchip implementing drivers work just fine as a loadable module.

As long as no other device that's instantiated earlier references that
irqchip?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
