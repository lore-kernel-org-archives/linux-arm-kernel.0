From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Tue, 31 Jul 2018 14:29:19 -0300
Subject: [PATCH] perf vendor events arm64: Update ThunderX2
 implementation defined pmu core events
In-Reply-To: <CAKTKpr7ZLru2wvtarq01p6PqJKQLEhCFtoo=tw45Svh-V_vFag@mail.gmail.com>
References: <20180731100251.23575-1-ganapatrao.kulkarni@cavium.com>
 <20180731142835.GC4909@kernel.org>
 <CAKTKpr7ZLru2wvtarq01p6PqJKQLEhCFtoo=tw45Svh-V_vFag@mail.gmail.com>
Message-ID: <20180731172919.GE4909@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, Jul 31, 2018 at 08:40:51PM +0530, Ganapatrao Kulkarni escreveu:
> Hi Arnaldo,
> 
> On Tue, Jul 31, 2018 at 7:58 PM, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> > Em Tue, Jul 31, 2018 at 03:32:51PM +0530, Ganapatrao Kulkarni escreveu:
> >> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> >
> > Can you please consider to provide an example of such counters being
> > used, i.e. with a simple C synthetic test that causes these events to
> > take place, then run it via 'perf stat' to show that indeed, they are
> > being programmed and read correctly?
> >
> > Ideally for all of them, but if that becomes too burdensome, for a few
> > of them?
> 
> It may be tedious for all, certainly I will provide the test
> results/log for some of them(as many as possible).

Right, we do try to test some of the events via 'perf test', for
instance:

[root at jouet perf]# perf test openat
 2: Detect openat syscall event                           : Ok
 3: Detect openat syscall event on all cpus               : Ok
15: syscalls:sys_enter_openat event fields                : Ok
[root at jouet perf]#

Things like setting up evsels for some events, then forking + calling a
syscall, then checking if that event appeared on the ring buffer, check
if the payload for the event, as read using the tracefs format fields
matches the parameters we passed in the syscall, etc.

See tools/perf/tests/openat-syscall-tp-fields.c for that
"syscalls:sys_enter_openat event fields" specific source code.

So doing some of these synthetic tests when updating the event files may
help us in the direction of having tests that run on those specific
hardwares (ThunderX2 in this case) everytime we run 'perf test', so that
we can detect failures sooner.

I.e. first write a simple test for one of those events, use it as
documentation, at some point, as time permits, turn those into a 'perf
test' entry.

Thanks,

- Arnaldo
 
> >
> > Thanks,
> >
> > - Arnaldo
> >
> >> ---
> >>  .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 87 +++++++++++++++++++++-
> >>  1 file changed, 84 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> >> index bc03c06..752e47e 100644
> >> --- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> >> +++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
> >> @@ -12,6 +12,21 @@
> >>          "ArchStdEvent": "L1D_CACHE_REFILL_WR",
> >>      },
> >>      {
> >> +        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "L1D_CACHE_INVAL",
> >> +    },
> >> +    {
> >>          "ArchStdEvent": "L1D_TLB_REFILL_RD",
> >>      },
> >>      {
> >> @@ -24,9 +39,75 @@
> >>          "ArchStdEvent": "L1D_TLB_WR",
> >>      },
> >>      {
> >> +        "ArchStdEvent": "L2D_TLB_REFILL_RD",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "L2D_TLB_REFILL_WR",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "L2D_TLB_RD",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "L2D_TLB_WR",
> >> +    },
> >> +    {
> >>          "ArchStdEvent": "BUS_ACCESS_RD",
> >> -   },
> >> -   {
> >> +    },
> >> +    {
> >>          "ArchStdEvent": "BUS_ACCESS_WR",
> >> -   }
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "MEM_ACCESS_RD",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "MEM_ACCESS_WR",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "UNALIGNED_LD_SPEC",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "UNALIGNED_ST_SPEC",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_UNDEF",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_SVC",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_PABORT",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_DABORT",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_IRQ",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_FIQ",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_SMC",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_HVC",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_TRAP_PABORT",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_TRAP_DABORT",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_TRAP_OTHER",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_TRAP_IRQ",
> >> +    },
> >> +    {
> >> +        "ArchStdEvent": "EXC_TRAP_FIQ",
> >> +    }
> >>  ]
> >> --
> >> 2.9.4
> 
> thanks
> Ganapat
