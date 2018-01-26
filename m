From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Jan 2018 21:39:12 +0000
Subject: [RFC 1/2] arm: cacheflush syscall: process only pages that are
 in the memory
In-Reply-To: <589aa8ab-5bfc-e065-51f9-3a403c346d92@samsung.com>
References: <CGME20180126111453eucas1p1330d8561386c3cf2bb457bc22c0d99a8@eucas1p1.samsung.com>
 <20180126111441.29353-1-m.szyprowski@samsung.com>
 <20180126113226.GX17719@n2100.armlinux.org.uk>
 <589aa8ab-5bfc-e065-51f9-3a403c346d92@samsung.com>
Message-ID: <20180126213911.GY17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 02:30:47PM +0100, Marek Szyprowski wrote:
> Hi Russell,
> 
> On 2018-01-26 12:32, Russell King - ARM Linux wrote:
> >On Fri, Jan 26, 2018 at 12:14:40PM +0100, Marek Szyprowski wrote:
> >>glibc in calls cacheflush syscall on the whole textrels section of the
> >>relocated binaries. However, relocation usually doesn't touch all pages
> >>of that section, so not all of them are read to memory when calling this
> >>syscall. However flush_cache_user_range() function will unconditionally
> >>touch all pages from the provided range, resulting additional overhead
> >>related to reading all clean pages. Optimize this by calling
> >>flush_cache_user_range() only on the pages that are already in the
> >>memory.
> >What ensures that another CPU doesn't remove a page while we're
> >flushing it?  That will trigger a data abort, which will want to
> >take the mmap_sem, causing a deadlock.
> 
> I thought that taking mmap_sem will prevent pages from being removed.
> mmap_sem has been already taken in the previous implementation of that
> syscall, until code simplification done by commit 97c72d89ce0e ("ARM:
> cacheflush: don't bother rounding to nearest vma").

No, you're not reading the previous code state correctly.  Take a closer
look at that commit.

find_vma() requires that mmap_sem is held across the call as the VMA
list is not stable without that semaphore held.  However, more
importantly, notice that it drops the semaphore _before_ calling the
cache flushing function (__do_cache_op()).

The point is that if __do_cache_op() faults, it will enter
do_page_fault(), which will try to take the mmap_sem again, causing
a deadlock.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
