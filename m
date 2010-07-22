From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 21:57:53 +0100
Subject: hotplug and init section
In-Reply-To: <989bc3c9f8d8ce1d51c480a0dbdce07e.squirrel@www.codeaurora.org>
References: <989bc3c9f8d8ce1d51c480a0dbdce07e.squirrel@www.codeaurora.org>
Message-ID: <20100722205753.GU31293@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 12:33:08PM -0700, smuckle at codeaurora.org wrote:
> I'm working on hotplug support. It looks like currently only mach-realview
> supports this on ARM, and it does not fully power down the core.  The core
> just goes into wfi. If we fully power down the core being hot-removed, we
> need to rerun the processor init, enable mmu, turn on mmu, etc when it is
> brought back up.

That's all sane.

> This code is currently all put in the .init section.

Not all of it.  The generic secondary CPU startup code (arch/arm/kernel/smp.c)
will live in core if hotplug cpu is selected - this is why its marked
with __cpuinit.  So secondary_start_kernel() et.al. is already fine.

> Changing things so
> that the code required for bringing up secondary cores is still present
> after init looks to be a fairly big change. As such I wanted to see if
> anyone had thoughts here before I start hacking up head.S, the linker
> script, etc.

No need to hack the linker script - all you need to do is to ensure that
the required parts of code are placed in the cpuinit sections - and there's
a macro to do that called "__CPUINIT" (which equates to a .section
directive.)

You'll need to ensure that stuff which shouldn't be in the cpuinit
section remains as-is, so you'll have to also add __INIT or
.section .text as appropriate.
