From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Thu, 01 Mar 2018 17:09:25 +0800
Subject: [PATCH] soc: rockchip: power-domain: remove PM clocks
In-Reply-To: <CAMuHMdU9PFAXwo+1Z7Baw1fanst9yFKZ3ohoSTiQiMKTaYMVVw@mail.gmail.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
 <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
 <CAAFQd5CLXUwH6jTq9ZOpbYt9-Xx-+Kgj-Nk+KujS=Y=qLByc9Q@mail.gmail.com>
 <CAMuHMdWdVdregCRh17Jfa92csBruZvLzAK+M8uajif0BSJTcaw@mail.gmail.com>
 <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com>
 <CAMuHMdVVDiuv7bpdC0X95Xy9dSK_TfjW5RvSekVym9Q02798Fg@mail.gmail.com>
 <CAAFQd5C0GZ9C-pAqAdpuyxaF2xthLPY62a921nmABTbbmYtBmQ@mail.gmail.com>
 <5A977638.8010506@rock-chips.com>
 <CAMuHMdU9PFAXwo+1Z7Baw1fanst9yFKZ3ohoSTiQiMKTaYMVVw@mail.gmail.com>
Message-ID: <5A97C345.3060205@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thanks for your reply.

On 03/01/2018 04:33 PM, Geert Uytterhoeven wrote:
>> >so maybe we can:
>> >1/ let the device(dts) or driver decide which clock is PM clk, and add it
>> >using*pm_clk_add*  APIs (even of_pm_clk_add_clks() if all clocks are pm clk)
>> >
>> >2/ add support for critical PM clk, which would return error to the driver
>> >if anything wrong
>> >
>> >3/ make sure PM clk always be controlled(otherwise it might be unexpected
>> >disabled by other clocks under the same clk parent?):
>> >  a) make sure Runtime PM is always enabled. and as discussed, we can select
>> >PM in ARCH_ROCKCHIP
> On Renesas SoCs, we only add the device's module clock with pm_clk_add().
> Drivers that don't care about properties of the module clock just call
> pm_runtime_*(). That way the same driver works on different SoCs using
> the same device, with and without power and/or clock domains.

well, i think we may need to check:
1/ so the driver might not know is the clock really enabled(currently):

static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
{
     if (!ce->clk)
         ce->clk = clk_get(dev, ce->con_id);
     if (IS_ERR(ce->clk)) {
         ce->status = PCE_STATUS_ERROR;

static inline void __pm_clk_enable(struct device *dev, struct 
pm_clock_entry *ce)
{
     int ret;

     if (ce->status < PCE_STATUS_ERROR) {
         ret = clk_enable(ce->clk);
         if (!ret)
             ce->status = PCE_STATUS_ENABLED;

it seems the status is private.

2/ the pm_clk_resume/suspend seems only be called in the domain's 
suspend/resume ops(or USE_PM_CLK_RUNTIME_OPS, or called directly in the 
drivers for example tegra-aconnect):

# cgrep pm_clk_resume -w
./include/linux/pm_clock.h:50:extern int pm_clk_resume(struct device *dev);
./include/linux/pm_clock.h:83:#define pm_clk_resume     NULL
./drivers/bus/tegra-aconnect.c:62:      return pm_clk_resume(dev);
./drivers/dma/tegra210-adma.c:649:      ret = pm_clk_resume(dev);
./drivers/base/power/clock_ops.c:421: * pm_clk_resume - Enable clocks in 
a device's PM clock list.
./drivers/base/power/clock_ops.c:424:int pm_clk_resume(struct device *dev)
./drivers/base/power/clock_ops.c:444:EXPORT_SYMBOL_GPL(pm_clk_resume);
./drivers/base/power/clock_ops.c:533:   ret = pm_clk_resume(dev);
./drivers/base/power/domain.c:1685:             genpd->dev_ops.start = 
pm_clk_resume;
./drivers/irqchip/irq-gic-pm.c:36:      ret = pm_clk_resume(dev);

so if the device doesn't have a power domain, the PM clks could be 
unmanaged right?

by the way, the tegra drivers(tegra-aconnect/tegra210-adma) seems like 
good examples of using current PM clks...


but anyway, force adding all clocks as PM clks in the rockchip power 
domain driver seems wrong...

>
> Drivers that care about properties of the module clock (mainly frequency)
> can still use the clk_*() API for that. Other (optional) clocks must be
> handled by the device driver itself.
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
>
>
