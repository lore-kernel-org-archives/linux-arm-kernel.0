From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Apr 2015 19:40:37 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <20150420155600.GF24715@e104818-lin.cambridge.arm.com>
References: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <2522717.YOvNMEL4TJ@wuerfel>
 <20150420155600.GF24715@e104818-lin.cambridge.arm.com>
Message-ID: <3662254.2ZhTAQGuKR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 April 2015 16:56:00 Catalin Marinas wrote:
> On Fri, Apr 17, 2015 at 05:49:44PM +0200, Arnd Bergmann wrote:
> > On Friday 17 April 2015 15:46:57 Catalin Marinas wrote:
> > > On Fri, Apr 17, 2015 at 02:17:32PM +0100, Arnd Bergmann wrote:
> > | typedef unsigned short          __kernel_mode_t;
> > | typedef unsigned short          __kernel_ipc_pid_t;
> > 
> > Both of these affect all sysvipc, but very little else
> > 
> > | typedef unsigned short          __kernel_uid_t;
> > | typedef unsigned short          __kernel_gid_t;
> > 
> > sysvipc, ncpfs, and core dumps (probably fine since they are separate
> > anyway), 
> 
> Not all ipc functions are affected AFAICT. msgsnd, msgrcv, msgctl look
> to me like we can just use the compat variants with the generic
> definitions for the types above (unless I missed something). Similarly
> for shmat, compat_sys_shmat just does some compat_ptr casting.

Right.

> > | typedef unsigned short          __kernel_old_dev_t; /* compat gets this wrong */
> > 
> > old-style loopdev ioctl
> > 
> > | struct stat { ... } /* possibly not needed */
> > 
> >  - lustre ioctls (needs to be fixed anyway)
> >  - old stat syscalls (won't be used with asm-generic/unistd.h)
> > 
> > | struct stat64 { ... }
> > 
> >  - lustre ioctls
> >  - new style stat syscalls
> 
> For stat64 the wrappers don't look complicated, so we could add arm64
> ILP32-specific ones.

stat is never easy ;-)

Note that for new architectures, we use 'struct stat64' on 32-bit systems
but 'struct stat' on 64-bit systems. Old architectures like arch/arm has
both, and neither of them matches the on from arch/arm64.

Also, the asm-generic definition of 'struct stat64' is wrong and really
needs to be fixed to have the same layout that 'struct stat' has on
a 64-bit architecture. The only difference between the two is the size
of the time related 'st_atime' etc members, and having them defined
this way was my biggest mistake when I created the uapi/asm-generic
headers.

> > So, in essence the difference comes down to the syscalls for stat
> > and ipc. If we use the aarch32 data types, we can share the
> > fstatat64, fstat64, semctl, msgsnd, msgrcv, msgctl, shmat,
> > and shmctl compat system calls between aarch32-compat and
> > aarch64-ilp32-compat. Otherwise we have to duplicate or extend
> > them to cover both cases at runtime. That would be rather ugly
> > but entirely doable. The ioctls are hardly affected, the few
> > ones that differ once __kernel_long_t matches could easily be
> > fixed up as you say.
> 
> I'd prefer a cleaner ABI even if we are to write some specific wrappers.

Ok, makes sense. As I replied to Philipp later, even with the
cleaner definition of 'stat64' and the sysipc syscalls, we should
be able to trivially reuse the native 64-bit version in the way that
the current patch set does for a lot of other syscalls, but keep all
the other syscalls using the normal 32-bit __kernel_long_t variants
that we already have.

	Arnd
