From: nm@ti.com (Nishanth Menon)
Date: Mon, 11 May 2015 13:58:32 -0500
Subject: [PATCH 5/7] ARM: re-implement physical address space switching
In-Reply-To: <E1YpwbF-0000wd-MP@rmk-PC.arm.linux.org.uk>
References: <20150506103000.GF2067@n2100.arm.linux.org.uk>
 <E1YpwbF-0000wd-MP@rmk-PC.arm.linux.org.uk>
Message-ID: <5550FBD8.3070103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2015 05:30 AM, Russell King wrote:
[...]
> @@ -1436,75 +1435,32 @@ void __init early_paging_init(const struct machine_desc *mdesc,

[...]
> -	/* Finally flush any stale TLB values. */
> -	local_flush_bp_all();
> -	local_flush_tlb_all();
> +	/* Re-enable the caches and cacheable TLB walks */
> +	asm volatile("mcr p15, 0, %0, c2, c0, 2" : : "ttbcr");
^^
on next-20150511, echo
"CONFIG_ARM_LPAE=y">>arch/arm/configs/multi_v7_defconfig ;make
multi_v7_defconfig;make arch/arm/mm/mmu.o
#
# configuration written to .config
#
scripts/kconfig/conf  --silentoldconfig Kconfig

<snip>
  CC      arch/arm/mm/mmu.o
arch/arm/mm/mmu.c: In function ?early_paging_init?:
arch/arm/mm/mmu.c:1461:54: error: expected ?(? before ?)? token
make[1]: *** [arch/arm/mm/mmu.o] Error 1
make: *** [arch/arm/mm/mmu.o] Error 2
this was using [1]

using gcc 4.9[2]:
arch/arm/mm/mmu.c: In function ?early_paging_init?:
arch/arm/mm/mmu.c:1461:54: error: expected ?(? before ?)? token
  asm volatile("mcr p15, 0, %0, c2, c0, 2" : : "ttbcr");
                                                      ^
scripts/Makefile.build:258: recipe for target 'arch/arm/mm/mmu.o' failed
make[1]: *** [arch/arm/mm/mmu.o] Error 1
Makefile:1545: recipe for target 'arch/arm/mm/mmu.o' failed
make: *** [arch/arm/mm/mmu.o] Error 2


> +	set_cr(cr);
>  }

[1] $ arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
Copyright (C) 2011 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.

[2] $ arm-linux-gnu-gcc --version
arm-linux-gnu-gcc (GCC) 4.9.2 20150107 (Red Hat Cross 4.9.2-3)
Copyright (C) 2014 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.

-- 
Regards,
Nishanth Menon
