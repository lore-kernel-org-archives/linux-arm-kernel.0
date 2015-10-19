From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 19 Oct 2015 16:20:05 -0700
Subject: vmalloc_reserve with no highmem
Message-ID: <56257AA5.1030800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, Laura,

Setting vmalloc= on the kernel command-line to define the amount of
vmalloc_reserve is not quite working when you have no highmem, as is the
case of one my boards which has 512MB or 256M populated on a first bank
at PA 0x0.

What happens in that case is that, despite setting vmalloc_reserve,
therefore bumping up vmalloc_min to a higher address than high_memory,
which is assigned __va(arm_lowmem_limit), we end-up with VMALLOC_START
at high_memory + VMALLOC_OFFSET, which yields the amount of physical
memory (start at PA 0x0 in my case) - VMALLOC_OFFSET.

The maths look like this for this particular board (512MB)

high_memory = 0x20000000 + PAGE_OFFSET = 0x20000000 + 0xC0000000 =
0xE0000000
vmalloc_min = 0xFF00000 - (248 * 1024 * 1024) = 0xEF800000

so we end-up with VMALLOC_START = high_memory + VMALLOC_OFFSET =
0xE0000000 + 8 * 1024* 1024 = 0xE0800000

in sanity_check_meminfo(), high_memory is unconditionally assigned with
arm_lowmem_limit's VA.

The following quick and dirty patch seems to do it for me, but I am not
confident this is remotely the correct approach here:

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 14428d2..e196ea4 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1196,7 +1211,14 @@ void __init sanity_check_meminfo(void)
        }
 #endif
        meminfo.nr_banks = j;
-       high_memory = __va(arm_lowmem_limit - 1) + 1;
+
+       if (vmalloc_limit > arm_lowmem_limit)
+               high_memory = vmalloc_min - VMALLOC_OFFSET;
+       else
+               high_memory = __va(arm_lowmem_limit - 1) + 1;
+
+       pr_info("%s: high_memory: 0x%p, arm_lowmem_limit: 0x%llx\n",
+               __func__, high_memory, arm_lowmem_limit);

BTW, even when there is highmem available, setting vmalloc= on the
command-line is off by VMALLOC_OFFSET, the way early_vmalloc() computes
things, is that intended?

Thanks!
-- 
Florian
