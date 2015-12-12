From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Dec 2015 21:41:04 +0100
Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into
 __aeabi_{u}idiv()
In-Reply-To: <alpine.LFD.2.20.1512111955380.26920@knanqh.ubzr>
References: <alpine.LFD.2.20.1512110105450.26920@knanqh.ubzr>
 <1952194.3mFBoOuPa0@wuerfel>
 <alpine.LFD.2.20.1512111955380.26920@knanqh.ubzr>
Message-ID: <31542311.prPJauWKRa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 December 2015 20:17:44 Nicolas Pitre wrote:
> ----- >8
> 
> family                  out of order                    in order
> ==============================================================================
> no mmu          |                               |                            |
> no cache        |       Falcon                  |       Falcon D             |
> "966"           |                               |       a.k.a. Dragonite     |
> ==============================================================================
> no mmu          |                               |                            |
> cache           |       Osprey                  |       Osprey D             |
> "946"           |                               |                            |
> ==============================================================================
>                 |       single issue: Mohawk    |                            |
> mmu             |       a.k.a. Feroceon 1850    |                            |
> cache           |       a.k.a. Feroceon FR-331  |       single issue:        |
> "926"           |                               |       Mohawk D             |
>                 |       dual issue: Jolteon     |                            |
>                 |       a.k.a. Feroceon 2850    |                            |
> ==============================================================================
> 
> Variants:
> - Falcon DMC - Multi-Core version of the Falcon D
> - Falcon DMT - Multi-Thread version of the Falcon D
> - Osprey DMT - Multi-Thread version of Osprey D
> 
> There is also the Flareon, which is what will be used in Dove:
> - Based on the Jolteon
> - v6/v7 support
> - packaged with L2, VFP, AXI
> 
> All of these cores can be mixed-and-matched with L2, VFP, AXI, wMMXt,
> etc.
> 
> ----- >8

Ok, so it seems that Mohawk is not just the name for 88sv331 in IXP3xx but
also for 88fr331 in Orion, I should add that. The table also confirms that
Feroceon is used as a family name for multiple cores rather than just
one of the models. It doesn't explain how the Feroceon and Sheeva names
relate though, I'll just leave that part of my table as it is, it's
still my best guess.

My table is now:

  Feroceon-1850 88fr331 "Mohawk"
        CPUID 0x5615331x or 0x41xx926x
        ARMv5TE, single issue
  Feroceon-2850 88fr531-vd "Jolteon"
        CPUID 0x5605531x or 0x41xx926x
        ARMv5TE, VFP, dual-issue
  Feroceon 88fr571-vd "Jolteon"
        CPUID 0x5615571x
        ARMv5TE, VFP, dual-issue
  Feroceon 88fr131 "Mohawk-D"
        CPUID 0x5625131x
        ARMv5TE, single-issue, in-order
  Sheeva PJ1 88sv331 "Mohawk"
        CPUID 0x561584xx
        ARMv5, single-issue, iWMMXt v2

Connecting the 88fr131 product code with the "Mohawk-D" name is a wild
guess, based on the fact that this is a later version of 88fr331 and
runs at a higher clock frequency but has a lower number.

88fr131 is the core used in Kirkwood. Is there any way to find out if
Kirkwood is indeed an in-order core unlike Orion5x?

	Arnd
