From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jan 2010 13:33:04 +0000
Subject: flush_dcache_page does too much?
In-Reply-To: <20100118131346.GA11589@desktop>
References: <20100118131346.GA11589@desktop>
Message-ID: <20100118133304.GA29645@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 09:13:46PM +0800, anfei wrote:
> I'm studying the cache alias problem especially of VIPT, I found
> function flush_dcache_page() does much more operations on ARM than MIPS.
> Can we not flush the userspace mappings and icache, just like MIPS?
> Are the cache more consistent with these operations?
> 
> As far as I know, flush_dcache_page is usually used as this:
>         kmap_atomic(page, ...);
>         write the page;
>         flush_dcache_page(page);
>         kunmap_atomic(...);
> called in the path of write()/..., but since mmap() + write() is not
> ensured to work (even on ARM currently), it's the userspace to consider
> msync()/munmap(), it looks okay without flush the userspace mappings
> here.  Other cases seem the same if the userspace takes charge of the 
> cache problem.

On VIPT on ARM, flush_dcache_page() flushes:

1. the direct kernel mapping and aliases of that (which read()/write()
   will touch.)

2. the user aliases, which may not be coherent with the direct kernel
   mapping.

It is unsafe to avoid dealing with any of those - and doing so will cause
shared mappings to be incoherent with filesystem IO.
