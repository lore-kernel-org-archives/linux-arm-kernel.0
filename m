From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 1 Aug 2018 10:29:32 +0530
Subject: [PATCH] perf vendor events arm64: Update ThunderX2 implementation
 defined pmu core events
In-Reply-To: <20180731172919.GE4909@kernel.org>
References: <20180731100251.23575-1-ganapatrao.kulkarni@cavium.com>
 <20180731142835.GC4909@kernel.org>
 <CAKTKpr7ZLru2wvtarq01p6PqJKQLEhCFtoo=tw45Svh-V_vFag@mail.gmail.com>
 <20180731172919.GE4909@kernel.org>
Message-ID: <CAKTKpr5wBZ0QogsZsKZb9Fk4D4K-u9XNza9S4GDg5Kt7WTRV4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaldo,


On Tue, Jul 31, 2018 at 10:59 PM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Tue, Jul 31, 2018 at 08:40:51PM +0530, Ganapatrao Kulkarni escreveu:
>> Hi Arnaldo,
>>
>> On Tue, Jul 31, 2018 at 7:58 PM, Arnaldo Carvalho de Melo
>> <arnaldo.melo@gmail.com> wrote:
>> > Em Tue, Jul 31, 2018 at 03:32:51PM +0530, Ganapatrao Kulkarni escreveu:
>> >> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> >
>> > Can you please consider to provide an example of such counters being
>> > used, i.e. with a simple C synthetic test that causes these events to
>> > take place, then run it via 'perf stat' to show that indeed, they are
>> > being programmed and read correctly?
>> >
>> > Ideally for all of them, but if that becomes too burdensome, for a few
>> > of them?
>>
>> It may be tedious for all, certainly I will provide the test
>> results/log for some of them(as many as possible).
>
> Right, we do try to test some of the events via 'perf test', for
> instance:
>
> [root at jouet perf]# perf test openat
>  2: Detect openat syscall event                           : Ok
>  3: Detect openat syscall event on all cpus               : Ok
> 15: syscalls:sys_enter_openat event fields                : Ok
> [root at jouet perf]#

we have not tried perf test, will look in to this test suite to keep
it complaint on our hardware too!

>
> Things like setting up evsels for some events, then forking + calling a
> syscall, then checking if that event appeared on the ring buffer, check
> if the payload for the event, as read using the tracefs format fields
> matches the parameters we passed in the syscall, etc.
>
> See tools/perf/tests/openat-syscall-tp-fields.c for that
> "syscalls:sys_enter_openat event fields" specific source code.
>
> So doing some of these synthetic tests when updating the event files may
> help us in the direction of having tests that run on those specific
> hardwares (ThunderX2 in this case) everytime we run 'perf test', so that
> we can detect failures sooner.
>
> I.e. first write a simple test for one of those events, use it as
> documentation, at some point, as time permits, turn those into a 'perf
> test' entry.

All these events are implemented as per "ARMv8, The Performance
Monitors Extension specification" [1].
Brief explanation of each of these events is already captured at
tools/perf/pmu-events/arch/arm64/armv8-recommended.json

[1] https://static.docs.arm.com/ddi0487/a/DDI0487A_j_armv8_arm.pdf?_ga=2.104377475.2065785066.1533095452-1490247355.1441251141

i have used ltp testcases as workload to test some of the events and
log is below,

root at SBR-26>ganapat>> perf stat -e
unaligned_ld_spec,unaligned_st_spec,unaligned_ldst_spec,mem_access_rd,mem_access_wr,armv8_pmuv3_0/mem_access/
ltp/testcases/kernel/mem/mtest001 -p80
mtest01     0  TINFO  :  Total memory already used on system = 11849792 kbytes
mtest01     0  TINFO  :  Total memory used needed to reach maximum =
214325040 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 202475248 kbytes
mtest01     1  TPASS  :  202475248 kbytes allocated only.

 Performance counter stats for 'ltp/testcases/kernel/mem/mtest01/mtest01 -p80':

             2,573      unaligned_ld_spec
             3,976      unaligned_st_spec
             6,549      unaligned_ldst_spec
         1,525,489      mem_access_rd
         1,549,531      mem_access_wr
         3,075,020      armv8_pmuv3_0/mem_access/

       0.006368837 seconds time elapsed

       0.000000000 seconds user
       0.006390000 seconds sys


root at SBR-26>ganapat>> perf stat -e
l1d_cache_refill_rd,l1d_cache_refill_wr,armv8_pmuv3_0/l1d_cache_refill/
./ltp/testcases/kernel/mem/mtest01/mtest01 -p80
mtest01     0  TINFO  :  Total memory already used on system = 11851520 kbytes
mtest01     0  TINFO  :  Total memory used needed to reach maximum =
214325040 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 202473520 kbytes
mtest01     1  TPASS  :  202473520 kbytes allocated only.

 Performance counter stats for
'./ltp/testcases/kernel/mem/mtest01/mtest01 -p80':

           257,128      l1d_cache_refill_rd
           162,151      l1d_cache_refill_wr
           419,279      armv8_pmuv3_0/l1d_cache_refill/

       0.006118645 seconds time elapsed

       0.000000000 seconds user
       0.006141000 seconds sys


root at SBR-26>ganapat>> perf stat -e exc_svc
./ltp/testcases/kernel/syscalls/brk/brk01
tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
brk01.c:67: PASS: brk() works fine

Summary:
passed   1
failed   0
skipped  0
warnings 0

 Performance counter stats for './ltp/testcases/kernel/syscalls/brk/brk01':

               100      exc_svc

       0.000887222 seconds time elapsed

       0.000950000 seconds user
       0.000000000 seconds sys


root at SBR-26>ganapat>>

>
> Thanks,
>
> - Arnaldo
>
>> >
>> > Thanks,
>> >
>> > - Arnaldo
>> >
>> >> ---
>> >>  .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 87 +++++++++++++++++++++-
>> >>  1 file changed, 84 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
>> >> index bc03c06..752e47e 100644
>> >> --- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
>> >> +++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
>> >> @@ -12,6 +12,21 @@
>> >>          "ArchStdEvent": "L1D_CACHE_REFILL_WR",
>> >>      },
>> >>      {
>> >> +        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "L1D_CACHE_INVAL",
>> >> +    },
>> >> +    {
>> >>          "ArchStdEvent": "L1D_TLB_REFILL_RD",
>> >>      },
>> >>      {
>> >> @@ -24,9 +39,75 @@
>> >>          "ArchStdEvent": "L1D_TLB_WR",
>> >>      },
>> >>      {
>> >> +        "ArchStdEvent": "L2D_TLB_REFILL_RD",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "L2D_TLB_REFILL_WR",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "L2D_TLB_RD",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "L2D_TLB_WR",
>> >> +    },
>> >> +    {
>> >>          "ArchStdEvent": "BUS_ACCESS_RD",
>> >> -   },
>> >> -   {
>> >> +    },
>> >> +    {
>> >>          "ArchStdEvent": "BUS_ACCESS_WR",
>> >> -   }
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "MEM_ACCESS_RD",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "MEM_ACCESS_WR",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "UNALIGNED_LD_SPEC",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "UNALIGNED_ST_SPEC",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_UNDEF",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_SVC",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_PABORT",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_DABORT",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_IRQ",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_FIQ",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_SMC",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_HVC",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_TRAP_PABORT",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_TRAP_DABORT",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_TRAP_OTHER",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_TRAP_IRQ",
>> >> +    },
>> >> +    {
>> >> +        "ArchStdEvent": "EXC_TRAP_FIQ",
>> >> +    }
>> >>  ]
>> >> --
>> >> 2.9.4
>>
>> thanks
>> Ganapat

thanks
Ganapat
