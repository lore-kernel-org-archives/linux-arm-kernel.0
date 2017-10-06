From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 06 Oct 2017 14:30:05 -0700
Subject: [PATCH v7 0/6] SMP and CPU hotplug support for Meson8/Meson8b
In-Reply-To: <CAFBinCCdj8LwXvUSoCPeVfPUTaLVFFyvKZcNceLGvj26Z740DQ@mail.gmail.com>
 (Martin Blumenstingl's message of "Sun, 1 Oct 2017 14:19:11 +0200")
References: <20170917164523.6970-1-martin.blumenstingl@googlemail.com>
 <CAFBinCCdj8LwXvUSoCPeVfPUTaLVFFyvKZcNceLGvj26Z740DQ@mail.gmail.com>
Message-ID: <7hpoa07yn6.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hello Russel, Hi Kevin,
>
> On Sun, Sep 17, 2017 at 6:45 PM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>> This patchset adds support for booting the secondary CPU cores (and
>> taking them offline again) on Amlogic Meson8 and Meson8b SoCs.
>> It is based on an earlier version from Carlo Caione - this helped me
>> a lot to get a better understanding of how SMP/CPU hotplug works
>> (compared to the code found in Amlogic's GPL kernel sources from
>> year 2015).
>>
>> Changes since v6 from [6]:
>> - rebased on top of v4.14-rc1 (which only corrected some line
>>   numbers in the SCU patches)
> it's been two weeks since v6 and since then Linus L?ssing has
> confirmed that this works fine on his Odroid-C1 as well (many thanks
> for testing!): [7]
>
>> Changes since v5 from [5]:
>> - dropped dependency on another patch series (for the clock
>>   controller's embedded reset controller, which is needed to boot
>>   the secondary CPUs) from the cover-letter as that series is now
>>   merged
>> - fix incorrect documentation of scu_cpu_power_enable (thanks to
>>   Russell King for spotting these). removed the paragraph about
>>   preemption, cache coherency and interrupts as we're powering on
>>   a CPU core (the text was copied from the original scu_power_mode
>>   but simply not adjusted). also changed "Set the executing CPUs"
>>   to "Set the given (logical) CPU's" as we're not modifying the
>>   current CPU. this affects only patch #2
>> - extended the commit message of patch #3 with a short sentence
>>   about why SCU_CPU_STATUS_MASK was introduced
>>
>> Changes since v4 from [4]:
>> - use __pa_symbol(secondary_startup) instead of
>>   virt_to_phys(secondary_startup) as suggested by Florian Fainelli
>>   (affects patch #4)
>> - (cover-letter) removed dependency on my other patch
>>   "ARM: dts: meson: add a node which describes the SRAM" [2] as that
>>   was merged into Kevin's Amlogic repo today
>> - dropped patch #5 ("clk: meson: meson8b: export the CPU soft reset
>>   lines") again because the reset controller series exposes the
>>   preprocessor macros now directly, see [1]
>> - refreshed the .dts patches so they now include the new header for
>>   the reset line preprocessor macros
>>
>> Changes since v3 from [3]:
>> - added Rob's ACK to patch #1
>> - replaced a msleep(10) with usleep_range(10000, 15000) in patch #4
>> - removed all "pen" code from patch #4 as that code was not needed
>>   at all (it was left-over while trying to fix Meson8 secondary CPU
>>   boot - which turned out to have nothing to do with this "pen" code)
>> - removed all memory barrier operations as they were added based on
>>   the code in the Amlogic GPL kernel tree (while trying to fix the
>>   Meson8 secondary CPU boot - just like the "pen" code). Everything
>>   still works fine with these on my Meson8m2 and Meson8b boards.
>> - added PATCH #5 as we now have to export the reset identifiers
>>   (just like we do it with the clock identifiers / preprocessor
>>   macros) - this is the result of a change in the reset controller
>>   patch in version 2, see [1]
>> - use the reset line preprocessor macros (from patch #5) in patches
>>   #6 and #7
>>
>> Changes since v2 from [0]:
>> - added support for Meson8 (which requires a slightly different
>>   enable-method)
>> - implemented CPU hotplug support which allows taking a CPU core
>>   offline for both, Meson8 and Meson8b
>> - add a function to smp_scu.c which allows enabling a CPU core from
>>   a different CPU (previously only the power mode for the current CPU
>>   could be changed). Without this the CPU cores on Meson8 won't come
>>   up (Amlogic's vendor GPL kernel sources also enable power through
>>   SCU as very first step for Meson8b as well)
>> - add a function to smp_scu.c to get the power status of a CPU core
>>   (which is needed because the code in .cpu_kill needs to wait until
>>   the core is actually powered off)
>> - dropped patch "ARM: DTS: meson8b: Extend L2 cache controller node"
>>   as it is already applied (for both, Meson8 and Meson8b)
>> - dropped the patches which implement the reset controller which is
>>   built into the clock-controller, these are a separate series: [1]
>> - moved the enable-method property to each CPU node
>>
>>
>> [0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/390355.html
>> [1] http://lists.infradead.org/pipermail/linux-amlogic/2017-July/004456.html
>> [2] http://lists.infradead.org/pipermail/linux-amlogic/2017-July/004282.html
>> [3] http://lists.infradead.org/pipermail/linux-amlogic/2017-July/004297.html
>> [4] http://lists.infradead.org/pipermail/linux-amlogic/2017-July/004354.html
>> [5] http://lists.infradead.org/pipermail/linux-amlogic/2017-July/004460.html
>> [6] http://lists.infradead.org/pipermail/linux-amlogic/2017-August/004588.html
>>
>> Carlo Caione (2):
>>   dt-bindings: Amlogic: Add Meson8 and Meson8b SMP related documentation
>>   ARM: dts: meson8b: add support for booting the secondary CPU cores
>>
>> Martin Blumenstingl (4):
>>   ARM: smp_scu: add a helper for powering on a specific CPU
>>   ARM: smp_scu: allow the platform code to read the SCU CPU status
>>   ARM: meson: Add SMP bringup code for Meson8 and Meson8b
>>   ARM: dts: meson8: add support for booting the secondary CPU cores
> @Russel: should Kevin take all patches including the two smp_scu ones?
> or do you want to take them through your own tree?

With Russell's ack, I can take the series via the amlogic tree.  But I'm
also fine if Russell wants to take the arch/arm/* via his tree, and I
will just queue up the DT.

Kevin
