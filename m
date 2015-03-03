From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 03 Mar 2015 16:20:26 +0100
Subject: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
In-Reply-To: <54F5CC0D.6060509@libero.it>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com>
 <4892716.Bf612zPN6E@vostro.rjw.lan> <54F03B51.1010708@free-electrons.com>
 <54F58D2F.2010907@linaro.org> <54F58E3B.9040302@free-electrons.com>
 <54F59285.5060306@libero.it> <54F5AE5C.6060006@free-electrons.com>
 <54F5CC0D.6060509@libero.it>
Message-ID: <54F5D13A.1020002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2015 03:58 PM, Fulvio wrote:
>
>> I didn't know you experimented random kernel panics and that you thought
>> it was related to the CPU Idle driver.
>>
>>> All i can say is that the system use the "armadaxp_idle" driver and
>>> works fine when running "stress --cpu 8" in background.
>>> I asked Netgear to provide a firmware without the idle driver to
>>> confirm if it's the cause of the problem, but they did not answered.
>>
>> I think that if you disable all the state using by doing an
>>
>> echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/stateNUM/disable
>>
>> where NUM is the nuymbert of the state. Then it should disable the
>> cpuidle on the fly.
> Thanks, i'll try that as soon as possible (i gave back the unit to my
> client) and report back.
>
> However, the description of the cpu_pm_enter function state:
> "Must be called on the affected CPU with interrupts disabled.  Platform
> is responsible for ensuring that cpu_pm_enter is not called twice on the
> same CPU before cpu_pm_exit is called. Notified drivers can include VFP
> co-processor, interrupt controller and its PM extensions, local CPU
> timers context save/restore which shouldn't be interrupted. Hence it
> must be called with interrupts disabled."
>
> and the point is: it that an invariant? Do current code and future code
> safely assume that cpu_pm_enter is not called twice?

The fix is correct. The cpu_pm_enter/exit symmetry must be kept because 
we don't know what the notifier clients are doing.

The point is : can we send it to stable@ as a bug fix or not ?

> For example if cpu_pm_enter do "context save" and cpu_pm_exit do
> "context restore", calling twice cpu_pm_enter will overwrite the
> previous saved context: is that safe in all circumstances?

That is the drawback of the notifiers: the kernel provides a service and 
everyone plug something on it. The cpu_pm notifier are very low level 
functions, so the answer of your question is not obvious. I already 
checked all the cpuidle drivers if the potential bug you reported is 
there or not but apparently everything else is fine, cpu_pm_exit is 
always called after cpu_pm_enter.

As you stated, the API description implies cpu_pm_exit must be called 
after cpu_pm_enter. So the fix is right.

> I assume the rule " It must fix a real bug that bothers people (not a,
> "This could be a problem..." type thing)." is to avoid committing
> useless changes that may introduce new bugs, but i do not think that
> apply to this case: a bug report from an unknown user (me) should change
> nothing.

It would be perfect if we can succeed to reproduce the bug you are 
facing and check the patch fixes it. In this case, it goes to stable@ 
automatically.


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
