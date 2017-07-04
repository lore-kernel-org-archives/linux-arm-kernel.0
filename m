From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 4 Jul 2017 20:29:38 +0200
Subject: Architecture Timer on R-Car Gen2
Message-ID: <CAMuHMdWaQLDoOLYjPNkwXNcam-UCCngyaY3D2yZctJrfGg27Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

        Hi Magnus, Mar[ck], Simon,

We're (finally) getting close to the point where Renesas R-Car Gen2
platform code no longer relies on hardcoded addresses.

The remaining parts are related to the ARM Architecture Timer / Generic
Timer / Generic Counter.  More specifically the code in
rcar_gen2_timer_init() in arch/arm/mach-shmobile/setup-rcar-gen2.c,
quoted below.  According to historical information, the issues being
solved here are (1) non-running timers, and (2) wrong frequencies,
leading to (m)sleep() not sleeping for the expected period.
But it's far from clear to me what's really going on...

>   void __iomem *base;
>   u32 freq;
>
>   /*
>    * Determine frequency.  Depending on SoC-type, it's either
>    *   - Crystal / 2 => (usually) 10 MHz (calculated from extal in DT)
>    *   - ZS clock / 8 => (always) 32.5 MHz (hardcoded)
>    */
>   freq = ...
>
>   /* Remap "armgcnt address map" space */
>   base = ioremap(0xe6080000, PAGE_SIZE);

I believe this region corresponds to the Generic Counter, which is not
the same, but related to the Architecture timer?
It seems no DT bindings exist for the Generic Counter?

(for a moment I thought this might correspond to "arm,armv7-timer-mem", but
 I no longer believe that's true)

>   /*
>    * Update the timer if it is either not running, or is not at the
>    * right frequency. The timer is only configurable in secure mode
>    * so this avoids an abort if the loader started the timer and
>    * entered the kernel in non-secure mode.
>    */
>
>   if ((ioread32(base + CNTCR) & 1) == 0 ||
>       ioread32(base + CNTFID0) != freq) {

On all SoC/board combos I checked (r8a7790/lager, r8a7791/koelsch,
r8a7791/porter, r8a7792/blanche, r8a7793/gose, r8a7794/alt), both
conditions are true, i.e.
  - The timer (counter?) is not running,
  - The configured frequency is 13 MHz, which is wrong.

>           /* Update registers with correct frequency */
>           iowrite32(freq, base + CNTFID0);

This doesn't seem to be needed?
With or without, both msleep() (kernel) and sleep() (userspace) sleep
for the expected amount of time.

>           asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (freq));

This is an open-coded implementation of arch_timer_set_cntfrq(), which
is not provided by arch/arm/include/asm/arch_timer.h (should it?).
Without this, the arch_timer driver complains:

    arch_timer: frequency not available

leading to failures (e.g. division by zero) later.

However, adding the proper "clock-frequency" property to the
"arm,armv7-timer" device node in DT fixes that.
Probably adding this property is a better way to work around broken(?)
firmware not setting CNTFRQ, than checking the SoC type and using
hardcoded values in platform code?

>           /* make sure arch timer is started by setting bit 0 of CNTCR */
>           iowrite32(1, base + CNTCR);

This is definitely needed.  Else the timer doesn't run.

>   }
>
>   iounmap(base);

Thanks for your time!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
