From: mboards@prograde.net (Michael Cashwell)
Date: Tue, 27 Apr 2010 13:36:49 -0400
Subject: PXA270 Errata and Data Cache question
Message-ID: <19E645CD-EDC9-478B-9D72-BEDF37F3AF4F@prograde.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I'm presently working to get cpufreq (with a voltage regulator) working reliably on a PXA27x system. I've worked on this some in the past (2.6.27.21) and saw odd core hangs where JTAG was locked out. We were on custom hardware then and were also having SDRAM issues so I just shut off cpufreq and moved on.

Currently we have another custom board in the pipeline but have arranged for the Gumstix Verdex Pro XL6P to be a drop-in alternative if the custom board is DOA. This means I'm porting our tools and modules to a later kernel but running it on the Gumstix. I'm on 2.6.33.2 and am seeing similar core hangs as before and since this is unmodified commercial hardware I've become more convinced that it's not a board quirk.

I've found a CPU errata E88 in the current Marvell PXA270 docs that seems applicable and is not addressed in cpufreq-pxa2xx.c. However I've hit a snag trying to implement the recommended workaround. It requires (among other things) that I do 50 reads from an SDRAM address that is not cached. (There's an alternate approach that invalidates the caches but I don't see how doing that while leaving caching enabled can work. I'd expect the d-cache to eliminate all but the first read which defeats the stated need to do 50.)

So setting that confusion aside, it seems simpler to use an uncached kernel SDRAM VA. In other instances I've used: "arch/arm/mach-pxa/include/mach/hardware.h:#define UNCACHED_ADDR UNCACHED_PHYS_0" which uses this mapping in arch/arm/mach-pxa/generic.c:

static struct map_desc standard_io_desc[] __initdata = {
	...
	{	/* UNCACHED_PHYS_0 */
		.virtual	= 0xff000000,
		.pfn		= __phys_to_pfn(0x00000000),
		.length		= 0x00100000,
		.type		= MT_DEVICE
	}
};

I could extend this to provide an uncached SDRAM page but choosing the VA and PA looks tricky.

Before I embark on all of that I'm wondering if such an uncached SDRAM mapping might not already exist.

Does anyone know of such a thing?

Thanks,
-Mike
