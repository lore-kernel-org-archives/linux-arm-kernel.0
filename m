From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 29 Aug 2013 17:41:55 +0900
Subject: [PATCH] clocksource: em_sti: Adjust clock event rating to fix SMP
 broadcast
In-Reply-To: <51F9777B.2080500@codeaurora.org>
References: <1375251940-7809-1-git-send-email-horms+renesas@verge.net.au>
 <51F94A35.2020907@codeaurora.org>
 <CANqRtoR0Wwctor1mpM+8nuC0_pZsPHUSShPuZFX4FVtoVKEuNw@mail.gmail.com>
 <51F9777B.2080500@codeaurora.org>
Message-ID: <CANqRtoT=gMKBHG8qJWc7FjcYFaaf5hBzzv8=AOLneoveasmKoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 1, 2013 at 5:45 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 07/31/13 12:17, Magnus Damm wrote:
>> Hi Stephen,
>>
>> On Thu, Aug 1, 2013 at 2:32 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>> On 07/30/13 23:25, Simon Horman wrote:
>>>> From: Magnus Damm <damm@opensource.se>
>>>>
>>>> Update the STI rating from 200 to 80 to fix SMP operation with
>>>> the ARM broadcast timer. This breakage was introduced by:
>>>>
>>>> f7db706 ARM: 7674/1: smp: Avoid dummy clockevent being preferred over real hardware clock-event
>>>>
>>>> Without this fix SMP operation is broken on EMEV2 since no
>>>> broadcast timer interrupts trigger on the secondary CPU cores.
>>>>
>>>> Signed-off-by: Magnus Damm <damm@opensource.se>
>>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>>> ---
>>> This looks suspicious. Are you're purposefully deflating the rating so
>>> that the STI timer fills in the broadcast position? Why not make the STI
>>> cpumask be all possible CPUs? Presumably the interrupt can target all
>>> CPUs since it isn't a per-cpu interrupt and doing this would cause the
>>> STI to fill in the broadcast slot, leaving the per-cpu dummys in the
>>> tick position.
>> While letting the timer broadcast to all CPUs sounds interesting the
>> STI driver has so far only been used to drive a single CPU core. This
>> used to work well for us but has since some time unfortunately been
>> broken. I agree that it may be suboptimal with a single timer like STI
>> and using IPI for broadcast, but for more efficient SMP we already
>> have TWD or arch timer.
>
> I think there is some confusion. The mask field says what CPUs the timer
> can possibly interrupt and for non-percpu interrupts this should be all
> possible CPUs (unless we're talking clusters, etc. but I don't think we
> are). Can you please give the output of /proc/timer_list or confirm that
> the STI is your broadcast source? If so you should probably be marking
> the cpumask for all possible CPUs so that the clockevent core knows to
> prefer this clockevent for the broadcast source and not a per-cpu
> source. Then you can leave the rating as is.

Hello Stephen,

Thanks for your suggestion. Yes, there was indeed some confusion. Now
after diving into the code a bit deeper I can finally understand what
you mean.

Instead of adjusting the rating I've changed the cpumask member like this:

--- 0001/drivers/clocksource/em_sti.c
+++ work/drivers/clocksource/em_sti.c    2013-08-29 17:33:16.000000000 +0900
@@ -301,7 +301,7 @@ static void em_sti_register_clockevent(s
     ced->name = dev_name(&p->pdev->dev);
     ced->features = CLOCK_EVT_FEAT_ONESHOT;
     ced->rating = 200;
-    ced->cpumask = cpumask_of(0);
+    ced->cpumask = cpu_all_mask;
     ced->set_next_event = em_sti_clock_event_next;
     ced->set_mode = em_sti_clock_event_mode;

Without the cpumask fix or without the earlier rating fix the
following interrupt count can be seen in /proc/interrupts on KZM9D:

157:        140          0       GIC 157  e0180000.sti
160:          0          0  e0050000.gpio   1  eth0
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts

Above, notice how no IPI1 interrupts seem to be arriving.

With the cpumask fix above the interrupt count becomes like this:

 157:        559          0       GIC 157  e0180000.sti
160:          0          0  e0050000.gpio   1  eth0
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0        601  Timer broadcast interrupts

Would this be in line with your expectation?

Thanks,

/ magnus
