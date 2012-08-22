From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Aug 2012 18:13:10 +0100
Subject: [PATCH v2 17/31] arm64: System calls handling
In-Reply-To: <201208221227.14274.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208220756.31149.arnd@arndb.de> <20120822102953.GA24136@arm.com>
 <201208221227.14274.arnd@arndb.de>
Message-ID: <20120822171309.GC2582@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 01:27:14PM +0100, Arnd Bergmann wrote:
> On Wednesday 22 August 2012, Catalin Marinas wrote:
> > But what's more important - moving this wrapper to glibc causes issues
> > with the page size. We support both 4KB and 64KB pages on 64-bit systems
> > (the latter without compat support). The kernel is in a better position
> > to do the shift by a compile-time constant. Glibc would need to enquire
> > the actual page size to do the shift before calling sys_mmap_pgoff. If
> > we assume in glibc that the shift is always 12, we need another wrapper
> > in the kernel anyway for 64KB page configuration. So passing the offset
> > in bytes worked best for us.
> 
> Right, the kernel interface should really be independent of the page
> size, as sys_mmap2 normally is, and sys_mmap2 is not provided here.

sys_mmap2 is indeed independent of the page size on most architectures
assuming that the last argument represents the offset in units of 4096.
The cris and ia64 seem to differ (one being 8K, the other variable).

sys_mmap is also independent of the page size.

But using sys_mmap2 for a 64-bit architecture, especially when the page
size is not always 4K, does not bring any advantages. We end up doing a
shift by 12 in glibc and another shift by (PAGE_SHIFT - 12) in the
kernel wrapper. Unless I missed your point, I don't see the reason for
using sys_mmap2 on a 64-bit architecture, apart from it being newer (and
compat support should not have any relevance, we have different syscall
tables anyway).

-- 
Catalin
