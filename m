From: james.morse@arm.com (James Morse)
Date: Mon, 8 Oct 2018 17:03:27 +0100
Subject: 4.19-rcX: WARN_ON() arch/arm64/kernel/setup.c:271
 reserve_memblock_reserved_regions
In-Reply-To: <20181008151138.GA19635@harukaze>
References: <20181008151138.GA19635@harukaze>
Message-ID: <47fa0375-ed69-0cbc-9dcb-0cafb9184f24@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo!

On 08/10/2018 16:11, Paolo Pisati wrote:
> This on my dragonboard 410c:
> 
> ...
> [    0.170657] WARNING: CPU: 2 PID: 1 at arch/arm64/kernel/setup.c:271 reserve_memblock_reserved_regions+0xd4/0x150
> [    0.170666] Modules linked in:
> [    0.170680] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7-dirty #3
> [    0.170687] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> [    0.170696] pstate: 20000005 (nzCv daif -PAN -UAO)
> [    0.170707] pc : reserve_memblock_reserved_regions+0xd4/0x150
> [    0.170718] lr : reserve_memblock_reserved_regions+0xcc/0x150
> [    0.170725] sp : ffff000008033d30

> [    0.170899] Call trace:
> [    0.170910]  reserve_memblock_reserved_regions+0xd4/0x150
> [    0.170921]  do_one_initcall+0x58/0x170
> [    0.170931]  kernel_init_freeable+0x1a4/0x264
> [    0.170942]  kernel_init+0x10/0x108
> [    0.170952]  ret_from_fork+0x10/0x18
> [    0.170962] ---[ end trace c7ce9242331f7319 ]---
> [    0.170974] name: reserved res: [mem 0xbff00000-0xbfffffff flags 0x200]

John Stultz saw this on Hikey,

> that memory region corresponds to the ramoops node:

... it was the ramoops description too.

There is a patch:
https://www.spinics.net/lists/arm-kernel/msg675580.html

Which I need to re-spin.

This is happening because your reserved-memory isn't described as memory. I
mistakenly believed no-one would do this, and I really didn't want to walk both
them memory and reserved lists at the same time!

mm/page_alloc.c:zero_resv_unavail() has a comment about this:
|	* Once memblock is changed so such behaviour is not allowed: i.e.
|	* list of "reserved" memory must be a subset of list of "memory", then
|	* this code can be removed.


> According to the comment in reserve_memblock_reserved_regions():

> and the reserved-memory region evades this condition, but i'm not entirely sure how to
> properly fix this - any idea?

Ideally reserved-memory would be described as memory. If you need it to be
removed from the linear map (e.g. because it needs special memory attributes),
use the binding's 'nomap' property. This causes
early_init_dt_reserve_memory_arch() to remove the memory instead of marking it
reserved.

But! DT's that have this reserved-but-not-memory are already out there, so we
should work around this in the kernel.


Thanks,

James
