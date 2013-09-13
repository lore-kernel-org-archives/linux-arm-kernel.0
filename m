From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 13 Sep 2013 10:25:57 +0200
Subject: [PATCH 1/2] tick: broadcast: Deny per-cpu clockevents from being
 broadcast sources
In-Reply-To: <alpine.DEB.2.02.1309122224420.4089@ionos.tec.linutronix.de>
References: <1379004640-15117-1-git-send-email-soren.brinkmann@xilinx.com>
 <1379004640-15117-2-git-send-email-soren.brinkmann@xilinx.com>
 <alpine.DEB.2.02.1309122224420.4089@ionos.tec.linutronix.de>
Message-ID: <5232CC15.8090208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2013 10:30 PM, Thomas Gleixner wrote:
> On Thu, 12 Sep 2013, Soren Brinkmann wrote:
>> From: Stephen Boyd <sboyd@codeaurora.org>
>>
>> On most ARM systems the per-cpu clockevents are truly per-cpu in
>> the sense that they can't be controlled on any other CPU besides
>> the CPU that they interrupt. If one of these clockevents were to
>> become a broadcast source we will run into a lot of trouble
>> because the broadcast source is enabled on the first CPU to go
>> into deep idle (if that CPU suffers from FEAT_C3_STOP) and that
>> could be a different CPU than what the clockevent is interrupting
>> (or even worse the CPU that the clockevent interrupts could be
>> offline).
>>
>> Theoretically it's possible to support per-cpu clockevents as the
>> broadcast source but so far we haven't needed this and supporting
>> it is rather complicated. Let's just deny the possibility for now
>> until this becomes a reality (let's hope it never does!).
> 
> Well, we can't do it this way. There are globally accessible clock
> event devices which deliver only to cpu0. So the mask check might be
> causing failure here.
> 
> Just add a feature flag CLOCK_EVT_FEAT_PERCPU to the clock event
> device and check for it.

It sounds probably more understandable than dealing with the cpumasks.

I am wondering if this is semantically opposed to
http://lwn.net/Articles/566270/ ?

[PATCH V3 0/6] cpuidle/ppc: Enable broadcast support for deep idle states

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

  * English - detected
  * English
  * French

  * English
  * French

 <javascript:void(0);>
