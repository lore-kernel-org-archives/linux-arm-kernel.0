From: slash.tmp@free.fr (Mason)
Date: Tue, 14 Jun 2016 14:42:20 +0200
Subject: Linux panics when suspend cannot offline the secondary cores
In-Reply-To: <20160613210213.GZ1041@n2100.armlinux.org.uk>
References: <575ADFAC.4090009@free.fr> <2922940.3xeChLaYeK@vostro.rjw.lan>
 <575EBA40.4000803@free.fr> <2041686.H4Vc2p72PV@vostro.rjw.lan>
 <20160613210213.GZ1041@n2100.armlinux.org.uk>
Message-ID: <575FFBAC.3000507@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/2016 23:02, Russell King - ARM Linux wrote:

> On Mon, Jun 13, 2016 at 10:49:32PM +0200, Rafael J. Wysocki wrote:
>
>> I guess all of the existing implementations of smp_ops.cpu_die() don't return
>> to the caller no matter what, so the caller did not have to consider anything
>> else.
> 
> Existing implementations for hardware which implements CPU hotplug
> takes the requested CPU down in such a way that smp_ops.cpu_die()
> *never* returns.
> 
> We have a number of evaluation boards where its desirable to emulate
> CPU hotplug.  These boards have no power management abilities, and
> have no way to power down or reset a CPU from software.  For these,
> we implement CPU hotplug by taking the CPU down gracefully, taking
> it out of coherency, and then placing it in a loop waiting for the
> CPU up event to arrive.  At that point (and this is the only legal
> time) smp_ops.cpu_die() returns - at which point you get the
> resuscitating kernel message, and the CPU re-enters the kernel.
> 
> This path is _only_ for these evaluation platforms which have no
> hardware support for CPU hotplug, and therefore no PM and no kexec.
> 
> The *only* solution to having working PM support Mason's platform is
> a properly implemented CPU hotplug correctly - which means ensuring
> that the CPU is either powered down or placed in reset during the
> smp_ops.cpu_die() call.  Everything else (even the simulation of it)
> is not good enough.
> 
> That can be done either by the dying CPU when it calls into
> smp_ops.cpu_die(), or the CPU requesting the death of the CPU via
> smp_ops.cpu_kill().
> 
> Either way, it's up to the platform code to implement these, and as
> I say, a correct and proper implementation of this is a fundamental
> requirement for system power management (like suspend) and kexec in
> a SMP system.

Hello Russell,

The current plan is to have cpu_die() jump into the firmware, and have
the firmware "park" the calling core into a WFI loop until someone wants
to online the parked core, via the smp_boot_secondary() callback.

Would that work?

So far, I haven't cared about what HOTPLUG does with the parked core,
because we would just provide HOTPLUG as a requirement for suspend,
which offlines the secondary cores, and then we will power down the
entire SoC.

On a tangential subject, is the scheduler able to off-line idle cores?

Regards.
