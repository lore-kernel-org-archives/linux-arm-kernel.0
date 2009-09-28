From: imre.deak@nokia.com (Imre Deak)
Date: Mon, 28 Sep 2009 12:54:29 +0300
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928094140.GA6715@n2100.arm.linux.org.uk>
References: <20090928092919.GA30271@localhost>
	<20090928094140.GA6715@n2100.arm.linux.org.uk>
Message-ID: <20090928095429.GB30271@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 11:41:40AM +0200, ext Russell King - ARM Linux wrote:
> On Mon, Sep 28, 2009 at 12:29:19PM +0300, Imre Deak wrote:
> > Hi,
> > 
> > the following test app will cause an unhandled kernel paging request
> > on VIPT platforms. The triggering condition is the mmap_sem held by
> > thread_func while the main thread performs cache flushing.
> > 
> > Since the likelihood of this to trigger is relatively low, a patch will
> > follow that makes similar bugs more visible.
> 
> The problem is that, unlike previous cache architectures, if a page is
> not present we now get a data abort during cache maintainence.  That
> means the cache maintainence instructions used for this call need to
> be marked with user fixups, so that the kernel knows how to handle
> such an abort.
> 
> It is not caused by the holding of mmap_sem.

This particular bug is caused by holding of mmap_sem, without any fixup
being defined.

> However, do_cache_op()
> should hold something to ensure the VMA doesn't disappear beneath it.

Yes, agreed.

--Imre
