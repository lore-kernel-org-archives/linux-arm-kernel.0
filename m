From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Mar 2017 10:51:08 +0000
Subject: [PATCH 14/14] arm64: pmuv3: use arm_pmu ACPI framework
In-Reply-To: <CAFpQJXUQm84-DTCAng1RQq-wv-nqw=+MTe=vGTL7Sw=yL2sd+A@mail.gmail.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <1489143891-11596-15-git-send-email-mark.rutland@arm.com>
 <CAFpQJXUQm84-DTCAng1RQq-wv-nqw=+MTe=vGTL7Sw=yL2sd+A@mail.gmail.com>
Message-ID: <20170314105108.GA15248@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ganapatrao,

On Tue, Mar 14, 2017 at 11:30:17AM +0530, Ganapatrao Kulkarni wrote:
> > +int __init armv8_pmu_driver_init(void)
> > +{
> > +       if (acpi_disabled)
> > +               return platform_driver_register(&armv8_pmu_driver);
> > +       else
> > +               return arm_pmu_acpi_probe(armv8_pmuv3_init);
> 
> i think this function needs to be updated to
> probe SoC specific init (armv8_a53_pmu_init, armv8_vulcan_pmu_init
> etc)  as well.

Only exposing generic PMUv3 here was a deliberate decision, based on
prior discussions, so as to keep things consistent on ACPI platforms
regardless of which CPU types the PMU code is immediately aware of.

I should have documented this better; sorry about that.

All events which can be enumerated via the PMU ID registers will be
exposed via sysfs.

Other events (e.g. those which are implementation defined) will not be
exposed via sysfs, but can still be used as raw events.

There's been some perf tool work to allow these to be enumerated in
userspace based on JSON files. This allows new events to be supported
with a userspace update, event when the kernel itself is older than the
CPU in question, and does not know anything about its events.

Thanks,
Mark.
