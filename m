From: imre.deak@nokia.com (Imre Deak)
Date: Mon, 28 Sep 2009 13:10:44 +0300
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928095945.GC6715@n2100.arm.linux.org.uk>
References: <20090928092919.GA30271@localhost>
	<20090928094140.GA6715@n2100.arm.linux.org.uk>
	<20090928095429.GB30271@localhost>
	<20090928095945.GC6715@n2100.arm.linux.org.uk>
Message-ID: <20090928101044.GD30271@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 11:59:45AM +0200, ext Russell King - ARM Linux wrote:
> On Mon, Sep 28, 2009 at 12:54:29PM +0300, Imre Deak wrote:
> > On Mon, Sep 28, 2009 at 11:41:40AM +0200, ext Russell King - ARM Linux wrote:
> > > On Mon, Sep 28, 2009 at 12:29:19PM +0300, Imre Deak wrote:
> > > > Hi,
> > > > 
> > > > the following test app will cause an unhandled kernel paging request
> > > > on VIPT platforms. The triggering condition is the mmap_sem held by
> > > > thread_func while the main thread performs cache flushing.
> > > > 
> > > > Since the likelihood of this to trigger is relatively low, a patch will
> > > > follow that makes similar bugs more visible.
> > > 
> > > The problem is that, unlike previous cache architectures, if a page is
> > > not present we now get a data abort during cache maintainence.  That
> > > means the cache maintainence instructions used for this call need to
> > > be marked with user fixups, so that the kernel knows how to handle
> > > such an abort.
> > > 
> > > It is not caused by the holding of mmap_sem.
> > 
> > This particular bug is caused by holding of mmap_sem, without any fixup
> > being defined.
> 
> No it is not.

What I meant is that without holding mmap_sem you'll not trigger the error
message even if you don't have a fixup routine.

> The problem has nothing to do with holding of mmap_sem
> AT ALL.  In fact, do_cache_op needs to hold mmap_sem itself, to prevent
> the VMA going away beneath it.  That's not going to stop it generating
> faults, and it's not going to stop it oopsing.
> 
> The problem is that we don't have any fixup in place for this situation.

Yes, agreed. What I stated is that for _triggerring_ the error message you
need mmap_sem.

> There is nothing wrong in the page fault handler.

Agreed. Only a warning would be nice to make similar cases more apparent
even if mmap_sem is not held.

--Imre
