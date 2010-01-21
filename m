From: will.deacon@arm.com (Will Deacon)
Date: Thu, 21 Jan 2010 10:56:37 -0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for	ARMv6
In-Reply-To: <20100121103803.GA15663@n2100.arm.linux.org.uk>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-2-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-3-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-4-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-5-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-6-git-send-email-jamie.iles@picochip.com>
	<20100121093917.GB4908@wear.picochip.com>
	<20100121103803.GA15663@n2100.arm.linux.org.uk>
Message-ID: <001701ca9a88$67f32c20$37d98460$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

* Russell King wrote:

> This function is called whenever the PMU support is built in - and
> this is the first place a decision is made about how to handle stuff.
> 
> Merely checking the part number without checking the implementer is
> nonsense - the part number is defined by the implmenter, not ARM, so
> the part number can only be interpreted with knowledge of the
> implementer.

Perhaps, but if [somehow] we know we're on a v7 core, then we must have
at least the PMU support defined by the architecture. We can then check
the part ID and the implementer ID to determine any extra events.

> So, when v7 gets added, checking the main ID register is the wrong
> thing to do.
>
> Given that cpu_architecture() appears to have been redefined to return
> the MMU architecture, we have no real way to properly determine if we
> have a v7 PMU present - in fact, the whole "are we v6 or v7 or something
> later" question seems to be extremely muddy and indeterminant.

Right. Could we use the Debug ID register (DIDR[19:16]) instead? If it reads
v7, we know how to talk to the PMU. If it reads v6, then if we haven't handled
the core already, it's unsupported.

> So I don't think even checking cpu_architecture() == CPU_ARCH_ARMv7
> is the right thing either.

Indeed. That always catches me out!

Cheers,

Will
