From: mpatocka@redhat.com (Mikulas Patocka)
Date: Mon, 6 Aug 2018 13:19:18 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <20180806171356.kk45vd7n5bdi6ka3@armageddon.cambridge.arm.com>
References: <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
 <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
 <CAKv+Gu_C2g=C=gMpk4a5jpDORnxZY6t1v=HDoy59m5vwNBxBBg@mail.gmail.com>
 <20180806171356.kk45vd7n5bdi6ka3@armageddon.cambridge.arm.com>
Message-ID: <alpine.LRH.2.02.1808061317470.12989@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 6 Aug 2018, Catalin Marinas wrote:

> On Mon, Aug 06, 2018 at 05:47:36PM +0200, Ard Biesheuvel wrote:
> > On 6 August 2018 at 14:42, Robin Murphy <robin.murphy@arm.com> wrote:
> > > On 06/08/18 11:25, Mikulas Patocka wrote:
> > > [...]
> > >>>
> > >>> None of this explains why some transactions fail to make it across
> > >>> entirely. The overlapping writes in question write the same data to
> > >>> the memory locations that are covered by both, and so the ordering in
> > >>> which the transactions are received should not affect the outcome.
> > >>
> > >> You're right that the corruption couldn't be explained just by reordering
> > >> writes. My hypothesis is that the PCIe controller tries to disambiguate
> > >> the overlapping writes, but the disambiguation logic was not tested and it
> > >> is buggy. If there's a barrier between the overlapping writes, the PCIe
> > >> controller won't see any overlapping writes, so it won't trigger the
> > >> faulty disambiguation logic and it works.
> > >>
> > >> Could the ARM engineers look if there's some chicken bit in Cortex-A72
> > >> that could insert barriers between non-cached writes automatically?
> > >
> > > I don't think there is, and even if there was I imagine it would have a
> > > pretty hideous effect on non-coherent DMA buffers and the various other
> > > places in which we have Normal-NC mappings of actual system RAM.
> > 
> > Looking at the A72 manual, there is one chicken bit that looks like it
> > may be related:
> > 
> > CPUACTLR_EL1 bit #50:
> > 
> > 0 Enables store streaming on NC/GRE memory type. This is the reset value.
> > 1 Disables store streaming on NC/GRE memory type.
> > 
> > so putting something like
> > 
> > mrs x0, S3_1_C15_C2_0
> > orr x0, x0, #(1 << 50)
> > msr S3_1_C15_C2_0, x0
> > 
> > in __cpu_setup() would be worth a try.
> 
> Note that access to this register may be disabled at EL3 by firmware
> (ACTLR_EL3.CPUACTLR).
> 
> FWIW, Mikulas' test seems to run fine on a ThunderX1 with AMD
> FirePro W2100 (on /dev/fb1)

I have the EDK EFI firmware sources (and I can load it from a SD card, so 
there's no risk of bricking the board), so I can insert the write into it, 
if you say where.

Mikulas
