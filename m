From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 27 Sep 2016 14:37:39 +0200
Subject: [PATCH/RFT 0/4] ARM: shmobile: R-Car Gen2: Allow booting
 secondary CPU cores in debug mode
In-Reply-To: <1471877069-4157-1-git-send-email-geert+renesas@glider.be>
References: <1471877069-4157-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdUfV46Y_L2yformTPcnGKpbfFawNOrutyeMk5L4rL5BfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon, Magnus,

On Mon, Aug 22, 2016 at 4:44 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series is an attempt to allow booting secondary CPU cores on
> R-Car Gen2 when hardware debug mode is enabled. In this mode, reset
> requests derived from power-shutoff to the AP-system CPU cores must be
> enabled before the AP-system cores first resume from power-shutoff. Else
> resume may fail, causing the system to hang during boot. Currently we
> avoid the hang by prohibiting booting secondary CPU cores when hardware
> debug mode is enabled.
>
> On all R-Car Gen2 SoCs, hardware debug mode is enabled by setting
> MD21=1.  On both Koelsch and Lager, this is done by setting mode switch
> SW8-4 to OFF.
>
> Unfortunately the hang is not easy to reproduce: I only saw it (on
> Koelsch) during real cold boot (power off during the night), and even
> then it's not guaranteed to trigger. Pressing the reset button
> afterwards recovers the system, and a subsequent boot will succeed
> (incl. secondary CPU core boot).
>
> This series configures the reset requests as documented in the R-Car
> Gen2 datasheet, and removes the check for MD21 during secondary CPU
> bringup.  It was inspired by CPU-specific patches in the BSP by
> Nakamura-san.
>
> This series has been boot-tested on r8a7791/koelsch (both debug mode and
> normal mode), on r8a7790/lager and r8a7793/gose (normal mode only), and
> on r8a7794/alt (normal mode UP only).

Any comments?
Any objection to applying this series?

I've been running my Koelsch with MD21=1 since I posted this series,
and it has been included in renesas-drivers since the beginning of September.

My main motivation to push this is that it removes two more users of
rcar_gen2_read_mode_pins(). After this, the only remaining user is the
clock driver, invoked from rcar_gen2_timer_init().

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
