From: dalias@libc.org (Rich Felker)
Date: Wed, 11 Feb 2015 15:12:51 -0500
Subject: [musl] Re: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <359577916.509062.1423684206521.JavaMail.open-xchange@oxbaltgw09.schlund.de>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
 <20150211190537.GK32724@port70.net>
 <359577916.509062.1423684206521.JavaMail.open-xchange@oxbaltgw09.schlund.de>
Message-ID: <20150211201251.GK23507@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 08:50:06PM +0100, arnd at arndb.de wrote:
> > > At least for AArch64 ILP32 we are still free to change the user/kernel
> > > ABI, so we could add wrappers for the affected syscalls to fix this up.
> > >
> >
> > yes, afaik on x32 the 64bit kernel expects 64bit layout,
> > arm64 can fix this
>  
> We have to fix it on all 32-bit architectures when we move to 64-bit time_t.
>  
> I think ideally you'd want a user space definition like
> 
> typedef long long time_t;
> struct timespec {
>       time_t tv_sec;
>       long long tv_nsec;
> };
> 
> which is the only way to avoid passing uninitialized tv_nsec into the kernel
> from arbitrary user space doing ioctl. This is of course against POSIX and
> C99. Changing POSIX to allow it is probably easier than the C standard,
> but we have a couple of years before we need to make this the default.

I don't see why you want it to be long long. There is no harm in
passing uninitialized padding to the kernel; the kernel just needs to
do the right thing and ignore it (or avoid reading it to begin with).
Changing the C standard in an incompatible way that invalidates
existing code is not preferable over fixing an implementation bug in
one implementation. Even if C16 or so changed the requirement, people
will still be looking to C11 (and even C99) for years or decades to
come. Alignment of code to language standards moves slowly.

The other direction, passing uninitialized data from the kernel to
userspace, would be dangerous. But it doesn't happen as long as the
userspace padding is positioned (in an endian-dependent manner) where
the high bits of the kernel type would lie. It could happen if you
used a separate conversion wrapper that ony wrote 32 bits, but if you
wanted to take that approach you'd just need the wrapper to also write
the padding field manually.

> In the kernel headers, the current plan is to provide interfaces taking
> structures 
>  
> typedef long long __kernel_time64_t;
> struct __kernel_timespec64_t {
>       __kernel_time64_t tv_sec;
>       long long tv_nsec;
> };
>  
> at least for ioctls, to avoid the ambiguity with libc headers specifying
> something else.

This seems hideous from an application standpoint. Application
programmers don't want to know, and shouldn't need to know, these
silly implementation details that make no sense except as historical
baggage. They should just be able to use "struct timespec" everywhere
and have it work.

Rich
