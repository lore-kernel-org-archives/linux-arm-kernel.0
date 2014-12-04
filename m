From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 4 Dec 2014 13:53:52 +0100
Subject: [PATCH 1/4] ARM: shmobile: R-Mobile: Add SYSC restart handler
In-Reply-To: <CAMuHMdWeFceyn3_TkgsuwakK9UOVUszBFqEv-uRqRC+2a=5XGA@mail.gmail.com>
References: <1417616227-6715-1-git-send-email-geert+renesas@glider.be>
 <1417616227-6715-2-git-send-email-geert+renesas@glider.be>
 <3671800.E1ZjeAe67g@wuerfel>
 <CAMuHMdWeFceyn3_TkgsuwakK9UOVUszBFqEv-uRqRC+2a=5XGA@mail.gmail.com>
Message-ID: <CAMuHMdXqY79KkrmEvnG4qqDaw5x8raxRs2eKBM6E-+DyZwFt-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Dec 4, 2014 at 12:47 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>> This clearly looks much better than the previous implementation, so that
>> is great. If you can decouple it from the rest of this file, either through
>> syscon or by asserting that sysc_base2 is not going to be needed for
>> anything else, how about moving the new code to a standalon driver in
>> drivers/power/reset?
>
> Yes, sysc_base2 is used for reset control only (I don't think we need to read
> the mode strap pins).
>
> So unless there's a simple solution to the regmap problem, I think moving
> this driver part to  drivers/power/reset is the most viable option.

There's another reasone for having a separate driver: if both the SH core and
the ARM core are in use, the second register bank can only be accessed after
acquiring the HPB (Peripheral Bus Bridge) semaphore.
While we don't actively support running anything on the SH core, we don't
want to prevent users from doing that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
