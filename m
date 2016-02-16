From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 16 Feb 2016 14:12:59 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <56C31D1D.50708@virtuozzo.com>
References: <20160212145844.GI31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-x6QPorWsPDP8bqAkmbasqzhqmP39HS=qprfGB4r8JLw@mail.gmail.com>
 <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com>
Message-ID: <20160216141258.GA8022@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 03:59:09PM +0300, Andrey Ryabinin wrote:
> 
> On 02/15/2016 09:59 PM, Catalin Marinas wrote:
> > On Mon, Feb 15, 2016 at 05:28:02PM +0300, Andrey Ryabinin wrote:
> >> On 02/12/2016 07:06 PM, Catalin Marinas wrote:
> >>> So far, we have:
> >>>
> >>> KASAN+for-next/kernmap goes wrong
> >>> KASAN+UBSAN goes wrong
> >>>
> >>> Enabled individually, KASAN, UBSAN and for-next/kernmap seem fine. I may
> >>> have to trim for-next/core down until we figure out where the problem
> >>> is.
> >>>
> >>> BUG: KASAN: stack-out-of-bounds in find_busiest_group+0x164/0x16a0 at addr ffffffc93665bc8c
> >>
> >> Can it be related to TLB conflicts, which supposed to be fixed in
> >> "arm64: kasan: avoid TLB conflicts" patch from "arm64: mm: rework page
> >> table creation" series ?
> > 
> > I can very easily reproduce this with a vanilla 4.5-rc1 series by
> > enabling inline instrumentation (maybe Mark's theory is true w.r.t.
> > image size).
> > 
> > Some information, maybe you can shed some light on this. It seems to
> > happen only for secondary CPUs on the swapper stack (I think allocated
> > via fork_idle()). The code generated looks sane to me, so KASAN should
> > not complain but maybe there is some uninitialised shadow, hence the
> > error.
> > 
> > The report:
> >
> 
> Actually, the first report is a bit more useful. It shows that shadow memory was corrupted:
> 
>   ffffffc93665bc00: f1 f1 f1 f1 00 f4 f4 f4 f2 f2 f2 f2 00 00 f1 f1
> > ffffffc93665bc80: f1 f1 00 00 00 00 f3 f3 00 f4 f4 f4 f3 f3 f3 f3
>                       ^
> F1 - left redzone, it indicates start of stack frame
> F3 - right redzone, it should be the end of stack frame.
> 
> But here we have the second set of F1s without F3s which should close the first set of F1s.
> Also those two F3s in the middle cannot be right.
> 
> So shadow is corrupted.
> Some hypotheses:
> 
> 1) We share stack between several tasks (e.g. stack overflow, somehow corrupted SP).
>     But this probably should cause kernel crash later, after kasan reports.
> 
> 2) Shadow memory wasn't cleared. GCC poison memory on function entrance and unpoisons it before return.
>      If we use some tricky way to exit from function this could cause false-positives like that.
>      E.g. some hand-written assembly return code.
> 
> 3) Screwed shadow mapping. I think the patch below should uncover such problem.
> It boot-tested on qemu and didn't show any problem

With that path applied I get:

[    0.000000] kasan: screwed shadow mapping 62184, 62182
[    0.000000] kasan: KernelAddressSanitizer initialized

I'm using v4.5-rc1 with KASAN_INLINE, and a random collection of debug options
to bloat the kernel per prior theory that the text size had somethign to do
with the issue.

Later in the boot process I see lots of failures like:

[   13.292190] ==================================================================
[   13.299543] BUG: KASAN: stack-out-of-bounds in find_busiest_group+0x1950/0x19b8 at addr ffffffc936ad3c8c
[   13.309090] Read of size 4 by task swapper/3/0
[   13.313575] page:ffffffbde6dab4c0 count:0 mapcount:0 mapping:          (null) index:0x0
[   13.321657] flags: 0x4000000000000000()
[   13.325539] page dumped because: kasan: bad access detected
[   13.331150] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.5.0-rc1+ #19
[   13.337528] Hardware name: ARM Juno development board (r1) (DT)
[   13.343471] Call trace:
[   13.345978] [<ffffffc000091400>] dump_backtrace+0x0/0x3c0
[   13.351416] [<ffffffc0000917e4>] show_stack+0x24/0x30
[   13.356507] [<ffffffc0008c3a64>] dump_stack+0xc4/0x150
[   13.361685] [<ffffffc0004032bc>] kasan_report_error+0x52c/0x558
[   13.367640] [<ffffffc0004033fc>] __asan_report_load4_noabort+0x54/0x60
[   13.374200] [<ffffffc0001a46e8>] find_busiest_group+0x1950/0x19b8
[   13.380327] [<ffffffc0001a49ec>] load_balance+0x29c/0x19e0
[   13.385851] [<ffffffc0001a67c0>] pick_next_task_fair+0x690/0xd88
[   13.391896] [<ffffffc001213cf4>] __schedule+0x85c/0x13c8
[   13.397248] [<ffffffc001214d7c>] schedule+0xe4/0x228
[   13.402256] [<ffffffc00121549c>] schedule_preempt_disabled+0x24/0xb8
[   13.408642] [<ffffffc0001b97f8>] cpu_startup_entry+0x188/0x738
[   13.414511] [<ffffffc00009bcfc>] secondary_start_kernel+0x244/0x2b8
[   13.420806] [<0000000080082efc>] 0x80082efc
[   13.425023] Memory state around the buggy address:
[   13.429854]  ffffffc936ad3b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   13.437153]  ffffffc936ad3c00: 00 00 00 00 00 00 f1 f1 f1 f1 f1 f1 00 00 f3 f3
[   13.444451] >ffffffc936ad3c80: f3 f3 00 00 00 00 00 00 00 f4 f4 f4 f3 f3 f3 f3
[   13.451742]                       ^
[   13.455274]  ffffffc936ad3d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   13.462572]  ffffffc936ad3d80: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
[   13.469863] ==================================================================

I guess memroy layout has something to do with this. FWIW on this board my
memory map comes from EFI:

[    0.000000] Processing EFI memory map:
[    0.000000]   0x000008000000-0x00000bffffff [Memory Mapped I/O  |RUN|  |XP|  |  |  |   |  |  |  |UC]
[    0.000000]   0x00001c170000-0x00001c170fff [Memory Mapped I/O  |RUN|  |XP|  |  |  |   |  |  |  |UC]
[    0.000000]   0x000080000000-0x00008000ffff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x000080010000-0x00008007ffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x000080080000-0x000081dbffff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x000081dc0000-0x00009fdfffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x00009fe00000-0x00009fe0ffff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x00009fe10000-0x0000dfffffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000e00f0000-0x0000f5a58fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000f5a59000-0x0000f7793fff [Loader Code        |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000f7794000-0x0000f9431fff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000f9432000-0x0000f944ffff [Loader Code        |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000f9450000-0x0000f945ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9460000-0x0000f94dffff [ACPI Reclaim Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f94e0000-0x0000f94effff [ACPI Memory NVS    |   |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f94f0000-0x0000f94fffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9500000-0x0000f950ffff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9510000-0x0000f953ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9540000-0x0000f954ffff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9550000-0x0000f956ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9570000-0x0000f958ffff [ACPI Reclaim Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9590000-0x0000f960ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9610000-0x0000f961ffff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9620000-0x0000f96effff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f96f0000-0x0000f96fffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9700000-0x0000f970ffff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9710000-0x0000f974ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9750000-0x0000f975ffff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9760000-0x0000f97cffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f97d0000-0x0000f97dffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f97e0000-0x0000f97effff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
[    0.000000]   0x0000f97f0000-0x0000f981ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f9820000-0x0000f9820fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000f9821000-0x0000f9827fff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000f9828000-0x0000f982bfff [Reserved           |   |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000f982c000-0x0000fdaedfff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fdaee000-0x0000fdfbefff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fdfbf000-0x0000fdfbffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fdfc0000-0x0000fdffbfff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fdffc000-0x0000fe018fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe019000-0x0000fe020fff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe021000-0x0000fe022fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe023000-0x0000fe02bfff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe02c000-0x0000fe03afff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe03b000-0x0000fe03dfff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe03e000-0x0000fe04efff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe04f000-0x0000fe057fff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe058000-0x0000fe073fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe074000-0x0000fe074fff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe075000-0x0000fe078fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe079000-0x0000fe07bfff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe07c000-0x0000fe07dfff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe07e000-0x0000fe085fff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe086000-0x0000fe087fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe088000-0x0000fe171fff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe172000-0x0000fe198fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe199000-0x0000fe65ffff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe660000-0x0000fe6a2fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe6a3000-0x0000fe7effff [Boot Code          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe7f0000-0x0000fe7fffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000fe800000-0x0000fe80ffff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
[    0.000000]   0x0000fe810000-0x0000fe82ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000fe830000-0x0000fe83ffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe840000-0x0000fe88ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
[    0.000000]   0x0000fe890000-0x0000fe891fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x0000fe892000-0x0000feffffff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x000880000000-0x00099bffffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000]   0x00099c000000-0x0009ffffffff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]

Thanks,
Mark.
