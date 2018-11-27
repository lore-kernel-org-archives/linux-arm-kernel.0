From: vineet.gupta1@synopsys.com (Vineet Gupta)
Date: Tue, 27 Nov 2018 17:06:10 +0000
Subject: 'branches' perf event mapping differs on ARC and ARM
References: <1543329386.13651.13.camel@synopsys.com>
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501464172A6@US01WEMBX2.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/18 6:36 AM, Eugeniy Paltsev wrote:
> Hi,
>
> While playing with perf tool on ARMv7 and ARCv2 processors and profiling the
> same application I got interesting results. Even if we got pretty
> similar total
> execution time and instructions number the number of branches on ARC is about
> three times more then on ARM.
>
> I dug into architecture
> specific perf sources and found that we map different
> HW counters into generic 'branches' event on ARC and ARM.
> - We use "ijmp" event on ARC which
> counts all jump and branch instructions (regardless
> of real execution flow - even if no real jump happens)

That doesn't seem correct IMO. A NOT taken conditional branch doesn't change
control flow, so semantically doesn't qualify as a branch.
On ARC, the generic branches event should be mapped to "actually taken branches"
condition i.e.  ijmptak


> - We use "pc_write_retired" event on ARM
> which counts only taken branches (Instruction
> architecturally executed, condition check pass - software change of the PC)

That seems correct.

> I guess counting all jump and branch instructions is correct because we use
> 'branches' event value to calculate relative value of 'branch-misses' using
>
> following formula:
> ----------------------------8----------------------------
> branch-misses-ration = 'branch-misses' / 'branches' * 100.0
> ----------------
> ------------8----------------------------
> And using only taken branches here is incorrect IMHO.

Why ? branch-misses is a CPU specific micro-arch state where the a changed control
flow was NOT predicted. If an implementation mispredicts NOT taken branches, those
should actually get counted and be fed to hardware folks to improve the micro-arch.


>  So I guess we should
> map 'br_immed_retired' instead of
> "pc_write_retired" into generic 'branches'
> event on ARM.
