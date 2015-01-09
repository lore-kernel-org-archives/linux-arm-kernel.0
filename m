From: mpeg.blue@free.fr (Mason)
Date: Fri, 09 Jan 2015 13:59:10 +0100
Subject: ioremap vs remap_pfn_range, VMSPLIT, etc
Message-ID: <54AFD09E.1010806@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

Yesterday, I used /dev/mem to mmap 2 GB and (to my surprise) it worked.
Specifically, I opened /dev/mem O_RDWR | O_SYNC
then called
  mmap(NULL, 1U<<31, PROT_WRITE, MAP_SHARED, fd, 0x80000000);

And mmap returned a valid pointer.

I was expecting it to fail.

- the kernel is configured with VMSPLIT_3G (3G/1G user/kernel)
- the kernel manages 256 MB RAM
- there is roughly 750 MB of VMALLOC space, no highmem

I know /dev/mem's mmap calls remap_pfn_range, but I was expecting
the VMALLOC space to impose a limit on the size of the mapping.
Obviously this was incorrect?

If I requested the same mapping *within the kernel* using ioremap,
would that fail because of limited VMALLOC space?

Moving to arch-specific questions (namely ARM Cortex-A9).
If I understand correctly (which is very possibly NOT the case)
the CPU has two registers pointing to page tables, one for
the current process, one for the kernel. And the CPU automatically
picks the correct one, based on the active context?
It would seem possible to have a full 4G for process, and a full 4G
for the kernel, using that method, no? (Like Ingo's old 4G/4G split).
Without the performance overhead of fiddling with the page tables.
What am I missing?

Regards.
