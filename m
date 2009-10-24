From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 24 Oct 2009 12:10:36 +0100
Subject: cpu_vm_mask checks in ARM flush functions
In-Reply-To: <f20fa6c60910232103h5a3046fbmda23a093f94fa230@mail.gmail.com>
References: <f20fa6c60910232103h5a3046fbmda23a093f94fa230@mail.gmail.com>
Message-ID: <20091024111036.GC16451@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2009 at 09:03:16PM -0700, muni anda wrote:
> I was going though the cache flush functions in arch/arm/mm/flush.c
> and found that cpu_isset() is used at a lot of places. I couldn't
> understand the reason why there is a need for cpu_vm_mask checks? My
> understanding was that those functions will be executed on the CPU for
> which the cpu_mask is already set (in switch_mm call). Is there a
> different calling sequence that I am missing?

There are cases where (eg) pages are unmapped in a different process
to the one which is running.

> Can someone please the need for those checks (For example
> flush_ptrace_access() function running on vipt_non_aliasing caches).

ptrace accesses are done by a different process from the one being
operated on, so it is not likely that their address space is directly
accessible - but it can be.

For VIVT caches, this means that if the address space is visible, we
need to flush the page.  If it is not visible, we must not do any
cache maintainence (which will be done when the kernel switches
address spaces anyway.)

For VIPT aliasing caches, we do not flush the caches on every context
switch, and so we must always deal with cache aliases caused by
accessing the kernel's view of memory.

For VIPT non-aliasing caches, there may be a bug there; it requires
more time than I currently have to think about to say for certain
though.
