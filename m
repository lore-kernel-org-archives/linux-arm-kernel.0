From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jun 2011 00:16:22 +0100
Subject: Missing volatile in hard_smp_processor_id.
In-Reply-To: <4E090C4D.1000309@xenomai.org>
References: <4E090C4D.1000309@xenomai.org>
Message-ID: <20110627231622.GB6222@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 01:03:41AM +0200, Gilles Chanteperdrix wrote:
> I know hard_smp_processor_id() disappeared after Linux 2.6.37, but this
> may be interesting for the stable and long term support branches. This
> issue is suspected to cause random segmentation faults on OMAP4 with 
> CONFIG_HIGHMEM on.

1. hard_smp_processor_id() was only used in the platform hotplug code
to verify that the intended CPU number was the same as the hardware
CPU number.  These checks were removed by bbc81fd (ARM: CPU hotplug:
remove bug checks in platform_cpu_die()).

2. OMAP - and as a general principle, no one else - does not and should
not make use of this macro.  CPU numbers within Linux are 'logical' and
may not correspond with the hardware CPU number.  However, there are
three places where we make the assumption that they're the same:

a) CPU bringup code
b) GIC cross-call code
c) Hotplug code

Even these places make no reference to the MPIDR register - the only
place which does is the very early assembly code.

_Anything_ which uses hard_smp_processor_id() is probably buggy.  We have
get_cpu()..put_cpu() to deal with preemption etc, and in any case the
logical CPU number should always be used for indexing data structures.

Finally, there is no code merged into mainline which mis-uses this
macro.

So, all in all I see no reason to submit patches to stable trees for
something which doesn't cause a problem in those trees themselves.
