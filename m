From: anfei.zhou@gmail.com (anfei)
Date: Mon, 18 Jan 2010 21:13:46 +0800
Subject: flush_dcache_page does too much?
Message-ID: <20100118131346.GA11589@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm studying the cache alias problem especially of VIPT, I found
function flush_dcache_page() does much more operations on ARM than MIPS.
Can we not flush the userspace mappings and icache, just like MIPS?
Are the cache more consistent with these operations?

As far as I know, flush_dcache_page is usually used as this:
        kmap_atomic(page, ...);
        write the page;
        flush_dcache_page(page);
        kunmap_atomic(...);
called in the path of write()/..., but since mmap() + write() is not
ensured to work (even on ARM currently), it's the userspace to consider
msync()/munmap(), it looks okay without flush the userspace mappings
here.  Other cases seem the same if the userspace takes charge of the 
cache problem.

Thanks,
Anfei.
