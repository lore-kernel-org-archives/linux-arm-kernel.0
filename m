From: lbassel@codeaurora.org (Larry Bassel)
Date: Thu, 24 Mar 2011 15:18:54 -0700
Subject: how can I cleanly exclude memory from the kernel memory allocator?
Message-ID: <20110324221854.GA29359@labbmf-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I want to (early in system initialization) exclude some
contiguous physical memory from one or more memory banks
so that it won't be mapped in the normal kernel 1-to-1 mapping
(so that it can be mapped uncached, strongly ordered, etc.
as needed -- I know that it is forbidden to have a cached
and an uncached mapping to the same memory) and so that it
won't be freed into the kernel memory allocator (so that
it won't fragment and can be allocated using genalloc).

I have tried to find a clean way to do this, but none of
the approaches I've considered seem very good:

1. Add a hook to the memory tag parsing routine to (possibly)
change each tag before arm_add_memory() is called,
or alter arm_add_memory() itself.
2. Add a hook at the beginning of paging_init() to inspect
and alter the meminfo memory bank starts and sizes as needed.
3. Wait until after the memory is added to the normal
kernel memory pool and somehow get it back out
(I can't use alloc_bootmem() or related functionality of course
since then the memory will be part of the cached kernel 1-to-1 1M
page mapping, precluding use of ioremap() on it).

A further drawback for #1 is that I'd really like to
see all of the available memory banks before deciding which
memory to steal (we often have multiple memory banks on
our platforms).

Perhaps there is a solution for this problem that already exists
that I'm unaware of (or at least community consensus about how
one should add this functionality).

I believe Russell King has stated that he intends
to carve out memory that can be used for dma_alloc_coherent(),
that won't be mapped otherwise by the kernel.

I'd like to know how he is planning to do this, as I could hopefully
do something similar.

Thanks.

Larry Bassel

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
