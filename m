From: anfei.zhou@gmail.com (anfei)
Date: Mon, 18 Jan 2010 21:54:31 +0800
Subject: flush_dcache_page does too much?
In-Reply-To: <20100118133304.GA29645@n2100.arm.linux.org.uk>
References: <20100118131346.GA11589@desktop>
	<20100118133304.GA29645@n2100.arm.linux.org.uk>
Message-ID: <20100118135431.GA12496@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 01:33:04PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 18, 2010 at 09:13:46PM +0800, anfei wrote:
> > I'm studying the cache alias problem especially of VIPT, I found
> > function flush_dcache_page() does much more operations on ARM than MIPS.
> > Can we not flush the userspace mappings and icache, just like MIPS?
> > Are the cache more consistent with these operations?
> > 
> > As far as I know, flush_dcache_page is usually used as this:
> >         kmap_atomic(page, ...);
> >         write the page;
> >         flush_dcache_page(page);
> >         kunmap_atomic(...);
> > called in the path of write()/..., but since mmap() + write() is not
> > ensured to work (even on ARM currently), it's the userspace to consider
> > msync()/munmap(), it looks okay without flush the userspace mappings
> > here.  Other cases seem the same if the userspace takes charge of the 
> > cache problem.
> 
> On VIPT on ARM, flush_dcache_page() flushes:
> 
> 1. the direct kernel mapping and aliases of that (which read()/write()
>    will touch.)
> 
> 2. the user aliases, which may not be coherent with the direct kernel
>    mapping.
> 
> It is unsafe to avoid dealing with any of those - and doing so will cause
> shared mappings to be incoherent with filesystem IO.

Do you mean this implementation can ensure the coherence between write
and shared mmapings?  But it's easy to reproduce the alias problem by
this simple testcase (w/o error handler) on omap2430 with VIPT cache:

---
#include <stdio.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(void)
{
        int fd;
        int *addr;
        int tmp;
        int val = 0x11111111;

        fd = open("abc", O_RDWR);
        addr = mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
        *(addr+0) = 0x44444444;
        tmp = *(addr+0);
        *(addr+1) = 0x77777777;
        write(fd, &val, sizeof(int));
        close(fd);

        return 0;
}
