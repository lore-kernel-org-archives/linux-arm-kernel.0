From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Mar 2014 11:00:02 +0000
Subject: [PATCH v3] ARM: vDSO gettimeofday using generic timer architecture
In-Reply-To: <1393813295-27376-1-git-send-email-nathan_lynch@mentor.com>
References: <1393813295-27376-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140303110001.GB8554@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nathan,

On Mon, Mar 03, 2014 at 02:21:35AM +0000, Nathan Lynch wrote:
> Provide fast userspace implementations of gettimeofday and
> clock_gettime on systems that implement the generic timers extension
> defined in ARMv7.  This follows the example of arm64 in conception but
> significantly differs in some aspects of the implementation (C vs
> assembly, mainly).
> 
> Clocks supported:
> - CLOCK_REALTIME
> - CLOCK_MONOTONIC
> - CLOCK_REALTIME_COARSE
> - CLOCK_MONOTONIC_COARSE
> 
> This also provides clock_getres (as arm64 does).
> 
> Note that while the high-precision realtime and monotonic clock
> support depends on the generic timers extension, support for
> clock_getres and coarse clocks is independent of the timer
> implementation and is provided unconditionally.
> 
> Run-time tested on OMAP5 and i.MX6 using a patched glibc[1], verifying
> that results from the vDSO are consistent with results from the
> kernel.  Build-tested against arch/arm/configs/*_defconfig with GCC
> 4.4 and 4.8.  Build-tested with multi_v7_defconfig with GCC 4.[4-8].
> 
> [1] RFC glibc patch here:
> https://www.sourceware.org/ml/libc-alpha/2014-02/msg00680.html
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---
> 
> Changes since v2:
> - Update to 3.14-rc4.
> - Make vDSO configurable, depending on AEABI and MMU.
> - Defer shifting of nanosecond component of timespec: fixes observed
>   1ns inconsistencies for CLOCK_REALTIME, CLOCK_MONOTONIC (see
>   45a7905fc48f for arm64 equivalent).
> - Force reload of seq_count when spinning: without a memory clobber
>   after the load of vdata->seq_count, GCC can generate code like this:
>     2f8:   e59c9020        ldr     r9, [ip, #32]
>     2fc:   e3190001        tst     r9, #1
>     300:   1a000033        bne     3d4 <do_realtime+0x104>
>     304:   f57ff05b        dmb     ish
>     308:   e59c3034        ldr     r3, [ip, #52]   ; 0x34
>     ...
>     3d4:   eafffffe        b       3d4 <do_realtime+0x104>

Have you thought about using a seqlock instead? It looks like a drop-in
replacement for your seqcnt_* stuff.

Will
