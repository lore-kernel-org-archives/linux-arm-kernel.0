From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 16 Mar 2017 21:00:58 +0800
Subject: [PATCH 00/14] arm_pmu: ACPI support
In-Reply-To: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
Message-ID: <58CA8C8A.8080405@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/3/10 19:04, Mark Rutland wrote:
> Hi,
>
> This series implements ACPI support in the ARM PMU code. It borrows some code
> from Jeremy's series [1], but takes a different approach to probing and
> association, using the usual hotplug state machine, minimising external changes
> required, and simplifying the relationship with the common arm_pmu code.
>
> The first few patches are preparatory cleanup/refactoring, with the latter half
> of the series being specific to ACPI support.
>
> The series is based on my IRQ rework patches [2]. I've pushed the whole series
> out to the arm/perf/acpi branch [3] of my kernel.org repo.
>
> Due to the innards of the hotplug callback framework, it's not entirely
> safe to register a PMU in a hotplug callback. Due to this, we can only
> associated hotplugged CPUs with a PMU if a matching CPU was around at
> probe time. A similar restriction already applies to DT systems. We may
> be able to relax this with some future work.
>
> I've given this some testing on a Juno platform (using SPIs). To see that IRQs
> are correctly associated, I've tested with the following:
>
>   $ taskset -c ${SOME_CPU_HERE} perf record \
>     -e armv8_pmuv3_0/cpu_cycles/ \
>     -e armv8_pmuv3_1/cpu_cycles/ \
>     cat /proc/interrupts
>  
> I've also booted with nr_cpus temporarily capped (passing maxcpus=) to test the
> association logic. This has also been tested in a VM using PPIs; I do not have
> access to a host machine which itself uses PPIs.

Booted OK and 'perf list' got on Hisilicon D03:

d03-09:~ # perf list

List of pre-defined events (to be used in -e):

  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]

  alignment-faults                                   [Software event]
  context-switches OR cs                             [Software event]
  cpu-clock                                          [Software event]
  cpu-migrations OR migrations                       [Software event]
  dummy                                              [Software event]
  emulation-faults                                   [Software event]
  major-faults                                       [Software event]
  minor-faults                                       [Software event]
  page-faults OR faults                              [Software event]
  task-clock                                         [Software event]

  L1-dcache-load-misses                              [Hardware cache event]
  L1-dcache-loads                                    [Hardware cache event]
  L1-dcache-store-misses                             [Hardware cache event]
  L1-dcache-stores                                   [Hardware cache event]
  L1-icache-load-misses                              [Hardware cache event]
  L1-icache-loads                                    [Hardware cache event]
  branch-load-misses                                 [Hardware cache event]
  branch-loads                                       [Hardware cache event]
  dTLB-load-misses                                   [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]

  armv8_pmuv3_0/br_mis_pred/                         [Kernel PMU event]
  armv8_pmuv3_0/br_pred/                             [Kernel PMU event]
  armv8_pmuv3_0/bus_access/                          [Kernel PMU event]
  armv8_pmuv3_0/bus_cycles/                          [Kernel PMU event]
  armv8_pmuv3_0/cid_write_retired/                   [Kernel PMU event]
  armv8_pmuv3_0/cpu_cycles/                          [Kernel PMU event]
  armv8_pmuv3_0/exc_return/                          [Kernel PMU event]
  armv8_pmuv3_0/exc_taken/                           [Kernel PMU event]
  armv8_pmuv3_0/inst_retired/                        [Kernel PMU event]
  armv8_pmuv3_0/inst_spec/                           [Kernel PMU event]
  armv8_pmuv3_0/l1d_cache/                           [Kernel PMU event]
  armv8_pmuv3_0/l1d_cache_refill/                    [Kernel PMU event]
  armv8_pmuv3_0/l1d_cache_wb/                        [Kernel PMU event]
  armv8_pmuv3_0/l1d_tlb_refill/                      [Kernel PMU event]
  armv8_pmuv3_0/l1i_cache/                           [Kernel PMU event]
  armv8_pmuv3_0/l1i_cache_refill/                    [Kernel PMU event]
  armv8_pmuv3_0/l1i_tlb_refill/                      [Kernel PMU event]
  armv8_pmuv3_0/l2d_cache/                           [Kernel PMU event]
  armv8_pmuv3_0/l2d_cache_refill/                    [Kernel PMU event]
  armv8_pmuv3_0/l2d_cache_wb/                        [Kernel PMU event]
  armv8_pmuv3_0/mem_access/                          [Kernel PMU event]
  armv8_pmuv3_0/memory_error/                        [Kernel PMU event]
  armv8_pmuv3_0/sw_incr/                             [Kernel PMU event]
  armv8_pmuv3_0/ttbr_write_retired/                  [Kernel PMU event]

  rNNN                                               [Raw hardware event descriptor]
  cpu/t1=v1[,t2=v2,t3 ...]/modifier                  [Raw hardware event descriptor]
   (see 'man perf-list' on how to encode it)

  mem:<addr>[/len][:access]                          [Hardware breakpoint]


Try some basic perf event and it works, anything else I can try in specific?

Thanks
Hanjun
