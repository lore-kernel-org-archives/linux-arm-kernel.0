From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 16 Feb 2016 14:29:14 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <20160216141258.GA8022@leverpostej>
References: <CAKv+Gu-x6QPorWsPDP8bqAkmbasqzhqmP39HS=qprfGB4r8JLw@mail.gmail.com>
 <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com> <20160216141258.GA8022@leverpostej>
Message-ID: <20160216142914.GB8022@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 02:12:59PM +0000, Mark Rutland wrote:
> On Tue, Feb 16, 2016 at 03:59:09PM +0300, Andrey Ryabinin wrote:
> > So shadow is corrupted.
> > Some hypotheses:
> > 
> > 1) We share stack between several tasks (e.g. stack overflow, somehow corrupted SP).
> >     But this probably should cause kernel crash later, after kasan reports.
> > 
> > 2) Shadow memory wasn't cleared. GCC poison memory on function entrance and unpoisons it before return.
> >      If we use some tricky way to exit from function this could cause false-positives like that.
> >      E.g. some hand-written assembly return code.
> > 
> > 3) Screwed shadow mapping. I think the patch below should uncover such problem.
> > It boot-tested on qemu and didn't show any problem
> 
> With that path applied I get:
> 
> [    0.000000] kasan: screwed shadow mapping 62184, 62182
> [    0.000000] kasan: KernelAddressSanitizer initialized
> 
> I'm using v4.5-rc1 with KASAN_INLINE, and a random collection of debug options
> to bloat the kernel per prior theory that the text size had somethign to do
> with the issue.

I hacked kasan_init to dump info as it created each shadow region:

[    0.000000] kasan_init shadowing [ffffffc000000000-ffffffc060000000] @ [ffffff8800000000-ffffff880c000001] nid 0
[    0.000000] kasan_init shadowing [ffffffc0600f0000-ffffffc079450000] @ [ffffff880c01e000-ffffff880f28a001] nid 0
[    0.000000] kasan_init shadowing [ffffffc079450000-ffffffc079820000] @ [ffffff880f28a000-ffffff880f304001] nid 0
[    0.000000] kasan_init shadowing [ffffffc079820000-ffffffc079821000] @ [ffffff880f304000-ffffff880f304201] nid 0
[    0.000000] kasan_init shadowing [ffffffc079821000-ffffffc079822000] @ [ffffff880f304200-ffffff880f304401] nid 0
[    0.000000] kasan_init shadowing [ffffffc079822000-ffffffc079828000] @ [ffffff880f304400-ffffff880f305001] nid 0
[    0.000000] kasan_init shadowing [ffffffc079828000-ffffffc07982c000] @ [ffffff880f305000-ffffff880f305801] nid 0
[    0.000000] kasan_init shadowing [ffffffc07982c000-ffffffc07e7f0000] @ [ffffff880f305800-ffffff880fcfe001] nid 0
[    0.000000] kasan_init shadowing [ffffffc07e7f0000-ffffffc07e830000] @ [ffffff880fcfe000-ffffff880fd06001] nid 0
[    0.000000] kasan_init shadowing [ffffffc07e830000-ffffffc07e840000] @ [ffffff880fd06000-ffffff880fd08001] nid 0
[    0.000000] kasan_init shadowing [ffffffc07e840000-ffffffc07e890000] @ [ffffff880fd08000-ffffff880fd12001] nid 0
[    0.000000] kasan_init shadowing [ffffffc07e890000-ffffffc07f000000] @ [ffffff880fd12000-ffffff880fe00001] nid 0
[    0.000000] kasan_init shadowing [ffffffc800000000-ffffffc980000000] @ [ffffff8900000000-ffffff8930000001] nid 0
[    0.000000] kasan: screwed shadow mapping 62184, 62182
[    0.000000] kasan: KernelAddressSanitizer initialized

I note the the end of each shadow region overlaps the beginning of the next due
to the intentional end+1...

Other than the waste of memory (and the TLB conflict that gets solved by my
pgtable rework), I'm not sure though I'm not sure that's a problem, though.

Mark.

> I guess memroy layout has something to do with this. FWIW on this board my
> memory map comes from EFI:
> 
> [    0.000000] Processing EFI memory map:
> [    0.000000]   0x000008000000-0x00000bffffff [Memory Mapped I/O  |RUN|  |XP|  |  |  |   |  |  |  |UC]
> [    0.000000]   0x00001c170000-0x00001c170fff [Memory Mapped I/O  |RUN|  |XP|  |  |  |   |  |  |  |UC]
> [    0.000000]   0x000080000000-0x00008000ffff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x000080010000-0x00008007ffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x000080080000-0x000081dbffff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x000081dc0000-0x00009fdfffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x00009fe00000-0x00009fe0ffff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x00009fe10000-0x0000dfffffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000e00f0000-0x0000f5a58fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000f5a59000-0x0000f7793fff [Loader Code        |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000f7794000-0x0000f9431fff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000f9432000-0x0000f944ffff [Loader Code        |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000f9450000-0x0000f945ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9460000-0x0000f94dffff [ACPI Reclaim Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f94e0000-0x0000f94effff [ACPI Memory NVS    |   |  |  |  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f94f0000-0x0000f94fffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9500000-0x0000f950ffff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9510000-0x0000f953ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9540000-0x0000f954ffff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9550000-0x0000f956ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9570000-0x0000f958ffff [ACPI Reclaim Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9590000-0x0000f960ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9610000-0x0000f961ffff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9620000-0x0000f96effff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f96f0000-0x0000f96fffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9700000-0x0000f970ffff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9710000-0x0000f974ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9750000-0x0000f975ffff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9760000-0x0000f97cffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f97d0000-0x0000f97dffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f97e0000-0x0000f97effff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f97f0000-0x0000f981ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f9820000-0x0000f9820fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000f9821000-0x0000f9827fff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000f9828000-0x0000f982bfff [Reserved           |   |  |  |  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000f982c000-0x0000fdaedfff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fdaee000-0x0000fdfbefff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fdfbf000-0x0000fdfbffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fdfc0000-0x0000fdffbfff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fdffc000-0x0000fe018fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe019000-0x0000fe020fff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe021000-0x0000fe022fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe023000-0x0000fe02bfff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe02c000-0x0000fe03afff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe03b000-0x0000fe03dfff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe03e000-0x0000fe04efff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe04f000-0x0000fe057fff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe058000-0x0000fe073fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe074000-0x0000fe074fff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe075000-0x0000fe078fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe079000-0x0000fe07bfff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe07c000-0x0000fe07dfff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe07e000-0x0000fe085fff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe086000-0x0000fe087fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe088000-0x0000fe171fff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe172000-0x0000fe198fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe199000-0x0000fe65ffff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe660000-0x0000fe6a2fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe6a3000-0x0000fe7effff [Boot Code          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe7f0000-0x0000fe7fffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000fe800000-0x0000fe80ffff [Runtime Code       |RUN|  |  |  |  |RO|   |WB|WT|WC|UC]*
> [    0.000000]   0x0000fe810000-0x0000fe82ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000fe830000-0x0000fe83ffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe840000-0x0000fe88ffff [Runtime Data       |RUN|  |XP|  |  |  |   |WB|WT|WC|UC]*
> [    0.000000]   0x0000fe890000-0x0000fe891fff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x0000fe892000-0x0000feffffff [Boot Data          |   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x000880000000-0x00099bffffff [Conventional Memory|   |  |  |  |  |  |   |WB|WT|WC|UC]
> [    0.000000]   0x00099c000000-0x0009ffffffff [Loader Data        |   |  |  |  |  |  |   |WB|WT|WC|UC]
> 
> Thanks,
> Mark.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
