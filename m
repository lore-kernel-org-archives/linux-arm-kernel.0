From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Jun 2010 10:26:13 +0100
Subject: [PATCH] Fix flush_kernel_dcache_page for VIPT non-aliasing caches
In-Reply-To: <1277194981-21548-1-git-send-email-rabin.vincent@stericsson.com>
References: <1277194981-21548-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1277198773.22719.16.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-06-22 at 09:23 +0100, Rabin Vincent wrote:
> flush_kernel_dcache_page() is currently a no-op on CPUs with VIPT
> non-aliasing data caches.
> 
> Because the data and instruction caches are not coherent, not flushing
> the D-cache when PIO is done in the kernel could mean that data stays in
> the D-cache and stale data is loaded from memory into the I-cache when
> this page is later executed from.

That's a long standing problem which I think we have resolved, though
patches not in mainline yet. There have been many discussions in the
past (FYI, more like bed-time reading):

http://comments.gmane.org/gmane.linux.usb.general/27072
http://comments.gmane.org/gmane.linux.ide/44847
http://comments.gmane.org/gmane.linux.kernel.cross-arch/5136
http://comments.gmane.org/gmane.linux.kernel.cross-arch/5170

> This can be observed, for example, as random crashes in the init process
> when a file system is mounted from MMC, if the drivers (or the MMC block
> driver bounce buffer) uses flush_kernel_dcache_page() (usually
> indirectly via the sg_miter API).
> 
> This problem is visible on systems with write-allocate caches.  To fix
> it, flush the D-cache in flush_kernel_dcache_page() even on VIPT
> non-aliasing caches.

I don't think this patch is needed. Implementing this function is only
required if we don't have a coherent D-cache (which is not the case with
non-aliasing VIPT). See Documentation/cachetlb.txt (though not always
accurate but we try to stay close to it).

Block device drivers should use flush_dcache_page() instead of
flush_kernel_dcache_page(). Since not all drivers do this, the solution
I'm proposing (under review so far) is assuming pages to be dirty by
default and thus you get a cache flushing via update_mmu_cache() (or
set_pte_at() on SMP systems).

Could you please try patches 2, 3 and 4 from this thread (can try 1 as
well, I don't mind):

http://thread.gmane.org/gmane.linux.ports.arm.kernel/82987

and post a Tested-by in reply?

The patches are also available in my "proposed" branch, if it is easier
for you to grab:

http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-2.6-cm.git;a=shortlog;h=refs/heads/proposed

Thanks.

-- 
Catalin
