From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 20 Jan 2014 15:41:55 +0100
Subject: [PATCH] arch_timer: Move delay timer to drivers clocksource
In-Reply-To: <52D932B5.7020909@nvidia.com>
References: <1389791227-24097-1-git-send-email-pgaikwad@nvidia.com>	<20140115154526.GC3571@mudshark.cambridge.arm.com>	<52D76BC8.6080405@nvidia.com>	<20140116121649.GG30257@mudshark.cambridge.arm.com>
 <878uufyo13.fsf@iki.fi> <52D8F403.9070602@linaro.org>
 <52D901B6.1070800@nvidia.com> <52D902D6.3090208@linaro.org>
 <52D915F3.3030500@nvidia.com> <52D91D3A.80800@linaro.org>
 <52D932B5.7020909@nvidia.com>
Message-ID: <52DD35B3.9000606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2014 02:40 PM, Prashant Gaikwad wrote:
> On Friday 17 January 2014 05:38 PM, Daniel Lezcano wrote:
>> On 01/17/2014 12:37 PM, Prashant Gaikwad wrote:
>>> On Friday 17 January 2014 03:45 PM, Daniel Lezcano wrote:
>>>> On 01/17/2014 11:11 AM, Prashant Gaikwad wrote:
>>>>> On Friday 17 January 2014 02:42 PM, Daniel Lezcano wrote:
>>>>>> On 01/17/2014 10:07 AM, Antti Miettinen wrote:
>>>>>>> Will Deacon <will.deacon@arm.com> writes:
>>>>>>>> Why can't you use the C3STOP feature so that the arch-timer isn't
>>>>>>>> used when
>>>>>>>> you go idle?
>>>>>>> That would mean falling back to broadcast timer, right? That's not
>>>>>>> necessarily on the local CPU so wakeups would often wake two CPUs.
>>>>>> You can prevent that if the hardware supports it with the
>>>>>> CLOCK_EVT_DYNIRQ flag on the broadcast timer.
>>>>> Instead of falling back on broadcast timer, is it possible to fall
>>>>> back
>>>>> on other per-CPU timer which is preserved across idle state?
>>>> Is it what you are looking for ?
>>>>
>>>> http://lwn.net/Articles/580568/
>>>>
>>> If I understand correctly these patches enables us to use per-CPU timers
>>> as broadcast timers. I do not want to use broadcast timer.
>> Why ?
>>
>
> For some idle states it may be required to change the timer when
> entering idle state to adjust the exit latency.
>
> It can be done for broadcast timer too but following scenario will not work
>
> 1. CPU1 enters in idle state:
>          Broadcast timer next event is in 2ms, CPU latency is 50us. So
> we change the broadcast timer to send event after (2ms - 50us).
>
> 2. After 1ms CPU2 enters in idle state:
>          Next event is 5ms. Broadcast timer is already programmed to <
> (5ms -50us) so we do nothing.
>
> 3. CPU1 exits from idle state because of timer interrupt
>
> 4. Broadcast event handler:
>      - Timer event is handled and CPU1 is switched back to local timer.
>      - Next CPU is CPU2 and next event for it is 4ms. So brodcast timer
> is programmed to 4ms.
>
> We can not change brodcast timer here to adjust delay caused by CPU exit
> latency.

Thanks for the detailed explanation. IIUC, this not only related to your 
hardware only but with how is implemented the broadcast timer, no ?

I think there is a similar need with the scheduler when it needs to know 
what is the idlest cpu. One thing the scheduler wants to know is the 
wakeup latency in order to choose the cpu in the shallowest state.

> CPU idle governors does help to solve the latency issue. I was thinking
> this from sub-states perspective which are not exposed to CPU idle
> governor.

Could you elaborate what you mean by these sub-states ? Is it related to 
the cpuidle backend drivers choosing an intermediate state different 
from the one the governor choose ?

> Solution for this could be to expose those states to CPU idle governor
> but just wanted to know if we can use timers this way

IMO, that should be studied in a larger scope including the scheduler.

> Another requirement:
>
> We have 3 timers T1, T2, T3 used as wake events for 3 idle states C1,
> C2, C3 respectively.
>
> Rating of T2 is better than T3. If I register T2 and T3 both as
> broadcast timers then T3 will not be used. But ...
>      - T2 is not preserved in C3 idle state.
>      - T3 resolution is very poor (ms) and can not be used as wake event
> for C2.
>
> Possible solution, register only T3 as broadcast device and use T2 as
> per-CPU fallback timer.
>
>>> If I have 2 per-CPU timers T1 and T2, T1 is not preserved across idle
>>> state and T2 is preserved. And I want to use T1 as scheduler timer.
>>> Can I do following for idle state?
>>>
>>> Idle entry:
>>>       clockevents_shutdown(T1);
>>>       clockevents_set_mode(T2, ONESHOT);
>>>       clockevents_program_event(T2, next_event);
>>>
>>> Idle exit:
>>>       clockevents_shutdown(T2);
>>>       clockevents_set_mode(T1, ONESHOT);

See answer to Stephen.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
