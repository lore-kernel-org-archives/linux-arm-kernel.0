From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Feb 2015 17:21:41 +0000
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150213162725.GC8656@n2100.arm.linux.org.uk>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <54D95DB8.9010308@codeaurora.org>
 <20150210151416.GD9432@leverpostej>
 <54DA6E92.3090109@codeaurora.org> <54DA725E.6080305@codeaurora.org>
 <20150213155208.GG10496@leverpostej>
 <20150213162725.GC8656@n2100.arm.linux.org.uk>
Message-ID: <20150213172141.GF2529@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 04:27:25PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 13, 2015 at 03:52:08PM +0000, Mark Rutland wrote:
> > > @@ -194,10 +195,6 @@ int __cpu_disable(void)
> > >  	unsigned int cpu = smp_processor_id();
> > >  	int ret;
> > >  
> > > -	ret = platform_cpu_disable(cpu);
> > > -	if (ret)
> > > -		return ret;
> > 
> > For PSCI 0.2+ I was hoping to hook the MIGRATE logic in here. The secure
> > side may reject hotplugging of a CPU, but it's a dynamic property of the
> > system and so can't be probed once at boot time.
> 
> You may have to think about how to deal with the static nature of the
> sysfs CPU hotplug properties then - or, you may wish to have the existing
> behaviour where we expose the sysfs hotplug properties on all CPUs and
> rely on returning -EPERM.
> 
> One question does come up - if it's a dynamic property of the system,
> what ensures that it can't change between the point when we test it
> (in __cpu_disable()) and when we actually come to take the CPU offline?

By relying on hotplug operations being serialised and the secure OS not
moving arbitrarily (as required by the PSCI spec).

This matters in the case of a UP, migrateable secure OS (AKA TOS). It
lives on a core, but we can ask it (via the PSCI implementation) to
move. It will only move in response to MIGRATE calls, and at boot time
we would query which CPU it's on (which should in practice be CPU0
except in rare cases like a crash kernel).

At __cpu_disable time (where the current platform_cpu_disable callback
is), if the core being disabled has the TOS resident it would call
MIGRATE, passsing the physical ID of another CPU to migrate to. If this
fails, then the TOS didn't move and we can't hotplug. If it succeeds,
then we know it has moved to the other CPU.

The disabled CPU then goes through the rest of the teardown, eventually
calling PSCI_OFF to actually be shut down. 

We can then wait for the dying CPU to have been killed with
AFFINITY_INFO (as with the current psci_cpu_kill implementation). As we
can't initiate antoehr hotplug before this we can't race and migrate the
TOS back to the original CPU.

> How does the secure side signal its rejection of hotunplugging of a CPU?

It returns an error code in response to the PSCI MIGRATE call.

> If it happens after __cpu_disable(), then that's a problem: the system
> will have gone through all the expensive preparation by that time to
> shut the CPU down, and it will expect the CPU to go offline.  The only
> way it can come back at that point is by going through a CPU plug-in
> cycle... which means going back through secondary_start_kernel.

This would happen within __cpu_disable, as the current
platform_cpu_disable() call does, before it's too late to abort the
hotplug.

Thanks,
Mark.
