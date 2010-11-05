From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Fri, 5 Nov 2010 20:30:04 +0100
Subject: Cache clean of page table entries
Message-ID: <AANLkTinB8=fF7XiMvhEfPoBHh9A9qeHM-ZDP1UxxEyqY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am the developer of KVM on ARM. I'm seeing the following behavior on
ARMv6 hardware:

KVM needs to read guest page tables to create corresponding mappings
for shadow page tables. Since KVM is actually a kernel device, this
means access to those pages from kernel mode. The virtual addresses
used to read the data are allocated by QEMU in userspace and accessed
from the kernel using copy_from_user(...).

The virtual addresses to which they were written are determined
exclusively by the guest and are not known to the kernel outside of
the KVM module.

What happens is this:
 - The guest kernel allocates memory and writes a guest page table entry.
 - Later, the guest tries to access the virtual address mapped through
the above entry
 - The driver (KVM) will have to create a corresponding mapping in
it's shadow page tables (which are the ones used by the MMU). To do
so, it must read the guest page table.
 - Before reading the data, the user space address (which is passed to
copy_from_user) is invalidated on the cache.
 - From time to time, however the read returns incorrect
(uninitialized or stale) data.

I understand that since the data is read from a different virtual
address than it is written to, there may be aliasing issues.

However, I would think it was sufficient to invalidate the cache by
MVA on the read side. The reason is that, as far as I understand, the
guest kernel must generally clean cache entries and drain the write
buffer for shadow page table entry writes, since the MMU doesn't read
from L1 caches on TLB misses.

But, for instance, I see that in arch/arm/mm/mmu.c the
create_36bit_mapping function writes a pmd entry without calling
flush_pmd_entry(...).

The problem can be circumvented (which also verifies the problem) by
cleaning the entire data cache before reading the guest entries - this
comes with a significant performance penalty though.

Any thoughts?

-Christoffer
