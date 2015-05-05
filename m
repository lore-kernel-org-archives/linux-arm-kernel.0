From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 May 2015 15:11:08 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <3908616.DHRS6D2Ytk@wuerfel>
References: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <6299275.Ntfb3Dzi12@wuerfel> <3908616.DHRS6D2Ytk@wuerfel>
Message-ID: <3710801.aNK3RcABri@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 May 2015 12:29:52 Arnd Bergmann wrote:
> 
> For 'struct stat', I ended up introducing a new structure on arm32 that
> matches the layout of arm64 (and I did the same for all other 32-bit
> architectures that have a 64-bit counterpart). This means we can share
> the same system calls between arm64-lp64, arm64-ilp32 and arm32 with
> 64-bit time_t and arm64-aarch32 emulation for 32-bit time_t, while
> using the existing compat handling for the original 'struct stat'
> emulation in both arm32 and arm64-aarch32.
> 
> However, for ipc, the situation is different: I found a way to use
> extra padding fields in semid64_ds/shmid64_ds/msqid64_ds, so the
> ipc system calls will still use normal 32-bit data structures
> on arm32 and arm64-aarch64, but you cannot use them arm64-ilp32,
> and will have to #ifdef the three header files there to choose between
> the two implementations.

I realized that this may need some more clarification. What I meant is
that we can extend the current 32-bit version of struct semid64_ds
and the others on arm32, and in the same way extend compat_semid64_ds
on arm64, but you cannot use that on arm64-ilp32 for other reasons.


The solution here is to redefine the normal arm64 semid64_ds so ilp32
see a structure with the same layout as lp64, and then use sys_semctl()
for arm64-ilp32 but use compat_sys_semctl() for aarch32-compat.

The definition would be something like

#ifdef __LP64__
#include <asm-generic/sembuf.h>
#else
struct semid64_ds {
        struct ipc64_perm sem_perm;     /* permissions .. see ipc.h */
        __kernel_time_t sem_otime;      /* last semop time */
        __kernel_time_t sem_ctime;      /* last change time */
        __u64		sem_nsems;      /* no. of semaphores in array */
        __u64 		__unused3;
        __u64		__unused4;
};
#endif

Alternatively, we could use the same definition for both lp64 and ilp32,
which would change the type mangling but not the binary structure.

	Arnd
