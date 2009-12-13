From: rshitrit@marvell.com (Ronen Shitrit)
Date: Sun, 13 Dec 2009 13:48:48 +0200
Subject: shared memory problem on ARM v5TE using threads
In-Reply-To: <20091207175608.GE26821@n2100.arm.linux.org.uk>
References: <309002C0DA137042828828FC53D7A9347E212D1152@IL-MB01.marvell.com>
	<20091206141601.GB28932@n2100.arm.linux.org.uk>
	<c70ff3ad0912070331y751900dbj62847dddb8521f4d@mail.gmail.com>
	<20091207114218.GA19348@n2100.arm.linux.org.uk>
	<4B1CF3ED.9080307@denx.de>
	<309002C0DA137042828828FC53D7A9347E212D150D@IL-MB01.marvell.com>
	<20091207145235.GD19348@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071027480.31174@xanadu.home>
	<20091207170546.GB26821@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0912071219100.31174@xanadu.home>
	<20091207175608.GE26821@n2100.arm.linux.org.uk>
Message-ID: <309002C0DA137042828828FC53D7A9347E2630EEC2@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another idea is to change the shared mapping handling, in case of vivt with pipt L2, so it won't remap the shared area as non-cacheable:
- make_coherent won't use adjust_pte and leave only the regular flush.
- Flush L1 for all context switches, also for the case that the new process is using same mm (thread context switch).

I tried it and it solved the original issue posted on this thread.

Any thoughts? Any pitfalls this solution is missing? 

Regards

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Monday, December 07, 2009 7:56 PM
To: Nicolas Pitre
Cc: Ronen Shitrit; hs at denx.de; saeed bishara; linux-arm-kernel at lists.infradead.org
Subject: Re: shared memory problem on ARM v5TE using threads

On Mon, Dec 07, 2009 at 12:33:20PM -0500, Nicolas Pitre wrote:
> On Mon, 7 Dec 2009, Russell King - ARM Linux wrote:
> > It seems the original commit (08e445bd6a) only partly addresses the problem;
> > it's broken in so many other ways, as is highlighted by this test case.
> > Was it originally created for Xscale3 or Feroceon?  Was the problem actually
> > found to exist on Xscale3 and Feroceon?
> 
> It fixed a test case that was discovered on XSC3 and turned up to be 
> valid on Feroceon as well.  I probably have the source for it somewhere.  
> The case was multiple mmap() of the same memory area within the same 
> process.  I think (but that needs confirmation) that this fixed a real 
> life db4 issue as well.

I have a test case for this as well.

> > Any read or write via another cacheable mapping will result in the L2
> > being loaded with data.  One instance is as shown in the original posters
> > test program - where a shared writable mapping exists in another process.
> > 
> > Another case would be having a shared writable mapping, and using read()/
> > write() on the mapped file.  This is normally taken care of with
> > flush_dcache_page(), but this does not do any L2 cache maintainence on
> > Feroceon.
> 
> I thought those were already handled by making L1 uncacheable (and L2 
> cleaned) as soon as a second user of a shared mapping was 
> encountered.

That doesn't work - the kernel mapping will still be cacheable, and it is
the kernel mapping that read() and write() will use.  Their coherency
issue is resolved by flush_dcache_page() performed _before_ the access
(note: there is no coherency after a write access, so WBWA caches are
probably broken wrt this.)

So:
	Process/Thread
	1/1		2/1		2/2		3/1	kernel
	map(MAP_SHARED)	map(MAP_SHARED)	map(MAP_SHARED)
	write mapping
								flush L1
			read mapping
					read mapping

Now, lets say we flush the L1 and L2 caches, and we mark all these
mappings uncachable.  Now, another process does a read from the file
backing this mapping:

								flush L1
							read
								flush_dcache_page()
								read data
								(loads L2 cache)
								flush L1
	write mapping
	(does not hit L2)
								flush L1
			read mapping
			(does not hit L2,
			sees data from 1/1)
					read mapping
					(does not hit L2,
					sees data from 1/1)
								flush L1
							read
								flush_dcache_page()
								read data
								(from L2 cache
								 and doesn't
								 see updates
								 from 1/1)

What I'm slightly more worried about as well is whether PIO writeouts
will write the data from process 1/1 onto disk.

> > Another case is any kind of mmap() of the same file - in other words, it
> > doesn't have to be another shared mmap to bring data into the L2 cache.
> 
> But that case is fine, no?  L2 being PIPT you get the same cached data 
> for both mappings, and a write will COW the page.

The point is its a way to get data into the L2 cache, which will be
visible via other cachable mappings and mask the shared-mapped updates.
I wasn't considering a COW to a private mapping.

> > Now, at first throught, if we disable the cache for all shared writable
> > mappings in addition to what we're already doing, does this solve the
> > problem?  Well, it means that the writes will bypass the caches and hit
> > the RAM directly.  The reads from the other shared mappings will read
> > direct from the RAM.
> > 
> > A private mapping using the same page will use the same page, and it
> > will not be marked uncacheable.  Accesses to it will draw data into the
> > L2 cache.
> 
> Hmmm...
> 
> > PIO kernel mode accesses will also use the cached copy, and that _is_
> > a problem - it means when we update the backing file on disk, we'll
> > write out the L2 cached data rather than what really should be written
> > out - the updated data from the writable shared mappings.
> > 
> > So it seems that at least these affected CPUs need flush_dcache_page()
> > to also do L2 cache maintainence.  I don't think that's enough to cover
> > all cases though - it probably also needs to do L2 cache maintainence
> > in all the other flush_cache_* functions as well.
> 
> /me starts to feel the head ache

You're not the only one...

I'm going to try and prove the msync() problem I mentioned at the end of
my mail - it's probably going to be easier to prove and solve (and impacts
more ARM CPUs than this problem.)

As for this problem, I'm not certain what the solution is.

In the mean time, as a work-around, I suggest that any CPU with L1 VIVT
cache (which thereby requires the make_coherent() code) has its L2 cache
disabled.  That should at least allow the system to behave as correctly
as it does for other ARM VIVT CPUs.
