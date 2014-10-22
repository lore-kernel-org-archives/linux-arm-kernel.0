From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 22 Oct 2014 19:34:17 +0200
Subject: [PATCH v2] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <20141022160800.GB1895@katana>
References: <1413993263-10444-1-git-send-email-geert+renesas@glider.be>
 <20141022160800.GB1895@katana>
Message-ID: <CAMuHMdUqWaaP9DKADj3t2gTib9_+nNE5N-teLc2dMk_zVowZFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 6:08 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>>     I'm wondering whether this can be fixed in the i2c driver? Does it
>>     really have to enable and disable the clock?
>
> From a power-saving PoV, this makes sense. I assume serial output works
> again as soon as the regular scif driver takes over? Isn't that a

Yes it continues fine afterwards.
With TMU0 in DT, it's enabled again even earlier, as they share the parent.

> generic problem of early_printk drivers that they are not refcounted for
> the clocks?

Yes.

BTW, the code in sh_mobile_i2c_init() does this:

        /* Get clock rate after clock is enabled */
        clk_prepare_enable(pd->clk);
        i2c_clk_khz = clk_get_rate(pd->clk) / 1000;
        clk_disable_unprepare(pd->clk);

I assume the enable/disable is no longer needed with CCF?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
