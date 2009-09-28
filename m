From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2009 10:41:40 +0100
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928092919.GA30271@localhost>
References: <20090928092919.GA30271@localhost>
Message-ID: <20090928094140.GA6715@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 12:29:19PM +0300, Imre Deak wrote:
> Hi,
> 
> the following test app will cause an unhandled kernel paging request
> on VIPT platforms. The triggering condition is the mmap_sem held by
> thread_func while the main thread performs cache flushing.
> 
> Since the likelihood of this to trigger is relatively low, a patch will
> follow that makes similar bugs more visible.

The problem is that, unlike previous cache architectures, if a page is
not present we now get a data abort during cache maintainence.  That
means the cache maintainence instructions used for this call need to
be marked with user fixups, so that the kernel knows how to handle
such an abort.

It is not caused by the holding of mmap_sem.  However, do_cache_op()
should hold something to ensure the VMA doesn't disappear beneath it.
