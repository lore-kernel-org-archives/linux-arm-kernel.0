From: ccross@google.com (Colin Cross)
Date: Tue, 1 Mar 2011 18:23:13 -0800
Subject: Common suspend and resume with L2 cache on
Message-ID: <AANLkTimxDjSun5+gaU5fMNf2KMVTNbfdq-D=0iU6tYZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that common suspend helpers are in linux-next, I'm going back to
trying to use them with the L2 cache on, which is required when
implementing cpuidle states that put a cpu in reset in an SMP system.

There are a few obvious requirements - the stack pointer, stack
contents, and page tables must be flushed in the L2 during suspend.

There is one trickier problem. The current resume sequence starts from
reset, with cache and MMU off:
   Restore cpu registers, including TTBR0, but not SCTLR
   Rewrite the page table to map the MMU trampoline VA=PA
   Restore SCTLR with dcache bit off (enables MMU)
   Jump to virtual address
   Restore SCTLR with original dcache bit

The page table is rewritten with the temporary mapping with the cache
off, so the write goes directly to memory.  When the MMU is enabled,
the TTBR0 RGN and IRGN bits determine the cachability attributes of
the page table walk memory accesses.  These bits are normally set to
cachable, so when the MMU is turned on, the page table walks can hit
the L2 instead of memory.  If a stale entry for the temporary mapping
is in the L2, which can happen if it is prefetched by the other cpu
during suspend, the page table walk will not see the new mapping.

This could be fixed by restoring the TTBR0 register with caching
disabled, and re-enabling caching after the page table entry is
restored, or by switching to a custom page table prepared during init
to avoid any writes while the cache is off.
