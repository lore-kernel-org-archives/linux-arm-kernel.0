From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 10 Feb 2015 11:19:39 +0100
Subject: [PATCH] ARM: shmobile: r8a73a4: Move pfc node to work around
 probe ordering bug
In-Reply-To: <20150209182918.GA2531@atomide.com>
References: <1423254173-31852-1-git-send-email-geert+renesas@glider.be>
 <20150209162428.GG25235@atomide.com>
 <CAMuHMdXsbmcgRacg9CT9N7+KjOrog2F8mmGfORu31P3xyoVviA@mail.gmail.com>
 <20150209182918.GA2531@atomide.com>
Message-ID: <CAMuHMdUmftjWD=hZVYVOGJWBc6tb1h=ZnMv61_nCROkOC=e_iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 9, 2015 at 7:29 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Geert Uytterhoeven <geert@linux-m68k.org> [150209 09:17]:
>> On Mon, Feb 9, 2015 at 5:24 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Geert Uytterhoeven <geert+renesas@glider.be> [150206 12:26]:
>> >> Notes:
>> >>   - It seems several people tried to solve this in the core OF probing
>> >>     code before, but the final solution never went in?
>> >>   - This can be reproduced on other SoCs (e.g. sh73a0 and r8a7740) by
>> >>     moving their pfc nodes before their interrupt controller nodes.
>> >>   - This patch is against my working tree, so it doesn't apply to
>> >>     Simon's repository, but you get the idea....
>> >
>> > No issues with the patch, but here are few comments on the core
>> > reasons (without looking at the code in this case) that might help
>> > fix similar issues.
>> >
>> > In all the cases I've seen these errors are caused by non-standard
>> > custom initcall levels for drivers like i2c bus. The real solution
>> > is to initialize drivers later with standard module_init, and stop
>> > the race to the bottom with custom initcall levels.
>> >
>> > If there is legacy board specific platofrm init code that needs
>> > i2c gpios early, that code can probably be moved to initialize
>> > later on.
>>
>> In this case no i2c is involved. The drivers for both pinctrl
>> (renesas,pfc-r8a73a4) and irqchip (renesas,irqc) are registered
>> at the same level:
>>   - postcore_initcall(sh_pfc_init);
>>   - postcore_initcall(irqc_init);
>> Hence the system uses the "natural" order from within the DTS,
>> and decided to instantiate the pfc before the irqchip.
>
> OK

I tried converting the renesas,irqc driver to IRQCHIP_DECLARE().
This solves the probe ordering problem, but it no longer allows the use of
a platform device. As I was already adding clock and runtime PM support
(which use platform devices), IRQCHIP_DECLARE doesn't look like the
right road to follow...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
