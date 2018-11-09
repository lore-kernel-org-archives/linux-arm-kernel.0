From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 9 Nov 2018 10:56:01 +0100
Subject: [PATCH 1/4] of/device: Add a way to probe drivers by match data
In-Reply-To: <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
 <CAL_JsqLvKWcJUYDyWOg3rMeEWv7JV4zw7-YkOUWiL5rfXgVRvQ@mail.gmail.com>
 <154161585170.88331.1822872519370217248@swboyd.mtv.corp.google.com>
Message-ID: <CAMuHMdUTwUTdbKAWCNxH72-tvJuY-LtRO2Dh8izdEOKrFOSwLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Nov 7, 2018 at 7:37 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Rob Herring (2018-11-06 12:44:52)
> > On Tue, Nov 6, 2018 at 12:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > We have a handful of clk drivers that have a collection of slightly
> > > variant device support keyed off of the compatible string. In each of
> > > these drivers, we demux the variant and then call the "real" probe
> > > function based on whatever is stored in the match data for that
> > > compatible string. Let's generalize this function so that it can be
> > > re-used as the platform_driver probe function directly.
> >
> > This looks really hacky to me. It sounds kind of general, but really
> > only works if we have match data that's a single function and we lose
> > any type checking on the function.
>
> I don't know what this means. Are you saying that we lose the ability to
> type check the function pointer stored in the data member? I don't have
> a good answer for this besides it's not any worse than the status quo
> for the mediatek drivers.

The .data field has always been void *, and is used for storing different
things, depending on the driver.
It's already up to the driver writer to get that right.

> One alternative is to add a DT only array to the platform_driver struct
> that has the platform driver probe function type and matches the index
> in the of_device_id table. Then we can add some logic into
> platform_drv_probe() to look for this table being set and find the probe
> function to call. Then we still have match data for anything that wants
> that (maybe it could be passed in to the probe function) at the cost of
> having another array. I don't have a use-case for this right now so I'm
> not sure this is a great idea.
>
>   struct of_platform_driver_probe_func {
>         int (*probe)(struct platform_device *pdev);
>   };
>
>   struct of_platform_driver_probe_func mtk_probes[] = {
>         mtk_probe1,
>         mtk_probe2,
>         mtk_probe3,
>   };
>
>   struct platform_driver mtk_driver = {
>         .of_probes = &mtk_probes;
>         .driver = {
>                 .name = "mtk-foo";
>                 .of_match_table = mtk_match_table,
>         },
>   };

This looks worse to me: people tend to be very good at keeping multiple
arrays in sync :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
