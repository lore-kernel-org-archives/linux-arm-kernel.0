From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Apr 2010 20:33:05 +0100
Subject: udelay() broken for SMP cores?
In-Reply-To: <d6e7a481ba26beb786f922f95a75875d.squirrel@www.codeaurora.org>
References: <4BCE60C4.8020505@codeaurora.org>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C4FEED81@dbde02.ent.ti.com>
	<4BCE9E8B.2070103@codeaurora.org>
	<20100421072243.GA913@n2100.arm.linux.org.uk>
	<ea62885d30e4bbfb84db59758fa9e946.squirrel@www.codeaurora.org>
	<20100421095036.GA13971@n2100.arm.linux.org.uk>
	<d6e7a481ba26beb786f922f95a75875d.squirrel@www.codeaurora.org>
Message-ID: <20100421193305.GB26616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 03:31:03AM -0700, skannan at codeaurora.org wrote:
> > Well, the assumption is that the CPUs will be running at their fastest
> > speed at boot time, and therefore loops_per_jiffy will be calibrated
> > such that we guarantee _at least_ the asked-for delay - which is the
> > only guarantee udelay has.
> 
> Even if the boot assumption is true, cpufreq actively changes the
> loops_per_jiffy value when it changes freq. So, this could still mess up
> the _at least_ guarantee.

Actually, it doesn't on SMP - if you build the kernel with SMP enabled,
the code which fiddles with loops_per_jiffy is disabled.  See the
#ifndef wrapping around adjust_jiffies() in drivers/cpufreq/cpufreq.c.

So, on SMP with cpufreq, the global loops_per_jiffy is a fixed value.
Provided it was calibrated with the CPU running at max clock rate,
the guarantee is satisfied for all CPUs in the system.
