From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Jan 2017 17:38:32 +0000
Subject: [PATCH WIP 4/4] ARM: remove compile time vector base for CP15 case
In-Reply-To: <20170107172228.6451-1-afzal.mohd.ma@gmail.com>
References: <20170107171339.GA5044@afzalpc>
 <20170107172228.6451-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170107173832.GN14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 07, 2017 at 10:52:28PM +0530, afzal mohammed wrote:
> vectors base is now dynamically updated for Hivecs as well as for
> REMAP_VECTORS_TO_RAM case to DRAM_START. Hence remove these CP15
> cases.
> 
> TODO:
> Kill off VECTORS_BASE completely - this would require to handle MMU
>  case as well as ARM_MPU scenario dynamically.

Why do you think MMU doesn't already handle it?

>  config VECTORS_BASE
>  	hex
> -	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
> -	default DRAM_BASE if REMAP_VECTORS_TO_RAM
> +	default 0xffff0000 if MMU
>  	default 0x00000000

When MMU=y, the resulting VECTORS_BASE is always 0xffff0000.  The only
case where this ends up zero after your change is when MMU=n.

In any case here's the places it's used:

For nommu:
arch/arm/kernel/head-nommu.S:       mov     r0, #CONFIG_VECTORS_BASE   @ Cover from VECTORS_BASE
arch/arm/kernel/head-nommu.S:       setup_region r0, r5, r6, MPU_DATA_SIDE  @ VECTORS_BASE, PL0 NA, enabled
arch/arm/kernel/head-nommu.S:       setup_region r0, r5, r6, MPU_INSTR_SIDE @ VECTORS_BASE, PL0 NA, enabled
arch/arm/mm/nommu.c:        memblock_reserve(CONFIG_VECTORS_BASE, 2 * PAGE_SIZE);
arch/arm/mm/nommu.c:        early_trap_init((void *)CONFIG_VECTORS_BASE);

To intercept the reset vector for secondary CPUs (because we hide it
away from platforms, so platforms end up hacking around to get at it.)
arch/arm/mach-berlin/platsmp.c:     vectors_base = ioremap(CONFIG_VECTORS_BASE, SZ_32K);

For printing:
arch/arm/mm/init.c:                 MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +

For dumping the page tables (but since this is only built for MMU=y,
we know what CONFIG_VECTORS_BASE is here.)
arch/arm/mm/dump.c: { CONFIG_VECTORS_BASE,     "Vectors" },
arch/arm/mm/dump.c: { CONFIG_VECTORS_BASE + PAGE_SIZE * 2, "Vectors End" },

For the Berlin and mm/dump code, we could very easily just have a
#define VECTORS_BASE 0xffff0000 in a header file and drop the CONFIG_
prefix.

The MMU case does have to cater for CPUs wanting vectors at 0xffff0000
and at 0x00000000, and this is handled via the page tables - but this
has nothing to do with CONFIG_VECTORS_BASE.  CONFIG_VECTORS_BASE
exists primarily for noMMU.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
