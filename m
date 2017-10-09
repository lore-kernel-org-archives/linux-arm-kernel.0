From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 9 Oct 2017 15:05:00 +0200
Subject: [PATCH v3 0/6] clk: renesas: r8a779[56]: Add Z and Z2 clock
 support
In-Reply-To: <1507209837-16938-1-git-send-email-horms+renesas@verge.net.au>
References: <1507209837-16938-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdW83Wv1d9oKCcHRUh+kSnxxDrgFvfgT=f5t9nq0C8Jq6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Oct 5, 2017 at 3:23 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> this patch-set adds Z and Z2 clock support.
>
> These are dependencies for supporting CPUFreq. The remainder of that
> work is being posted separately and can be found at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/rcar-gen3-cpufreq
>
>
> A description of steps taken to lightly exercise the same feature for the
> r88a7795 the above can be found at the link below. The results are the same
> for the r8a7796 with the exception that it has two active CPU cores rather
> than four.
>
> http://elinux.org/Tests:R-CAR-GEN3-CPUFreq

Thanks for your patches!

I see the following anomalies on Salvator-X (R-Car H3 ES1.0 and M3-W ES1.0)
and Salvator-XS (R-Car H3 ES2.0):

1. dmesg:

    cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 2999999 KHz
    cpu cpu0: dev_pm_opp_set_rate: failed to find current OPP for freq
2999999880 (-34)
    cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed
to: 1500000 KHz

2. Z2 clock frequency:

    grep -wE "(z|z2)" /sys/kernel/debug/clk/clk_summary
          z2                              0            0  2399999904
       0 0
          z                               0            0  1499999940
       0 0

So Linux is off by a factor of two for the initial Z and Z2 clock frequencies.
Which means it's probably off by a factor of two all the time, and thus running
the CA57 CPU cores at 750 MHz instead of 1.5 GHz?

<looking@the PMU cycle counter>

Yes, it's only running at 750 MHz.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
