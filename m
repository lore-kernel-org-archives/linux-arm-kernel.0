From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 23 Aug 2017 17:20:55 +0200
Subject: [PATCH v2 0/6] clk: renesas: r8a779[56]: Add Z and Z2 clock
 support
In-Reply-To: <1503320487-13591-1-git-send-email-horms+renesas@verge.net.au>
References: <1503320487-13591-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdX62COFSZPQw7UBMtnqA+pCbV1GeK9nfUrJ6K+aM7-zcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Aug 21, 2017 at 3:01 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> this patch-set adds Z and Z2 clock support.
>
> These are dependencies for supporting CPUFreq. The remainder of that
> work is being posted separately and can be found at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/rcar-gen3-cpufreq
>
> A description of steps taken to lightly exercise the same feature for the
> r88a7795 the above can be found at the link below. The results are the same
> for the r8a7796 with the exception that it has two active CPU cores rather
> than four.
>
> http://elinux.org/Tests:R-CAR-GEN3-CPUFreq

Thanks for your patches, and the wiki page!

I gave it a try on R-Car H3 (ES1.0 and ES2.0) and M3-W (ES1.0), and the
off-by-two factor of the Z clock frequency is gone.
I couldn't test on R-Car H3 ES1.1. Probably it's OK, too (ES1.1 fixed the
missing PLL0/2/4 post-divider in ES1.0).

1. After boot-up, the CPU clock frequency is 1.5 GHz, and
   /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq and
   /sys/kernel/debug/clk/z/clk_rate agree. Good.

2. After switching to the conservative governor, scaling_cur_freq reports
   either a 500 MHz or 1 GHz clock rate.
   But /sys/kernel/debug/clk/z/clk_rate disagrees: it reports either a 200
   or 700 MHz clock rate.

   Ah, there's also cpuinfo_cur_freq. That value matches the Z clock.
   Interestingly, cpuinfo_cur_freq is lower than cpuinfo_min_freq?
   /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:200000
   /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:1500000
   /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:500000

3. After switching back to the performance governor, scaling_cur_freq reports
   1.5 GHz again.
   But cpuinfo_cur_freq is still only 700 MHz, just like z/clk_rate.

Do you know what's wrong?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
