From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Feb 2015 17:54:39 +0100
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150216153817.GY23507@brightrain.aerifal.cx>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <2282163.7MvOQMXljz@wuerfel> <20150216153817.GY23507@brightrain.aerifal.cx>
Message-ID: <23076192.51ypQe2bTC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 February 2015 10:38:18 Rich Felker wrote:
> On Mon, Feb 16, 2015 at 03:40:54PM +0100, Arnd Bergmann wrote:
> > On Friday 13 February 2015 13:37:07 Rich Felker wrote:
> > > On Fri, Feb 13, 2015 at 05:33:46PM +0000, Catalin Marinas wrote:
> > > > I think there is another problem with sign-extending tv_nsec in libc.
> > > > The prototype for functions like clock_settime(2) take a const struct
> > > > timespec *. There isn't anything to prevent such structure being in a
> > > > read-only section, even though it is unlikely. So libc would have to
> > > > duplicate the structure rather than just sign-extending tv_nsec in
> > > > place.
> > 
> > Do we actually need sign-extend, or does zero-extend have the exact
> > same effect? For all I can tell, all invalid nanoseconds values
> > remain invalid, and the accepted values are unchanged regardless
> > of which type extension gets used.
> 
> I think it matters for futimensat which has some special negative
> codes you can store in tv_nsec, but perhaps there's an easy trick to
> distinguish them even with zero extending.

Ah, good point.

> > > Yes, we already have to do this for x32 in musl. I'd rather not have
> > > to do the same for aarch64-ILP32.
> > 
> > This would of course be solved by using a 64-bit __kernel_snseconds_t
> > or snseconds_t, and I suspect other libc implementations would just do
> > that, when they are less strict about posix/c11 compliance compared
> > to musl.
> 
> I think they would be more strict if this were for a target that
> actually sees use and they were getting bug reports from C programmers
> annoyed that their code was not working correctly or not even
> compiling. AFAIK there are no distros based on x32 now and it's
> something of an alternate model on x86_64 distros that some people are
> playing around with.

I would expect to see much more build breakage and runtime problems
from going to 64-bit time_t than from anything accessing the tv_nsec
field.

I'd also like to hear opinions from other libc maintainers on this.

> > If you don't mind the (slight) distraction, can you describe what your
> > plans are for handling 64-bit time_t on the existing 32-bit ABIs?
> > I'm involved in both the efforts to do that and the ilp32 code on
> > ARM, so it would be good for me to understand your plans for musl to
> > get the bigger picture. Specifically, which of these do you plan
> > to support (if you know already):
> 
> It largely depends on if there's demand. If we have users who want to
> run 32-bit systems with an ABI that will survive Y2038, it will be
> supported, but as a new ABI for these targets. This will likely allow
> fixing other ABI issues at the same time -- for example, on i386 I
> would probably switch to mandating SSE2 for floating point, and
> possibly using regparm everywhere.

I see. Note that in case of i386, the main use case would be
embedded systems, so while using regparm works, mandating anything
that is not part of the quark soc (mmx, sse, cmov, ...) might
be counterproductive.

Regarding ARM, you can probably do it more modern though and
require armv7-hardfloat, if you don't do that already.

> There are a couple of different ways it could be done though:
>
> 1. On a per-arch basis, defining a new ABI variant for the arch.
> 
> 2. With a new abstraction at the syscall boundary to get rid of all
> kernel-arch-specific structures in userspace and redefine all types to
> have plenty of room for growth.

We currently plan to change the kernel for all 32-bit
architectures to support the new ABI everywhere, in order to
avoid special casing rarely used architectures, which would
in turn be a potential source for bugs.

We will only add system calls with 64-bit time_t that don't have
a replacement already. So e.g. according to the current plan, there
won't be a time(2) or gettimeofday(2) system call with 64-bit
time_t in the kernel, but we expect the C library to implement
these through clock_gettime(2).

> In regards to your specific questions about ways it could be done:
> 
> > - using 64-bit time_t on future arm32/i386/... kernels
> > - using 64-bit time_t on existing arm32/i386/... kernels with native
> >   32-bit time_t
> 
> If the former is supported, I would think we'd want to support the
> latter too. An ABI that only works on very-new kernels is very
> restrictive in who can use it. Kernel support hardly matters (until
> Y2038 actually arrives); the point of 64-bit time_t is to have an ABI
> that's _ready_ for it so existing binaries can keep working.

Ok.

> > - using 32-bit time_t on future architectures that only support 64-bit
> >   time_t in the kernel
> 
> Definitely will not be supported. Introducing a new ABI with 32-bit
> time_t is a huge mistake, and the only reason it's been done for some
> of the new targets musl supports is because the kernel does it, and
> working around a mismatch between kernel and user time_t is a huge
> problem -- all sorts of things, including for example struct stat,
> depend on the time_t definition, and if you're going to allow mismatch
> with kernel you might as well go ahead and have a full translation
> layer for kernel structs like this.

Makes sense, I hope we can do the same for all libc implementations

> > - running existing binaries with 32-bit time_t on a library with 64-bit
> >   time_t support, using symbol versioning
> 
> Symbol versions don't solve any problem, and they mask dangerous bugs,
> so no. The problem is that a symbol version is only able to represent
> a single interface boundary (between a caller and libc), not all the
> other interface boundaries between third-party libraries. If code
> compiled for 32-bit time_t calls into code that uses 64-bit time_t
> with a time_t* argument and the callee writes back a result, it's
> corrupted the caller's memory. Symbol versions have no way to diagnose
> this.
> 
> They're also bound at ld-time, whereas the choice of needed version
> depends on compile-time (which definitions were used in the header the
> code was compiled against).

Ok, good. This differs from the approach taken by glibc though,
as they plan to use symbol versioning for this, like it was used
for off_t interfaces.

Introducing a new ABI like this definitely helps us prototype
the entire environment when doing the kernel port for the new
syscalls, this should be a lot easier to do than glibc with all
combinations of backwards compatibility.

> > - building a libc for existing architectures but without support for
> >   running existing 32-bit time_t applications.
> 
> Yes; this would be the way a new ABI would always work. But since musl
> inherently supports multi-arch (each arch variant has its own
> PT_INTERP name and library path config) you can easily run both types
> of binaries on the same system. They just need completely separate
> library ecosystems. This is the only way I know to prevent the
> dangerous issues that arise with other [non-]solutions like symbol
> versioning or feature test macros (as in -D_FILE_OFFSET_BITS=64) for
> the problem.

Ok, good. This will also help in case of embedded systems that want
to ensure that we use 64-bit time_t system-wide. I plan to add a
configuration option to the kernel to disallow all code that is
not y2038-safe (including ext3, NFSv3 and drivers with broken ioctls),
and it helps to have the same thing in user space. Of course the kernel
will by default have to support both ABIs.

Thanks a lot for your feedback.

	Arnd
