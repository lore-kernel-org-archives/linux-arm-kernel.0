From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2009 11:28:15 +0100
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928101044.GD30271@localhost>
References: <20090928092919.GA30271@localhost>
	<20090928094140.GA6715@n2100.arm.linux.org.uk>
	<20090928095429.GB30271@localhost>
	<20090928095945.GC6715@n2100.arm.linux.org.uk>
	<20090928101044.GD30271@localhost>
Message-ID: <20090928102815.GH6715@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 01:10:44PM +0300, Imre Deak wrote:
> On Mon, Sep 28, 2009 at 11:59:45AM +0200, ext Russell King - ARM Linux wrote:
> > The problem has nothing to do with holding of mmap_sem
> > AT ALL.  In fact, do_cache_op needs to hold mmap_sem itself, to prevent
> > the VMA going away beneath it.  That's not going to stop it generating
> > faults, and it's not going to stop it oopsing.
> > 
> > The problem is that we don't have any fixup in place for this situation.
> 
> Yes, agreed. What I stated is that for _triggerring_ the error message you
> need mmap_sem.
> 
> > There is nothing wrong in the page fault handler.
> 
> Agreed. Only a warning would be nice to make similar cases more apparent
> even if mmap_sem is not held.

Page faults can happen at other times, and validly be fixed up.  vmalloc
space as an example.  You can't assume that a kernel mode page fault
without an exception fixup is invalid.
