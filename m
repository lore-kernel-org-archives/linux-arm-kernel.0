From: szabolcs.nagy@arm.com (Szabolcs Nagy)
Date: Fri, 3 Jun 2016 12:02:50 +0100
Subject: [PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <20160602190344.GA24533@yury-N73SV>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <20160602190344.GA24533@yury-N73SV>
Message-ID: <575163DA.3060502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/16 20:03, Yury Norov wrote:
> On Tue, May 24, 2016 at 03:04:29AM +0300, Yury Norov wrote:
>> ILP32 glibc branch is available here:
>> https://github.com/norov/glibc/tree/ilp32-2.23
>>
> 
> So for AARCH64/ILP32 we turn next types to 64-bit in glibc:
> #define __INO_T_TYPE            __UQUAD_TYPE
> #define __OFF_T_TYPE            __SQUAD_TYPE
> #define __BLKCNT_T_TYPE         __SQUAD_TYPE
> #define __FSBLKCNT_T_TYPE       __UQUAD_TYPE
> #define __FSFILCNT_T_TYPE       __UQUAD_TYPE
> 
> And define:
> # define __INO_T_MATCHES_INO64_T                1
> # define __OFF_T_MATCHES_OFF64_T                1
> # define __BLKCNT_T_MATCHES_BLKCNT64_T          1
> # define __FSBLKCNT_T_MATCHES_FSBLKCNT64_T      1
> # define __FSFILCNT_T_MATCHES_FSFILCNT_T        1
> 
> If so, stat and statfs  structures for ilp32 are turning the same as
> for lp64. And so we'd handle related syscalls with native lp64
> handlers (wrapped, to zero top halves) in kernel. 
> 
> And we don't need stat64 for ilp32.
> 
> Did I miss something? Is everything correct?
> 
> OFF_T is turned to 64-bit quite smoothly, others make applications
> crash with segfault. Now I'm in deep debugging.
> 

based on previous discussions, non-trivial glibc changes may
be needed to make 64bit fs apis the default on a 32bit abi.
http://sourceware.org/ml/libc-alpha/2016-05/msg00337.html
http://sourceware.org/ml/libc-alpha/2016-05/msg00356.html

but i guess if you consistently fix the 32bit assumptions
then it should work.

> https://github.com/norov/glibc/commits/ilp32-dev
> https://github.com/norov/linux/commits/ilp32
> 
> Yury.
> 
