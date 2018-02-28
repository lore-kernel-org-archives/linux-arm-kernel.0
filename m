From: andreyknvl@google.com (Andrey Konovalov)
Date: Wed, 28 Feb 2018 20:32:48 +0100
Subject: Clang build of arm64 kernel fails
Message-ID: <CAAeHK+wRcZ1o53CEpeOQ-J5AayVAd8nm-ASj8HsTy1vOzHQAqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc!

I've tried to pull in new upstream commits and the kernel build
started failing for me with the following errors (see below).

It seems that the reason is your commit "arm64: Add
ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support". It seems that Clang
doesn't like 32 bits registers being used in 64 bits build.

Would you mind sending a fix?

Thanks!

arch/arm64/kernel/cpu_errata.c:156:2: error: unknown register name 'r0' in asm
        arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
        ^
./include/linux/arm-smccc.h:276:32: note: expanded from macro
'arm_smccc_1_1_smc'
#define arm_smccc_1_1_smc(...)  __arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
                                ^
./include/linux/arm-smccc.h:255:3: note: expanded from macro '__arm_smccc_1_1'
                __declare_args(__count_args(__VA_ARGS__), __VA_ARGS__); \
                ^
./include/linux/arm-smccc.h:240:37: note: expanded from macro '__declare_args'
#define __declare_args(count, ...)  ___declare_args(count, __VA_ARGS__)
                                    ^
./include/linux/arm-smccc.h:239:37: note: expanded from macro '___declare_args'
#define ___declare_args(count, ...) __declare_arg_ ## count(__VA_ARGS__)
                                    ^
<scratch space>:136:1: note: expanded from here
__declare_arg_0
^
./include/linux/arm-smccc.h:197:32: note: expanded from macro '__declare_arg_0'
        register u32           r0 asm("r0") = a0;
