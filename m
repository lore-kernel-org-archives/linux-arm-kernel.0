From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 26 Feb 2017 15:40:49 +0100
Subject: [PATCH v2 04/17] clocksource: Add Owl timer
In-Reply-To: <20170225215941.GA30601@mai>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-5-afaerber@suse.de> <20170224222921.GA23152@mai>
 <ab18d509-9fb2-1b4c-bdee-e2ce5d4273a3@suse.de> <20170225215941.GA30601@mai>
Message-ID: <afd6bfbc-e17c-dd79-d2ff-42bac6c274db@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.02.2017 um 22:59 schrieb Daniel Lezcano:
> On Sat, Feb 25, 2017 at 12:25:32AM +0100, Andreas F?rber wrote:
>> Am 24.02.2017 um 23:29 schrieb Daniel Lezcano:
>>> On Fri, Feb 24, 2017 at 04:40:42AM +0100, Andreas F?rber wrote:
>>>> +static struct clock_event_device owl_clockevent = {
>>>> +	.name			= "owl_tick",
>>>> +	.rating			= 200,
>>>> +	.features		= CLOCK_EVT_FEAT_ONESHOT,
>>>
>>> Did you consider adding CLOCK_EVT_FEAT_DYNIRQ ?
>>
>> No, it was not present downstream. Got a good example?
> 
> https://lwn.net/Articles/541000/

Looking at your current Nomadik code, it seems I can literally should
just add this flag (done), without needing to implement any new hooks.

On a related topic, how do we determine the cpumask? Downstream and some
in-tree drivers use cpumask_of(0), others use cpu_possible_mask.

>> Do you spot anything functionally wrong in this driver? Despite adding
>> this new driver, I am only getting the following additional earlycon output:
>>
>> [    0.000029] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps
>> every 89478484971ns
>> [    0.007888] clocksource: timer: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 79635851949 ns
>> [    0.017748] Console: colour dummy device 80x30
>> [    0.022243] Calibrating delay loop...
>> [    0.030895] random: fast init done
>> [    0.231021] random: crng init done
>>
>> For S900 I'm using the generic timer instead.
> 
> I don't get the issue, can you elaborate ?

Found it myself: I forgot to clear the interrupt pending bit in the
interrupt handler routine.

+       writel(OWL_Tx_CTL_PD, owl_timer_base + OWL_T1_CTL);

Now it goes past this point, initializes the real serial driver and
boots up to not finding the rootfs:

[    0.000032] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps
every 89478484971ns
[    0.007898] clocksource: timer: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 79635851949 ns
[    0.017886] Console: colour dummy device 80x30
[    0.022386] Calibrating delay loop... 405.50 BogoMIPS (lpj=2027520)
[    0.083523] pid_max: default: 32768 minimum: 301
...

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
