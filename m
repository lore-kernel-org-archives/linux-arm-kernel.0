From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 13 Sep 2013 17:19:17 +0200
Subject: [PATCH v2 00/12] CPU idle for Armada XP
In-Reply-To: <871u4shj6i.fsf@linaro.org>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
 <20130913110043.GJ19363@lunn.ch> <5232F43D.4040404@free-electrons.com>
 <871u4shj6i.fsf@linaro.org>
Message-ID: <52332CF5.8050404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 04:48 PM, Kevin Hilman wrote:
> Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
> 
>> On 13/09/2013 13:00, Andrew Lunn wrote:
>>>
>>> On Fri, Sep 13, 2013 at 12:06:29PM +0200, Gregory CLEMENT wrote:
>>>> Hello,
>>>>
>>>> This patch set adds the CPU idle support for Armada XP and prepares
>>>> the support for Armada 370. This was based on the work of Nadav
>>>> Haklai.
>>>
>>> Hi Gregory.
>>>
>>> Kirkwood has the ability to put the DDR into self refresh mode, which
>>> is used as part of the second level idle mode. Does 370/XP have this?
>>
>> Indeed there is a self refresh bit on a DDR related register. I thought
>> this kind of feature is more likely used for suspend to ram.
>>
>> We plan to also submit the suspend to ram but not immediately.
>>
>>>
>>> For XP, with it being SMP, it would be a bit more complex, since you
>>> would not want to use it unless all CPUs were idle.
>>
>> I wonder how the others SMP ARM SoCs deal with it, I hope this time
>> there will be a framework available and we won't have to create it! ;)
> 
> You shouldn't have to invent anything here.
> 
> For low-power states that require all CPUs to be idle, we have "coupled"
> CPUidle states (c.f. drivers/cpuidle/coupled.)  OMAP and Tegra are using
> this, but I believe Daniel wants to move away from this, so I'll let him
> elaborate.

Yes, I would not recommend to use the "coupled" idle states unless you
have a good reason to do that (eg. only CPU0 can do set the PMU).

If the board provides enough mechanisms with the PMSU, there is an
alternate, lockless, sync algorithm, which can be reused, in the ux500's
cpuidle driver (c.f. drivers/cpuidle/cpuidle-ux500.c).

Otherwise, I recommend to have a look at MCPM (c.f
drivers/cpuidle/cpuidle-big_little.c).

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
