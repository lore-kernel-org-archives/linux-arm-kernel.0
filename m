From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 27 Nov 2018 15:28:25 +0000
Subject: 'branches' perf event mapping differs on ARC and ARM
In-Reply-To: <1543329386.13651.13.camel@synopsys.com>
References: <1543329386.13651.13.camel@synopsys.com>
Message-ID: <48cfcbf3-0084-7b17-f30d-371bbb5cbdde@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/2018 14:36, Eugeniy Paltsev wrote:
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
> - We use "pc_write_retired" event on ARM
> which counts only taken branches (Instruction
> architecturally executed, condition check pass - software change of the PC)
> 
> So I was wondering do you know
> which approach is correct?
> 
> 
> 
> I guess counting all jump and branch instructions is correct because we use
> 'branches' event value to calculate relative value of 'branch-misses' using
> 
> following formula:
> ----------------------------8----------------------------
> branch-misses-ration = 'branch-misses' / 'branches' * 100.0
> ----------------
> ------------8----------------------------
> And using only taken branches here is incorrect IMHO. So I guess we should
> map 'br_immed_retired' instead of
> "pc_write_retired" into generic 'branches'
> event on ARM.

But register branches (including procedure returns) are also branches, 
so only counting immediate branches would be just as, if not more, 
misleading.

Robin.
