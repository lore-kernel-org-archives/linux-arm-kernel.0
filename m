From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 14 Jan 2013 09:05:25 -0500 (EST)
Subject: [PATCH 00/16] big.LITTLE low-level CPU and cluster power
 management
In-Reply-To: <1358157392.19304.243.camel@jlo-ubuntu-64.nvidia.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1358157392.19304.243.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <alpine.LFD.2.02.1301140849020.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Jan 2013, Joseph Lo wrote:

> Hi Nicolas,
> 
> On Thu, 2013-01-10 at 08:20 +0800, Nicolas Pitre wrote:
> > This is the initial public posting of the initial support for big.LITTLE.
> > Included here is the code required to safely power up and down CPUs in a
> > b.L system, whether this is via CPU hotplug, a cpuidle driver or the
> > Linaro b.L in-kernel switcher[*] on top of this.  Only  SMP secondary
> > boot and CPU hotplug support is included at this time.  Getting to this
> > point already represents a significcant chunk of code as illustrated by
> > the diffstat below.
> > 
> > This work was presented at Linaro Connect in Copenhagen by Dave Martin and
> > myself.  The presentation slides are available here:
> > 
> > http://www.linaro.org/documents/download/f3569407bb1fb8bde0d6da80e285b832508f92f57223c
> > 
> > The code is now stable on both Fast Models as well as Virtual Express TC2
> > and ready for public review.
> > 
> > Platform support is included for Fast Models implementing the
> > Cortex-A15x4-A7x4 and Cortex-A15x1-A7x1 configurations.  To allow
> > successful compilation, I also included a preliminary version of the
> > CCI400 driver from Lorenzo Pieralisi.
> > 
> > Support for actual hardware such as Vexpress TC2 should come later,
> > once the basic infrastructure from this series is merged.  A few DT
> > bindings are used but not yet documented.
> > 
> > This series is made of the following parts:
> > 
> > Low-level support code:
> > [PATCH 01/16] ARM: b.L: secondary kernel entry code
> > [PATCH 02/16] ARM: b.L: introduce the CPU/cluster power API
> > [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
> > [PATCH 04/16] ARM: b.L: Add baremetal voting mutexes
> > [PATCH 05/16] ARM: bL_head: vlock-based first man election
> > 
> > Adaptation layer to hook with the generic kernel infrastructure:
> > [PATCH 06/16] ARM: b.L: generic SMP secondary bringup and hotplug
> > [PATCH 07/16] ARM: bL_platsmp.c: close the kernel entry gate before
> > [PATCH 08/16] ARM: bL_platsmp.c: make sure the GIC interface of a
> > [PATCH 09/16] ARM: vexpress: Select the correct SMP operations at
> > 
> > Fast Models support:
> > [PATCH 10/16] ARM: vexpress: introduce DCSCB support
> > [PATCH 11/16] ARM: vexpress/dcscb: add CPU use counts to the power
> > [PATCH 12/16] ARM: vexpress/dcscb: do not hardcode number of CPUs
> > [PATCH 13/16] drivers: misc: add ARM CCI support
> > [PATCH 14/16] ARM: TC2: ensure powerdown-time data is flushed from
> > [PATCH 15/16] ARM: vexpress/dcscb: handle platform coherency
> > [PATCH 16/16] ARM: vexpress/dcscb: probe via device tree
> > 
> 
> Thanks for introducing this series.
> I am taking a look at this series. It introduced an algorithm for
> syncing and avoid racing when syncing the power status of clusters and
> CPUs. Do you think these codes could have a chance to become a generic
> framework?

Yes.  As I mentioned before, the bL_ prefix is implied only by the fact 
that big.LITTLE was the motivation for creating this code.

> The Tegra chip series had a similar design for CPU clusters and it 
had
> limitation that the CPU0 always needs to be the last CPU to be shut down
> before cluster power down as well. I believe it can also get benefits of
> this works. We indeed need a similar algorithm to sync CPUs power status
> before cluster power down and switching.
> 
> The "bL_entry.c", "bL_entry.S", "bL_entry.h", "vlock.h" and "vlock.S"
> looks have a chance to be a common framework for ARM platform even if it
> just support one cluster. Because some systems had the limitations for
> cluster power down. That's why the coupled cpuidle been introduced. And
> this framework could be enabled automatically if platform dependent or
> by menuconfig.

Absolutely.


> For ex,
> 	select CPUS_CLUSTERS_POWER_SYNC_FRAMEWORK if SMP && CPU_PM
> 
> How do you think of this suggestion?

I'd prefer a more concise name though.

> BTW, some questions...
> 1. The "bL_entry_point" looks like a first run function when CPUs just
> power up, then jumping to original reset vector that it should be
> called. Do you think this should be a function and be called by reset
> handler? Or in your design, this should be called as soon as possible
> when the CPU power be resumed?

This should be called as soon as possible.

> 2. Does the Last_man mechanism should implement in platform specific
> code to check something like cpu_online_status and if there is a
> limitation for the specific last CPU to be powered down?

The selection of the last man is accomplished using a platform specific 
mechanism.  By the time this has to be done, the CPU is already dead as 
far as the Linux kernel is concerned, and therefore the generic CPU map 
is not reliable.  In the DCSCB case we simply look at the hardware reset 
register being modified to directly determine the last man.  On TC2 (not 
yet posted) we have to keep a local map of online CPUs.

In your case, the selection of the last man would simply be forced on 
CPU0.


Nicolas
