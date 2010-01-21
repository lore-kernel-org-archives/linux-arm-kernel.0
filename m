From: will.deacon@arm.com (Will Deacon)
Date: Thu, 21 Jan 2010 10:28:26 -0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for	ARMv6
In-Reply-To: <20100121093917.GB4908@wear.picochip.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-2-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-3-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-4-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-5-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-6-git-send-email-jamie.iles@picochip.com>
	<20100121093917.GB4908@wear.picochip.com>
Message-ID: <001501ca9a84$77ff48a0$67fdd9e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Jamie,

* Jamie Iles wrote:

> Given the difficulty in determining the CPU type 100%, this should be changed
> to:
> 
> 	unsigned long cpuid = read_cpuid_id();
> 	unsigned long implementor = (cpuid & 0xFF000000) >> 24;
> 	unsigned long part_number = (cpuid & 0xFFF0);
> 
> 	/* We only support ARM CPUs implemented by ARM at the moment. */
> 	if (implementor == 0x41) {
> 		switch (part_number) {
> 		case 0xB360:
> 		case 0xB560:
> 			etc

Whilst I understand that the whole cpuid thing is a complete mess [I saw the
lkml posts yesterday], I'm not sure this is necessary for v7 cores. For v7,
the PMU is part of the architecture and so *must* be implemented in the way
described in the ARM ARM [Chapter 9], regardless of the implementer.

However, for v6 you're right - checking that ARM is the implementer is a sensible
thing to do. This does rely on the implementer setting those bits correctly
though :)

Additionally, it's quite possible for an implementer to extend the hardware
counters on a v7 SoC. This means that you would have the PMU as described in the
ARM ARM, but then additional counters, perhaps outside the core that can be
accessed in a different way. In this case, switching on the implementer ID is
essential to determine extra features, but the base features can be assumed to be
present.

All food for thought.

Cheers,

Will
