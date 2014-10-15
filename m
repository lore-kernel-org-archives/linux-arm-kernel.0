From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 15 Oct 2014 20:18:18 +0300
Subject: ARM: issue with memory reservation from DT
Message-ID: <543EAC5A.6050209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I did some experiments with memory reservation from DT and got boot failure.

Input data:
- Platform Keystone 2 K2HK
- LPAE enabled
- RAM 1G:
	memory {
		reg = <0x8 0x00000000 0x0 0x40000000>; 
	};

- memory reservation 512M:

	reserved-memory {
		#address-cells = <2>;
		#size-cells = <2>;
		ranges;

		dspsmem: dspsmem at 20000000 {
			reg = <0x8 0x20000000 0x0 0x20000000>;
			no-map;
		};
	};

So, total memory available for Kernel should be 512M, below is memory state for the case
when memory is reserved from u-boot:
[    0.000000] Memory: 486200K/524288K available (5085K kernel code, 265K rwdata, 1776K rodata, 296K init, 178K bss, 38088K reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc06bb8a4   (6863 kB)
[    0.000000]       .init : 0xc06bc000 - 0xc0706000   ( 296 kB)
[    0.000000]       .data : 0xc0706000 - 0xc07485fc   ( 266 kB)
[    0.000000]        .bss : 0xc07485fc - 0xc07751e0   ( 179 kB)


Why:
- I'm trying to reserve memory from kernel instead of u-boot.

Fast ;( investigation results:

1) The issue happens only if no-map; is used. In this case FDT
code will call memblock_remove() instead of memblock_reserve().


2) ARM limits are set wrongly from sanity_check_meminfo():
  [    0.000000] ======= memblock_limit=0x000000082f800000 arm_lowmem_limit=0x000000082f800000 vmalloc_limit=ef800000 high_memory=0x000000082f800000
instead of
  [    0.000000] ======= memblock_limit=0x0000000820000000 arm_lowmem_limit=0x0000000820000000 vmalloc_limit=e0000000 high_memory=0x000000082f800000

3) If I apply below change - I can boot:
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c031063..85ad92b 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -917,8 +917,8 @@ void __init setup_arch(char **cmdline_p)
 
        early_paging_init(mdesc, lookup_processor_type(read_cpuid_id()));
        setup_dma_zone(mdesc);
-       sanity_check_meminfo();
        arm_memblock_init(mdesc);
+       sanity_check_meminfo();
 
        paging_init(mdesc);
        request_standard_resources(mdesc);

^^ not sure if it totally safe, because dma_contiguous_reserve(arm_dma_limit);
is called from inside arm_memblock_init() and it does bootmem allocations.

Sort Summary:
It looks like all static memory reservation and memory stealing's (calling of memblock_remove()) 
 have to be done before any other operations and before calculating ARM memory limits.

Thank you for any comments.

Regards,
-grygorii
