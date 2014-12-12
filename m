From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Dec 2014 17:37:26 +0000
Subject: CCF locking problems
Message-ID: <20141212173726.GV11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CCF is causing lockdep problems elsewhere in the kernel...

During kernel boot, the following lock chain is established via CCF when
debugfs is enabled:

	clk_register()
	`-> __clk_init() (takes prepare_lock)
	    `-> clk_debug_register() (takes clk_debug_lock)
	        `-> debugfs_create_dir()
	            `-> __create_file() (takes i_mutex)

So, prepare_lock ends up being a parent of the i_mutex class.

Generic kernel code creates a dependency between i_mutex and mmap_sem:

	iterate_dir() (takes i_mutex)
	`-> dcache_readdir()
	    `-> filldir64()
	        `-> might_fault() (marks mmap_sem as potentially taken by
				   a fault)

This means prepare_lock is also a parent lock of mmap_sem.

The kernel mmap() implementation of takes the mmap_sem, before calling
into drivers.  DRM's drm_gem_mmap() function which will be called as a
result of a mmap() takes the dev->struct_mutex mutex - which ends up as
a child of mmap_sem.

Now, if a DRM driver _then_ wants to use runtime PM, it may need to
call runtime PM functions beneath DRM's dev->struct_mutex (since, eg,
it may be protecting other DRM data while deciding which GPU to forward
to.)  This ends up creating a circular dependency between dev->struct_mutex
and prepare_lock, involving all the above mentioned locks.

I believe it is totally unreasonable for CCF to allow the prepare lock
to depend on something as fundamental as core kernel locks - in fact,
looking at __clk_init(), it looks like this fails in a very basic aspect
of kernel programming: do setup first, then publish.  If it did follow
that principle, it probably would not need to take the prepare lock
while calling clk_debug_register(), which would mean that prepare_lock
would not end up being a parent of potentially a lot of core kernel locks.

When you consider what prepare_lock is supposed to be doing, it's quite
clear that it should not be a parent to those.

Another interesting point is that clk_debug_create_one() has a comment
above it which is untrue:

/* caller must hold prepare_lock */

... except when it's called by clk_debug_init().

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
