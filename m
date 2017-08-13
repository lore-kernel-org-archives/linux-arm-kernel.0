From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 13 Aug 2017 20:30:06 +0200
Subject: [PATCH v5 0/6] SMP and CPU hotplug support for Meson8/Meson8b
In-Reply-To: <20170728212138.12217-1-martin.blumenstingl@googlemail.com>
References: <20170728212138.12217-1-martin.blumenstingl@googlemail.com>
Message-ID: <CAFBinCCYMQr3VwLX=7f9ti2MxDecmTdELxb1wiMLsR9_6SZEbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel and all other ARM maintainers,

On Fri, Jul 28, 2017 at 11:21 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> This patchset adds support for booting the secondary CPU cores (and
> taking them offline again) on Amlogic Meson8 and Meson8b SoCs.
> It is based on an earlier version from Carlo Caione - this helped me
> a lot to get a better understanding of how SMP/CPU hotplug works
> (compared to the code found in Amlogic's GPL kernel sources from
> year 2015).
>
>
> The .dts changes from series depend on:
> - "add the reset controller to the Meson8b clkc" version 3, see [1]
this dependency is now queued in Kevin's linux-amlogic tree (and the
pull request for the corresponding clock driver updates is waiting to
be merged as well).

>
> Changes since v4 from [4]:
> - use __pa_symbol(secondary_startup) instead of
>   virt_to_phys(secondary_startup) as suggested by Florian Fainelli
>   (affects patch #4)
> - (cover-letter) removed dependency on my other patch
>   "ARM: dts: meson: add a node which describes the SRAM" [2] as that
>   was merged into Kevin's Amlogic repo today
> - dropped patch #5 ("clk: meson: meson8b: export the CPU soft reset
>   lines") again because the reset controller series exposes the
>   preprocessor macros now directly, see [1]
> - refreshed the .dts patches so they now include the new header for
>   the reset line preprocessor macros
>
> Changes since v3 from [3]:
> - added Rob's ACK to patch #1
> - replaced a msleep(10) with usleep_range(10000, 15000) in patch #4
> - removed all "pen" code from patch #4 as that code was not needed
>   at all (it was left-over while trying to fix Meson8 secondary CPU
>   boot - which turned out to have nothing to do with this "pen" code)
> - removed all memory barrier operations as they were added based on
>   the code in the Amlogic GPL kernel tree (while trying to fix the
>   Meson8 secondary CPU boot - just like the "pen" code). Everything
>   still works fine with these on my Meson8m2 and Meson8b boards.
> - added PATCH #5 as we now have to export the reset identifiers
>   (just like we do it with the clock identifiers / preprocessor
>   macros) - this is the result of a change in the reset controller
>   patch in version 2, see [1]
> - use the reset line preprocessor macros (from patch #5) in patches
>   #6 and #7
>
> Changes since v2 from [0]:
> - added support for Meson8 (which requires a slightly different
>   enable-method)
> - implemented CPU hotplug support which allows taking a CPU core
>   offline for both, Meson8 and Meson8b
> - add a function to smp_scu.c which allows enabling a CPU core from
>   a different CPU (previously only the power mode for the current CPU
>   could be changed). Without this the CPU cores on Meson8 won't come
>   up (Amlogic's vendor GPL kernel sources also enable power through
>   SCU as very first step for Meson8b as well)
> - add a function to smp_scu.c to get the power status of a CPU core
>   (which is needed because the code in .cpu_kill needs to wait until
>   the core is actually powered off)
> - dropped patch "ARM: DTS: meson8b: Extend L2 cache controller node"
>   as it is already applied (for both, Meson8 and Meson8b)
> - dropped the patches which implement the reset controller which is
>   built into the clock-controller, these are a separate series: [1]
> - moved the enable-method property to each CPU node
>
>
> [0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390355.html
> [1] http://lists.infradead.org/pipermail/linux-amlogic/2017-July/004456.html
> [2] http://lists.infradead.org/pipermail/linux-amlogic/2017-July/004282.html
> [3] http://lists.infradead.org/pipermail/linux-amlogic/2017-July/004297.html
> [4] http://lists.infradead.org/pipermail/linux-amlogic/2017-July/004354.html
>
> Carlo Caione (2):
>   dt-bindings: Amlogic: Add Meson8 and Meson8b SMP related documentation
>   ARM: dts: meson8b: add support for booting the secondary CPU cores
>
> Martin Blumenstingl (4):
>   ARM: smp_scu: add a helper for powering on a specific CPU
>   ARM: smp_scu: allow the platform code to read the SCU CPU status
could you please have a look at these patches specifically? please let
me know if these are fine
will you take these patches through some ARM tree or should Kevin take
them through his linux-amlogic tree (I assume that Kevin can simply
take all other patches, as the other ones can go the standard route
for arch/arm/mach-meson, dt-bindings documentation and .dts changes)?

>   ARM: meson: Add SMP bringup code for Meson8 and Meson8b
>   ARM: dts: meson8: add support for booting the secondary CPU cores
>
>  .../devicetree/bindings/arm/amlogic/pmu.txt        |  18 +
>  .../devicetree/bindings/arm/amlogic/smp-sram.txt   |  32 ++
>  Documentation/devicetree/bindings/arm/cpus.txt     |   2 +
>  arch/arm/Makefile                                  |   1 +
>  arch/arm/boot/dts/meson8.dtsi                      |  21 +
>  arch/arm/boot/dts/meson8b.dtsi                     |  21 +
>  arch/arm/include/asm/smp_scu.h                     |  12 +
>  arch/arm/kernel/smp_scu.c                          |  47 ++-
>  arch/arm/mach-meson/Kconfig                        |   1 +
>  arch/arm/mach-meson/Makefile                       |   1 +
>  arch/arm/mach-meson/platsmp.c                      | 440 +++++++++++++++++++++
>  11 files changed, 590 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/pmu.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
>  create mode 100644 arch/arm/mach-meson/platsmp.c
>
> --
> 2.13.3
>


Thank you!
Regards,
Martin
