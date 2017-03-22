From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 22 Mar 2017 14:46:50 +0530
Subject: [PATCH 00/14] arm_pmu: ACPI support
In-Reply-To: <CAFpQJXVe_=42R+0Ch-tLwCcvhX3xJa20mhgYCWWNty-sn1Gp+g@mail.gmail.com>
References: <1489143891-11596-1-git-send-email-mark.rutland@arm.com>
 <58CA8C8A.8080405@huawei.com>
 <CAFpQJXVe_=42R+0Ch-tLwCcvhX3xJa20mhgYCWWNty-sn1Gp+g@mail.gmail.com>
Message-ID: <CAFpQJXXqU6pvjckrQ86jXPhKd9XZQ+hDHt8X19Wy31JmLJvrjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i am not able to run with latest perf tool, i see issue with memory
corruption in malloc
is this seen from anyone else too?
i am not sure, is this issue with my setup?

root at VAL1-13>perf>> perf stat -e armv8_pmuv3_0/br_mis_pred/ sleep 1

 Performance counter stats for 'sleep 1':

            10,815      armv8_pmuv3_0/br_mis_pred/

       1.001232167 seconds time elapsed

root at VAL1-13>perf>> ./perf stat -e armv8_pmuv3_0/br_mis_pred/ sleep 1
*** Error in `./perf': free(): invalid next size (fast): 0x00000000086a7a00 ***
Aborted (core dumped)
root at VAL1-13>perf>> ./perf -v
perf version 4.11.rc3.g093b99
root at VAL1-13>perf>> perf -v
perf version 4.8.rc6.g21c488
root at VAL1-13>perf>> uname -a
Linux VAL1-13 4.11.0-rc2-12139-g3804e12 #1 SMP PREEMPT Wed Mar 22
06:26:28 UTC 2017 aarch64 aarch64 aarch64 GNU/Linux
root at VAL1-13>perf>>


On Mon, Mar 20, 2017 at 11:41 PM, Ganapatrao Kulkarni
<gpkulkarni@gmail.com> wrote:
> Hi Hanjun,
>
> On Thu, Mar 16, 2017 at 6:30 PM, Hanjun Guo <guohanjun@huawei.com> wrote:
>> On 2017/3/10 19:04, Mark Rutland wrote:
>>> Hi,
>>>
>>> This series implements ACPI support in the ARM PMU code. It borrows some code
>>> from Jeremy's series [1], but takes a different approach to probing and
>>> association, using the usual hotplug state machine, minimising external changes
>>> required, and simplifying the relationship with the common arm_pmu code.
>>>
>>> The first few patches are preparatory cleanup/refactoring, with the latter half
>>> of the series being specific to ACPI support.
>>>
>>> The series is based on my IRQ rework patches [2]. I've pushed the whole series
>>> out to the arm/perf/acpi branch [3] of my kernel.org repo.
>>>
>>> Due to the innards of the hotplug callback framework, it's not entirely
>>> safe to register a PMU in a hotplug callback. Due to this, we can only
>>> associated hotplugged CPUs with a PMU if a matching CPU was around at
>>> probe time. A similar restriction already applies to DT systems. We may
>>> be able to relax this with some future work.
>>>
>>> I've given this some testing on a Juno platform (using SPIs). To see that IRQs
>>> are correctly associated, I've tested with the following:
>>>
>>>   $ taskset -c ${SOME_CPU_HERE} perf record \
>>>     -e armv8_pmuv3_0/cpu_cycles/ \
>>>     -e armv8_pmuv3_1/cpu_cycles/ \
>>>     cat /proc/interrupts
>>>
>>> I've also booted with nr_cpus temporarily capped (passing maxcpus=) to test the
>>> association logic. This has also been tested in a VM using PPIs; I do not have
>>> access to a host machine which itself uses PPIs.
>>
>> Booted OK and 'perf list' got on Hisilicon D03:
>>
>> d03-09:~ # perf list
>>
>> List of pre-defined events (to be used in -e):
>>
>>   branch-misses                                      [Hardware event]
>>   bus-cycles                                         [Hardware event]
>>   cache-misses                                       [Hardware event]
>>   cache-references                                   [Hardware event]
>>   cpu-cycles OR cycles                               [Hardware event]
>>   instructions                                       [Hardware event]
>>
>>   alignment-faults                                   [Software event]
>>   context-switches OR cs                             [Software event]
>>   cpu-clock                                          [Software event]
>>   cpu-migrations OR migrations                       [Software event]
>>   dummy                                              [Software event]
>>   emulation-faults                                   [Software event]
>>   major-faults                                       [Software event]
>>   minor-faults                                       [Software event]
>>   page-faults OR faults                              [Software event]
>>   task-clock                                         [Software event]
>>
>>   L1-dcache-load-misses                              [Hardware cache event]
>>   L1-dcache-loads                                    [Hardware cache event]
>>   L1-dcache-store-misses                             [Hardware cache event]
>>   L1-dcache-stores                                   [Hardware cache event]
>>   L1-icache-load-misses                              [Hardware cache event]
>>   L1-icache-loads                                    [Hardware cache event]
>>   branch-load-misses                                 [Hardware cache event]
>>   branch-loads                                       [Hardware cache event]
>>   dTLB-load-misses                                   [Hardware cache event]
>>   iTLB-load-misses                                   [Hardware cache event]
>>
>>   armv8_pmuv3_0/br_mis_pred/                         [Kernel PMU event]
>>   armv8_pmuv3_0/br_pred/                             [Kernel PMU event]
>>   armv8_pmuv3_0/bus_access/                          [Kernel PMU event]
>>   armv8_pmuv3_0/bus_cycles/                          [Kernel PMU event]
>>   armv8_pmuv3_0/cid_write_retired/                   [Kernel PMU event]
>>   armv8_pmuv3_0/cpu_cycles/                          [Kernel PMU event]
>>   armv8_pmuv3_0/exc_return/                          [Kernel PMU event]
>>   armv8_pmuv3_0/exc_taken/                           [Kernel PMU event]
>>   armv8_pmuv3_0/inst_retired/                        [Kernel PMU event]
>>   armv8_pmuv3_0/inst_spec/                           [Kernel PMU event]
>>   armv8_pmuv3_0/l1d_cache/                           [Kernel PMU event]
>>   armv8_pmuv3_0/l1d_cache_refill/                    [Kernel PMU event]
>>   armv8_pmuv3_0/l1d_cache_wb/                        [Kernel PMU event]
>>   armv8_pmuv3_0/l1d_tlb_refill/                      [Kernel PMU event]
>>   armv8_pmuv3_0/l1i_cache/                           [Kernel PMU event]
>>   armv8_pmuv3_0/l1i_cache_refill/                    [Kernel PMU event]
>>   armv8_pmuv3_0/l1i_tlb_refill/                      [Kernel PMU event]
>>   armv8_pmuv3_0/l2d_cache/                           [Kernel PMU event]
>>   armv8_pmuv3_0/l2d_cache_refill/                    [Kernel PMU event]
>>   armv8_pmuv3_0/l2d_cache_wb/                        [Kernel PMU event]
>>   armv8_pmuv3_0/mem_access/                          [Kernel PMU event]
>>   armv8_pmuv3_0/memory_error/                        [Kernel PMU event]
>>   armv8_pmuv3_0/sw_incr/                             [Kernel PMU event]
>>   armv8_pmuv3_0/ttbr_write_retired/                  [Kernel PMU event]
>>
>>   rNNN                                               [Raw hardware event descriptor]
>>   cpu/t1=v1[,t2=v2,t3 ...]/modifier                  [Raw hardware event descriptor]
>>    (see 'man perf-list' on how to encode it)
>>
>>   mem:<addr>[/len][:access]                          [Hardware breakpoint]
>>
>>
>> Try some basic perf event and it works, anything else I can try in specific?
>
> you can try perf fuzzer
>
> thanks
> Ganapat
>
>>
>> Thanks
>> Hanjun
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

thanks
Ganapat
