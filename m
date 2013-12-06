From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 03:31:31 +0100
Subject: Moschip MCS8142 SoC
In-Reply-To: <OF433D4F00.CB35F8E7-ON86257C37.004F3E8D@rockwellcollins.com>
References: <OF433D4F00.CB35F8E7-ON86257C37.004F3E8D@rockwellcollins.com>
Message-ID: <201312060331.31958.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 December 2013, mlweber1 at rockwellcollins.com wrote:
> Has anyone happened to work with this Moschip SoC?  I found Linux BSP 
> patches for the MCS8140 (OpenWRT 3.3 Kernel plus some initial attempts at 
> mainlining around 3.7), however that MCS8140 SoC was a true ARMv5 compared 
> to the MCS8142 which seems to be based on a Faraday fa526 ARMv4.  
> Another item I'm not to sure about is if the bus and peripheral 
> architecture are similar.
> 
> Any help is appreciated (reference docs that outline the register 
> definition, etc.) .  We're trying to get a 3.x kernel running on this 
> target to replace a older 2.6.24 blob that we can't get source for..... 
> 
> Matthew L Weber / Sr Software Engineer / Platform SW 

Hi Matthew,

Florian Fainelli (now on Cc) did the patch series for MCS814x in the past,
see http://lwn.net/Articles/507006/. As far as I understand, MCS8140
and MCS8142 only differ in the CPU core, so the required code is actually
almost identical.
However, I would now recommend doing the port on the latest kernel version,
i.e. 3.13 at this point, for which you would not be able to reuse
much of the code, as we have redone all the interfaces to make it simpler
to add a new platform. Essentially you add separate drivers to 
drivers/irqchip, drivers/clocksource, drivers/clk, arch/arm/include/debug
and drivers/pci/host but won't need any actual code in arch/arm/mach-* any
more at this point.

Jonas Jensen is working on support for the "moxart" platform, which uses
the same fa526 core and which is similar in other regards, so I'd recommend
looking at his code as examples for how to do this the right way.

	Arnd
