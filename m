From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 13 May 2014 09:33:45 +0200
Subject: [PATCH 00/03] ARM: shmobile: Use shmobile_init_delay() on r8a7791
In-Reply-To: <20140513071224.GC27611@verge.net.au>
References: <20140511232508.20177.11556.sendpatchset@w520>
 <1509906.x9u0HJ6AbJ@avalon> <20140513005936.GB30252@verge.net.au>
 <20140513071224.GC27611@verge.net.au>
Message-ID: <CAMuHMdWBAkh_Jkfsok-Nws56z0ZsU0LmxV2nob_LKrMY_tFF6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, May 13, 2014 at 9:12 AM, Simon Horman <horms@verge.net.au> wrote:
> From: Simon Horman <horms+renesas@verge.net.au>
>
> [PATCH] ARM: shmobile: Set clock frequency in HZ from OF nodes
>
> shmobile_init_delay() looks for OF "clock-frequency" to determine
> the delay which is set by calling shmobile_setup_delay().
>
> Unfortunately this seems to be incorrect in detail as
> "clock-frequency" node values are in HZ whereas the frequency
> argument to shmobile_setup_delay() is in MHz.

Indeed. Nice catch.

> Provide a variant of shmobile_setup_delay() that accepts HZ to
> correct this problem.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
> index ccecde9..8d80a33 100644
> --- a/arch/arm/mach-shmobile/timer.c
> +++ b/arch/arm/mach-shmobile/timer.c
> @@ -23,21 +23,24 @@
>  #include <linux/delay.h>
>  #include <linux/of_address.h>
>
> -void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
> -                                unsigned int mult, unsigned int div)
> +void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
> +                                   unsigned int mult, unsigned int div)
>  {
>         /* calculate a worst-case loops-per-jiffy value
> -        * based on maximum cpu core mhz setting and the
> +        * based on maximum cpu core hz setting and the
>          * __delay() implementation in arch/arm/lib/delay.S
>          *
>          * this will result in a longer delay than expected
>          * when the cpu core runs on lower frequencies.
>          */
> -
> -       unsigned int value = (1000000 * mult) / (HZ * div);
> -
>         if (!preset_lpj)
> -               preset_lpj = max_cpu_core_mhz * value;
> +               preset_lpj = max_cpu_core_hz * mult / (HZ * div);

I believe it was written this way to avoid integer overflow.
As soon as we get a 2.2 GHz A15 (mult = 2), "max_cpu_core_hz * mult"
will overflow.

When using Hz instead of MHz, we probably want to switch from
multiplying a small number (in MHz) to dividing a large number (in Hz):

        preset_lpj = max_cpu_core_hz / value;

So value should be:

        value = HZ * div / mult;

which is OK as mult is really small (1 or 2).
Does this look right? Haven't had my coffee yet ;-)

All of this will still overflow when clock-frequency no longer fits in u32,
and we have to revise the bindings ;-)

> +}
> +
> +void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
> +                                unsigned int mult, unsigned int div)
> +{
> +       shmobile_setup_delay_hz(max_cpu_core_mhz, mult * 100000, div);

While this works (for now --- no longer with my proposed modifications
above), didn't you intend this?

    shmobile_setup_delay_hz(max_cpu_core_mhz * 1000000, mult, div);

>  }
>
>  void __init shmobile_init_delay(void)
> @@ -58,12 +61,12 @@ void __init shmobile_init_delay(void)
>
>         if (max_freq) {
>                 if (of_find_compatible_node(NULL, NULL, "arm,cortex-a8"))
> -                       shmobile_setup_delay(max_freq, 1, 3);
> +                       shmobile_setup_delay_hz(max_freq, 1, 3);
>                 else if (of_find_compatible_node(NULL, NULL, "arm,cortex-a9"))
> -                       shmobile_setup_delay(max_freq, 1, 3);
> +                       shmobile_setup_delay_hz(max_freq, 1, 3);
>                 else if (of_find_compatible_node(NULL, NULL, "arm,cortex-a15"))
>                         if (!IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
> -                               shmobile_setup_delay(max_freq, 2, 4);
> +                               shmobile_setup_delay_hz(max_freq, 2, 4);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
