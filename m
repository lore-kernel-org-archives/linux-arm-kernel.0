From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 7 Mar 2017 20:56:59 +0800
Subject: [PATCH 00/17] clocksource/arch_timer: Errara workaround
 infrastructure rework
In-Reply-To: <20170306112622.13853-1-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
Message-ID: <1b9f55f7-fdb2-289c-13ae-b5911e45b0ed@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 2017/3/6 19:26, Marc Zyngier wrote:
> It has recently become obvious that a number of arm64 systems have
> been blessed with a set of timers that are slightly less than perfect,
> and require a bit of hand-holding. We already have a bunch of
> errata-specific code to deal with this, but as we're adding more
> potential detection methods (DT, ACPI, capability), things are getting
> a bit out of hands.
>
> Instead of adding more ad-hoc fixes to an already difficult code base,
> let's give ourselves a bit of an infrastructure that can deal with
> this and hide most of the uggliness behind frendly accessors.
>
> The series is structured as such:
>
> - The first half of the series rework the existing workarounds,
>   allowing errata to be matched using a given detection method
>
> - Another patch allows a workaround to affect a subset of the CPUs,
>   and not the whole system
>
> - Another set of patches allow the virtual counter to be trapped when
>   accessed from userspace (something that affects the current set of
>   broken platform, and that is not worked around yet)
>
> - We then work around a Cortex-A73 erratum, whose counter can return a
>   wrong value if read while crossing a 32bit boundary
>
> - Finally, we add some ACPI-specific workarounds for HiSilicon
>   platforms that have the HISILICON_ERRATUM_161010101 defect.

Thanks for doing this, I tested this patch set on D03, and it boots
OK with log:

[    0.000000] arm_arch_timer: Enabling global workaround for HiSilicon 
erratum 161010101
[    0.000000] arm_arch_timer: CPU0: Trapping CNTVCT access
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 
50.00MHz (phys).

With patches other than Cortex-A73 erratum,

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
