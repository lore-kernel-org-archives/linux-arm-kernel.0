From: arnd@arndb.de (arnd at arndb.de)
Date: Wed, 11 Feb 2015 20:50:06 +0100 (CET)
Subject: [musl] Re: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150211190537.GK32724@port70.net>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
 <20150211190537.GK32724@port70.net>
Message-ID: <359577916.509062.1423684206521.JavaMail.open-xchange@oxbaltgw09.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Szabolcs Nagy <nsz@port70.net> hat am 11. Februar 2015 um 20:05 geschrieben:
> * Catalin Marinas <catalin.marinas@arm.com> [2015-02-11 17:39:19 +0000]:
> > (adding Marcus)
> >
> > On Tue, Feb 10, 2015 at 06:13:02PM +0000, Rich Felker wrote:
> > > I don't know if this has been discussed on libc-alpha yet or not, but
> > > I think we need to open a discussion of how it relates to open glibc
> > > bug #16437, which presently applies only to x32 (ILP32 ABI on x86_64):
> > >
> > > https://sourceware.org/bugzilla/show_bug.cgi?id=16437
> ...
> > So w.r.t. C11, the exported kernel timespec looks fine. But I think the
> > x32 kernel support (and the current ILP32 patches) assume a native
> > struct timespec with tv_nsec as 64-bit.
> >
> > If we are to be C11 conformant, glibc on x32 has a bug as it defines
> > timespec incorrectly. This hid a bug in the kernel handling the
> > corresponding x32 syscalls. What's the best fix for x32 I can't really
> > tell (we need people to agree on where the bugs are).
> >
> > At least for AArch64 ILP32 we are still free to change the user/kernel
> > ABI, so we could add wrappers for the affected syscalls to fix this up.
> >
>
> yes, afaik on x32 the 64bit kernel expects 64bit layout,
> arm64 can fix this
 
We have to fix it on all 32-bit architectures when we move to 64-bit time_t.
 
I think ideally you'd want a user space definition like

typedef long long time_t;
struct timespec {
      time_t tv_sec;
      long long tv_nsec;
};

which is the only way to avoid passing uninitialized tv_nsec into the kernel
from arbitrary user space doing ioctl. This is of course against POSIX and
C99. Changing POSIX to allow it is probably easier than the C standard,
but we have a couple of years before we need to make this the default.

In the kernel headers, the current plan is to provide interfaces taking
structures 
 
typedef long long __kernel_time64_t;
struct __kernel_timespec64_t {
      __kernel_time64_t tv_sec;
      long long tv_nsec;
};
 
at least for ioctls, to avoid the ambiguity with libc headers specifying
something else.

A libc could use other definitions with added padding for what it exports
to user space though, or even make this depend on compile-time flags to
determine whether to make tv_nsec as long long, or to insert padding
in the right place based on endianess.

> > > While most of the other type changes proposed (I'm looking at
> > > https://lkml.org/lkml/2014/9/3/719) are permissible and simply
> > > ugly/undesirable,
> >
> > They may be ugly but definitely not undesirable ;).
> >
>
> several types have the same c level definition across all archs..
> except x32 because of
>
> typedef long long __kernel_long_t;
>
> this should not cause posix/c conformance issues (as you noted
> timespec is ok in the uapi header only the kernel side behaviour
> is wrong)
 
The kernel behavior is right for the syscalls except ioctl, the uapi
header is wrong (not according to C99, but according to common sense)
and needs to be changed in order to work with big-endian. For x32,
I wonder if we can just #define timespec as __kernel_timespec64
once we introduce that.

> > > Working around the discrepencies in userspace IS possible, but ugly.
> > > We do it in musl libc for x32 right now -- see:
> > >
> > > http://git.musl-libc.org/cgit/musl/tree/arch/x32/syscall_arch.h?id=v1.1.6
> > > http://git.musl-libc.org/cgit/musl/tree/arch/x32/src/syscall_cp_fixup.c?id=v1.1.6
> >
> > For AArch64 ILP32 I would rather see the fix-ups in kernel wrappers.
> >
> > Are you aware of other cases like this?
> >
>
> i know at least one android kernel issue: there is an ioctl for the
> alarm device that takes timespec argument
>
> (i think it's not in the mainline kernel and i guess android does
> not care about x32 so it was not an issue so far, but this is something
> that should not be fixed on the libc side)

ioctl is a known problem with x32 and the ARM ILP32 support. This is
not limited to timespec but to any driver that uses an ioctl with
a data structure that includes a __kernel_long_t or __kernel_ulong_t
argument. There are a couple of drivers using these, and we either
need to change the structures to use 'long' instead, or fix the driver
to be aware of the difference between old-style 32-bit compat and
x32-style compat ioctl handling.

The types affected by this are
include/uapi/asm-generic/posix_types.h:typedef __kernel_ulong_t __kernel_ino_t;
include/uapi/asm-generic/posix_types.h:typedef __kernel_ulong_t __kernel_size_t;
include/uapi/asm-generic/posix_types.h:typedef __kernel_long_t
         __kernel_suseconds_t;
include/uapi/asm-generic/posix_types.h:typedef __kernel_long_t
 __kernel_ssize_t;
include/uapi/asm-generic/posix_types.h:typedef __kernel_long_t
 __kernel_ptrdiff_t;
include/uapi/asm-generic/posix_types.h:typedef __kernel_long_t  __kernel_off_t;
include/uapi/asm-generic/posix_types.h:typedef __kernel_long_t  __kernel_time_t;
include/uapi/asm-generic/posix_types.h:typedef __kernel_long_t
 __kernel_clock_t;

and anything derived from this.

     Arnd
