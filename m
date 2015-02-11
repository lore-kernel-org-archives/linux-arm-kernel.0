From: nsz@port70.net (Szabolcs Nagy)
Date: Wed, 11 Feb 2015 20:05:37 +0100
Subject: [musl] Re: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
Message-ID: <20150211190537.GK32724@port70.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [2015-02-11 17:39:19 +0000]:
> (adding Marcus)
> 
> On Tue, Feb 10, 2015 at 06:13:02PM +0000, Rich Felker wrote:
> > I don't know if this has been discussed on libc-alpha yet or not, but
> > I think we need to open a discussion of how it relates to open glibc
> > bug #16437, which presently applies only to x32 (ILP32 ABI on x86_64):
> > 
> > https://sourceware.org/bugzilla/show_bug.cgi?id=16437
...
> So w.r.t. C11, the exported kernel timespec looks fine. But I think the
> x32 kernel support (and the current ILP32 patches) assume a native
> struct timespec with tv_nsec as 64-bit.
> 
> If we are to be C11 conformant, glibc on x32 has a bug as it defines
> timespec incorrectly. This hid a bug in the kernel handling the
> corresponding x32 syscalls. What's the best fix for x32 I can't really
> tell (we need people to agree on where the bugs are).
> 
> At least for AArch64 ILP32 we are still free to change the user/kernel
> ABI, so we could add wrappers for the affected syscalls to fix this up.
> 

yes, afaik on x32 the 64bit kernel expects 64bit layout,
arm64 can fix this

> > While most of the other type changes proposed (I'm looking at
> > https://lkml.org/lkml/2014/9/3/719) are permissible and simply
> > ugly/undesirable,
> 
> They may be ugly but definitely not undesirable ;).
> 

several types have the same c level definition across all archs..
except x32 because of

 typedef long long __kernel_long_t;

this should not cause posix/c conformance issues (as you noted
timespec is ok in the uapi header only the kernel side behaviour
is wrong)

however note that the kernel documentation is explicit about some of
the types and now x32 does not match those which you may consider
as a documentation issue, but it can easily break existing code so
at least some of the type changes are undesirable
(now it's not clear what libc should do with these)

http://man7.org/linux/man-pages/man2/sysinfo.2.html
http://man7.org/linux/man-pages/man2/adjtimex.2.html
http://man7.org/linux/man-pages/man2/getrusage.2.html

> > Note that on aarch64 ILP32, the consequences of not fixing this right
> > away will be much worse than on x32, since aarch64 (at least as I
> > understand it) supports big endian where it's not just a matter of
> > sign-extending the value from userspace and ignoring the padding, but
> > rather changing the offset of the tv_nsec member.
> 
> Indeed.
> 

the ugliest (little endian only) workaround in glibc now is i think

http://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/bits/resource.h;hb=HEAD#l183

> > Working around the discrepencies in userspace IS possible, but ugly.
> > We do it in musl libc for x32 right now -- see:
> > 
> > http://git.musl-libc.org/cgit/musl/tree/arch/x32/syscall_arch.h?id=v1.1.6
> > http://git.musl-libc.org/cgit/musl/tree/arch/x32/src/syscall_cp_fixup.c?id=v1.1.6
> 
> For AArch64 ILP32 I would rather see the fix-ups in kernel wrappers.
> 
> Are you aware of other cases like this?
> 

i know at least one android kernel issue: there is an ioctl for the
alarm device that takes timespec argument

(i think it's not in the mainline kernel and i guess android does
not care about x32 so it was not an issue so far, but this is something
that should not be fixed on the libc side)

wrt. ioctl/fcntl another issue if there is ever a call that takes signed
long or signed int argument which has to be signextended when doing a syscall

(i think this is also a problem if userspace code uses syscall(2) directly,
libc cannot possibly know where to signextend and the kernel side does not
do the fixup right now)

> (the rest of the comment below for Marcus' attention)
> 
> > I imagine the workarounds in glibc might need to be considerably more
> > widespread and uglier.
> > 
> > Whatever happens on the kernel side, this needs to be coordinated with
> > userspace (glibc, etc.) properly so that the type error (glibc bug
> > 16437) is not propagated into a new target that we actually want
> > people to use. I'd really like it if other undesirable type changes
> > could be cleaned up too, but perhaps that's too much to ask from the
> > kernel side.
> 
> -- 
> Catalin
