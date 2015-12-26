From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Sat, 26 Dec 2015 14:28:53 +0000
Subject: [RFC PATCH] ARM64: mm: check if the read/write block is in
 memblock
In-Reply-To: <1451115730-4244-1-git-send-email-yangyingliang@huawei.com>
References: <1451115730-4244-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <20151226142853.GV25034@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yang,

On Sat, Dec 26, 2015 at 03:42:10PM +0800, Yang Yingliang wrote:
> If the address is non-RAM address, when we read/write
> the /dev/mem it will cause an exception. It is not enough
> that just check if the address is out of high_memory in
> valid_phys_addr_range(), when we read/write the /dev/mem.
> Because it may have memory holes below the high_memory,
> when the system tries to access them, it will trigger an
> exception. To avoid the exception, it needs to check
> if the read/write range is a subset of a System RAM in
> valid_phys_addr_range().
> 
>  Reproduce the problem by command:
>  # cat /dev/mem > /tmp/mem

I have two issues with this patch:
1) I hate /dev/mem. It is the opposite of what an operating system is
   for, And I am reasonaly convinced it can never practically be made
   safe for use outside of platforms with very strictly defined memory
   maps (x86), and I'm not entirely sure about those either. If
   anything, we should be directing people towards disabling the
   interface completely, now that this option exists.
2) If we were to accept that /dev/mem has genuine merit, would this
   patch not completely disable the (unfortunate) use case of mapping
   i/o devices from userland?

So I would like to turn the tables and ask - what is it you feel you
need /dev/mem for on arm64? Is there another way the kernel can
provide that, using a less suicidal mechanism? We (well, Roy and Ivan,
and Jean) have already enabled interfaces for ACPI and SMBIOS access
without providing userland with direct access to system memory - could
something similar be done for your use case?

Regards,

Leif

> Unable to handle kernel paging request at virtual address ffff80007fc00000
> pgd = ffff8011f5ee8000
> [ffff80007fc00000] *pgd=0000000000000000
> Internal error: Oops: 96000006 [#1] SMP
> 
> Modules linked in:
> 
> CPU: 2 PID: 885 Comm: cat Not tainted 4.1.12+ #3
> task: ffff8011f604a100 ti: ffff8011f54b4000 task.ti: ffff8011f54b4000
> PC is at __copy_to_user+0xc/0x60
> LR is at read_mem+0xc8/0x150
> pc : [<ffff80000035ab9c>] lr : [<ffff800000402178>] pstate: 20000145
> sp : ffff8011f54b7d70
> x29: ffff8011f54b7d70 x28: ffff800000987000
> x27: 0000fffffcda5c70 x26: 000000007fc00000
> x25: 0000000000001000 x24: ffff8011f54b4000
> x23: ffff800000000000 x22: 0000000000001000
> x21: 0000000000000000 x20: ffff8011f54b7ec8
> x19: 0000000000001000 x18: 0000000000000000
> x17: 0000ffff7c4e8e10 x16: ffff8000001aabd0
> x15: 000000000000579b x14: 0000ffff7c42daa0
> x13: 0000ffff7c430aa8 x12: 000000000000081a
> x11: 0101010101010101 x10: 0000ffff7c645cb0
> x9 : 6b6872731f203c1f x8 : 000000000000003f
> x7 : 0000000000000000 x6 : ffff8000006c5c68
> x5 : ffff8000004020b0 x4 : 0000fffffcda6c70
> x3 : 0000000000000001 x2 : 0000000000000ff8
> x1 : ffff80007fc00000 x0 : 0000fffffcda5c70
> 
> Process cat (pid: 885, stack limit = 0xffff8011f54b4020)
> Stack: (0xffff8011f54b7d70 to 0xffff8011f54b8000)
> 7d60:                                     ffff8011 f54b7dd0 ffff8000 001a96c8
> 7d80: ffff8011 f51b3a00 ffff8011 f54b7ec8 ffff8011 f54b7ec8 00000000 00001000
> 7da0: 00000000 60000000 00000000 00000015 00000000 0000011a 00000000 0000003f
> 7dc0: ffff8000 00674000 ffff8011 f54b4000 ffff8011 f54b7e50 ffff8000 001aa00c
> 7de0: ffff8011 f51b3a00 0000ffff fcda5c70 00000000 00000000 00000000 00000000
> 7e00: ffff8011 f54b7e30 ffff8000 001a9ee4 00000000 00001000 ffff8011 f51b3a00
> 7e20: ffff8011 f54b7ec8 00000000 00001000 ffff8011 f54b7e50 ffff8000 001a9ff0
> 7e40: ffff8011 f51b3a00 0000ffff fcda5c70 ffff8011 f54b7e90 ffff8000 001aac14
> 7e60: ffff8011 f51b3a00 ffff8011 f51b3a00 0000ffff fcda5c70 00000000 00001000
> 7e80: 00000000 60000000 00000000 00001000 0000ffff fcda6d90 ffff8000 00084c30
> 7ea0: 00000000 00000000 00000000 00001000 ffffffff ffffffff 0000ffff 7c4e8df8
> 7ec0: 00000000 00000038 00000000 7fc00000 00000000 00000003 0000ffff fcda5c70
> 7ee0: 00000000 00001000 00000000 00000000 00000000 00000000 00000000 00000001
> 7f00: 00000000 00000080 00000000 00000000 00000000 0000003f 6b687273 1f203c1f
> 7f20: 0000ffff 7c645cb0 01010101 01010101 00000000 0000081a 0000ffff 7c430aa8
> 7f40: 0000ffff 7c42daa0 00000000 0000579b 00000000 00000000 0000ffff 7c4e8e10
> 7f60: 00000000 00000000 00000000 0049e000 00000000 00001000 0000ffff fcda5c70
> 7f80: 00000000 00000003 00000000 00000003 00000000 00000001 00000000 00000001
> 7fa0: 00000000 00001000 00000000 00000038 00000000 00000000 0000ffff fcda6d90
> 7fc0: 00000000 0040a9a4 0000ffff fcda5bf0 0000ffff 7c4e8df8 00000000 60000000
> 7fe0: 00000000 00000003 00000000 0000003f afafafaf afafafaf afafafaf afafafaf
> Call trace:
> [<ffff80000035ab9c>] __copy_to_user+0xc/0x60
> [<ffff8000001a96c4>] __vfs_read+0x24/0x110
> [<ffff8000001aa008>] vfs_read+0x78/0x150
> [<ffff8000001aac10>] SyS_read+0x40/0xa0
> Code: 1f2003d5 0400028b 422000f1 a4000054 (238440f8)
> ---[ end trace 0fa00f6f46f79c5a ]---
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Leif Lindholm <leif.lindholm@linaro.org>
> Cc: Xishi Qiu <qiuxishi@huawei.com>
> ---
>  arch/arm64/mm/mmap.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index ed17747..5e89dcf 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -26,6 +26,7 @@
>  #include <linux/io.h>
>  #include <linux/personality.h>
>  #include <linux/random.h>
> +#include <linux/memblock.h>
>  
>  #include <asm/cputype.h>
>  
> @@ -100,12 +101,24 @@ EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
>   */
>  int valid_phys_addr_range(phys_addr_t addr, size_t size)
>  {
> +	int i;
> +	int cnt = memblock.memory.cnt;
> +	phys_addr_t addr_end = addr + size;
> +
>  	if (addr < PHYS_OFFSET)
>  		return 0;
> -	if (addr + size > __pa(high_memory - 1) + 1)
> +	if (addr_end > __pa(high_memory - 1) + 1)
>  		return 0;
>  
> -	return 1;
> +	for (i = 0; i < cnt; i++) {
> +		phys_addr_t mem_start = memblock.memory.regions[i].base;
> +		phys_addr_t mem_end = memblock.memory.regions[i].base + memblock.memory.regions[i].size;
> +
> +		if (addr >= mem_start && addr_end <= mem_end)
> +			return 1;
> +	}
> +
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.5.0
> 
> 
