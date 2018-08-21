From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 21 Aug 2018 17:45:43 +0200
Subject: bcm2837: tons of DMA mask not set in 4.18.0-rc6-next-20180727
In-Reply-To: <aee486c9-e503-ce1a-9102-82712be2db62@arm.com>
References: <325098108.159647.1532708245242@email.1und1.de>
 <aee486c9-e503-ce1a-9102-82712be2db62@arm.com>
Message-ID: <CAMuHMdURr7nLs3d1G4KyM9MCtY2veP2jV6Fid4qhjDyo-A3F7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

CC Lee (mfd), Wolfram (i2c), Marek (bd9571wmv + recent da9063 hacking)

On Fri, Jul 27, 2018 at 6:28 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 27/07/18 17:17, Stefan Wahren wrote:
> > i was noticed that recent linux-next on Raspberry Pi 3 (32 bit) doesn't boot anymore. So i tested todays linux-next with multi_v7_defconfig and i'm getting a lot of DMA mask not set warnings. At least USB dwc2 is broken.
> >
> > Any suggestions before i start to bisect?
>
> https://patchwork.kernel.org/patch/10547231/
>
> Although the upside of this hiccup is that it should give us a fair view
> of how many active drivers are still relying on implicit default DMA
> masks - I'm now waiting for kernelci's boot chart to catch up with
> today's -next to see the full fallout...

I'm still seeing the following on r8a7791/koelsch with a DA9063 PMIC, which
is an MFD device:

    da9063-watchdog da9063-watchdog: DMA mask not set
    da9063-rtc da9063-rtc: DMA mask not set

The dma masks (both normal and coherent) are NULL, and inherited from the
i2c parent device (6-0058):

        pmic at 58 {
                compatible = "dlg,da9063";
                reg = <0x58>;
                interrupt-parent = <&irqc0>;
                interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
                interrupt-controller;

                rtc {
                        compatible = "dlg,da9063-rtc";
                };

                wdt {
                        compatible = "dlg,da9063-watchdog";
                };
        };

The DA9063 MFD driver creates more subdevices than the two listed above,
but the warning doesn't trigger for them, presumably because they don't
have corresponding nodes in DT.

On r8a779{5,6,65}*/salvator-x, there's also an MFD device (BD9571WMC PMIC)
on an i2c bus, inheriting NULL DMA masks from its parent, but it doesn't
have any subnodes in DT, and the warning isn't triggered neither.

Anyone with a clue?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
