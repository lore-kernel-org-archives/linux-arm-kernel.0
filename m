From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Feb 2012 08:46:42 +0000
Subject: [PATCH v6 13/15] ARM: hotplug: Introduce dummy_cpu_kill
In-Reply-To: <alpine.LFD.2.02.1202081608100.1656@xanadu.home>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
 <1328661059-24584-14-git-send-email-marc.zyngier@arm.com>
 <alpine.LFD.2.02.1202081608100.1656@xanadu.home>
Message-ID: <20120209084642.GO889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 04:16:24PM -0800, Nicolas Pitre wrote:
> What avout this instead:
> 
> int __weak __cpuinit platform_cpu_kill(unsigned int cpu)
> {
> 	if (!soc_smp_ops)
> 		return 0;
> 	if (!soc_smp_ops->cpu_kill)
> 		return 1;
> 	return soc_smp_ops->cpu_kill(cpu);
> }
> 
> and get rid of the dummy handler entirely?

No.  This is silly.  Think about it - if you don't provide a cpu_kill
then you can't support the unplug operation.  So you shouldn't even
allow the system to get anywhere near this.

So get rid of the tests for soc_smp_ops and soc_smp_ops->cpu_kill, and
just make this a simple:

	return soc_smp_ops->cpu_kill(cpu);

I'm not sure that the call to platform_cpu_kill() in ipi_cpu_stop() is
correct - platform_cpu_kill() is supposed to run on a CPU which is not
the one going down, whereas platform_cpu_die() runs on the CPU which
is going down.
