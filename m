From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 31 May 2010 09:18:00 +0900
Subject: [PATCH] s5pv210: Change the base ram address to 0x3000'0000
In-Reply-To: <20100528023559.GA8174@july>
References: <20100528023559.GA8174@july>
Message-ID: <004601cb0056$bcd03420$36709c60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> s5pc110 (aka s5pv210) has 2 DRAM port and used it both usually.
> Assume DMC0 starts with 0x2000'0000 with 128MiB.
> DMC1 starts with 0x4000'0000 with 128MiB.
> Note that DMC1 has to start address 0x4000'0000 at least.

Hi,

Following is memory map of S5PV210 and S5PC110.

0x80000000  -------------------
            |          |
0x70000000  |          |
            |          |
0x60000000  |  DMC 1  |  up to 1GB
            |          |
0x50000000  |          |
            |          |
0x40000000  ----------------- 
            |          |
0x30000000  |  DMC 0  |  up to 512MB
            |          |
0x20000000  -------------------

According to memory map, S5PV210 and S5PC110 can support up to 1.5GB memory.
So, the base address of system memory should be 0x20000000 to support 1.5GB.

The oneDRAM in S5PC110 MCP(Multi Chip Package) has to map to DMC0, but
mDDR(or SDR) in the MCP without oneDRAM can be mapped to DMC0.
Also, whatever memory types, the base address must be at 0x20000000, in case
the memory size is over 256MB.

That is, it has problem to move base address of system memory to 0x30000000
only to support specific S5PC110 MCP type.

> Then there's too much memory hole 0x1800'0000 (128MiB + 256MiB)
> 
> To reduce memory waste, the DMC0 start with 0x3000'0000.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/arch/arm/mach-s5pv210/Makefile.boot b/arch/arm/mach-
> s5pv210/Makefile.boot
> index ff90aa1..b0909e3 100644
> --- a/arch/arm/mach-s5pv210/Makefile.boot
> +++ b/arch/arm/mach-s5pv210/Makefile.boot
> @@ -1,2 +1,2 @@
> -   zreladdr-y	:= 0x20008000
> -params_phys-y	:= 0x20000100
> +   zreladdr-y	:= 0x30008000
> +params_phys-y	:= 0x30000100
> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-
> s5pv210/include/mach/map.h
> index 34eb168..9f4c368 100644
> --- a/arch/arm/mach-s5pv210/include/mach/map.h
> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> @@ -74,7 +74,7 @@
>  #define S5PV210_PA_VIC3		(0xF2300000)
>  #define S5P_PA_VIC3		S5PV210_PA_VIC3
> 
> -#define S5PV210_PA_SDRAM	(0x20000000)
> +#define S5PV210_PA_SDRAM	(0x30000000)
>  #define S5P_PA_SDRAM		S5PV210_PA_SDRAM
> 
>  /* I2S */
> diff --git a/arch/arm/mach-s5pv210/include/mach/memory.h b/arch/arm/mach-
> s5pv210/include/mach/memory.h
> index 379117e..07a15d8 100644
> --- a/arch/arm/mach-s5pv210/include/mach/memory.h
> +++ b/arch/arm/mach-s5pv210/include/mach/memory.h
> @@ -13,7 +13,7 @@
>  #ifndef __ASM_ARCH_MEMORY_H
>  #define __ASM_ARCH_MEMORY_H
> 
> -#define PHYS_OFFSET		UL(0x20000000)
> +#define PHYS_OFFSET		UL(0x30000000)
>  #define CONSISTENT_DMA_SIZE	(SZ_8M + SZ_4M + SZ_2M)
> 
>  /* Maximum of 256MiB in one bank */
> 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
