From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 14:47:37 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <20150414165459.GG14546@e104818-lin.cambridge.arm.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <9F7FC15C-EED1-4939-B66A-1BC3119E0D9C@theobroma-systems.com>
 <20150414165459.GG14546@e104818-lin.cambridge.arm.com>
Message-ID: <2059078.o6U5BYXcDP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 17:55:00 Catalin Marinas wrote:
> On Tue, Apr 14, 2015 at 05:29:36PM +0200, Dr. Philipp Tomsich wrote:

> > So tv_nsec needs to be 32bit on ILP32, as we would otherwise break the C
> > language.  Any program that assumes that tv_nsec is sizeof(long) would be
> > correct and it would be unexpected and surprising behaviour [even though it
> > would be consider a good programming style] if one would need to explicitly 
> > ask for the sizeof(ts.tv_nsec). Having the same problem on x32 doesn?t seem 
> > like a good justification to do the same.
> 
> From a standards perspective, that's clear, and I'm fine with not making
> the same choice as x32. I think on x32 it was a side-effect of glibc
> defining tv_nsec as __syscall_slong_t and the kernel defining
> __kernel_long_t to 64-bit.

I'm pretty sure that this part of the x32 ABI was a deliberate choice
in full knowledge of the tradeoffs.

> > For time_t, I don?t see the need to have a 32bit type yet.
> > As long as the the type is properly exposed through header files (and user
> > programs can thus recreate the kernel?s data model), we should be safe.
> 
> The problem with a 64-bit time_t is that the timespec structure looks
> like neither compat32 nor native 64-bit. If we make the AArch32 and
> native ILP32 exclusive and build time, it makes it easier, otherwise we
> need to support a third ABI in the kernel.

Exactly, which is why the layout was chosen to be the same as x86-64
for x32.

> > Can we thus agree on the following for the next revision of the patch-set:
> >  (1) We retain a 64bit time_t, but implement different sizes (between ILP32 and 
> > 	LP64) for ?tv_nsec' in 'struct timespec??
> >  (2) We use the 64bit system calls whereever possible (i.e. no register splitting).
> 
> As I mentioned above, timespec and possibly other structures no longer
> like any of the existing ABIs. Do we know how many syscalls are
> affected?
> 
> The alternative is 32-bit time_t which makes it easier to use the compat
> syscall implementations (not numbers). It also depends on how we plan to
> fix the 2038 problem. For new 32-bit only architectures, are we going to
> require them to use a 64-bit time_t or we get alternative time64_t and
> timespec64 specs?

No, we had originally planned that a few years ago, but after deciding that
we are fixing this problem for all 32-bit machines, and also seeing the
magnitude of changes involved in that, I think we have a general consensus
that we do not want to add special cases for architectures that use 64-bit
time_t before everyone else does.

	Arnd
