From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 5 Jul 2017 12:33:37 +0100
Subject: Architecture Timer on R-Car Gen2
In-Reply-To: <CAMuHMdWaQLDoOLYjPNkwXNcam-UCCngyaY3D2yZctJrfGg27Xw@mail.gmail.com>
References: <CAMuHMdWaQLDoOLYjPNkwXNcam-UCCngyaY3D2yZctJrfGg27Xw@mail.gmail.com>
Message-ID: <20170705113335.GE25115@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 08:29:38PM +0200, Geert Uytterhoeven wrote:
>         Hi Magnus, Mar[ck], Simon,

Hi,

> We're (finally) getting close to the point where Renesas R-Car Gen2
> platform code no longer relies on hardcoded addresses.
> 
> The remaining parts are related to the ARM Architecture Timer / Generic
> Timer / Generic Counter.  More specifically the code in
> rcar_gen2_timer_init() in arch/arm/mach-shmobile/setup-rcar-gen2.c,
> quoted below.  According to historical information, the issues being
> solved here are (1) non-running timers, and (2) wrong frequencies,
> leading to (m)sleep() not sleeping for the expected period.
> But it's far from clear to me what's really going on...
> 
> >   void __iomem *base;
> >   u32 freq;
> >
> >   /*
> >    * Determine frequency.  Depending on SoC-type, it's either
> >    *   - Crystal / 2 => (usually) 10 MHz (calculated from extal in DT)
> >    *   - ZS clock / 8 => (always) 32.5 MHz (hardcoded)
> >    */
> >   freq = ...
> >
> >   /* Remap "armgcnt address map" space */
> >   base = ioremap(0xe6080000, PAGE_SIZE);
> 
> I believe this region corresponds to the Generic Counter, which is not
> the same, but related to the Architecture timer?
> It seems no DT bindings exist for the Generic Counter?
> 
> (for a moment I thought this might correspond to "arm,armv7-timer-mem", but
>  I no longer believe that's true)

The short of it is that this is *not* described by
"arm,armv7-timer-mem".

Given that this has the CNTCR and CNTFID0 registers, this is the
"counter module". This is not described by the "arm,armv7-timer-mem"
binding.

This is only expected to be of use to boot FW, and the counter module is
liable to be secure only, so this isn't something we want in that
binding, and I am not keen on adding a new binding for it.

For more details, take a look at ARM DDI 0406C.c, D5.2 "Memory-mapped
counter module" on page D5-2399.

> >   /*
> >    * Update the timer if it is either not running, or is not at the
> >    * right frequency. The timer is only configurable in secure mode
> >    * so this avoids an abort if the loader started the timer and
> >    * entered the kernel in non-secure mode.
> >    */
> >
> >   if ((ioread32(base + CNTCR) & 1) == 0 ||
> >       ioread32(base + CNTFID0) != freq) {
> 
> On all SoC/board combos I checked (r8a7790/lager, r8a7791/koelsch,
> r8a7791/porter, r8a7792/blanche, r8a7793/gose, r8a7794/alt), both
> conditions are true, i.e.
>   - The timer (counter?) is not running,
>   - The configured frequency is 13 MHz, which is wrong.
> 
> >           /* Update registers with correct frequency */
> >           iowrite32(freq, base + CNTFID0);

CNTFID<0..n> are ID registers, each describing a frequency that the
counter supports. These may be RO or RW. If the latter, some early
bringup software is expected to fill them in so that subsequent users
see sane values.

These are *not* control registers, and writing to them should have no
affect other than changing the value read back from them.

Note that CNTCR.FCREQ is expected to be programmed with the index of the
desired frequency (resetting to 0).

> This doesn't seem to be needed?
> With or without, both msleep() (kernel) and sleep() (userspace) sleep
> for the expected amount of time.
> 
> >           asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (freq));
> 
> This is an open-coded implementation of arch_timer_set_cntfrq(), which
> is not provided by arch/arm/include/asm/arch_timer.h (should it?).

We expect FW to configure CNTFRQ along with the rest of the boot-time
generic timer initialisation which can only be done from the secure
side.

I'm hesitant to expose a helper that makes it look like this is a
sensible thing to do in the kernel, so I'm not keen on a geneic
arch_timer_set_cntfrq() helper.

> Without this, the arch_timer driver complains:
> 
>     arch_timer: frequency not available
> 
> leading to failures (e.g. division by zero) later.
> 
> However, adding the proper "clock-frequency" property to the
> "arm,armv7-timer" device node in DT fixes that.
> Probably adding this property is a better way to work around broken(?)
> firmware not setting CNTFRQ, than checking the SoC type and using
> hardcoded values in platform code?

The clock-frequency property is also a bodge, and is problemaic for
virtualisation, or in the presence of userspace timer access.

If you can't fix the FW, it would be much nicer to have a
platform-specific bootloader shim set this all up prior to entering the
kernel.

Thanks,
Mark.
