From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Aug 2011 13:50:14 +0100
Subject: MX53Loco reports half of the total memory
In-Reply-To: <CAOMZO5A0N6VcTOgWTpqe_mW4ekW1fSY4+=7o8mXSPFeEmjg26w@mail.gmail.com>
References: <CAOMZO5C6gaJUD3RTCwGqDhcojx3Thww22c+tsdC4bvTUmiSw6w@mail.gmail.com>
	<20110824205415.GN31404@pengutronix.de>
	<20110824214311.GA21759@n2100.arm.linux.org.uk>
	<CAOMZO5A0N6VcTOgWTpqe_mW4ekW1fSY4+=7o8mXSPFeEmjg26w@mail.gmail.com>
Message-ID: <20110825125014.GD8883@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 08:53:49AM -0300, Fabio Estevam wrote:
> "config HIGHMEM
> 	bool "High Memory Support"
> 	depends on MMU
> 	help
> 	  The address space of ARM processors is only 4 Gigabytes large
> 	  and it has to accommodate user address space, kernel address
> 	  space as well as some memory mapped IO. That means that, if you
> 	  have a large amount of physical memory and/or IO, not all of the
> 	  memory can be "permanently mapped" by the kernel. The physical
> 	  memory that is not permanently mapped is called "high memory".
> 
> 	  Depending on the selected kernel/user memory split, minimum
> 	  vmalloc space and actual amount of RAM, you may not need this
> 	  option which should result in a slightly faster kernel.
> 
> 	  If unsure, say n."
> 
> So is it correct to say that CONFIG_VMSPLIT_2G is preferred over
> CONFIG_HIGHMEM due to the "should result in a slightly faster kernel."
> statement above?

It depends what your userspace is expecting.  There's a few issues to
consider:

1. The 3G split is the well established normal split both on ARM and x86.
2. Userspace is sparsely populated into three or four main regions.
3. There are some programs which assume that there's 3G of userspace
   available (some have hard-coded constants for this - notorious
   examples a garbage collection libraries, though they may have been
   fixed with the advent of stack placement randomization.)

Reducing the size of userspace squashes the regions together, which may
limit the amount of memory available to any one process.  You won't see
that effect from just running a shell or 'cat' etc, but you may find it
if you have a heavy-weight application wanting to allocate lots of
memory.

Out of the two, highmem is the overall safer option in this regard because
it allows you to keep the standard user layout while still having access
to more physical memory.

It may be slower as a result of the kernel having to map/unmap highmem
pages during startup, but (again, depending on your userspace behaviour)
it may make no difference to your userspace once its cached the user
programs in memory.
