From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 03 Mar 2015 14:00:51 +0100
Subject: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
In-Reply-To: <54F5AE5C.6060006@free-electrons.com>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com>
 <4892716.Bf612zPN6E@vostro.rjw.lan> <54F03B51.1010708@free-electrons.com>
 <54F58D2F.2010907@linaro.org> <54F58E3B.9040302@free-electrons.com>
 <54F59285.5060306@libero.it> <54F5AE5C.6060006@free-electrons.com>
Message-ID: <54F5B083.5010601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2015 01:51 PM, Gregory CLEMENT wrote:
> Hi Fulvio,
>
> On 03/03/2015 11:52, Fulvio wrote:
>> Gregory CLEMENT wrote:
>>> Hi Rafael,
>>>
>>>
>>>
>>> On 03/03/2015 11:30, Daniel Lezcano wrote:
>>>
>>>> On 02/27/2015 10:39 AM, Gregory CLEMENT wrote:
>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> On 26/02/2015 22:55, Rafael J. Wysocki wrote:
>>>>>
>>>>>> On Thursday, February 26, 2015 06:20:48 PM Gregory CLEMENT wrote:
>>>>>>
>>>>>>> As stated in kernel/cpu_pm.c, "Platform is responsible for ensuring
>>>>>>> that cpu_pm_enter is not called twice on the same CPU before
>>>>>>> cpu_pm_exit is called.". In the current code in case of failure when
>>>>>>> calling mvebu_v7_cpu_suspend, the function cpu_pm_exit() is never
>>>>>>> called whereas cpu_pm_enter() was called just before.
>>>>>>>
>>>>>>> This patch moves the cpu_pm_exit() in order to balance the
>>>>>>> cpu_pm_enter() calls.
>>>>>>>
>>>>>>> Reported-by: Fulvio Benini <fbf@libero.it>
>>>>>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>>>>>
>>>>>> Should that go to "stable" too?  Which "stable" series it should go to if so?
>>>>>>
>>>>> Yes as it fixes a potential issue, you're right it should go
>>>>> to "stable". The bug was here since the introduction of the driver
>>>>> in 3.16.
>>>>>
>>>> Hi Gregory,
>>>>
>>>> actually the 'stable' rules state clearly:
>>>>
>>>> "- It must fix a real bug that bothers people (not a, "This could be a
>>>> problem..." type thing)."
>>>>
>>>> You say "it fixes a potential issue", so no bug has been raise yet, right ?
>>>>
>>>
>>> Indeed nobody claimed yet having a bug related to this issue.
>>>
>>> Gregory
>>>
>>>
>> I reported the issue, but i cannot say if it's a real bug.
>> I had random kernel panics with a Netgear ReadyNAS RN102 (armada 370 cpu):
>> http://www.readynas.com/forum/viewtopic.php?f=20&t=78697&sid=14747617286d55ac27296cdee7a3f420&start=210#p452214
>
> I didn't know you experimented random kernel panics and that you thought
> it was related to the CPU Idle driver.
>
>>
>> All i can say is that the system use the "armadaxp_idle" driver and
>> works fine when running "stress --cpu 8" in background.
>> I asked Netgear to provide a firmware without the idle driver to confirm
>> if it's the cause of the problem, but they did not answered.
>
> I think that if you disable all the state using by doing an
>
> echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/stateNUM/disable
>
> where NUM is the nuymbert of the state. Then it should disable the
> cpuidle on the fly.
>
> Daniel, is it correct?

Yes, it is correct.

Make sure it is done on all cpus.

> Or if you can modify your bootargs, then just add cpuidle.off=1 to the kernel
> command line.
>
> Thanks,
>
> Gregory
>
>> Bye,
>> Fulvio
>>
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
