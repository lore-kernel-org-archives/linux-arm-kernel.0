From: maddy@linux.vnet.ibm.com (Madhavan Srinivasan)
Date: Fri, 6 Nov 2015 13:03:10 +0530
Subject: [RFC PATCH 0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
In-Reply-To: <CAMsRxfJLLV9pOr3iL8KXqVPk0dk3t_fkueW-9WHf6WiyP6DHrA@mail.gmail.com>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
 <CAMsRxfJLLV9pOr3iL8KXqVPk0dk3t_fkueW-9WHf6WiyP6DHrA@mail.gmail.com>
Message-ID: <563C57B6.8040606@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 05 November 2015 08:12 PM, Stephane Eranian wrote:
> Hi,
>
> On Wed, Nov 4, 2015 at 9:46 PM, Madhavan Srinivasan
> <maddy@linux.vnet.ibm.com> wrote:
>> This patchset extend the perf sample regs infrastructure
>> to include architecture specific regs. Current perf_sample_regs_intr
>> exports only registers in the pt_regs to perf.data using
>> PERF_SAMPLE_REGS_INTR sample type. But sometimes we end up looking
>> for or prefer raw register values at the interrupt during debug.
>>
> I don't quite understand this explanation here.
> What do you mean by raw register values?
> The content of pt_regs is also raw register values at interrupt.

Was out and did not have access to mail, so missed to respond in time.

Yes. that is right. My bad. Did not effectively communicate
what I intended. Intend here is to capture more data related to
pmu context for the sample.

And in case of arch/powerpc, only a subset of pmu regs are
in the pt_regs structure. By adding these  additional pmu registers
(which are not part of pt_regs and i dont intend to overload
pt_regs struct with these regs, since it is not relevant to ptrace),
more interesting data about the PMU and its context is captured
for the sample.

> The API does not say that the content of perf_sample_regs_intr can ONLY
> contain names of registers coming from pt_regs. The meaning of each bit
> is arch specific and you are free to map to whatever is relevant for your arch.
> All the API says is that the values captured in the sampling buffer for these
> registers are taken at PMU interrupt.
Yes thats right. But what I propose here to include an
arch specific struct in the perf_regs, so that more register values
can be fetched as part of perf_sample_regs_intr without
extending pt_regs.

Maddy

>> This patchset extends the perf_regs to include arch specific struct,
>> and makes perf_sample_regs_intr in kernel/event/core.c as __weak__
>> function. This way, an arch specific implementation of
>> perf_sample_regs_intr() can update the arch specific data to
>> the perf_regs.
>>
>> First patch defines a new structure arch_misc_reg and updates the same
>> in the struct perf_regs. Patch also modifies the perf_reg_value()
>> and perf_output_sample_regs() to take perf_regs parameter instead of pt_regs.
>>
>> Second patch updates struct arch_misc_reg for arch/powerpc with pmu registers
>> and adds offsetof macro for the same. It extends perf_reg_value()
>> to use reg idx to decide on struct to return value from.
>>
>> Third patch adds arch specific perf_sample_regs_intr() in arch/powerpc
>> to hook up the arch_misc_regs to perf_regs.
>>
>> This patchset depends on the recent posting by Anju T in
>> linuxppc-dev at lists.ozlabs.org to enable PERF_SAMPLE_REGS_INTR
>> support in arch/powerpc.
>>
>> https://patchwork.ozlabs.org/patch/539242/
>> https://patchwork.ozlabs.org/patch/539243/
>> https://patchwork.ozlabs.org/patch/539244/
>>
>> Would appreciate comments and feedback.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Stephane Eranian <eranian@gmail.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>>
>> Madhavan Srinivasan (3):
>>   perf/core: extend perf_regs to include arch specific regs
>>   perf/powerpc: update macros and add regs to arch_misc_reg struct
>>   perf/powerpc: Functions to update arch_misc_regs
>>
>>  arch/arm/include/asm/ptrace.h               |  2 ++
>>  arch/arm/kernel/perf_regs.c                 |  4 +++-
>>  arch/arm64/include/asm/ptrace.h             |  2 ++
>>  arch/arm64/kernel/perf_regs.c               |  4 +++-
>>  arch/powerpc/include/uapi/asm/perf_regs.h   | 10 ++++++++++
>>  arch/powerpc/include/uapi/asm/ptrace.h      | 11 +++++++++++
>>  arch/powerpc/perf/core-book3s.c             | 29 +++++++++++++++++++++++++++++
>>  arch/powerpc/perf/perf_regs.c               | 28 ++++++++++++++++++++++++++--
>>  arch/x86/include/asm/ptrace.h               |  2 ++
>>  arch/x86/kernel/perf_regs.c                 |  4 +++-
>>  include/linux/perf_regs.h                   |  5 +++--
>>  kernel/events/core.c                        |  8 ++++----
>>  tools/perf/arch/powerpc/include/perf_regs.h | 16 ++++++++++++++++
>>  13 files changed, 114 insertions(+), 11 deletions(-)
>>
>> --
>> 1.9.1
>>
