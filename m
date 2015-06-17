From: dave.long@linaro.org (David Long)
Date: Wed, 17 Jun 2015 14:51:04 -0400
Subject: [PATCH v7 0/7] arm64: Add kernel probes (kprobes) support
In-Reply-To: <558181C2.6020500@hitachi.com>
References: <1434395229-6654-1-git-send-email-dave.long@linaro.org>
 <558181C2.6020500@hitachi.com>
Message-ID: <5581C198.1040802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/15 10:18, Masami Hiramatsu wrote:
> Hi David,
>
> At first, thank you for updating this series! :)
>
> On 2015/06/16 4:07, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches,
>> first seen in October 2013. This version attempts to address concerns raised by
>> reviewers and also fixes problems discovered during testing.
>>
>> This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
>> and return probes(kretprobes) support for ARM64.
>>
>> The kprobes mechanism makes use of software breakpoint and single stepping
>> support available in the ARM v8 kernel.
>>
>> The is patch depends on:
>> 	[PATCH 1/2] Move the pt_regs_offset struct definition from arch to common include file
>> 	[PATCH 2/2] Consolidate redundant register/stack access code
>>
>
> Hmm, what are those patches ? Would they be not merged to upstream yet?
> If so, where I can get them from? I'd like to know the actual url for them.
>

These patches were sent out to the kernel mailing lists shortly before 
the kprobes64 patch.  Until such time as they are accepted upstream they 
can also be found on the "kprobes64-v7" branch of my personal git repo at:

https://git.linaro.org/people/dave.long/linux.git

as commits:

3ce7d917bef3aee9fff70252d83e65f1cc7f909b
03f4bece51a068f4e1dac8813a57feeccfa24c26


Since I'm not planning on keeping that branch around forever I did not 
include that info in the cover-letter email.  Please advise if there is 
a better way to record dependencies like this.

>
> [...]
>> Changes since v6 include:
>>
>> 1) New trampoline code from Will Cohen fixes the occasional failure seen
>> when processing kretprobes by replacing the software breakpoint with
>> assembly code to implement the return to the original execution stream.
>
> Yeah, that's what we need :)
>
> Thank you,
>

You're welcome :-)

>> 2) Changed ip0, ip1, fp, and lr to plain numbered registers for purposes
>> of recognizing them as an ascii string in the stack/reg access code.
>> 3) Removed orig_x0.
>> 4) Moved ARM_x* defines from arch/arm64/include/uapi/asm/ptrace.h to
>> arch/arm64/kernel/ptrace.c.
>>
>> David A. Long (2):
>>    arm64: Add HAVE_REGS_AND_STACK_ACCESS_API feature
>>    arm64: Add more test functions to insn.c
>>
>> Sandeepa Prabhu (4):
>>    arm64: Kprobes with single stepping support
>>    arm64: kprobes instruction simulation support
>>    arm64: Add kernel return probes support (kretprobes)
>>    kprobes: Add arm64 case in kprobe example module
>>
>> William Cohen (1):
>>    arm64: Add trampoline code for kretprobes
>>
>>   arch/arm64/Kconfig                       |   3 +
>>   arch/arm64/include/asm/debug-monitors.h  |   5 +
>>   arch/arm64/include/asm/insn.h            |  18 +
>>   arch/arm64/include/asm/kprobes.h         |  63 +++
>>   arch/arm64/include/asm/probes.h          |  50 +++
>>   arch/arm64/include/asm/ptrace.h          |  28 +-
>>   arch/arm64/kernel/Makefile               |   3 +
>>   arch/arm64/kernel/debug-monitors.c       |  35 +-
>>   arch/arm64/kernel/insn.c                 |  28 ++
>>   arch/arm64/kernel/kprobes-arm64.c        | 166 ++++++++
>>   arch/arm64/kernel/kprobes-arm64.h        |  71 ++++
>>   arch/arm64/kernel/kprobes.c              | 665 +++++++++++++++++++++++++++++++
>>   arch/arm64/kernel/kprobes.h              |  24 ++
>>   arch/arm64/kernel/probes-condn-check.c   | 122 ++++++
>>   arch/arm64/kernel/probes-simulate-insn.c | 174 ++++++++
>>   arch/arm64/kernel/probes-simulate-insn.h |  33 ++
>>   arch/arm64/kernel/ptrace.c               |  77 ++++
>>   arch/arm64/kernel/vmlinux.lds.S          |   1 +
>>   arch/arm64/mm/fault.c                    |  25 ++
>>   samples/kprobes/kprobe_example.c         |   8 +
>>   20 files changed, 1588 insertions(+), 11 deletions(-)
>>   create mode 100644 arch/arm64/include/asm/kprobes.h
>>   create mode 100644 arch/arm64/include/asm/probes.h
>>   create mode 100644 arch/arm64/kernel/kprobes-arm64.c
>>   create mode 100644 arch/arm64/kernel/kprobes-arm64.h
>>   create mode 100644 arch/arm64/kernel/kprobes.c
>>   create mode 100644 arch/arm64/kernel/kprobes.h
>>   create mode 100644 arch/arm64/kernel/probes-condn-check.c
>>   create mode 100644 arch/arm64/kernel/probes-simulate-insn.c
>>   create mode 100644 arch/arm64/kernel/probes-simulate-insn.h
>>
>
>
