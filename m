From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 20 Apr 2015 16:56:00 +0100
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <2522717.YOvNMEL4TJ@wuerfel>
References: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <3365190.ZbiKjUlDk2@wuerfel>
 <20150417144656.GQ819@e104818-lin.cambridge.arm.com>
 <2522717.YOvNMEL4TJ@wuerfel>
Message-ID: <20150420155600.GF24715@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 17, 2015 at 05:49:44PM +0200, Arnd Bergmann wrote:
> On Friday 17 April 2015 15:46:57 Catalin Marinas wrote:
> > On Fri, Apr 17, 2015 at 02:17:32PM +0100, Arnd Bergmann wrote:
> > >   g) create a new ABI that does things in exactly the way that we
> > >      would use as the native syscall interface if we had an ilp32
> > >      kernel running on aarch64 with the asm-generic/unistd.h.
> > >      This would mean a 32-bit __kernel_long_t and time_t, but extending
> > >      time_t in the long run, together with aarch32 and i386.
> > >      This one is particularly interesting for people that are interested
> > >      in maximum posix compliance and in having a "nice" ABI, in particular
> > >      if there is a slight chance that within the next decade we have
> > >      reason to support building an arch/arm64 kernel itself in
> > >      aarch64-ilp32 mode.
> > 
> > I don't think there is a much difference between g) and e). The reason
> > we re-define many structures in asm/compat.h is because we don't have a
> > generic compat_* definition (e.g. compat_timespec, compat_timeval,
> > compat_flock, compat_flock64; anyway, I think some of these may not even
> > be needed with the canonical set of syscalls). The signal related
> > structures need to be handled differently for AArch32 and AArch64-ILP32
> > anyway because of the difference in the register set.
> 
> Interesting observation, I had not guessed this.
> 
> Let's list the differences, this is what I could find:
> 
> | #define FIOQSIZE        0x545E
> 
> probably broken on arm64 already, should be investigated

Yes, it seems broken. arm64 uses the generic FIOQSIZE which doesn't
match the compat one.

> | typedef unsigned short          __kernel_mode_t;
> | typedef unsigned short          __kernel_ipc_pid_t;
> 
> Both of these affect all sysvipc, but very little else
> 
> | typedef unsigned short          __kernel_uid_t;
> | typedef unsigned short          __kernel_gid_t;
> 
> sysvipc, ncpfs, and core dumps (probably fine since they are separate
> anyway), 

Not all ipc functions are affected AFAICT. msgsnd, msgrcv, msgctl look
to me like we can just use the compat variants with the generic
definitions for the types above (unless I missed something). Similarly
for shmat, compat_sys_shmat just does some compat_ptr casting.

> | typedef unsigned short          __kernel_old_dev_t; /* compat gets this wrong */
> 
> old-style loopdev ioctl
> 
> | struct stat { ... } /* possibly not needed */
> 
>  - lustre ioctls (needs to be fixed anyway)
>  - old stat syscalls (won't be used with asm-generic/unistd.h)
> 
> | struct stat64 { ... }
> 
>  - lustre ioctls
>  - new style stat syscalls

For stat64 the wrappers don't look complicated, so we could add arm64
ILP32-specific ones.

I'm not sure about the ioctls affected, I haven't checked.

> So, in essence the difference comes down to the syscalls for stat
> and ipc. If we use the aarch32 data types, we can share the
> fstatat64, fstat64, semctl, msgsnd, msgrcv, msgctl, shmat,
> and shmctl compat system calls between aarch32-compat and
> aarch64-ilp32-compat. Otherwise we have to duplicate or extend
> them to cover both cases at runtime. That would be rather ugly
> but entirely doable. The ioctls are hardly affected, the few
> ones that differ once __kernel_long_t matches could easily be
> fixed up as you say.

I'd prefer a cleaner ABI even if we are to write some specific wrappers.

-- 
Catalin
