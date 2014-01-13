From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 13 Jan 2014 09:57:08 +0100
Subject: [PATCH 3/4] thermal: rcar: Add missing clock handling
In-Reply-To: <CAMuHMdW+1yP2PqvLTc0tjyrnhGssvn_iK8mCO6u-++pjGYR9KQ@mail.gmail.com>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
 <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
 <87ha9fxoua.wl%kuninori.morimoto.gx@gmail.com>
 <CAMuHMdW+1yP2PqvLTc0tjyrnhGssvn_iK8mCO6u-++pjGYR9KQ@mail.gmail.com>
Message-ID: <CAMuHMdWVZhWKDS46GWo83z940B9+Z-yt1WrBKSuiS+zwYMqZQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san,

On Wed, Jan 8, 2014 at 11:23 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Jan 8, 2014 at 2:08 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@gmail.com> wrote:
>>> +     common->clk = devm_clk_get(&pdev->dev, NULL);
>>> +     if (IS_ERR(common->clk)) {
>>> +             dev_err(&pdev->dev, "cannot get clock\n");
>>> +             return PTR_ERR(common->clk);
>>> +     }
>>> +
>>> +     ret = clk_prepare(common->clk);
>>> +     if (ret < 0) {
>>> +             dev_err(&pdev->dev, "unable to prepare clock\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     clk_enable(common->clk);
>>> +
>>>       pm_runtime_enable(dev);
>>>       pm_runtime_get_sync(dev);
>>
>> And this patch seems strange for me.
>> pm_runtime_xxx() is doing same things.
>> If it didn't work, wrong place is not driver, clock side ?
>
> That's an interesting observation...

You were right. After applying both of "ARM: shmobile: compile drivers/sh
for CONFIG_ARCH_SHMOBILE_MULTI" and "power: clock_ops.c: fixup clk
prepare/unprepare count" from Ben Dooks the issue went away.

So my patch can be dropped.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
