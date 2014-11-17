From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 17 Nov 2014 14:57:46 +0100
Subject: ARM: shmobile: sh73a0: CPU1 failed to come online (Re: [PATCH 0/4]
 ARM: shmobile: r8a7740/armadillo: Migrate to generic l2c OF)
Message-ID: <CAMuHMdWyUJ81G2CLpYScm9qB0KMia0PReBQ8oXdu+Z2P6AWWNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 2:53 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series migrates the DT-based generic r8a7740 platform and the
> armadillo legacy platform from calling l2x0_of_init() to the generic l2c OF
> initialization.
>
> Note that this conversion should be applied to sh73a0, r8a7778, and r8a7779,
> too. More about sh73a0 later.

I tried to convert sh73a0, but it doesn't work, due to problems
bringing up the second
CPU core.

Details:
  - l2x0_of_init() is called much earlier than l2x0_init().
    When the L2 cache is enabled, initialization of the second CPU core of
    sh73a0 (Dual-core Cortex-A9) fails.
  - As jiffies are not yet incrementing at that point (they are on r8a7791?),
    timeouts don't work, and the kernel hangs at the
    wait_for_completion_timeout() call in arch/arm/kernel/smp.c:__cpu_up().
  - This may be related to the intermittent failure to bring up the second
    CPU core when resuming from s2ram:

        CPU1: failed to come online

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
