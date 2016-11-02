From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Nov 2016 23:28:54 +0000
Subject: arm64 build failure with CONFIG_ARM64_LSE_ATOMICS=y
In-Reply-To: <20161102164427.GB24243@shodan.usersys.redhat.com>
References: <20161102164427.GB24243@shodan.usersys.redhat.com>
Message-ID: <20161102232854.GO22791@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem,

On Wed, Nov 02, 2016 at 05:44:27PM +0100, Artem Savkov wrote:
> Hello Catalin,
> 
> Looks like your patch "efd9e03 arm64: Use static keys for CPU features"
> breaks arm64 build with "CONFIG_ARM64_LSE_ATOMICS=y" because it creates a
> circular dependency for asm/lse.h through jump_label.h:
> 
>   CC      arch/arm64/kernel/asm-offsets.s
> In file included from ./arch/arm64/include/asm/atomic.h:34:0,
>                  from ./include/linux/atomic.h:4,
>                  from ./include/linux/jump_label.h:169,
>                  from ./arch/arm64/include/asm/cpufeature.h:12,
>                  from ./arch/arm64/include/asm/alternative.h:4,
>                  from ./arch/arm64/include/asm/lse.h:7,
>                  from ./arch/arm64/include/asm/spinlock.h:19,
>                  from ./include/linux/spinlock.h:87,
>                  from ./include/linux/seqlock.h:35,
>                  from ./include/linux/time.h:5,
>                  from ./include/uapi/linux/timex.h:56,
>                  from ./include/linux/timex.h:56,
>                  from ./include/linux/sched.h:19,
>                  from arch/arm64/kernel/asm-offsets.c:21:
> ./arch/arm64/include/asm/atomic_lse.h: In function ?atomic_andnot?:
> ./arch/arm64/include/asm/atomic_lse.h:35:15: error: expected string literal before ?ARM64_LSE_ATOMIC_INSN?
>   asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(op),  \
> 
> ...
> 
> ./arch/arm64/include/asm/cmpxchg.h: In function ?__xchg_case_1?:
> ./arch/arm64/include/asm/cmpxchg.h:38:15: error: expected string literal before ?ARM64_LSE_ATOMIC_INSN?
>   asm volatile(ARM64_LSE_ATOMIC_INSN(    \

I'm unable to reproduce this. I've tried enabling LSE with defconfig and
mainline, using compilers that both do and don't support the instructions.

What am I missing?

Will
