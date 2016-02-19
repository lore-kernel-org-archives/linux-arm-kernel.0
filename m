From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Feb 2016 16:34:51 +0100
Subject: [PATCH 4/9] ARM: add CONFIG_PHYS_OFFSET default values
In-Reply-To: <HK2PR06MB056137892B6F968A8A1008C58AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <3974581.yknKb3tq7o@wuerfel>
 <HK2PR06MB056137892B6F968A8A1008C58AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <14272873.q312Ii8Axy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 February 2016 14:29:00 Chris Brandt wrote:
> On 19 Feb 2016, Arnd Bergmann wrote:
> 
> > On Thursday 18 February 2016 11:02:33 Nicolas Pitre wrote:
> > > 
> > > Acked-by: Nicolas Pitre <nico@linaro.org>
> > > 
> > > Is there a way to provide a default for defaults?
> > 
> > We could have something like
> > 
> > config PHYS_OFFSET_0
> > 	bool
> > 
> > config PHYS_OFFSET_1
> > 	bool
> > 
> > config PHYS_OFFSET_2
> > 	bool
> > 
> > ... (we need 8 of the 16 possible addresses)
> > 
> > 
> > config PHYS_OFFSET
> > 	hex "Physical address of main memory" if MMU
> > 	default DRAM_BASE if !MMU
> > 	default 0x00000000 if PHYS_OFFSET_0
> > 	default 0x10000000 if PHYS_OFFSET_1
> > 	default 0x20000000 if PHYS_OFFSET_2
> > 	default 0x30000000 if PHYS_OFFSET_3
> > 	default 0x70000000 if PHYS_OFFSET_7
> > 	default 0x80000000 if PHYS_OFFSET_8
> > 	default 0xa0000000 if PHYS_OFFSET_A
> > 	default 0xc0000000 if PHYS_OFFSET_C
> > 
> > 
> > and then select one of the bool symbols from each platform.
> > Would that address your question?
> 
> 
> Here's a question:
> 
> Can we just get rid of PHYS_OFFSET???
> 
> If it's only used at boot for XIP systems, we could:
> 
> A) pass it in via an unused register like atags and DT
>  or
> B) just assume that atags or DT is in RAM, so round down to the nearest section and assume that is the start of your RAM
> 
> If it is needed after initial boot, then on first boot we save what was passed in from the boot loader for later use.

Hmm, you mean making phys_offset a runtime variable instead
of patching it at early boot time in the instructions?

I have no idea if that works, how much effort it would be,
or how much it would enlarge the kernel image size, but
you can definitely try.

Of course we must not break existing platforms using XIP_KERNEL
already, but the installed base among systems that are upgrading
to modern kernels is very small now, given how all modern platforms
don't support XIP_KERNEL today, or have no MMU to start with.

	Arnd
