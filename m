From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 06 Nov 2015 17:23:37 +0100
Subject: [GIT PULL] arm64 updates for 4.4
In-Reply-To: <20151106160407.GX7637@e104818-lin.cambridge.arm.com>
References: <20151104182508.GA28726@e104818-lin.cambridge.arm.com>
 <6512377.hSX37CgtMC@wuerfel>
 <20151106160407.GX7637@e104818-lin.cambridge.arm.com>
Message-ID: <6253831.r99BEBrMgd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 November 2015 16:04:08 Catalin Marinas wrote:
> On Fri, Nov 06, 2015 at 10:57:58AM +0100, Arnd Bergmann wrote:
> > On Thursday 05 November 2015 18:27:18 Catalin Marinas wrote:
> > > On Wed, Nov 04, 2015 at 02:55:01PM -0800, Linus Torvalds wrote:
> > > > On Wed, Nov 4, 2015 at 10:25 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > It's good for single-process loads - if you do a lot of big fortran
> > > > jobs, or a lot of big database loads, and nothing else, you're fine.
> > > 
> > > These are some of the arguments from the server camp: specific
> > > workloads.
> > 
> > I think (a little overgeneralized), you want 4KB pages for any file
> > based mappings,
> 
> In general, yes, but if the main/only workload on your server is mapping
> large db files, the memory usage cost may be amortised.

This will still only do you good for a database that is read into memory
once and not written much, and at that point you can as well use hugepages.

The problems for using 64kb page cache on file mappings are

- while you normally want some readahead, the larger pages also result
  in read-behind, so you have to actually transfer data from disk into
  RAM without ever accessing it.

- When you write the data, you have to write the full 64K page because
  that is the granularity of your dirty bit tracking.

So even if you don't care at all about memory consumption, you are
still transferring several times more data to and from your drives.
As mentioned that can be a win on some storage devices, but usually
it's a loss.

> > but larger (in some cases much larger) for anonymous
> > memory. The last time this came up, I theorized about a way to change
> > do_anonymous_page() to always operate on 64KB units on a normal
> > 4KB page based kernel, and use the ARM64 contiguous page hint
> > to get 64KB TLBs for those pages.
> 
> We have transparent huge pages for this, though the much higher 2MB
> size. This would also improve the cost of a TLB miss by walking one
> fewer level (point 2 above). I've seen patches for THP on file maps but
> I'm not sure what the status is.
> 
> As a test, we could fake a 64KB THP by using a dummy PMD that contains
> 16 PTE entries, just to see how the performance goes. But this would
> only address point 1 above.

Right.

> > This could be done compile-time, system-wide, or per-process if
> > desired, and should provide performance as good as the current
> > 64KB page kernels for almost any server workloads, and in
> > some cases much better than that, as long as the hints are
> > actually interpreted by the CPU implementation.
> 
> Apart from anonymous mappings, could the file page cache be optimised?
> Not all file accesses use mmap() (e.g. gcc compilation seems to do
> sequential accesses for the C files the compiler reads), so you don't
> always need a full page cache page for a file.
> 
> We could have a feature to allow sharing of partially filled page cache
> pages and only break them up if mmap'ed to user.

I would think that adds way too much complexity for the gains.

> A less optimal
> implementation based on the current kernel infrastructure could be
> something like a cleancache driver able to store partially filled page
> cache pages more efficiently (together with a more aggressive eviction
> of such pages from the page cache into the cleancache).

Not sure, it could work but may still require changing too much of
the way we handle files today.

	Arnd
