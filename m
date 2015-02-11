From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Feb 2015 17:39:19 +0000
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150210181302.GA23886@brightrain.aerifal.cx>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
Message-ID: <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(adding Marcus)

On Tue, Feb 10, 2015 at 06:13:02PM +0000, Rich Felker wrote:
> On Thu, 2 Oct 2014 at 16:52:18 +0100, Catalin Marinas wrote:
> > On Wed, Sep 03, 2014 at 10:18:54PM +0100, Andrew Pinski wrote:
> > > New version with all of the requested changes.  Updated to the
> > > latest sources.
> > > 
> > > Notable changes from the previous versions:
> > > VDSO code has been factored out to be easier to understand and
> > > easier to maintain.
> > > Move the config option to the last thing that gets added.
> > > Added some extra COMPAT_* macros for core dumping for easier usage.
> > 
> > Apart from a few comments I've made, I would also like to see non-empty
> > commit logs and long line wrapping (both in commit logs and
> > Documentation/). Otherwise, the patches look fine.
> > 
> > So what are the next steps? Are the glibc folk ok with the ILP32 Linux
> > ABI? On the kernel side, what I would like to see:
> 
> I don't know if this has been discussed on libc-alpha yet or not, but
> I think we need to open a discussion of how it relates to open glibc
> bug #16437, which presently applies only to x32 (ILP32 ABI on x86_64):
> 
> https://sourceware.org/bugzilla/show_bug.cgi?id=16437

I'm trying to understand the problem first. Quoting from the bug above
(which I guess is quoted form C11):

"The range and precision of times representable in clock_t and time_t
are implementation-defined. The timespec structure shall contain at
least the following members, in any order.

         time_t tv_sec; // whole seconds -- >= 0
         long   tv_nsec; // nanoseconds -- [0, 999999999]"

So changing time_t to 64-bit is fine on x32. The timespec struct
exported by the kernel always uses a long for tv_nsec. However, glibc uses
__syscall_slong_t which ends up as 64-bit for x32 (I guess it mirrors
the __kernel_long_t definition).

So w.r.t. C11, the exported kernel timespec looks fine. But I think the
x32 kernel support (and the current ILP32 patches) assume a native
struct timespec with tv_nsec as 64-bit.

If we are to be C11 conformant, glibc on x32 has a bug as it defines
timespec incorrectly. This hid a bug in the kernel handling the
corresponding x32 syscalls. What's the best fix for x32 I can't really
tell (we need people to agree on where the bugs are).

At least for AArch64 ILP32 we are still free to change the user/kernel
ABI, so we could add wrappers for the affected syscalls to fix this up.

> While most of the other type changes proposed (I'm looking at
> https://lkml.org/lkml/2014/9/3/719) are permissible and simply
> ugly/undesirable,

They may be ugly but definitely not undesirable ;).

> defining struct timespec with tv_nsec having any type other than long
> conflicts with the requirements of C11 and POSIX, and WG14 is unlikely
> to be interested in changing the C language because the Linux kernel
> has the wrong type in timespec.

I agree. The strange thing is that the Linux exported headers are fine.

> Note that on aarch64 ILP32, the consequences of not fixing this right
> away will be much worse than on x32, since aarch64 (at least as I
> understand it) supports big endian where it's not just a matter of
> sign-extending the value from userspace and ignoring the padding, but
> rather changing the offset of the tv_nsec member.

Indeed.

> Working around the discrepencies in userspace IS possible, but ugly.
> We do it in musl libc for x32 right now -- see:
> 
> http://git.musl-libc.org/cgit/musl/tree/arch/x32/syscall_arch.h?id=v1.1.6
> http://git.musl-libc.org/cgit/musl/tree/arch/x32/src/syscall_cp_fixup.c?id=v1.1.6

For AArch64 ILP32 I would rather see the fix-ups in kernel wrappers.

Are you aware of other cases like this?

(the rest of the comment below for Marcus' attention)

> I imagine the workarounds in glibc might need to be considerably more
> widespread and uglier.
> 
> Whatever happens on the kernel side, this needs to be coordinated with
> userspace (glibc, etc.) properly so that the type error (glibc bug
> 16437) is not propagated into a new target that we actually want
> people to use. I'd really like it if other undesirable type changes
> could be cleaned up too, but perhaps that's too much to ask from the
> kernel side.

-- 
Catalin
