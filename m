From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Sep 2012 21:01:38 +0200
Subject: [PATCH] RFC: ARM: nomadik/ux500: convert to SPARSE_IRQ
In-Reply-To: <1347629033-30451-1-git-send-email-linus.walleij@stericsson.com>
References: <1347629033-30451-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkda3zSktJH9xbPb1bZSiC2HV5wKYs-65h_-Zrtzya9ut0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 3:23 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> This converts the Nomadik and Ux500 over to using sparse IRQ,
> including some pokes around the pinctrl driver. To avoid
> referencing unnecessary header files, the plat-nomadik timer
> driver is augmented to pass an irq number at init time, and
> the change is applied across both platforms simultaneously
> for this reason.
>
> The change works fine for the Nomadik with it's VIC IRQ
> controller, whereas the GIC on ux500 complains like this:
>
> ------------[ cut here ]------------
> WARNING: at /home/elinwal/linux-stericsson/arch/arm/common/gic.c:713 gic_init_bases+0xe8/0x290()
> Cannot allocate irq_descs @ IRQ16, assuming pre-allocated
> Modules linked in:
> [<c0014710>] (unwind_backtrace+0x0/0xf8) from [<c001d304>] (warn_slowpath_common+0x4c/0x64)
> [<c001d304>] (warn_slowpath_common+0x4c/0x64) from [<c001d3b0>] (warn_slowpath_fmt+0x30/0x40)
> [<c001d3b0>] (warn_slowpath_fmt+0x30/0x40) from [<c03e60f8>] (gic_init_bases+0xe8/0x290)
> [<c03e60f8>] (gic_init_bases+0xe8/0x290) from [<c03e6560>] (ux500_init_irq+0xb0/0xfc)
> [<c03e6560>] (ux500_init_irq+0xb0/0xfc) from [<c03e2114>] (init_IRQ+0x14/0x1c)
> [<c03e2114>] (init_IRQ+0x14/0x1c) from [<c03df698>] (start_kernel+0x198/0x2ec)
> [<c03df698>] (start_kernel+0x198/0x2ec) from [<00008044>] (0x8044)
> ---[ end trace 1b75b31a2719ed1c ]---

Paging ARM SoC maintainers to see of this warning is OK when doing
sparse IRQ.

Recap:
- Displays when the using static IRQs in the range used by the GIC
  from <mach/irqs.h> or so.
- Getting rid of it the proper way means switching to DT and IRQ domain
- Feels like the warning is punishing for doing a stepwise migration?
- Can it be tolerated?

Yours,
Linus Walleij
