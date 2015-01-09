From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jan 2015 13:13:22 +0000
Subject: ioremap vs remap_pfn_range, VMSPLIT, etc
In-Reply-To: <54AFD09E.1010806@free.fr>
References: <54AFD09E.1010806@free.fr>
Message-ID: <20150109131322.GO12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 01:59:10PM +0100, Mason wrote:
> Hello everyone,
> 
> Yesterday, I used /dev/mem to mmap 2 GB and (to my surprise) it worked.
> Specifically, I opened /dev/mem O_RDWR | O_SYNC
> then called
>   mmap(NULL, 1U<<31, PROT_WRITE, MAP_SHARED, fd, 0x80000000);

So you asked to map 2GB starting@2GB physical.

> And mmap returned a valid pointer.

And that mapping would have been created to map physical addresses
0x80000000-0xffffffff inclusive.

> I was expecting it to fail.
> 
> - the kernel is configured with VMSPLIT_3G (3G/1G user/kernel)

This has no bearing on the above.

> - the kernel manages 256 MB RAM
> - there is roughly 750 MB of VMALLOC space, no highmem

vmalloc has no bearing on the above, mmap() doesn't allocate anything
into vmalloc space.

> If I requested the same mapping *within the kernel* using ioremap,
> would that fail because of limited VMALLOC space?

Correct.

> Moving to arch-specific questions (namely ARM Cortex-A9).
> If I understand correctly (which is very possibly NOT the case)
> the CPU has two registers pointing to page tables, one for
> the current process, one for the kernel. And the CPU automatically
> picks the correct one, based on the active context?
> It would seem possible to have a full 4G for process, and a full 4G
> for the kernel, using that method, no? (Like Ingo's old 4G/4G split).
> Without the performance overhead of fiddling with the page tables.
> What am I missing?

It's possible to use both, but the CPU selects the page table register
according to the virtual address.  So it's not possible to have 4G for
both.  There's only a restricted set of options:  2G / 2G, where the
bottom 2G of virtual space uses TTBR0 and the upper 2G uses TTBR1.
1G / 3G (1G for TTBR0, 3G for TTBR1).

We don't use it because most people run with 3G for userspace, which
isn't supported in hardware.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
