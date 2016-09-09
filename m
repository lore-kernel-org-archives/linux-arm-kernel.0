From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 9 Sep 2016 08:06:44 +0100
Subject: [PATCH v4 3/4] arm64: arch_timer: Work around QorIQ Erratum
 A-008585
In-Reply-To: <57D246AE.8040900@huawei.com>
References: <1467877572-10817-1-git-send-email-oss@buserror.net>
 <1467877572-10817-3-git-send-email-oss@buserror.net>
 <20160826134004.7e86e798@arm.com> <57D246AE.8040900@huawei.com>
Message-ID: <20160909080644.5fbc2f68@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Sep 2016 13:20:46 +0800
Ding Tianhong <dingtianhong@huawei.com> wrote:

Hi Ding,

> > I'm still worried that this series doesn't address Xen or KVM guests
> > that need to be made aware of the broken timers.
> >   
> Hi Marc:
> 
> I think "ARCH_TIMER_REG_READ("cntv_tval_el0", arch_timer_get_vtval)"
> could cover the tval changes in KVM guest, and I fould the guest
> still use the get_cycles() to get the timer cycles, if I miss
> something, please remind me, thanks.

You're missing the point that to tell the guest that the HW has this
erratum, we need the DT to be populated with the right property.

> > At the very least, I'd like a kernel command line option that'd let
> > the user reliably run its VMs. You can do something along the lines
> > of 46fd5c6b, and have a command line argument like
> > "clocksource.arm_arch_timer.fsl-a008585=1", which would enable the
> > workaround.
> >   
> 
> I don't think adding in command line is a good solution for this bug,
> we should not told the OS user how to fix it by adding command line
> option, and need to fix it by dts or ACPI.

Sure. I'm happy to review the patches that will:
- Add a new KVM kernel API describing properties for the timer so that
  we can expose the erratum from the kernel to userspace
- Add a similar API for Xen
- Have all the userspace (QEMU, kvmtool, the Xen tools) to be converted
  to use this new API so that they can emit the correct DT
- Point to a change in the ACPI spec so that we can encode errata there
- Add support for handling this erratum using ACPI in the kernel
- Allow QEMU and the Xen tools to expose this erratum in the guests
  ACPI tables

Unless you're in a position to write all this code (and
specifications), and post the patches *now*, I'll stand by my
recommendation to have a command-line option. Not exposing this issue
to the guest results in unreliable operations. You may not care, but I
do.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
