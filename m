From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Feb 2015 18:20:18 +0100
Subject: [musl] Re: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150211213758.GN23507@brightrain.aerifal.cx>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <1383502854.512344.1423688575473.JavaMail.open-xchange@oxbaltgw09.schlund.de>
 <20150211213758.GN23507@brightrain.aerifal.cx>
Message-ID: <95765022.dfzNYZrNVS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 February 2015 16:37:58 Rich Felker wrote:
> On Wed, Feb 11, 2015 at 10:02:55PM +0100, arnd at arndb.de wrote:
> > Rich Felker <dalias@libc.org> hat am 11. Februar 2015 um 21:12 geschrieben:
> > > On Wed, Feb 11, 2015 at 08:50:06PM +0100, arnd at arndb.de wrote:
> > > > > > At least for AArch64 ILP32 we are still free to change the user/kernel
> > > > > > ABI, so we could add wrappers for the affected syscalls to fix this up.
> > > > > yes, afaik on x32 the 64bit kernel expects 64bit layout,
> > > > > arm64 can fix this
> > > >
> > > > We have to fix it on all 32-bit architectures when we move to 64-bit time_t.
> > > >
> > > > I think ideally you'd want a user space definition like
> > > >
> > > > typedef long long time_t;
> > > > struct timespec {
> > > > time_t tv_sec;
> > > > long long tv_nsec;
> > > > };
> > > >
> > > > which is the only way to avoid passing uninitialized tv_nsec into the kernel
> > > > from arbitrary user space doing ioctl. This is of course against POSIX and
> > > > C99. Changing POSIX to allow it is probably easier than the C standard,
> > > > but we have a couple of years before we need to make this the default.
> > >
> > > I don't see why you want it to be long long. There is no harm in
> > > passing uninitialized padding to the kernel; the kernel just needs to
> > > do the right thing and ignore it (or avoid reading it to begin with).
> >  
> > This would however mean having three different implementations
> > in the kernel rather than just two: Every driver that can pass a timespec
> > with this model needs to handle the native 64-bit case (64/64), the legacy
> > 32-bit case (32/32) and the y2038-safe case (64/32). Most code can
> > already handle the first two, and none today handles the third. If you
> > want to make the handling explicitly incompatible with native 64-bit
> > mode, you get a lot of untested code in obscure places that are never
> > tested properly, while using the normal behavior in the kernel at least
> > gives us the same bugs that we already have on native 64-bit systems.
> 
> Would it really be that hard to do:
> 
> 	if (ILP32_on_64_process) tv_nsec = (int)tv_nsec;
> 
> or similar? That's all that's needed.
> 
> > In some cases, there may also be a measurable performance penalty
> > in interpreting a user space data structure manually over copying
> > it (including the timespec values) in one chunk.
> 
> I don't think the above would be measurable.

It depends: Copying the structure first and then doing the conversion
in kernel space on the specific members as you do in the example
should indeed have a trivial performance impact. However, it is also
the hardest for driver writers to get right, and it's better not to
trust them with corner cases like this.

To make it more readable, we would probably introduce a helper function
that copies the timespec from user space memory to kernel space and
then does all the checks and conversions as required. However, doing
separate copies can (depending on the architecture) have a noticeable
impact. An example for this would be architectures that require setting
up a page table entry for the user space page in order to access the
data and then destroy it again afterwards, with the correct TLB flushes.

We can do something like this for the old-style compat handlers that
use 32-bit time_t, but I'd prefer not to have it in the fast path for
the native 64-bit time_t on 64-bit architectures.

> > An alternative would be to change the native 64-bit case to ignore the upper
> > half of tv_nsec and always just copy the low bits. This should work
> > fine almost all of the time, but I fear that there might be corner cases
> > where existing 64-bit user space depends on passing large or negative
> > tv_nsec values into the kernel.
> 
> Most functions using caller-provided timespecs are required to
> diagnose invalid forms with EINVAL when tv_nsec>=1000000000 or <0, so
> if the kernel examines only the low 32 bits on ABIs where long is
> 64-bit, userspace would need to be responsible for doing this
> checking.

Right, that would not be good, in particular because we should not
change that for existing architectures.

> > > > In the kernel headers, the current plan is to provide interfaces taking
> > > > structures
> > > >
> > > > typedef long long __kernel_time64_t;
> > > > struct __kernel_timespec64_t {
> > > > __kernel_time64_t tv_sec;
> > > > long long tv_nsec;
> > > > };
> > > >
> > > > at least for ioctls, to avoid the ambiguity with libc headers specifying
> > > > something else.
> > >
> > > This seems hideous from an application standpoint. Application
> > > programmers don't want to know, and shouldn't need to know, these
> > > silly implementation details that make no sense except as historical
> > > baggage. They should just be able to use "struct timespec" everywhere
> > > and have it work.
> > 
> > The kernel does not even know how timespec is defined by libc, and we have
> > to at least be able to handle the common cases of timespec being 32/32
> > and 64/64 (or 64/32 plus explicit padding). For system calls, we can rely
> > on libc calling the syscalls that match the definition (or convert the
> > structure as necessary), while for ioctl the command number is chosen
> > by the application and has to match the structure definition provided in
> > the same header.
> 
> Generally I would think the kernel knows the model the process is
> using, but if not, all you need is separate ioctl numbers for
> userspace to use depending on which definition it's using.

I've checked now, and indeed the kernel knows for ilp32 x86 and arm, since
it uses a different ELF interpreter. I thought it might be running the
ilp32 binaries as ELF64, but it does not.

I would like to avoid separate ioctl command numbers, but we have to
do it for 64-bit time_t on the original 32-bit architectures in the
cases where the size is not already encoded in the command number.

	Arnd
