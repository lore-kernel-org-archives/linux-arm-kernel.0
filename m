From: hechtb@gmail.com (Bastian Hecht)
Date: Thu, 11 Apr 2013 14:06:24 +0200
Subject: [PATCH] ARM: shmobile: r8a7740: Add Suspend-To-RAM modes and
 CPUIdle
In-Reply-To: <51667D68.7070804@linaro.org>
References: <1365609107-14290-1-git-send-email-hechtb+renesas@gmail.com>
 <5165E929.9030309@linaro.org>
 <CABYn4sxEOvQhZP7GnS5-AgNjkvJJXyv4n1UjVGBjXbVq0N+9_A@mail.gmail.com>
 <51667D68.7070804@linaro.org>
Message-ID: <CABYn4syA6R0PU1xEQLcm29sYkD+fGi6vx+tCrFSNfA4qPo0npg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

>>>> +
>>>> +static struct cpuidle_driver r8a7740_cpuidle_driver = {
>>>> +     .name                   = "r8a7740_cpuidle",
>>>> +     .owner                  = THIS_MODULE,
>>>> +     .en_core_tk_irqen       = 1,
>>>> +     .state_count            = 3,
>>>> +     .safe_state_index       = 0, /* C1 */
>>>> +     .states[0] = ARM_CPUIDLE_WFI_STATE,
>>>> +     .states[0].enter = shmobile_enter_wfi,
>>>
>>> The WFI macro already set a simple enter function doing cpu_do_idle.
>>
>> Oh yes, I'll remove it.
>>
>>> We are trying to consolidate the cpuidle drivers across the different
>>> platforms [1]. One of the objective is to move the cpuidle drivers to
>>> drivers/cpuidle, a place where they belong to.
>>>
>>> Do you think it is possible you split your code to have one part with
>>> the cpuidle driver and another part with the PM code ?
>>
>> Hmm. The CPUIdle part is enclosed in the #ifdef CONFIG_CPU_IDLE part anyway.
>> The other part (CONFIG_SUSPEND | CONFIG_CPU_IDLE) contains the part
>> that actually does drive down the hardware and is needed as soon as
>> SUSPEND or CPUIdle is used.
>>
>> So is it split well enough already or does it help if I split my patch
>> into 2, first adding suspend and then CPUIdle to the same file? But
>> the outcome will be the same I think.
>
>
> Well, if you can convert the pm functions into ops used in the cpuidle
> driver and then create a file eg. cpuidle-r8a7740.c with the cpuidle
> code calling the ops that will separate clearly the cpuidle code from
> the pm code and make easier to move the cpuidle driver to the
> drivers/cpuidle directory. Also, I think that will help to consolidate
> the other shmobile cpuidle drivers, maybe into a single one.
>
>

Ok I've prepared a new patchset and think the splitting looks good .
As this is a sensitive code area I want to retest it though and post
it in a couple of hours.

Cheers,

 Bastian
