From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 27 Apr 2016 16:25:01 +0300
Subject: [PATCH v1] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
In-Reply-To: <57209154.6050508@arm.com>
References: <1461684532-16848-1-git-send-email-grygorii.strashko@ti.com>
 <20160426160245.GI28464@e106497-lin.cambridge.arm.com>
 <571FC2EC.9090605@ti.com> <57209154.6050508@arm.com>
Message-ID: <5720BDAD.1040806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2016 01:15 PM, Robin Murphy wrote:
> On 26/04/16 20:35, Grygorii Strashko wrote:
>> On 04/26/2016 07:02 PM, Liviu Dudau wrote:
>>> On Tue, Apr 26, 2016 at 06:28:52PM +0300, Grygorii Strashko wrote:
>>>
>>> Hi Grygorii,
>>>
>>> First time I'm seeing this patch, so I have a few questions, mostly
>>> related to the commit message:
>>
>> Hm. You are in cc for RFC.
>> Sry, forgot to add link [1].
>>
>>>
>>>> This patch intended to fix following cases:
>>>> - SoC-A has ARM GT, defines DT node for ARM GT and selects
>>>> ARM_GLOBAL_TIMER statically in Kconfig file. SoC-B has ARM GT and
>>>> defines DT node for ARM GT, but do not selects ARM_GLOBAL_TIMER
>>>> statically in Kconfig file. In case of multiplatform build ARM GT will
>>>> be implicitly enabled for SoC-B.
>>>
>>> Well, SoC-B has the GT *and* the DT node, so what is the problem with
>>> enabling it for SoC-B? If there are reasons not to use the Global Timer
>>> on SoC-B, surely a better option would be to mark it in DT with 
>>> status = "disabled";
>>
>> This was rejected [2]. DT describes HW and if it is functional the 
>> status = "disabled"
>> is not good choice.
>> ARM GT can't be used as clocksource/sched_clock/clockevent when 
>> CPUFreq or
>> CPUIdle are enabled :(, and this is Linux specific functionality and
>> not HW description.
> 
> It sounds to me like the cleanest option might then be to address it 
> within the Linux-specific driver itself. How feasible would it be for 
> the GT driver to detect at runtime whether CPUfreq/idle will be used and 
> simply refuse to register as a clocksource if so? (I guess there are 
> probably horrible initialisation order issues, at least...)
> 

I do not thinK this is really possible, taking into account that
clockevent device might need to be registered very early and 
PM features can be enabled/disabled dynamically.
For example, PM is enabled by loading module for TI am437x and am335x SoCs,
but ARM GT is initialized much earlier. Before loading PM module,
it is (theoretically) possible to change clocksource and
clockevent (unbind) devices, but there is no way to change sched_clock
(or timer_delay).

-- 
regards,
-grygorii
