From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 30 Aug 2013 16:02:39 +0900
Subject: [PATCH] clocksource: em_sti: Adjust clock event rating to fix SMP
 broadcast
In-Reply-To: <521F7C42.7060108@codeaurora.org>
References: <1375251940-7809-1-git-send-email-horms+renesas@verge.net.au>
 <51F94A35.2020907@codeaurora.org>
 <CANqRtoR0Wwctor1mpM+8nuC0_pZsPHUSShPuZFX4FVtoVKEuNw@mail.gmail.com>
 <51F9777B.2080500@codeaurora.org>
 <CANqRtoT=gMKBHG8qJWc7FjcYFaaf5hBzzv8=AOLneoveasmKoA@mail.gmail.com>
 <521F7C42.7060108@codeaurora.org>
Message-ID: <CANqRtoSVg=801TetBMcyAAQykHK4bB0bHLwj=htq26badguOYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 1:52 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 08/29/13 01:41, Magnus Damm wrote:
>> Thanks for your suggestion. Yes, there was indeed some confusion. Now
>> after diving into the code a bit deeper I can finally understand what
>> you mean.
>>
>> Instead of adjusting the rating I've changed the cpumask member like this:
>>
>> --- 0001/drivers/clocksource/em_sti.c
>> +++ work/drivers/clocksource/em_sti.c    2013-08-29 17:33:16.000000000 +0900
>> @@ -301,7 +301,7 @@ static void em_sti_register_clockevent(s
>>      ced->name = dev_name(&p->pdev->dev);
>>      ced->features = CLOCK_EVT_FEAT_ONESHOT;
>>      ced->rating = 200;
>> -    ced->cpumask = cpumask_of(0);
>> +    ced->cpumask = cpu_all_mask;
>
> It would be better to use cpu_possible_mask.

I agree, thanks.

>>      ced->set_next_event = em_sti_clock_event_next;
>>      ced->set_mode = em_sti_clock_event_mode;
>>
>> Without the cpumask fix or without the earlier rating fix the
>> following interrupt count can be seen in /proc/interrupts on KZM9D:
>>
>> 157:        140          0       GIC 157  e0180000.sti
>> 160:          0          0  e0050000.gpio   1  eth0
>> IPI0:          0          0  CPU wakeup interrupts
>> IPI1:          0          0  Timer broadcast interrupts
>>
>> Above, notice how no IPI1 interrupts seem to be arriving.
>>
>> With the cpumask fix above the interrupt count becomes like this:
>>
>>  157:        559          0       GIC 157  e0180000.sti
>> 160:          0          0  e0050000.gpio   1  eth0
>> IPI0:          0          0  CPU wakeup interrupts
>> IPI1:          0        601  Timer broadcast interrupts
>>
>> Would this be in line with your expectation?
>
> Yes that is what I'm saying. What is the output of cat /proc/timer_list?

/ # head -n 60 foo
Timer List Version: v0.7
HRTIMER_MAX_CLOCK_BASES: 4
now at 543066528320 nsecs

cpu: 0
 clock 0:
  .base:       c066f5f8
  .index:      0
  .resolution: 7812500 nsecs
  .get_time:   ktime_get
active timers:
 #0: <c0670148>, menu_hrtimer_notify, S:01
 # expires at 543066282109-543066282109 nsecs [in -246211 to -246211 nsecs]
 clock 1:
  .base:       c066f630
  .index:      1
  .resolution: 7812500 nsecs
  .get_time:   ktime_get_real
active timers:
 clock 2:
  .base:       c066f668
  .index:      2
  .resolution: 7812500 nsecs
  .get_time:   ktime_get_boottime
active timers:
 clock 3:
  .base:       c066f6a0
  .index:      3
  .resolution: 7812500 nsecs
  .get_time:   ktime_get_clocktai
active timers:

cpu: 1
 clock 0:
  .base:       c06775f8
  .index:      0
  .resolution: 7812500 nsecs
  .get_time:   ktime_get
active timers:
 clock 1:
  .base:       c0677630
  .index:      1
  .resolution: 7812500 nsecs
  .get_time:   ktime_get_real
active timers:
 clock 2:
  .base:       c0677668
  .index:      2
  .resolution: 7812500 nsecs
  .get_time:   ktime_get_boottime
active timers:
 clock 3:
  .base:       c06776a0
  .index:      3
  .resolution: 7812500 nsecs
  .get_time:   ktime_get_clocktai
active timers:

Tick Device: mode:     0
Broadcast device
Clock Event Device: e0180000.sti
 max_delta_ns:   131071523464981
 min_delta_ns:   61034
 mult:           70369
 shift:          31
 mode:           3
 next_event:     543070312500 nsecs
 set_next_event: em_sti_clock_event_next
 set_mode:       em_sti_clock_event_mode
 event_handler:  tick_handle_periodic_broadcast
 retries:        0

tick_broadcast_mask: 00000003

Tick Device: mode:     0
Per CPU device: 0
Clock Event Device: dummy_timer
 max_delta_ns:   0
 min_delta_ns:   0
 mult:           1
 shift:          0
 mode:           1
 next_event:     9223372036854775807 nsecs
 set_next_event: <00000000>
 set_mode:       broadcast_timer_set_mode
 event_handler:  tick_handle_periodic
 retries:        0

Tick Device: mode:     0
Per CPU device: 1
Clock Event Device: dummy_timer
 max_delta_ns:   0
 min_delta_ns:   0
 mult:           0
 shift:          0
 mode:           1
 next_event:     9223372036854775807 nsecs
 set_next_event: <00000000>
 set_mode:       dummy_timer_set_mode
 event_handler:  tick_handle_periodic
 retries:        0

Thanks for your help!

/ magnus
