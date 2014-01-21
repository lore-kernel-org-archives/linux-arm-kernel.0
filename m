From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 21 Jan 2014 09:40:15 +0100
Subject: [PATCH] arch_timer: Move delay timer to drivers clocksource
In-Reply-To: <52DE2DB5.5000101@nvidia.com>
References: <1389791227-24097-1-git-send-email-pgaikwad@nvidia.com>	<20140115154526.GC3571@mudshark.cambridge.arm.com>	<52D76BC8.6080405@nvidia.com>	<20140116121649.GG30257@mudshark.cambridge.arm.com>
 <878uufyo13.fsf@iki.fi> <52D8F403.9070602@linaro.org>
 <52D901B6.1070800@nvidia.com> <52D902D6.3090208@linaro.org>
 <52D915F3.3030500@nvidia.com> <52D91D3A.80800@linaro.org>
 <52D932B5.7020909@nvidia.com> <52D97831.6030700@codeaurora.org>
 <52DD35C2.3070809@linaro.org> <52DE2DB5.5000101@nvidia.com>
Message-ID: <52DE326F.40105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2014 09:20 AM, Prashant Gaikwad wrote:
> On Monday 20 January 2014 08:12 PM, Daniel Lezcano wrote:
>> On 01/17/2014 07:36 PM, Stephen Boyd wrote:
>>> On 01/17/14 05:40, Prashant Gaikwad wrote:
>>>> Another requirement:
>>>>
>>>> We have 3 timers T1, T2, T3 used as wake events for 3 idle states C1,
>>>> C2, C3 respectively.
>>>>
>>>> Rating of T2 is better than T3. If I register T2 and T3 both as
>>>> broadcast timers then T3 will not be used. But ...
>>>>       - T2 is not preserved in C3 idle state.
>>>>       - T3 resolution is very poor (ms) and can not be used as wake
>>>> event for C2.
>>>>
>>>> Possible solution, register only T3 as broadcast device and use T2 as
>>>> per-CPU fallback timer.
>>> We have the same situation on MSM. I've been thinking about proposing we
>>> allow multiple broadcast timers to exist in the system and then have the
>>> clockevents_notify() caller indicate which C state is being entered. The
>>> broadcast timers would need to indicate which C state they don't work in
>>> though.
>> IMO, there are different solutions:
>>
>> 1. extend the C3STOP to C1STOP, C2STOP, etc ... and pass the idle state
>> to the time framework where these flags are checked against. I don't
>> like this approach but it is feasible.
>>
>> 2. use the generic power domain. When the power domain is shutdown via
>> the cpuidle backend driver, it switches the timer.
>
> I am aware of a way to attach idle state to GenPD where we enable an
> idle state when that power domain is turned off but not the other way
> where domain is shutdown via CPU idle driver. How do we do it?
>
> Even though we shutdown power domain via cpuidle driver this still has
> to happen from CPU idle state, is that correct assumption? and we switch
> the timer here. So we still need a way to switch timer from CPU idle
> state. Hence the question remains is how to switch timers from idle state?

You can effectively attach a power domain to a cpuidle state but that 
wasn't the point.

What I meant is to create a generic power domain which maps the power 
domain of the idle state. When the power domain is shutdown, the 
callback of the genpd will switch to the timer.

I can't give too much details because I am not used to this code but 
maybe it is a good solution for your specific case.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
