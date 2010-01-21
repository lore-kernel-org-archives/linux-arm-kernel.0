From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jan 2010 10:38:03 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-2-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-3-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-4-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-5-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-6-git-send-email-jamie.iles@picochip.com>
	<20100121093917.GB4908@wear.picochip.com>
Message-ID: <20100121103803.GA15663@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2010 at 10:28:26AM -0000, Will Deacon wrote:
> 
> Hi Jamie,
> 
> * Jamie Iles wrote:
> 
> > Given the difficulty in determining the CPU type 100%, this should be changed
> > to:
> > 
> > 	unsigned long cpuid = read_cpuid_id();
> > 	unsigned long implementor = (cpuid & 0xFF000000) >> 24;
> > 	unsigned long part_number = (cpuid & 0xFFF0);
> > 
> > 	/* We only support ARM CPUs implemented by ARM at the moment. */
> > 	if (implementor == 0x41) {
> > 		switch (part_number) {
> > 		case 0xB360:
> > 		case 0xB560:
> > 			etc
> 
> Whilst I understand that the whole cpuid thing is a complete mess [I saw the
> lkml posts yesterday], I'm not sure this is necessary for v7 cores. For v7,
> the PMU is part of the architecture and so *must* be implemented in the way
> described in the ARM ARM [Chapter 9], regardless of the implementer.

This function is called whenever the PMU support is built in - and
this is the first place a decision is made about how to handle stuff.

Merely checking the part number without checking the implementer is
nonsense - the part number is defined by the implmenter, not ARM, so
the part number can only be interpreted with knowledge of the
implementer.

So, when v7 gets added, checking the main ID register is the wrong
thing to do.

Given that cpu_architecture() appears to have been redefined to return
the MMU architecture, we have no real way to properly determine if we
have a v7 PMU present - in fact, the whole "are we v6 or v7 or something
later" question seems to be extremely muddy and indeterminant.

So I don't think even checking cpu_architecture() == CPU_ARCH_ARMv7
is the right thing either.
