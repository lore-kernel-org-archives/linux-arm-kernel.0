From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Feb 2015 15:40:54 +0100
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150213183706.GF23507@brightrain.aerifal.cx>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150213173345.GA26217@e104818-lin.cambridge.arm.com>
 <20150213183706.GF23507@brightrain.aerifal.cx>
Message-ID: <2282163.7MvOQMXljz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 February 2015 13:37:07 Rich Felker wrote:
> On Fri, Feb 13, 2015 at 05:33:46PM +0000, Catalin Marinas wrote:
> > > > > The data structure definition is a little bit fragile, as it depends on
> > > > > user space not using the __BIT_ENDIAN symbol in a conflicting way. So
> > > > > far we have managed to keep that outside of general purpose headers, but
> > > > > it should at least blow up in an obvious way if it does, rather than
> > > > > breaking silently.
> > > > > 
> > > > > I still think it's more practical to keep the zeroing in user space though.
> > > > > In that case, we keep defining __kernel_timespec64 with a 'typedef long
> > > > > long __kernel_snseconds_t', and it's up to the libc to either use
> > > > > __kernel_timespec64 as its timespec, or to define a C11-compliant
> > > > > timespec itself and zero out the bits before passing the data to the kernel.
> > > > 
> > > > The problem with doing this in user space is syscall(2). If we don't
> > > > allow it, then it's fine to do the padding in libc.
> > > 
> > > It's already the case that callers have to tiptoe around syscall(2)
> > > usage on a per-arch basis for silly things like the convention for
> > > passing 64-bit arguments on 32-bit archs, different arg orders to work
> > > around 64-bit alignment and issues with too many args, and various
> > > legacy issues.

Right. If one wants to use syscall(), they have to know exactly what the
kernel's calling conventions are, including knowing what the timespec
definition looks like, which could have a different size and padding
compared to the user space one.

> > I think there is another problem with sign-extending tv_nsec in libc.
> > The prototype for functions like clock_settime(2) take a const struct
> > timespec *. There isn't anything to prevent such structure being in a
> > read-only section, even though it is unlikely. So libc would have to
> > duplicate the structure rather than just sign-extending tv_nsec in
> > place.

Do we actually need sign-extend, or does zero-extend have the exact
same effect? For all I can tell, all invalid nanoseconds values
remain invalid, and the accepted values are unchanged regardless
of which type extension gets used.

> Yes, we already have to do this for x32 in musl. I'd rather not have
> to do the same for aarch64-ILP32.

This would of course be solved by using a 64-bit __kernel_snseconds_t
or snseconds_t, and I suspect other libc implementations would just do
that, when they are less strict about posix/c11 compliance compared
to musl.

If you don't mind the (slight) distraction, can you describe what your
plans are for handling 64-bit time_t on the existing 32-bit ABIs?
I'm involved in both the efforts to do that and the ilp32 code on
ARM, so it would be good for me to understand your plans for musl to
get the bigger picture. Specifically, which of these do you plan
to support (if you know already):

- using 64-bit time_t on future arm32/i386/... kernels
- using 64-bit time_t on existing arm32/i386/... kernels with native
  32-bit time_t
- using 32-bit time_t on future architectures that only support 64-bit
  time_t in the kernel
- running existing binaries with 32-bit time_t on a library with 64-bit
  time_t support, using symbol versioning
- compiling new code with 32-bit time_t against a library that supports
  both 32-bit and 64-bit time_t at runtime.
- building a libc for existing architectures but without support for
  running existing 32-bit time_t applications.

	Arnd
