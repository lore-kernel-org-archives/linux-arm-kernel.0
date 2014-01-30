From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 30 Jan 2014 14:44:00 +0100
Subject: [PATCH v2 1/6] idle: move the cpuidle entry point to the generic
 idle loop
In-Reply-To: <alpine.LFD.2.11.1401300021530.1652@knanqh.ubzr>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-2-git-send-email-nicolas.pitre@linaro.org>
 <alpine.LFD.2.11.1401291526320.1652@knanqh.ubzr>
 <52E9C946.50704@linux.vnet.ibm.com>
 <alpine.LFD.2.11.1401300021530.1652@knanqh.ubzr>
Message-ID: <52EA5720.8010000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2014 06:28 AM, Nicolas Pitre wrote:
> On Thu, 30 Jan 2014, Preeti U Murthy wrote:
>
>> Hi Nicolas,
>>
>> On 01/30/2014 02:01 AM, Nicolas Pitre wrote:
>>> On Wed, 29 Jan 2014, Nicolas Pitre wrote:
>>>
>>>> In order to integrate cpuidle with the scheduler, we must have a better
>>>> proximity in the core code with what cpuidle is doing and not delegate
>>>> such interaction to arch code.
>>>>
>>>> Architectures implementing arch_cpu_idle() should simply enter
>>>> a cheap idle mode in the absence of a proper cpuidle driver.
>>>>
>>>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>>>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> As mentioned in my reply to Olof's comment on patch #5/6, here's a new
>>> version of this patch adding the safety local_irq_enable() to the core
>>> code.
>>>
>>> ----- >8
>>>
>>> From: Nicolas Pitre <nicolas.pitre@linaro.org>
>>> Subject: idle: move the cpuidle entry point to the generic idle loop
>>>
>>> In order to integrate cpuidle with the scheduler, we must have a better
>>> proximity in the core code with what cpuidle is doing and not delegate
>>> such interaction to arch code.
>>>
>>> Architectures implementing arch_cpu_idle() should simply enter
>>> a cheap idle mode in the absence of a proper cpuidle driver.
>>>
>>> In both cases i.e. whether it is a cpuidle driver or the default
>>> arch_cpu_idle(), the calling convention expects IRQs to be disabled
>>> on entry and enabled on exit. There is a warning in place already but
>>> let's add a forced IRQ enable here as well.  This will allow for
>>> removing the forced IRQ enable some implementations do locally and
>>
>> Why would this patch allow for removing the forced IRQ enable that are
>> being done on some archs in arch_cpu_idle()? Isn't this patch expecting
>> the default arch_cpu_idle() to have re-enabled the interrupts after
>> exiting from the default idle state? Its supposed to only catch faulty
>> cpuidle drivers that haven't enabled IRQs on exit from idle state but
>> are expected to have done so, isn't it?
>
> Exact.  However x86 currently does this:
>
> 	if (cpuidle_idle_call())
> 	        x86_idle();
> 	else
> 	        local_irq_enable();
>
> So whenever cpuidle_idle_call() is successful then IRQs are
> unconditionally enabled whether or not the underlying cpuidle driver has
> properly done it or not.  And the reason is that some of the x86 cpuidle
> do fail to enable IRQs before returning.
>
> So the idea is to get rid of this unconditional IRQ enabling and let the
> core issue a warning instead (as well as enabling IRQs to allow the
> system to run).

But what I don't get with your comment is the local_irq_enable is done 
from the cpuidle common framework in 'cpuidle_enter_state' it is not 
done from the arch specific backend cpuidle driver.

So the code above could be:

	if (cpuidle_idle_call())
		x86_idle();

without the else section, this local_irq_enable is pointless. Or may be 
I missed something ?


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
