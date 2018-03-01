From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 1 Mar 2018 09:33:22 +0100
Subject: [PATCH] soc: rockchip: power-domain: remove PM clocks
In-Reply-To: <5A977638.8010506@rock-chips.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
 <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
 <CAAFQd5CLXUwH6jTq9ZOpbYt9-Xx-+Kgj-Nk+KujS=Y=qLByc9Q@mail.gmail.com>
 <CAMuHMdWdVdregCRh17Jfa92csBruZvLzAK+M8uajif0BSJTcaw@mail.gmail.com>
 <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com>
 <CAMuHMdVVDiuv7bpdC0X95Xy9dSK_TfjW5RvSekVym9Q02798Fg@mail.gmail.com>
 <CAAFQd5C0GZ9C-pAqAdpuyxaF2xthLPY62a921nmABTbbmYtBmQ@mail.gmail.com>
 <5A977638.8010506@rock-chips.com>
Message-ID: <CAMuHMdU9PFAXwo+1Z7Baw1fanst9yFKZ3ohoSTiQiMKTaYMVVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

On Thu, Mar 1, 2018 at 4:40 AM, JeffyChen <jeffy.chen@rock-chips.com> wrote:
> if i'm reading the code right, the PM clk means:
> 1/ the clocks which would be enabled while power on
> 2/ these clocks are optional, it's ok if anything wrong with them
> 3/ controlled by pm_domain(or USE_PM_CLK_RUNTIME_OPS & pm_clk_add_notifier)
>
> and currently we're adding all clocks of the attached device as PM clk in
> rockchip PM domain driver, which seems wrong. because we might have these
> kinds of clocks:
> 1/ critical, should block power on if anything wrong with it(failed to get/
> prepare/ enable)
> 2/ optional, could ignore it if anything wrong
> 3/ only required in some special cases, for example register r/w, and
> doesn't need to stay enabled while power on
>
> so maybe we can:
> 1/ let the device(dts) or driver decide which clock is PM clk, and add it
> using *pm_clk_add* APIs (even of_pm_clk_add_clks() if all clocks are pm clk)
>
> 2/ add support for critical PM clk, which would return error to the driver
> if anything wrong
>
> 3/ make sure PM clk always be controlled(otherwise it might be unexpected
> disabled by other clocks under the same clk parent?):
>  a) make sure Runtime PM is always enabled. and as discussed, we can select
> PM in ARCH_ROCKCHIP

On Renesas SoCs, we only add the device's module clock with pm_clk_add().
Drivers that don't care about properties of the module clock just call
pm_runtime_*(). That way the same driver works on different SoCs using
the same device, with and without power and/or clock domains.

Drivers that care about properties of the module clock (mainly frequency)
can still use the clk_*() API for that. Other (optional) clocks must be
handled by the device driver itself.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
