From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2009 17:05:46 +0000
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <alpine.LFD.2.00.0912071027480.31174@xanadu.home>
References: <20091204191349.GG20386@n2100.arm.linux.org.uk>
	<4B196473.2040407@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<20091206141601.GB28932@n2100.arm.linux.org.uk>
	<c70ff3ad0912070331y751900dbj62847dddb8521f4d@mail.gmail.com>
	<20091207114218.GA19348@n2100.arm.linux.org.uk>
	<4B1CF3ED.9080307@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
	<20091207145235.GD19348@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071027480.31174@xanadu.home>
Message-ID: <20091207170546.GB26821@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 10:37:35AM -0500, Nicolas Pitre wrote:
> On Mon, 7 Dec 2009, Russell King - ARM Linux wrote:
> 
> > On Mon, Dec 07, 2009 at 02:55:52PM +0200, Ronen Shitrit wrote:
> > > > Russell King - ARM Linux wrote:
> > > > > On Mon, Dec 07, 2009 at 01:31:41PM +0200, saeed bishara wrote:
> > > > [...]
> > > > >>> If there's no problem with C=0 B=1 mappings on Kirkwood, I've no idea
> > > > >>> what's going on, and I don't have any suggestion on what to try next.
> > > > >>>
> > > > >>> The log shows that the kernel is doing the right thing: when we detect
> > > > >>> two mappings for the same page in the same MM space, we clean and
> > > > >>> invalidate any existing cacheable mappings visible in the MM space
> > > > >>> (both L1 and L2), and switch all visible mappings to C=0 B=1 mappings.
> > > > >>> This makes the area non-cacheable.
> > > > >> what about the PTE of the MM space of the write process? if it remains
> > > > >> C=1 B=1, then it's data will be at the L2, and as the L2 is not
> > > > >> flushed on context switch, then that explains this behavior.
> > > > > 
> > > > > That's probably the issue, and it means that _all_ shared writable
> > > > > mappings on your processor will be broken.
> > > > 
> > > > Hmm.. I tried also the testprg with CACHE_FEROCEON_L2 deaktivated,
> > > > same result ...
> > > > 
> > > > > Oh dear, that really is bad news.
> > > > 
> > > > Indeed.
> > > > 
> > > > > There are two solutions to this which I can currently think of:
> > > > > 1. flush the L2 cache on every context switch
> > > > 
> > > > To clarify, the testprg runs fine, if I start 4 processes each with
> > > > only one read thread. In this case all works as expected. The mess
> > > > begins only, if one read process starts more than one read thread ...
> > > > 
> > > That also match the theory:
> > > When using different processes, the shared area will stay C=1 B=1, 
> > > On each context switch L1 will be flushed,
> > > Since L2 is PIPT next process will get the correct data...
> > 
> > Hang on - if L2 is PIPT, then there shouldn't be a problem provided it's
> > searched with C=0 B=1 mappings.  Is that the case?
> 
> I don't have the time to properly wrap my brain around the current issue 
> at the moment.  However there are 3 facts to account for:
> 
> 1) Only 2 ARMv5 CPU variants with L2 cache exist: Feroceon and XSC3.
>    However this issue should affect both equally.
> 
> 2) L2 cache is PIPT in both cases.
> 
> 3) From commit 08e445bd6a which fixed such a similar issue on Feroceon 
>    and XSC3:
> 
>     Ideally, we would make L1 uncacheable and L2 cacheable as L2 is PIPT. But
>     Feroceon does not support that combination, and the TEX=5 C=0 B=0 encoding
>     for XSc3 doesn't appear to work in practice.

Sigh, why do people create this kind of hardware brokenness.

It seems the original commit (08e445bd6a) only partly addresses the problem;
it's broken in so many other ways, as is highlighted by this test case.
Was it originally created for Xscale3 or Feroceon?  Was the problem actually
found to exist on Xscale3 and Feroceon?

Any read or write via another cacheable mapping will result in the L2
being loaded with data.  One instance is as shown in the original posters
test program - where a shared writable mapping exists in another process.

Another case would be having a shared writable mapping, and using read()/
write() on the mapped file.  This is normally taken care of with
flush_dcache_page(), but this does not do any L2 cache maintainence on
Feroceon.

Another case is any kind of mmap() of the same file - in other words, it
doesn't have to be another shared mmap to bring data into the L2 cache.

Now, at first throught, if we disable the cache for all shared writable
mappings in addition to what we're already doing, does this solve the
problem?  Well, it means that the writes will bypass the caches and hit
the RAM directly.  The reads from the other shared mappings will read
direct from the RAM.

A private mapping using the same page will use the same page, and it
will not be marked uncacheable.  Accesses to it will draw data into the
L2 cache.

PIO kernel mode accesses will also use the cached copy, and that _is_
a problem - it means when we update the backing file on disk, we'll
write out the L2 cached data rather than what really should be written
out - the updated data from the writable shared mappings.

So it seems that at least these affected CPUs need flush_dcache_page()
to also do L2 cache maintainence.  I don't think that's enough to cover
all cases though - it probably also needs to do L2 cache maintainence
in all the other flush_cache_* functions as well.

This is something that should be benchmarked on the affected CPUs and
compared with the unmodified code with L2 cache disabled.


As a side note, I'm currently concerned that the sequence:

	mmap(MAP_SHARED);
	write to shared mapping;
	msync(MS_SYNC);

may not result in the written data hitting the disk (due to missing a
cache flush) but as yet I'm unable to prove it.  Since I now get lost
reading the Linux VFS/MM code, I can't prove this by code inspection.

Checking for this isn't going to be easy - (a) munmapping the region
will cause the data to hit RAM, (b) any context switch will cause the
data to hit RAM, (c) merely reading back the file via read() will
trigger flush_dcache_page()...  Need some way to externally monitor
what gets written to the storage device...
