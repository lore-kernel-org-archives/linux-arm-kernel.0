From: will.deacon@arm.com (Will Deacon)
Date: Sun, 30 Oct 2011 21:07:36 +0000
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111029200548.GC19187@n2100.arm.linux.org.uk>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
	<20111029200548.GC19187@n2100.arm.linux.org.uk>
Message-ID: <20111030210736.GB28363@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2011 at 09:05:48PM +0100, Russell King - ARM Linux wrote:
> On Sat, Oct 29, 2011 at 02:56:53PM +0100, Will Deacon wrote:
> > I initially observed this in the idle code, where it looks to me like all
> > the pm_idle overrides could actually be done in the arch_idle hook (the only
> > slightly fiddly one is OMAP). Maybe Nicolas could use the same sort of
> > approach for that?
> 
> Beware about changing the semantics of pm_idle - it's a cross-arch thing,
> and we really shouldn't change those semantics without changing the other
> architectures as well.

Indeed. I'm not suggesting making any changes to pm_idle, I'm just pointing
out that all of the pm_idle overrides for ARM can be written as:

	if (!need_resched())
		do_magic_soc_specific_idle();
	local_irq_enable();

so the platform magic may as well just be implemented using arch_idle and we
can remove the ability to reassign pm_idle, therefore consolidating the
platform idle code into one function pointer.

Will
