From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 3 May 2017 21:18:14 +0100
Subject: [PATCH] arm64: Add translation functions for /dev/mem read/write
In-Reply-To: <bda22142-6b46-0e11-9d13-4bed0dcfd713@codeaurora.org>
References: <1493756885-29704-1-git-send-email-sgoel@codeaurora.org>
 <20170503112639.GG8233@arm.com>
 <bda22142-6b46-0e11-9d13-4bed0dcfd713@codeaurora.org>
Message-ID: <20170503201814.GP1657@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 11:07:45AM -0600, Goel, Sameer wrote:
> On 5/3/2017 5:26 AM, Will Deacon wrote:
> > [adding some /dev/mem fans to cc]
> > 
> > On Tue, May 02, 2017 at 02:28:05PM -0600, Sameer Goel wrote:
> >> Port architecture specific xlate and unxlate functions for /dev/mem
> >> read/write. This sets up the mapping for a valid physical address if a
> >> kernel direct mapping is not already present.
> >>
> >> This is a generic issue as a user space app should not be allowed to crash
> >> the kernel.
> > 
> >> This issue was observed when systemd tried to access performance
> >> pointer record from the FPDT table.
> > 
> > Why is it doing that? Is there not a way to get this via /sys?
>
> There is no ACPI FPDT implementation in the kernel, so the userspace
> systemd code is getting the FPDT table contents from /sys
> and parsing the entries. The performance pointer record is a
> reserved address populated by UEFI and the userspace code tries to
> access it using /dev/mem. The physical address is valid, so cannot
> push back on the user space code.

OK, so then we need to add support for parsing this table in the
kernel and exposing the referred-to regions in a controllable fashion.
Maybe something that belongs under /sys/firmware/efi (adding Matt), or
maybe something that deserves its own driver.

The only two use-cases for /dev/mem on arm64 are:
- Implementing interfaces in the kernel takes up-front effort.
- Being able to accidentally panic the kernel from userland.

/
    Leif

> https://github.com/systemd/systemd/blob/master/src/shared/acpi-fpdt.c
> http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf  5.2.23 
> > 
> >> Ported from commit e045fb2a988a ("x86: PAT avoid aliasing in /dev/mem
> >> read/write")
> >>
> >> Crash Signature:
> >>  Unable to handle kernel paging request at virtual address ffff800008ff0000
> >>  pgd = ffff8007de8b2200
> >>  [ffff800008ff0000] *pgd=0000000000000000, *pud=0000000000000000
> >>  Internal error: Oops: 96000007 [#1] SMP
> >> ................
> >>  CPU: 0 PID: 1 Comm: systemd Not tainted 4.10.0 #1
> >>  task: ffff8007c0820000 task.stack: ffff8007c0900000
> >>  PC is at __arch_copy_to_user+0xb4/0x280
> >>  LR is at read_mem+0xc0/0x138
> >>  pc : [<ffff0000084b3bb4>] lr : [<ffff00000869d178>]
> >> pstate: 80000145
> >>  sp : ffff8007c0903d40
> >> ....................
> >>  x3 : ffff800800000000 x2 : 0000000000000008
> >>  x1 : ffff800008ff0000 x0 : 0000fffff6fdac00
> >> ....................
> >>  Call trace:
> >>  Exception stack(0xffff8007c0903b70 to 0xffff8007c0903ca0)
> >>  [<ffff0000084b3bb4>] __arch_copy_to_user+0xb4/0x280
> >>  [<ffff0000082454d0>] __vfs_read+0x48/0x130
> >>  [<ffff0000082467dc>] vfs_read+0x8c/0x148
> >>  [<ffff000008247a34>] SyS_pread64+0x94/0xa8
> >>  [<ffff0000080833b0>] el0_svc_naked+0x24/0x28
> > 
> > So this certainly looks like a kernel bug, but I don't think your patch is
> > the right way to fix it.
> 
> I agree that the reserved regions are not meant to be accessed by the kernel as system 
> ram. So, another option was to to return a NULL for this translation.
> 
> Since, the same usage was working on other architectures I ported over the same code to
> highlight the issue.
> 
> > 
> >>  Code: a88120c7 d503201f d503201f 36180082 (f8408423)
> >>
> >> Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
> >> Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
> >> ---
> >>  arch/arm64/include/asm/io.h |  5 +++++
> >>  arch/arm64/mm/ioremap.c     | 31 +++++++++++++++++++++++++++++++
> >>  2 files changed, 36 insertions(+)
> >>
> >> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> >> index 0c00c87..c869ea4 100644
> >> --- a/arch/arm64/include/asm/io.h
> >> +++ b/arch/arm64/include/asm/io.h
> >> @@ -183,6 +183,11 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
> >>  #define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
> >>  #define iowrite64be(v,p)	({ __iowmb(); __raw_writeq((__force __u64)cpu_to_be64(v), p); })
> >>  
> >> +extern void *xlate_dev_mem_ptr(phys_addr_t phys);
> >> +extern void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
> >> +
> >> +#define xlate_dev_mem_ptr xlate_dev_mem_ptr
> >> +#define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
> >>  #include <asm-generic/io.h>
> >>  
> >>  /*
> >> diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> >> index c4c8cd4..ba7e63b 100644
> >> --- a/arch/arm64/mm/ioremap.c
> >> +++ b/arch/arm64/mm/ioremap.c
> >> @@ -24,6 +24,7 @@
> >>  #include <linux/mm.h>
> >>  #include <linux/vmalloc.h>
> >>  #include <linux/io.h>
> >> +#include <linux/memblock.h>
> >>  
> >>  #include <asm/fixmap.h>
> >>  #include <asm/tlbflush.h>
> >> @@ -105,6 +106,36 @@ void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size)
> >>  EXPORT_SYMBOL(ioremap_cache);
> >>  
> >>  /*
> >> + * Convert a physical pointer to a virtual kernel pointer for /dev/mem
> >> + * access
> >> + */
> >> +void *xlate_dev_mem_ptr(phys_addr_t phys)
> >> +{
> >> +	unsigned long start  = phys &  PAGE_MASK;
> >> +	unsigned long offset = phys & ~PAGE_MASK;
> >> +	void *vaddr;
> >> +
> >> +	/* If page is RAM, we can use __va. Otherwise ioremap and unmap. */
> >> +	if (page_is_ram(start >> PAGE_SHIFT) && memblock_is_memory(phys))
> >> +		return __va(phys);
> >> +
> >> +	vaddr = ioremap_cache(start, PAGE_SIZE);
> > 
> > Blindly using ioremap like this looks unsafe, since we could accidentally
> > set conflict with the attributes of a mapping used by something else (e.g.
> > firmware running on another CPU).
> > 
> > I'd like to understand more about the crash, so we can see work out how to
> > fix this properly.
> >
> This does opens up access to any valid physical address. In the short term we 
> can block this crash by return NULL from this function if the memblock is MEMBLOCK_NOMAP.
> 
> Eventually we might need to add another memory type to make sure that it can be mapped.
> I have not though about the exact design here.
> 
> Thanks,
> Sameer
>  
> > Will
> > 
> 
> -- 
>  Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
