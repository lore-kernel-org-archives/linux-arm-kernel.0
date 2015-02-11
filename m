From: arnd@arndb.de (arnd at arndb.de)
Date: Wed, 11 Feb 2015 22:09:32 +0100 (CET)
Subject: [musl] Re: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <1383502854.512344.1423688575473.JavaMail.open-xchange@oxbaltgw09.schlund.de>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <20150211173919.GF9058@e104818-lin.cambridge.arm.com>
 <20150211190537.GK32724@port70.net>
 <359577916.509062.1423684206521.JavaMail.open-xchange@oxbaltgw09.schlund.de>
 <20150211201251.GK23507@brightrain.aerifal.cx>
 <1383502854.512344.1423688575473.JavaMail.open-xchange@oxbaltgw09.schlund.de>
Message-ID: <2013411126.512657.1423688972986.JavaMail.open-xchange@oxbaltgw09.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry about the HTML mail, I'm currently travelling without access to my regular
mail client. 

> "arnd at arndb.de" <arnd@arndb.de> hat am 11. Februar 2015 um 22:02 geschrieben:
> 
>  Rich Felker <dalias@libc.org> hat am 11. Februar 2015 um 21:12 geschrieben:
>  > On Wed, Feb 11, 2015 at 08:50:06PM +0100, arnd at arndb.de wrote:
>  > > > > At least for AArch64 ILP32 we are still free to change the
>  > > > > user/kernel
>  > > > > ABI, so we could add wrappers for the affected syscalls to fix this
>  > > > > up.
>  > > > yes, afaik on x32 the 64bit kernel expects 64bit layout,
>  > > > arm64 can fix this
>  > >
>  > > We have to fix it on all 32-bit architectures when we move to 64-bit
>  > > time_t.
>  > >
>  > > I think ideally you'd want a user space definition like
>  > >
>  > > typedef long long time_t;
>  > > struct timespec {
>  > > time_t tv_sec;
>  > > long long tv_nsec;
>  > > };
>  > >
>  > > which is the only way to avoid passing uninitialized tv_nsec into the
>  > > kernel
>  > > from arbitrary user space doing ioctl. This is of course against POSIX
>  > > and
>  > > C99. Changing POSIX to allow it is probably easier than the C standard,
>  > > but we have a couple of years before we need to make this the default.
>  >
>  > I don't see why you want it to be long long. There is no harm in
>  > passing uninitialized padding to the kernel; the kernel just needs to
>  > do the right thing and ignore it (or avoid reading it to begin with).
>   
>  This would however mean having three different implementations
>  in the kernel rather than just two: Every driver that can pass a timespec
>  with this model needs to handle the native 64-bit case (64/64), the legacy
>  32-bit case (32/32) and the y2038-safe case (64/32). Most code can
>  already handle the first two, and none today handles the third. If you
>  want to make the handling explicitly incompatible with native 64-bit
>  mode, you get a lot of untested code in obscure places that are never
>  tested properly, while using the normal behavior in the kernel at least
>  gives us the same bugs that we already have on native 64-bit systems.
>   
>  In some cases, there may also be a measurable performance penalty
>  in interpreting a user space data structure manually over copying
>  it (including the timespec values) in one chunk.
>   
>  An alternative would be to change the native 64-bit case to ignore the upper
>  half of tv_nsec and always just copy the low bits. This should work
>  fine almost all of the time, but I fear that there might be corner cases
>  where existing 64-bit user space depends on passing large or negative
>  tv_nsec values into the kernel.
>   
>  > The other direction, passing uninitialized data from the kernel to
>  > userspace, would be dangerous. But it doesn't happen as long as the
>  > userspace padding is positioned (in an endian-dependent manner) where
>  > the high bits of the kernel type would lie. It could happen if you
>  > used a separate conversion wrapper that ony wrote 32 bits, but if you
>  > wanted to take that approach you'd just need the wrapper to also write
>  > the padding field manually.
>   
>  Going from kernel to user space should not be an issue as long as we
>  always just write two 64-bit words, and this will zero-fill the upper half.
> 
>  > > In the kernel headers, the current plan is to provide interfaces taking
>  > > structures
>  > >
>  > > typedef long long __kernel_time64_t;
>  > > struct __kernel_timespec64_t {
>  > > __kernel_time64_t tv_sec;
>  > > long long tv_nsec;
>  > > };
>  > >
>  > > at least for ioctls, to avoid the ambiguity with libc headers specifying
>  > > something else.
>  >
>  > This seems hideous from an application standpoint. Application
>  > programmers don't want to know, and shouldn't need to know, these
>  > silly implementation details that make no sense except as historical
>  > baggage. They should just be able to use "struct timespec" everywhere
>  > and have it work.
>  The kernel does not even know how timespec is defined by libc, and we have
>  to at least be able to handle the common cases of timespec being 32/32
>  and 64/64 (or 64/32 plus explicit padding). For system calls, we can rely
>  on libc calling the syscalls that match the definition (or convert the
>  structure as necessary), while for ioctl the command number is chosen
>  by the application and has to match the structure definition provided in
>  the same header.
>   
>  In a lot of cases, the ioctl command number is defined (correctly) using the
>  _IOR/_IOW macros that take the size of the structure into account, but then
>  you also have cases where you get indirect pointers and the size of data
> structure
>  passed by the ioctl command is independent of the size of timespec or time_t.
>   
>  This is not just limited to time_t, we have a lot of data types for which we
> define
>  __kernel_*_t types for this purpose, to deal with ioctls that need a specific
>  layout independent of what libc uses.
>   
>        Arnd
> 

 
