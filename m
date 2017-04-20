From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Apr 2017 09:53:00 +0100
Subject: [PATCH 3/3] perf tool, arm64, thunderx2: Add implementation
 defined events for ThunderX2
In-Reply-To: <CAFpQJXUfR98gWbfmiBM69wKVLM7e=ujo8LZxmUFfxJ0iTrCKsQ@mail.gmail.com>
References: <1491291403-29893-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1491291403-29893-4-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170404122828.GB8551@leverpostej>
 <CAFpQJXWTQ=gX63NHPoUST0oU9cP4xo+2fdr-p7ifhvJ6x-ih+A@mail.gmail.com>
 <20170405100548.GA10833@leverpostej>
 <CAFpQJXX9pt2R8TrLv0z=JT2VJxQROCn3cxPbaYiOEOFAT=Fg2Q@mail.gmail.com>
 <20170406095533.GB29947@leverpostej>
 <CAFpQJXUfR98gWbfmiBM69wKVLM7e=ujo8LZxmUFfxJ0iTrCKsQ@mail.gmail.com>
Message-ID: <20170420085259.GD31436@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 11:37:31PM +0530, Ganapatrao Kulkarni wrote:
> Hi Mark,

Hi,

> On Thu, Apr 6, 2017 at 3:25 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Apr 06, 2017 at 09:50:33AM +0530, Ganapatrao Kulkarni wrote:
> >> On Wed, Apr 5, 2017 at 3:35 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Wed, Apr 05, 2017 at 02:42:39PM +0530, Ganapatrao Kulkarni wrote:
> >> >> On Tue, Apr 4, 2017 at 5:58 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> >> > On Tue, Apr 04, 2017 at 01:06:43PM +0530, Ganapatrao Kulkarni wrote:
> >
> >> >> >> +     "CPU" :"armv8_pmuv3_0"
> >> >> >
> >> >> > Please let's not hard-code the name like this. Surely we can get rid of this?
> >> >> >
> >> >> > The kernel doesn't currently name PMUs as armv8_pmuv3_*, and as that can
> >> >> > differ across DT/ACPI and in big.LITTLE, I don't think it makes sense to
> >> >> > try to rely one particular string regardless.
> >> >>
> >> >> This string/name is fixed for a platform. having name here is essential to
> >> >> know which devices among pmu (armv8_pmuv3_0, breakpoint, software)
> >> >> devices, these jevents to be added.
> >> >> also this json file is specific to a arch/soc/board, it is not a
> >> >> generic file to be common.
> >> >
> >> > This file describe the events of a CPU PMU, and CPUs are not specific to
> >> > a platform in general. There are many systems using Cortex-A57, for
> >> > example.
> >> >
> >> > Across big.LITTLE SoCs with Cortex-A57, there's no guarantee as to
> >> > whether the Cortex-A57 cores would be named armv8_pmuv3_0, or
> >> > armv8_pmuv3_1, etc. This would depend on the boot CPU, probe order of
> >> > secondaries, etc.
> 
> some of the applications(perf etc) use sysfs files of perf PMU CORE devices.
> at present the names are created as per SOC/platform like
> armv8_pmuv3, armv8_cavium_thunder,  armv8_cortex_a57 etc.
> 
> cpu_pmu->name                   = "armv8_cavium_thunder";
> 
> can we please have common name similar to x86(cpu) and call them as
> cpu_0 and cpu_1?

I don't see how that helps in this case?

I'd rather that we expose some mechanism to determine whether a PMU is a
CPU PMU, other than the name. Userspace can then throw away the name if
it so wishes, and it doesn't have the potential to break existing users.

Thanks,
Mark.
