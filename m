From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Jul 2013 14:45:06 +0100
Subject: [RFC PATCH 0/5] arm64: initial CPU_HOTPLUG support
In-Reply-To: <51E3F839.4010900@windriver.com>
References: <1373494279-24712-1-git-send-email-mark.rutland@arm.com>
 <20130715104706.GA14505@e106331-lin.cambridge.arm.com>
 <51E3F839.4010900@windriver.com>
Message-ID: <20130715134506.GA31535@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 02:25:13PM +0100, Paul Gortmaker wrote:
> On 13-07-15 06:47 AM, Mark Rutland wrote:
> > Hi Catalin, Paul,
> > 
> > I've realised these patches are going to conflict with Paul's "arm64:
> > delete __cpuinit usage from all users", so I'd like to rebase this
> > series atop of it (removing my cpuinit additions as I do so).
> > 
> > Catalin, would you be happy to create a stable branch at some point soon
> > with Paul's arm64 patch for me to work atop of?
> 
> Now that 3.11-rc1 is out, I'll be sending a pull request
> for phase two of the removal, including the arm64 patch,
> so that should be mainline very shortly.

Ok, I'll wait for that to hit.

Thanks,
Mark.

> 
> Paul.
> --
> 
> > 
> > Thanks,
> > Mark.
> > 
> > On Wed, Jul 10, 2013 at 11:11:14PM +0100, Mark Rutland wrote:
> >> The following patches add basic CPU_HOTPLUG support to arm64, which
> >> combined with appropriate firmware (e.g. [1]) can be used to power CPUs
> >> up and down dynamically. From discussions at connect it seemed that
> >> several people were interested in working in this area, so I thought I'd
> >> make my current implementation public now that I've managed to regain
> >> access to my inbox.
> >>
> >> I've tested this series with the bootwrapper PSCI implementation I've
> >> placed on linux-arm.org [1] and a modified foundation model dts with a
> >> psci node and each CPU's enable-method set to "psci", using a shell
> >> while repeatedly cycling all cpus off and on:
> >>
> >> for C in $(seq 0 3); do
> >> 	./cyclichotplug.sh $C >/dev/null 2>&1 &
> >> done
> >>
> >> ---->8----
> >> #!/bin/sh
> >> # cyclichotplug.sh
> >>
> >> CPU=$1;
> >>
> >> if [ -z "$CPU" ]; then
> >> 	printf "Usage: $0 <cpu id>\n";
> >> 	exit 1;
> >> fi
> >>
> >> ONLINEFILE=/sys/devices/system/cpu/cpu$CPU/online;
> >>
> >> while true; do
> >> 	echo 0 > $ONLINEFILE;
> >> 	echo 1 > $ONLINEFILE;
> >> done
> >> ---->8----
> >>
> >> Patches are based on v3.10.
> >>
> >> Thanks,
> >> Mark.
> >>
> >> [1] http://linux-arm.org/git?p=boot-wrapper-aarch64.git;a=shortlog;h=refs/tags/simple-psci
> >>
> >> Mark Rutland (5):
> >>   arm64: reorganise smp_enable_ops
> >>   arm64: factor out spin-table boot method
> >>   arm64: read enable-method for CPU0
> >>   arm64: add CPU_HOTPLUG infrastructure
> >>   arm64: add PSCI CPU_OFF-based hotplug support
> >>
> >>  arch/arm64/Kconfig                 |    7 ++
> >>  arch/arm64/include/asm/irq.h       |    1 +
> >>  arch/arm64/include/asm/smp.h       |   37 +++++--
> >>  arch/arm64/kernel/cputable.c       |    2 +-
> >>  arch/arm64/kernel/head.S           |   12 +-
> >>  arch/arm64/kernel/irq.c            |   61 ++++++++++
> >>  arch/arm64/kernel/process.c        |    7 ++
> >>  arch/arm64/kernel/smp.c            |  215 ++++++++++++++++++++++--------------
> >>  arch/arm64/kernel/smp_psci.c       |   54 +++++++--
> >>  arch/arm64/kernel/smp_spin_table.c |   85 +++++++++++++-
> >>  arch/arm64/kernel/vmlinux.lds.S    |    1 -
> >>  11 files changed, 375 insertions(+), 107 deletions(-)
> >>
> >> -- 
> >> 1.7.9.5
> >>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
