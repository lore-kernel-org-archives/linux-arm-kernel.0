From: asavkov@redhat.com (Artem Savkov)
Date: Wed, 2 Nov 2016 17:44:27 +0100
Subject: arm64 build failure with CONFIG_ARM64_LSE_ATOMICS=y
Message-ID: <20161102164427.GB24243@shodan.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

Looks like your patch "efd9e03 arm64: Use static keys for CPU features"
breaks arm64 build with "CONFIG_ARM64_LSE_ATOMICS=y" because it creates a
circular dependency for asm/lse.h through jump_label.h:

  CC      arch/arm64/kernel/asm-offsets.s
In file included from ./arch/arm64/include/asm/atomic.h:34:0,
                 from ./include/linux/atomic.h:4,
                 from ./include/linux/jump_label.h:169,
                 from ./arch/arm64/include/asm/cpufeature.h:12,
                 from ./arch/arm64/include/asm/alternative.h:4,
                 from ./arch/arm64/include/asm/lse.h:7,
                 from ./arch/arm64/include/asm/spinlock.h:19,
                 from ./include/linux/spinlock.h:87,
                 from ./include/linux/seqlock.h:35,
                 from ./include/linux/time.h:5,
                 from ./include/uapi/linux/timex.h:56,
                 from ./include/linux/timex.h:56,
                 from ./include/linux/sched.h:19,
                 from arch/arm64/kernel/asm-offsets.c:21:
./arch/arm64/include/asm/atomic_lse.h: In function ?atomic_andnot?:
./arch/arm64/include/asm/atomic_lse.h:35:15: error: expected string literal before ?ARM64_LSE_ATOMIC_INSN?
  asm volatile(ARM64_LSE_ATOMIC_INSN(__LL_SC_ATOMIC(op),  \

...

./arch/arm64/include/asm/cmpxchg.h: In function ?__xchg_case_1?:
./arch/arm64/include/asm/cmpxchg.h:38:15: error: expected string literal before ?ARM64_LSE_ATOMIC_INSN?
  asm volatile(ARM64_LSE_ATOMIC_INSN(    \

-- 
Regards,
  Artem
