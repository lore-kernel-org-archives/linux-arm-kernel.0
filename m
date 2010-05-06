From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 06 May 2010 16:00:57 +0100
Subject: [PATCH] [ARM] Do not call flush_cache_user_range with mmap_semheld
In-Reply-To: <20100429182455.GH4877@n2100.arm.linux.org.uk>
References: <20100429182455.GH4877@n2100.arm.linux.org.uk>
Message-ID: <1273158057.2094.27.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-04-29 at 19:24 +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 29, 2010 at 07:16:36PM +0100, Jamie Lokier wrote:
> > Russell King - ARM Linux wrote:
> > > On Wed, Apr 28, 2010 at 12:32:11AM -0700, Dima Zavin wrote:
> > > > We can't be holding the mmap_sem while calling flush_cache_user_range
> > > > because the flush can fault. If we fault on a user address, the
> > > > page fault handler will try to take mmap_sem again. Since both places
> > > > acquire the read lock, most of the time it succeeds. However, if another
> > > > thread tries to acquire the write lock on the mmap_sem (e.g. mmap) in
> > > > between the call to flush_cache_user_range and the fault, the down_read
> > > > in do_page_fault will deadlock.
> > >
> > > That's a non-issue.  If do_cache_op is holding a read lock, _nothing_
> > > _else_ can be holding that lock in write mode.  So, holding the lock in
> > > read mode ensures that when faults occur, the fault handler can be sure
> > > that its read lock will succeed.
> >
> > read-write locks will block a reader when there is a already blocked
> > writer.  Otherwise the writer can be permanently starved due to new
> > readers always arriving so reader count doesn't reach zero.
> 
> Hmm, true, and rather unfortunate.
> 
> As I've already said, we can not do this cache maintainence outside of
> the lock.
> 
> The point of this code is to first validate that the region we're working
> on is valid.  As soon as we drop the lock, we lose the guarantee that
> the region is valid while we operate on it - indeed, the region could be
> unmapped and remapped by a different thread.

The flush_cache_user_range operation cannot actually damage the data. If
the application is so badly written that one of its threads remaps a
page range while another thread writes to it and flushes the caches,
then it deserves the memory corruption.

Personally, I would go even further and remove the find_vma() call (of
course with an access_ok() call to make sure the address isn't a kernel
one). I actually did some tests but the performance improvement was too
significant to be worth arguing the case on the list. But the app I was
using was a simple test where the vma tree was small. Things may be
different for a fully featured Java VM for example.

-- 
Catalin
