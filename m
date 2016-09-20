From: panand@redhat.com (Pratyush Anand)
Date: Tue, 20 Sep 2016 08:21:04 +0530
Subject: [PATCH 0/5] ARM64: Uprobe support added
In-Reply-To: <20160824072622.GB24311@localhost.localdomain>
References: <cover.1470114993.git.panand@redhat.com>
 <20160824072622.GB24311@localhost.localdomain>
Message-ID: <CAHB_GuqgV2bWX_LQnWuTdY2uZ8y6H9Z5CMWMQS6SdpXCh7ghiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will/Catalin,

So far there is no comment which would require any modification in
this patch set. However, a rebase would be required, because we have a
fixup "arm64: Improve kprobes test for atomic sequence" in the next
now. Also, since we have "arm64: kprobe: Always clear pstate.D in
breakpoint exception handler" in next, so I can remove __kprobes tag
from uprobe_breakpoint_handler() and uprobe_single_step_handler().

Do you think that these patches are good to be taken for 4.9? If yes,
then I will send a quick V2 with above modifications.

~Pratyush


On Wed, Aug 24, 2016 at 12:56 PM, Pratyush Anand <panand@redhat.com> wrote:
> Hi Will/Catalin,
>
> Do you have any specific comment for this patch set?
>
> ~Pratyush
>
> [1] https://lkml.org/lkml/2016/8/22/69
>
> On 02/08/2016:11:00:04 AM, Pratyush Anand wrote:
>> ARM64 kprobe support is lying in torvalds/linux.git:master now. Therefore
>> sending my uprobe patches which were dependent on decode-insn code of kprobe
>> patches.
>>
>> Unit tests for following have been done so far and they have been found
>> working.
>>      1. Step-able instructions, like sub, ldr, add etc.
>>      2. Simulation-able like ret, cbnz, cbz etc.
>>      3. uretprobe
>>      4. Reject-able instructions like sev, wfe etc.
>>      5. trapped and abort xol path
>>      6. probe at unaligned user address.
>>      7. longjump test cases
>>
>> Currently it does not support aarch32 instruction probing.
>>
>> RFC patches were sent long back, and all review comments for RFCs have been
>> incorporated. RFCs were here: https://lwn.net/Articles/648514/
>>
>> Pratyush Anand (5):
>>   arm64: kprobe: protect/rename few definitions to be reused by uprobe
>>   arm64: kgdb_step_brk_fn: ignore other's exception
>>   arm64: Handle TRAP_HWBRKPT for user mode as well
>>   arm64: Handle TRAP_BRKPT for user mode as well
>>   arm64: Add uprobe support
>>
>>  arch/arm64/Kconfig                      |   3 +
>>  arch/arm64/include/asm/debug-monitors.h |   3 +
>>  arch/arm64/include/asm/probes.h         |  23 ++--
>>  arch/arm64/include/asm/ptrace.h         |   8 ++
>>  arch/arm64/include/asm/thread_info.h    |   5 +-
>>  arch/arm64/include/asm/uprobes.h        |  37 ++++++
>>  arch/arm64/kernel/debug-monitors.c      |  40 +++---
>>  arch/arm64/kernel/entry.S               |   6 +-
>>  arch/arm64/kernel/kgdb.c                |   3 +
>>  arch/arm64/kernel/probes/Makefile       |   2 +
>>  arch/arm64/kernel/probes/decode-insn.c  |  31 ++---
>>  arch/arm64/kernel/probes/decode-insn.h  |   8 +-
>>  arch/arm64/kernel/probes/kprobes.c      |  36 ++---
>>  arch/arm64/kernel/probes/uprobes.c      | 227 ++++++++++++++++++++++++++++++++
>>  arch/arm64/kernel/signal.c              |   4 +-
>>  arch/arm64/mm/flush.c                   |   6 +
>>  16 files changed, 378 insertions(+), 64 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/uprobes.h
>>  create mode 100644 arch/arm64/kernel/probes/uprobes.c
>>
>> --
>> 2.5.5
