From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 19 Feb 2016 14:29:00 +0000
Subject: [PATCH 4/9] ARM: add CONFIG_PHYS_OFFSET default values
In-Reply-To: <3974581.yknKb3tq7o@wuerfel>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-5-git-send-email-arnd@arndb.de>
 <alpine.LFD.2.20.1602181100410.13632@knanqh.ubzr>
 <3974581.yknKb3tq7o@wuerfel>
Message-ID: <HK2PR06MB056137892B6F968A8A1008C58AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 Feb 2016, Arnd Bergmann wrote:

> On Thursday 18 February 2016 11:02:33 Nicolas Pitre wrote:
> > 
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> > 
> > Is there a way to provide a default for defaults?
> 
> We could have something like
> 
> config PHYS_OFFSET_0
> 	bool
> 
> config PHYS_OFFSET_1
> 	bool
> 
> config PHYS_OFFSET_2
> 	bool
> 
> ... (we need 8 of the 16 possible addresses)
> 
> 
> config PHYS_OFFSET
> 	hex "Physical address of main memory" if MMU
> 	default DRAM_BASE if !MMU
> 	default 0x00000000 if PHYS_OFFSET_0
> 	default 0x10000000 if PHYS_OFFSET_1
> 	default 0x20000000 if PHYS_OFFSET_2
> 	default 0x30000000 if PHYS_OFFSET_3
> 	default 0x70000000 if PHYS_OFFSET_7
> 	default 0x80000000 if PHYS_OFFSET_8
> 	default 0xa0000000 if PHYS_OFFSET_A
> 	default 0xc0000000 if PHYS_OFFSET_C
> 
> 
> and then select one of the bool symbols from each platform.
> Would that address your question?


Here's a question:

Can we just get rid of PHYS_OFFSET???

If it's only used at boot for XIP systems, we could:

A) pass it in via an unused register like atags and DT
 or
B) just assume that atags or DT is in RAM, so round down to the nearest section and assume that is the start of your RAM

If it is needed after initial boot, then on first boot we save what was passed in from the boot loader for later use.


Chris
