From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 22 Oct 2015 17:28:56 +0800
Subject: Problem about CPU stalling in hrtimer_intterrupts()
In-Reply-To: <alpine.DEB.2.11.1510220942010.4012@nanos>
References: <56288585.40204@huawei.com>
 <alpine.DEB.2.11.1510220942010.4012@nanos>
Message-ID: <5628AC58.2030509@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/22 15:43, Thomas Gleixner wrote:
> On Thu, 22 Oct 2015, Yang Yingliang wrote:
>> I use the kernel-4.1.6 running on arm64.
>> My testcase is that it calls clock_settime and clock_adjtime alternately with
>> random params on each core. My system has 32 cores.
>>
>> I found the cpu stalling in  hrtimer_intterrupts(). So I added some debug info
>> in hrtimer_intterrupts() and found that the while loop runs 1020437660 times
>> and takes 98761 jiffies(HZ=250).
>>
>> Some debug log is here:
>> ---start---
>> Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830
>> hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0
>> timer:ffffffdffdec6138, timer->function:ffffffc000129b84
>> Jan 01 00:03:32 Linux kernel: i:0 basenow.tv64:4809284991830
>> hrtimer_get_softexpires_tv64(timer):4440120000000 ccpu0
> 
> Something is rearming a timer over and over with expiry time in the
> past.
> 
> Thanks,
> 
> 	tglx
> 


Hi Thomas:

This problem could only occur on the system with 32 cores, when I cut the cores to 16, this problem disappeared, 
so I think there is some parallel problem when the 32 core set clock time together:

I try to reproduce the scene:

1.do_settimeofday64
2.update tk time
3.update base time offset
4.update expires_next

the 3 and 4 will be called in softirq, but the hrtimer_interrupt may break the order and run before 3, I am not
sure whether this could make the problem, do we need to update base time and expires_next in the hrtimer_interrupt?
maybe I miss something, thanks for any suggestion.

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 93ef7190..9adab23 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1254,6 +1254,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)

raw_spin_lock(&cpu_base->lock);
entry_time = now = hrtimer_update_base(cpu_base);
+ hrtimer_force_reprogram(cpu_base, 0);
retry:
cpu_base->in_hrtirq = 1;


Thanks

Ding


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
