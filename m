From: k.kozlowski.k@gmail.com (=?UTF-8?Q?Krzysztof_Koz=C5=82owski?=)
Date: Sun, 14 Jun 2015 17:56:20 +0900
Subject: [RFC] ARM: exynos: MCPM: [is this a] fix for secondary boot on
 5422?
In-Reply-To: <1416896510-24612-1-git-send-email-khilman@kernel.org>
References: <1416896510-24612-1-git-send-email-khilman@kernel.org>
Message-ID: <CAJKOXPfLEV1sQsz87ULDKX4vijqRpbGj7AcOEDiy83kukvVKVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-25 15:21 GMT+09:00 Kevin Hilman <khilman@kernel.org>:
> From: Kevin Hilman <khilman@linaro.org>
>
> Using the current exynos_defconfig on the exynos5422-odroid-xu3, only
> 6 of 8 CPUs come online with MCPM boot.  CPU0 is an A7, CPUs 1-4 are
> A15s and CPU5-7 are the other A7s, but with the current code, CPUs 5
> and 7 do not boot:
>
>    [...]
>    Exynos MCPM support installed
>    CPU1: update cpu_capacity 1535
>    CPU1: thread -1, cpu 0, socket 0, mpidr 80000000
>    CPU2: update cpu_capacity 1535
>    CPU2: thread -1, cpu 1, socket 0, mpidr 80000001
>    CPU3: update cpu_capacity 1535
>    CPU3: thread -1, cpu 2, socket 0, mpidr 80000002
>    CPU4: update cpu_capacity 1535
>    CPU4: thread -1, cpu 3, socket 0, mpidr 80000003
>    CPU5: failed to come online
>    CPU6: update cpu_capacity 448
>    CPU6: thread -1, cpu 2, socket 1, mpidr 80000102
>    CPU7: failed to come online
>    Brought up 6 CPUs
>    CPU: WARNING: CPU(s) started in wrong/inconsistent modes
>    (primary CPU mode 0x13)
>    CPU: This may indicate a broken bootloader or firmware.
>
> Thanks to a tip from Abhilash, this patch gets all 8 CPUs booting
> again, but the warning about CPUs started in inconsistent modes
> remains.  Also, not being terribly familiar with Exynos internals,
> it's not at all obvious to me why this register write (done for *all*
> secondaries) makes things work works for the 2 secondary CPUs that
> didn't come online.  It's also not obvious whether this is the right
> general fix, since it doesn't seem to be needed on other 542x or 5800
> platforms.
>
> I suspect the "right" fix is in the bootloader someplace, but not
> knowing this hardware well, I'm not sure if the fix is in u-boot
> proper, or somewhere in the binary blobs (bl1/bl2/tz) that start
> before u-boot.  The u-boot I'm using is from the hardkernel u-boot
> repo[1], and I'd welcome any suggestions to try.  I'm able to rebuild
> my own u-boot from there, but only have binaries for bl1/bl2/tz.
>
> [1] branch "odroidxu3-v2012.07" of: https://github.com/hardkernel/u-boot.git
>
>
> Cc: Mauro Ribeiro <mauro.ribeiro@hardkernel.com>
> Cc: Abhilash Kesavan <a.kesavan@samsung.com>,
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
>  arch/arm/mach-exynos/mcpm-exynos.c | 2 ++
>  arch/arm/mach-exynos/regs-pmu.h    | 1 +
>  2 files changed, 3 insertions(+)

Hi,

+Cc Marek, Bartlomiej, Kukjin Kim,


I would like to bring back this topic. Unfortunately I don't have
access to source code of BL1 (or any other firmware blob) so my
knowledge here comes mostly from experimenting and from looking at
sources of vendor kernel for Gear 2 (Exynos3250) and SM-G900H (Galaxy
S5, Exynos5422).

It seems that some booting firmware (I would suspect BL1 because this
ships Samsung to Hardkernel) uses SPARE2 as synchronization mechanism.
For example vendor kernel, when booting little core, it waits till
SPARE2==1 and then executes software reset for this core.

Observations shown that BL1 for Odroid, when booting secondary little core:
1. Expects that SPARE2 register will be initialized to 1.
2. If it is, then it sets it to 0, proceeds further and little core boots.
3. If it is not, then it sets it to 1 and waits. Maybe this is a
notification to userspace - reset me please!

Unfortunately executing software reset in that time (at point 3)
stopped kernel from booting. No logs/dmesg and I was unable to turn on
early printk.

The answer why two of little cores boot is quite simple now. At
beginning the SPARE2==0 so first little core will set it to 1 and wait
till software reset. Kernel timeouts on this CPU bring up so it starts
the sequence for next little core. Now the SPARE2==1 so the core boots
fine and SPARE2 is set to 0. The last little core starts from
SPARE2==0, sets it to 1 and waits for software reset.

Since no one knows how this exactly works and we are stuck with BL1
provided as is, then IMHO the patch makes sense.

Kevin, can you refresh the patch?
It would be nice to:
1. set SPARE2 only for Odroid (of_machine_is_compatible()),
2. extend the explanation.


Best regards,
Krzysztof
