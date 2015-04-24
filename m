From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Apr 2015 11:11:36 +0100
Subject: [v2 1/5] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <1429861989-8417-2-git-send-email-takahiro.akashi@linaro.org>
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <1429861989-8417-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20150424101136.GE29183@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 24, 2015 at 08:53:04AM +0100, AKASHI Takahiro wrote:
> On system kernel, the memory region used by crash dump kernel must be
> specified by "crashkernel=X at Y" boot parameter. reserve_crashkernel()
> will allocate the region in "System RAM" and reserve it for later use.
> 
> On crash dump kernel, memory region information in system kernel is
> described in a specific region specified by "elfcorehdr=X at Y" boot parameter.
> reserve_elfcorehdr() will set aside the region to avoid data destruction
> by the kernel.
> 
> Crash dump kernel will access memory regions in system kernel via
> copy_oldmem_page(), which reads a page by ioremap'ing it assuming that
> such pages are not part of main memory of crash dump kernel.
> This is true under non-UEFI environment because kexec-tools modifies
> a device tree adding "usablemem" attributes to memory sections.

I'm not sure what you mean by "usablemem" here.

Do you just mean that the memory nodes are altered such that they only
cover memory usable by the crash kernel?

Why not _always_ require a command line argument for the crash kernel
that restricts its memory usage to a particular range? That way it
doesn't matter whether we're using UEFI or not.

> Under UEFI, however, this is not true because UEFI remove memory sections
> in a device tree and export all the memory regions, even though they belong
> to system kernel.
> 
> So we should add "mem=X[MG]" boot parameter to limit the memory size and
> avoid hitting the following assertion in ioremap():
>         if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
>                 return NULL;

That looks suspicious. What is being ioremapped at that point?

[...]

> @@ -393,6 +398,7 @@ void __init setup_arch(char **cmdline_p)
>         local_async_enable();
> 
>         efi_init();
> +
>         arm64_memblock_init();
> 
>         paging_init();

Nit: unrelated whitespace change.

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index ae85da6..ea70d41 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -34,6 +34,8 @@
>  #include <linux/dma-contiguous.h>
>  #include <linux/efi.h>
>  #include <linux/swiotlb.h>
> +#include <linux/kexec.h>
> +#include <linux/crash_dump.h>

Nit: please keep these ordered.

[...]

> +               if (memblock_reserve(crash_base, crash_size)) {
> +                       pr_warn("crashkernel reservation failed - out of memory\n");
> +                       return;
> +               }

If we can remove this memory rather than reserving it, we can limit the
first kernel's ability to accidentally clobber the crash kernel, at the
expense of having to explicitly map/unmap around loading it.

Mark.
