From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Apr 2015 17:49:44 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <20150417144656.GQ819@e104818-lin.cambridge.arm.com>
References: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <3365190.ZbiKjUlDk2@wuerfel>
 <20150417144656.GQ819@e104818-lin.cambridge.arm.com>
Message-ID: <2522717.YOvNMEL4TJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 April 2015 15:46:57 Catalin Marinas wrote:
> On Fri, Apr 17, 2015 at 02:17:32PM +0100, Arnd Bergmann wrote:
> > - If we do not use the exact data structures that we have on aarch32,
> >   then I think we should make aarch32 emulation and aarch64-ilp32
> >   emulation mutually exclusive, and provide two separate asm/compat.h
> >   header files that contain the differences. In this case, we should
> >   try to come up with an ABI that makes the most sense for the majority
> >   of the use cases that people are interested in. The two most likely
> >   choices here would be
> > 
> >   f) create a new ABI that follows exactly what x32 did. This is a
> >      variation of the earlier b), c), or d), but with the change of
> >      fixing ioctl support by using a matching asm/compat.h. This
> >      would not be entirely POSIX compliant, but it would be a nice
> >      hack to get the highest performance in microbenchmarks, as it
> >      avoids most of the compat layer. Over time, it can get extended
> >      to coexist with aarch32 emulation, but that may take a few years.
> 
> Even in this case, we could enable AArch32 compat knowing that ioctls
> wouldn't work. If this is important, we can add an option to enable
> ioctl support for ILP32 and re-target the asm/compat.h definitions.

We can allow them to coexist, but I'd only do that in mainline after
fixing all existing problems. Otherwise we can end up with user space
that tries to use the wrong ioctl API, and fixing the kernel breaks
the application, without a way for the kernel to detect which behavior
the user expects.

> >   g) create a new ABI that does things in exactly the way that we
> >      would use as the native syscall interface if we had an ilp32
> >      kernel running on aarch64 with the asm-generic/unistd.h.
> >      This would mean a 32-bit __kernel_long_t and time_t, but extending
> >      time_t in the long run, together with aarch32 and i386.
> >      This one is particularly interesting for people that are interested
> >      in maximum posix compliance and in having a "nice" ABI, in particular
> >      if there is a slight chance that within the next decade we have
> >      reason to support building an arch/arm64 kernel itself in
> >      aarch64-ilp32 mode.
> 
> I don't think there is a much difference between g) and e). The reason
> we re-define many structures in asm/compat.h is because we don't have a
> generic compat_* definition (e.g. compat_timespec, compat_timeval,
> compat_flock, compat_flock64; anyway, I think some of these may not even
> be needed with the canonical set of syscalls). The signal related
> structures need to be handled differently for AArch32 and AArch64-ILP32
> anyway because of the difference in the register set.

Interesting observation, I had not guessed this.

Let's list the differences, this is what I could find:

| #define FIOQSIZE        0x545E

probably broken on arm64 already, should be investigated

| typedef unsigned short          __kernel_mode_t;
| typedef unsigned short          __kernel_ipc_pid_t;

Both of these affect all sysvipc, but very little else

| typedef unsigned short          __kernel_uid_t;
| typedef unsigned short          __kernel_gid_t;

sysvipc, ncpfs, and core dumps (probably fine since they are separate
anyway), 

| typedef unsigned short          __kernel_old_dev_t; /* compat gets this wrong */

old-style loopdev ioctl

| struct stat { ... } /* possibly not needed */

 - lustre ioctls (needs to be fixed anyway)
 - old stat syscalls (won't be used with asm-generic/unistd.h)

| struct stat64 { ... }

 - lustre ioctls
 - new style stat syscalls

So, in essence the difference comes down to the syscalls for stat
and ipc. If we use the aarch32 data types, we can share the
fstatat64, fstat64, semctl, msgsnd, msgrcv, msgctl, shmat,
and shmctl compat system calls between aarch32-compat and
aarch64-ilp32-compat. Otherwise we have to duplicate or extend
them to cover both cases at runtime. That would be rather ugly
but entirely doable. The ioctls are hardly affected, the few
ones that differ once __kernel_long_t matches could easily be
fixed up as you say.

> I would add a variation of g):
> 
>   h) create a new ABI that uses asm-generic/unistd.h and generic types
>      with 32-bit __kernel_long_t and 64-bit time_t. This would be POSIX
>      compliant and we don't have to worry about extending time_t in the
>      future. We would have to duplicate some of the generic structures
>      in asm/compat.h so that we can use the compat layer. However, at
>      least in the short term, we don't have an easy way to enable both
>      AArch32 and AArch64 ILP32 in the same kernel (they would be
>      exclusive).

I'd particularly like to avoid this case, out of pure self-interest:

> > > > However, it would be nice to get agreement on the normal 32-bit ABI
> > > > for time_t and timespec first, and then use the same thing everywhere.
> > > 
> > > Do you mean for native 32-bit architectures? I think OpenBSD uses a
> > > 64-bit time_t already on 32-bit arches, it's doable in Linux as well.
> > 
> > Yes, and I'm working on that for Linux. The first step involves fixing
> > the kernel, one file at a time, changing all users of time_t to use
> > some other type (ktime_t or time64_t in most cases) instead, and introducing
> > additional system calls to handle the boundary to user space without
> > breaking stuff. See my presentation at http://elinux.org/ELC_2015_Presentations
> > for more detail.
> 
> The approach here is primarily to fix the problem for existing 32-bit
> architectures by adding a new syscall and that's fine. But what if we
> enforce 64-bit time_t for all _new_ architectures?

I think that makes the job of fixing the existing architectures harder,
because it adds more special cases. It's already incredibly hard to
do this without breaking user space or missing some corner cases that
needs to be fixed. So far, the easy assumption is that 64-bit architectures
use 64-bit time_t, 32-bit architectures use 32-bit time_t, and x32
is somewhat broken regarding ioctl and would be fixed in the process.
I don't want to have to deal with more combinations in the kernel for now.
Once we have established a syscall API and found a large-enough subset
of drivers that have a working ioctl (and the other ones marked
'depends on COMPAT_TIME_T'), we would stop taking new architecture
ports that provide both APIs and mandate that new ones only implement
the 64-bit time_t one.

	Arnd
