From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Fri, 13 Apr 2018 20:32:24 -0700
Subject: [bug report] locking/qrwlock, arm64: Move rwlock implementation
 over to qrwlocks causes CPU crashes/stalls when killing java processes
In-Reply-To: <CACgAJHz9_JKdO9bn1fiPURNq5S4XGeVNnBKx79JhM7Hcp-Tf-w@mail.gmail.com>
References: <CACgAJHzeS7CNqLaVckNtS5BNTsqe0ac+u0LwJAr1_1i1=OLcnA@mail.gmail.com>
 <20180412172456.GA27033@arm.com>
 <CACgAJHz9_JKdO9bn1fiPURNq5S4XGeVNnBKx79JhM7Hcp-Tf-w@mail.gmail.com>
Message-ID: <CACgAJHwemngF4XgfTvWkjANYoWO-=HTKrJmJg8VonJPCR8ZxrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I tried to remove wfe from cmpwait and still could reproduce the issue.

--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -232,7 +232,6 @@
        "       ldxr" #sz "\t%" #w "[tmp], %[v]\n"              \
        "       eor     %" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"     \
        "       cbnz    %" #w "[tmp], 1f\n"                             \
-       "       wfe\n"                                                  \
        "1:"                                                            \
        : [tmp] "=&r" (tmp), [v] "+Q" (*(unsigned long *)ptr)           \
        : [val] "r" (val));                                             \

I dumped out CPU pc and they seem to be looping in the
arch_spin_lock() trying to get the lock.

ffff00000810a968 <queued_write_lock_slowpath>:
ffff00000810a968:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
ffff00000810a96c:       aa0003e3        mov     x3, x0
ffff00000810a970:       91001005        add     x5, x0, #0x4
ffff00000810a974:       910003fd        mov     x29, sp
ffff00000810a978:       f98000b1        prfm    pstl1strm, [x5]
ffff00000810a97c:       885ffca1        ldaxr   w1, [x5]
ffff00000810a980:       11404022        add     w2, w1, #0x10, lsl #12
ffff00000810a984:       88047ca2        stxr    w4, w2, [x5]
ffff00000810a988:       35ffffa4        cbnz    w4, ffff00000810a97c
<queued_write_lock_slowpath+0x14>
ffff00000810a98c:       4ac14022        eor     w2, w1, w1, ror #16
ffff00000810a990:       340000c2        cbz     w2, ffff00000810a9a8
<queued_write_lock_slowpath+0x40>
ffff00000810a994:       d50320bf        sevl
ffff00000810a998:       d503205f        wfe
ffff00000810a99c:       485ffca4        ldaxrh  w4, [x5]
ffff00000810a9a0:       4a414082        eor     w2, w4, w1, lsr #16
ffff00000810a9a4:       35ffffa2        cbnz    w2, ffff00000810a998
<queued_write_lock_slowpath+0x30>
ffff00000810a9a8:       b9400001        ldr     w1, [x0]
ffff00000810a9ac:       350000e1        cbnz    w1, ffff00000810a9c8
<queued_write_lock_slowpath+0x60>
ffff00000810a9b0:       d2800001        mov     x1, #0x0
         // #0
ffff00000810a9b4:       d2801fe2        mov     x2, #0xff
         // #255

Tai

On Thu, Apr 12, 2018 at 10:49 AM, Tai Tri Nguyen <ttnguyen@apm.com> wrote:
> Hi Will,
>
> Somehow so far I only see the issue when killing Java processes.
> Here is the log. It's a bit long.
> I'll try removing wfe as you suggested.
>
> [ 2499.459849] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459851] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459855] INFO: rcu_sched self-detected stall on CPU
>
> [ 2499.459856] INFO: rcu_sched self-detected stall on CPU
>
> [ 2499.459858] INFO: rcu_sched self-detected stall on CPU
>
> [ 2499.459861]  1-...!: (11 GPs behind) idle=dee/140000000000001/0
> softirq=40890/40890 fqs=0
>
> [ 2499.459862] INFO: rcu_sched self-detected stall on CPU
>
> [ 2499.459864] INFO: rcu_sched self-detected stall on CPU
>
> [ 2499.459866] INFO: rcu_sched self-detected stall on CPU
>
> [ 2499.459866]
> [ 2499.459870]  14-...!: (1 GPs behind) idle=a9e/140000000000001/0
> softirq=42949/42950 fqs=0
> [ 2499.459871] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459873] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459876] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459878] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459881] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459882]  (t=60744 jiffies g=20044 c=20043 q=4496)
> [ 2499.459884] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459885] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459886]
> [ 2499.459890]  0-...!: (11 GPs behind) idle=70a/140000000000001/0
> softirq=44883/44883 fqs=0
> [ 2499.459891] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459893] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459896] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459898] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459899] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459901] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459903] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459906] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459907] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459909] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459910] INFO: rcu_sched self-detected stall on CPU
> [ 2499.459914] rcu_sched kthread starved for 60744 jiffies! g20044
> c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
> [ 2499.459916]  (t=60744 jiffies g=20044 c=20043 q=4506)
> [ 2499.459916]
> [ 2499.459920]  6-...!: (2 GPs behind) idle=e0a/140000000000001/0
> softirq=42006/42006 fqs=0
> [ 2499.459924]  31-...!: (8 GPs behind) idle=6fe/140000000000001/0
> softirq=39495/39495 fqs=0
> [ 2499.459928] rcu_sched       I
> [ 2499.459930] rcu_sched kthread starved for 60744 jiffies! g20044
> c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x402 ->cpu=16
> [ 2499.459932]  (t=60744 jiffies g=20044 c=20043 q=4518)
> [ 2499.459932]
> [ 2499.459935]  12-...!: (48 GPs behind) idle=37a/140000000000001/0
[...]
> [ 2499.460317] rcu_sched kthread starved for 60744 jiffies! g20044
> c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x200 ->cpu=16
> [ 2499.460318]  (t=60744 jiffies g=20044 c=20043 q=4703)
> [ 2499.460320]  ret_from_fork+0x10/0x18
> [ 2499.460322]  kthread+0xfc/0x128
> [ 2499.460323]  rcu_gp_kthread+0x3a8/0x7c0
> [ 2499.460324]  schedule_timeout+0x17c/0x340
> [ 2499.460326]  schedule+0x2c/0x84
> [ 2499.460328]  __schedule+0x308/0x780
> [ 2499.460332]  __switch_to+0x8c/0xa8
> [ 2499.460333] Call trace:
> [ 2499.460334]     0     8      2 0x00000000
> [ 2499.460335] rcu_sched       R
> [ 2499.460338] rcu_sched kthread starved for 60744 jiffies! g20044
> c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x200 ->cpu=16
> [ 2499.460338]   running task
> [ 2499.460341]  ret_from_fork+0x10/0x18
> [ 2499.460342]  kthread+0xfc/0x128
> [ 2499.460345]  rcu_gp_kthread+0x3a8/0x7c0
> [ 2499.460347]  schedule_timeout+0x17c/0x340
> [root at hadoop-slave-1 scripts]# [ 2499.460349]  schedule+0x2c/0x84
> [ 2499.460351]  __schedule+0x308/0x780
> [ 2499.460355]  __switch_to+0x8c/0xa8
>
> [ 2499.460356] Call trace:
> [ 2499.460358]     0     8      2 0x00000000
> [ 2499.460359] rcu_sched       R
> [ 2499.460362] rcu_sched kthread starved for 60744 jiffies! g20044
> c20043 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x200 ->cpu=16
> [ 2499.460363]  ret_from_fork+0x10/0x18
> [root at hadoop-slave-1 scripts]# [ 2499.460365]  kthread+0xfc/0x128
> [ 2499.460366]  rcu_gp_kthread+0x3a8/0x7c0
> [ 2499.460368]  schedule_timeout+0x17c/0x340
>
> [ 2499.460370]  schedule+0x2c/0x84
> [ 2499.460373]  __switch_to+0x8c/0xa8
> [ 2499.460376]  __schedule+0x308/0x780
> [ 2499.460377] Call trace:
> [ 2499.460378]     0     8      2 0x00000000
[...]

> On Thu, Apr 12, 2018 at 10:24 AM, Will Deacon <will.deacon@arm.com> wrote:
>> Hi Tai,
>>
>> On Thu, Apr 12, 2018 at 10:10:40AM -0700, Tai Tri Nguyen wrote:
>>> Recently I have observed the CPU crashes/stalls when rebooting after I
>>> ran cassandra benchmark.
>>> The issue happens randomly.
>>
>> Please could you share some logs and more details about the crashes and
>> stalls? At the moment there's not much we can do with this report :/
>>
>> Ideally, we'd have steps to reproduce the issue, but it seems that you
>> don't have a reliable method for that.
>>
>> One other thing you could try is removing the WFE from our cmpwait
>> implementation in case you have a CPU erratum in that area.
>>
>> Will
>
>
>
> --
> Tai



-- 
Tai
