From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 May 2013 11:43:03 +0100
Subject: [PATCH V4] ARM: handle user space mapped pages in
 flush_kernel_dcache_page
In-Reply-To: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
References: <1368336956-6693-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <20130523104303.GC16722@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 12, 2013 at 06:35:56AM +0100, Simon Baatz wrote:
> Commit f8b63c1 made flush_kernel_dcache_page a no-op assuming that the pages
> it needs to handle are kernel mapped only.  However, for example when doing
> direct I/O, pages with user space mappings may occur.
> 
> Thus, continue to do lazy flushing if there are no user space mappings.
> Otherwise, flush the kernel cache lines directly.
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>

An issue is that for kunmap_atomic() && VIVT we flush the same page
twice. I don't think we should remove the cache flushing in
__kunmap_atomic() for VIVT since not all kunmap_atomic() calls require
flush_kernel_dcache_page() (unless we just assume that highmem && vivt
don't work together). Flushing the VIVT cache on kunmap is essential
since we just lose the alias after that.

> +void flush_kernel_dcache_page(struct page *page)
> +{
> +	if (cache_is_vivt() || cache_is_vipt_aliasing()) {

So you could add the ((cache_is_vivt() || cache_is_vipt_aliasing()) &&
!PageHighMem(page)) check back (as it was prior to commit f8b63c184,
actually reverting it) and the mapping tests as a possible optimisation.
But in this case there is no need to split __flush_dcache_page() in two
since we don't care about the PageHighMem() case.

And we need to fix kunmap() with VIVT to flush the cache as well (in
case anyone uses highmem on VIVT hardware).

-- 
Catalin
