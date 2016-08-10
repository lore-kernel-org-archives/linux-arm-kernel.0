From: james.morse@arm.com (James Morse)
Date: Wed, 10 Aug 2016 17:38:05 +0100
Subject: [PATCH v24 5/9] arm64: kdump: add kdump support
In-Reply-To: <20160809015615.28527-3-takahiro.akashi@linaro.org>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015615.28527-1-takahiro.akashi@linaro.org>
 <20160809015615.28527-3-takahiro.akashi@linaro.org>
Message-ID: <57AB586D.3080900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 09/08/16 02:56, AKASHI Takahiro wrote:
> On crash dump kernel, all the information about primary kernel's system
> memory (core image) is available in elf core header.
> The primary kernel will set aside this header with reserve_elfcorehdr()
> at boot time and inform crash dump kernel of its location via a new
> device-tree property, "linux,elfcorehdr".
> 
> Please note that all other architectures use traditional "elfcorehdr="
> kernel parameter for this purpose.
> 
> Then crash dump kernel will access the primary kernel's memory with
> copy_oldmem_page(), which reads one page by ioremap'ing it since it does
> not reside in linear mapping on crash dump kernel.
> 
> We also need our own elfcorehdr_read() here since the header is placed
> within crash dump kernel's usable memory.

On Seattle when I panic and boot the kdump kernel, I am unable to read the
/proc/vmcore file. Instead I get:
nanook at frikadeller:~$ sudo cp /proc/vmcore /
[  174.393875] Unhandled fault: synchronous external abort (0x96000210) at
0xffffff80096b6000
[  174.402158] Internal error: : 96000210 [#1] PREEMPT SMP
[  174.407370] Modules linked in:
[  174.410417] CPU: 6 PID: 2059 Comm: cp Tainted: G S      W I     4.8.0-rc1+ #4708
[  174.417799] Hardware name: AMD Overdrive/Supercharger/Default string, BIOS
ROD1002C 04/08/2016
[  174.426396] task: ffffffc0fdec5780 task.stack: ffffffc0f34bc000
[  174.432313] PC is at __arch_copy_to_user+0x180/0x280
[  174.437274] LR is at copy_oldmem_page+0xac/0xf0
[  174.441791] pc : [<ffffff800835e080>] lr : [<ffffff8008095b9c>] pstate: 20000145
[  174.449173] sp : ffffffc0f34bfc90
[  174.452474] x29: ffffffc0f34bfc90 x28: 0000000000000000
[  174.457776] x27: 0000000008000000 x26: 000000000000d000
[  174.463077] x25: 0000000000000001 x24: ffffff8008eb5000
[  174.468378] x23: 0000000000000000 x22: ffffff80096b6000
[  174.473679] x21: 0000000000000001 x20: 0000000030127000
[  174.478979] x19: 0000000000001000 x18: 0000007ff7085d60
[  174.484279] x17: 0000000000429358 x16: ffffff80081d9e88
[  174.489579] x15: 0000007fae377590 x14: 0000000000000000
[  174.494880] x13: 0000000000000000 x12: ffffff8008dd1000
[  174.500180] x11: ffffff80096b6fff x10: ffffff80096b6fff
[  174.505480] x9 : 0000000040000000 x8 : ffffff8008db6000
[  174.510781] x7 : ffffff80096b7000 x6 : 0000000030127000
[  174.516082] x5 : 0000000030128000 x4 : 0000000000000000
[  174.521382] x3 : 00e8000000000713 x2 : 0000000000000f80
[  174.526682] x1 : ffffff80096b6000 x0 : 0000000030127000
[  174.531982]
[  174.533461] Process cp (pid: 2059, stack limit = 0xffffffc0f34bc020)

[  174.848448] [<ffffff800835e080>] __arch_copy_to_user+0x180/0x280
[  174.854448] [<ffffff8008245f34>] read_from_oldmem.part.4+0xb4/0xf4
[  174.860615] [<ffffff8008246074>] read_vmcore+0x100/0x22c
[  174.865919] [<ffffff8008239378>] proc_reg_read+0x64/0x90
[  174.871223] [<ffffff80081d7da8>] __vfs_read+0x28/0x108
[  174.876348] [<ffffff80081d8ae4>] vfs_read+0x84/0x144
[  174.881301] [<ffffff80081d9ecc>] SyS_read+0x44/0xa0
[  174.886167] [<ffffff8008082ef0>] el0_svc_naked+0x24/0x28
[  174.891466] Code: 00000000 00000000 00000000 00000000 (a8c12027)
[  174.897562] ---[ end trace 00801b2e35b0cd1f ]---


The offending call is:
> copy_oldmem_page(0x8000000, 0x00000000385f8000, 0x1000, 0, 1)

This is trying to access the bottom page of memory. From the efi memory map:
> efi:   0x008000000000-0x008001e7ffff [Runtime Data       |RUN|  |WB|WT|WC|UC]*
> efi:   0x008001e80000-0x008001ffffff [Conventional Memory|   |  |WB|WT|WC|UC]

This page is 'Runtime Data', and marked as nomap by both the original and kdump
kernels, but copy_oldmem_page() doesn't know this.

In this case because we have already parsed the efi memory map again in the
kdump kernel and re-marked these regions as nomap, the below hunk fixes the
problem for me:
=========================%<=========================
diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
index 2dc54d129be1..784d4c30b534 100644
--- a/arch/arm64/kernel/crash_dump.c
+++ b/arch/arm64/kernel/crash_dump.c
@@ -37,6 +37,11 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
        if (!csize)
                return 0;

+       if (memblock_is_memory(pfn << PAGE_SHIFT) &&
+           !memblock_is_map_memory(pfn << PAGE_SHIFT))
+               /* skip this nomap memory region, reserved by firmware */
+               return 0;
+
        vaddr = ioremap_cache(__pfn_to_phys(pfn), PAGE_SIZE);
        if (!vaddr)
                return -ENOMEM;
=========================%<=========================

With this I can copy the vmcore file, and feed it to crash to read dmesg, task
list etc...

This could be a deeper/wider issue, but I can't see any other users of
memblock_mark_nomap().
Do you think depending on this this 're-learning' is robust enough, or should
the nomap ranges be described in the vmcoreinfo elf notes?


Thanks,

James


> diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
> new file mode 100644
> index 0000000..2dc54d1
> --- /dev/null
> +++ b/arch/arm64/kernel/crash_dump.c
> @@ -0,0 +1,71 @@
> +/*
> + * Routines for doing kexec-based kdump
> + *
> + * Copyright (C) 2014 Linaro Limited
> + * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/crash_dump.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/memblock.h>
> +#include <linux/uaccess.h>
> +#include <asm/memory.h>
> +
> +/**
> + * copy_oldmem_page() - copy one page from old kernel memory
> + * @pfn: page frame number to be copied
> + * @buf: buffer where the copied page is placed
> + * @csize: number of bytes to copy
> + * @offset: offset in bytes into the page
> + * @userbuf: if set, @buf is in a user address space
> + *
> + * This function copies one page from old kernel memory into buffer pointed by
> + * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
> + * copied or negative error in case of failure.
> + */
> +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> +			 size_t csize, unsigned long offset,
> +			 int userbuf)
> +{
> +	void *vaddr;
> +
> +	if (!csize)
> +		return 0;
> +
> +	vaddr = ioremap_cache(__pfn_to_phys(pfn), PAGE_SIZE);
> +	if (!vaddr)
> +		return -ENOMEM;
> +
> +	if (userbuf) {
> +		if (copy_to_user(buf, vaddr + offset, csize)) {
> +			iounmap(vaddr);
> +			return -EFAULT;
> +		}
> +	} else {
> +		memcpy(buf, vaddr + offset, csize);
> +	}
> +
> +	iounmap(vaddr);
> +
> +	return csize;
> +}
