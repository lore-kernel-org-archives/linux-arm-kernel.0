From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 2 Jun 2016 22:03:44 +0300
Subject: [PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20160602190344.GA24533@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 03:04:29AM +0300, Yury Norov wrote:
> This series enables aarch64 with ilp32 mode, and as supporting work,
> introduces compat wrappers based on s390 solution, and also introduces
> ARCH_32BIT_OFF_T configuration option that is enabled for existing
> 32-bit architectures but disabled for new arches (so 64-bit off_t is 
> is used by new userspace).
> 
> This version is based on kernel v4.6.
> It works with glibc-2.23, and tested with LTP.
> 
> It was tested on QEMU and ThunderX machines. No major differences found.
> 
> This is not RFC anymore, because ILP32 is now tested in big-endian mode;
> signals, vDSO and other subsystems are tested, and look working
> 
>  v3: https://lkml.org/lkml/2014/9/3/704
>  v4: https://lkml.org/lkml/2015/4/13/691
>  v5: https://lkml.org/lkml/2015/9/29/911
>  v6: ABI reworked significantly;
>     - syscall input arguments are deloused with compat wrappers;
>     - vDSO is now working for both BE and LE;
>     - signal subsystem is reworked to handle signal context properly;
>     - binfmt_elf is reworked, and now most of places where execution mode
>       should be detected, are handled statically;
>     - many other less-important fixes.
> 
> ILP32 glibc branch is available here:
> https://github.com/norov/glibc/tree/ilp32-2.23
> 

So for AARCH64/ILP32 we turn next types to 64-bit in glibc:
#define __INO_T_TYPE            __UQUAD_TYPE
#define __OFF_T_TYPE            __SQUAD_TYPE
#define __BLKCNT_T_TYPE         __SQUAD_TYPE
#define __FSBLKCNT_T_TYPE       __UQUAD_TYPE
#define __FSFILCNT_T_TYPE       __UQUAD_TYPE

And define:
# define __INO_T_MATCHES_INO64_T                1
# define __OFF_T_MATCHES_OFF64_T                1
# define __BLKCNT_T_MATCHES_BLKCNT64_T          1
# define __FSBLKCNT_T_MATCHES_FSBLKCNT64_T      1
# define __FSFILCNT_T_MATCHES_FSFILCNT_T        1

If so, stat and statfs  structures for ilp32 are turning the same as
for lp64. And so we'd handle related syscalls with native lp64
handlers (wrapped, to zero top halves) in kernel. 

And we don't need stat64 for ilp32.

Did I miss something? Is everything correct?

OFF_T is turned to 64-bit quite smoothly, others make applications
crash with segfault. Now I'm in deep debugging.

https://github.com/norov/glibc/commits/ilp32-dev
https://github.com/norov/linux/commits/ilp32

Yury.
