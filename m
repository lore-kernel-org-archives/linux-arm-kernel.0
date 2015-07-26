From: hch@lst.de (Christoph Hellwig)
Date: Sun, 26 Jul 2015 19:31:13 +0200
Subject: [PATCH v2 23/25] arch: remove ioremap_cache, replace with
 arch_memremap
In-Reply-To: <20150725024007.8664.58668.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725024007.8664.58668.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20150726173113.GB29513@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 10:40:07PM -0400, Dan Williams wrote:
> Now that all call sites for ioremap_cache() have been converted to
> memremap(MEMREMAP_CACHE) we can now proceed with removing the
> implementation in the archs.  This amounts to replacing the per-arch
> ioremap_cache() implementation with arch_memremap.

Please have prototypes for arch_memremap and arch_memunmap in
linux/io.h so that we enforce common prototypes.  This also
forces arch_memunmap to be out of line which makes sense for such
a slow patch API.

Also while you're at it please convert the ioremap_cached implementations
on metag and unicore32 which looks like misspellings, fix up the comment
in arch/arm/mm/mmu.c and the documentation in Documentation/x86/pat.txt
to not longer refer to ioremap_cache.
