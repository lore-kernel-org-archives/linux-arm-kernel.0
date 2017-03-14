From: c.jayachandran@gmail.com (Jayachandran C.)
Date: Tue, 14 Mar 2017 17:42:18 +0530
Subject: [PATCH 14/14] arm64: pmuv3: use arm_pmu ACPI framework
In-Reply-To: <20170314105108.GA15248@leverpostej>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <1489143891-11596-15-git-send-email-mark.rutland@arm.com>
 <CAFpQJXUQm84-DTCAng1RQq-wv-nqw=+MTe=vGTL7Sw=yL2sd+A@mail.gmail.com>
 <20170314105108.GA15248@leverpostej>
Message-ID: <CA+7sy7CcaNL5CBH3mmGk6WVfA73u8CarT3LhSAzhw9UbA65Zxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 4:21 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ganapatrao,
>
> On Tue, Mar 14, 2017 at 11:30:17AM +0530, Ganapatrao Kulkarni wrote:
>> > +int __init armv8_pmu_driver_init(void)
>> > +{
>> > +       if (acpi_disabled)
>> > +               return platform_driver_register(&armv8_pmu_driver);
>> > +       else
>> > +               return arm_pmu_acpi_probe(armv8_pmuv3_init);
>>
>> i think this function needs to be updated to
>> probe SoC specific init (armv8_a53_pmu_init, armv8_vulcan_pmu_init
>> etc)  as well.
>
> Only exposing generic PMUv3 here was a deliberate decision, based on
> prior discussions, so as to keep things consistent on ACPI platforms
> regardless of which CPU types the PMU code is immediately aware of.
>
> I should have documented this better; sorry about that.
>
> All events which can be enumerated via the PMU ID registers will be
> exposed via sysfs.

If we take a specific case here of L1D read access, it will be mapped
to either  ARMV8_IMPDEF_PERFCTR_L1D_CACHE_RD or
ARMV8_PMUV3_PERFCTR_L1D_CACHE depending on whether
you booted from ACPI or DT (on most platforms).

This does not look correct, am I missing something?

Thanks,
JC.
