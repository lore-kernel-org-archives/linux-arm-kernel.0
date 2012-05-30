From: bill4carson@gmail.com (bill4carson)
Date: Wed, 30 May 2012 18:01:59 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <20120530063858.GB6484@mudshark.cambridge.arm.com>
References: <4FAA34A9.5020708@gmail.com>
 <20120511085150.GA17453@mudshark.cambridge.arm.com>
 <4FC45E6B.2070202@gmail.com>
 <20120530063858.GB6484@mudshark.cambridge.arm.com>
Message-ID: <4FC5F017.4050202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Will

First of all, Thanks your attentions for this issue.


On 2012?05?30? 14:38, Will Deacon wrote:
> On Tue, May 29, 2012 at 06:28:11AM +0100, bill4carson wrote:
>> --- a/arch/arm/mm/cache-v6.S
>> +++ b/arch/arm/mm/cache-v6.S
>> @@ -170,6 +170,10 @@ ENDPROC(v6_coherent_kern_range)
>>    ENTRY(v6_flush_kern_dcache_area)
>>           add     r1, r0, r1
>>    1:
>> +#ifdef CONFIG_SMP
>> +       ldr     r2, [r0]                        @ read for ownership
>> +       str     r2, [r0]                        @ write for ownership
>> +#endif /* CONFIG_SMP */
>>    #ifdef HARVARD_CACHE
>>           mcr     p15, 0, r0, c7, c14, 1          @ clean&  invalidate D line
>>    #else
>
> I don't think the invalidation is needed here, so you probably don't need to
> hack this function at all.


     CPU0                        CPU1
+--------------------+        +--------------------+   +----------+
| L1 Dcache   part_a |        | L1 Dcache   part_b |   |  Icache  |
+--------------------+        +--------------------+   +----------+
             ^                                            |
             |                   +------------------------+
             |                   |
             |         SCU       V
     +-------|-------------------|---------+
     |       +------- ??? -------+         |
     |                 |                   |
     +-----------------|-------------------+
                       |
                       V
              Main   Memory
     +-------------------------------------+
     |       stale part_a       part_b     |
     +-------------------------------------+


1. task t runs on CPU 0, it executes one program in nand flash,
    so first task t read *part* of this program into its local Dcache,
    let's call it part_a;

2. task t migrates from CPU0 onto CPU1, in there reads the rest of
    program into its local Dcache, label it part_b;

3. on CPU1, task t flush the whole address range of this program,
    As with ARM11 MPCore, this flush is locally effective, after flush
    part_a still resides in CPU0 L1 Dcache.

4. When this program gets executed, CPU 1 fetch its instructions from
    Icache, SCU will notice this action,

    Question:
    At this point, is stale part_a in main memory *or* L1 Dcache part_a
    in CPU0 routed into CPU1 as instruction?



>
>> But I have no idea on how to accomplish the v6_flush_kern_cache_all,
>> maybe IPI is needed?
>
> We could add an IPI to invalidate the I-caches on the other cores, however
> I haven't checked to see if we could instead do something on the CPU
> migration path which avoid the need for the broadcasting.
>


Another workaround is mark the task migrations in function "pull_task",
while in function "context_switch", check it to see if any tasks
migrated into current CPU, if there do be such tasks, flush entire data
cache on remote core(the source core of task migration) and wait the
operation accomplished. This is also verified. But from my point of
view, this is just a temporary workaround instead of resolution.
The little patch above should be the right one that fix this bug:
Make the flush_kern_dcache_area global affective.


It's very pleased if you could give your insights in this.


> Will
>

-- 
Love each day!

--bill
