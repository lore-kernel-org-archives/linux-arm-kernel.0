From: dann.frazier@canonical.com (dann frazier)
Date: Mon, 6 Mar 2017 14:48:50 -0700
Subject: [PATCH 00/17] clocksource/arch_timer: Errara workaround
 infrastructure rework
In-Reply-To: <20170306112622.13853-1-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
Message-ID: <CALdTtntmgZDzKWgveydH0vCBTO74Tu=tHCQYSTkVt476G=SR6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 6, 2017 at 4:26 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
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
>
> Note that so far, we only deal with arm64. Once the infrastructure is
> agreed upon, we can look at generalizing it (to some extent) to 32bit
> ARM (typical use case would be a 32bit guest running on an affected
> host).

Thanks Marc. Worked on our HiSilicon board:

[    0.000000] arm_arch_timer: Enabling global workaround for
HiSilicon erratum 161010101
[    0.000000] arm_arch_timer: CPU0: Trapping CNTVCT access
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at
50.00MHz (phys).
[    0.266571] arm_arch_timer: CPU1: Trapping CNTVCT access
[    0.270108] arm_arch_timer: CPU2: Trapping CNTVCT access
[...]

Tested-by: dann frazier <dann.frazier@canonical.com>

  -dann
