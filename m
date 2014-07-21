From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 21 Jul 2014 14:34:23 +0200
Subject: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
In-Reply-To: <20140721140917.16e71558@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>	<52019695.n2AjkGEsJ7@wuerfel>	<20140721133534.3415e425@free-electrons.com>	<5251405.VTrfDi1rj5@wuerfel>
 <20140721140917.16e71558@free-electrons.com>
Message-ID: <53CD08CF.6080900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2014 02:09 PM, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
>
> On Mon, 21 Jul 2014 14:00:22 +0200, Arnd Bergmann wrote:
>
>> I don't know, it really depends on what the differences are between
>> the SoCs, and I haven't looked at them.
>>
>> Using the compatible strings would make it work best if you have one
>> driver per variant, and then share some common code, as opposed to
>> having one shared driver with a number of exceptions.
>>
>> If the differences are just a few parameters, it might be better
>> to encode those parameters in DT properties instead.
>
> The differences are in the cpuidle states that are supported, see
> patches "cpuidle: mvebu: add Armada 370 support" and "cpuidle: mvebu:
> add Armada 38x support" in the series.
>
> I honestly believe that since cpuidle functionality is not described in
> the Device Tree and therefore probed using a statically defined
> platform_device, the good way to pass these informations is to simply
> use platform_data.

Ok, so for the record the cpuidle functionality described via DT is 
under discussion [1].

I understand you need several drivers for the different SoC because of 
the different latencies.

I admit passing an extra flag via the platform_data is a valid approach 
but I have been unifying the different drivers across the existing SoC 
and there is still a lot of things to do. So accepting this patch brings 
another way to discriminate the SoC variant I would like to avoid.

Due the different latencies, I don't think the DT property is enough and 
that may enter in conflict with Lorenzo's work.

So there are three solutions:

1. Pass the flag through the platform data, I am not really in favor of 
that as mentioned above

2. Use the compatible string like the cpuidle-big-little.c driver, but 
Arnd is not in favor of that

3. Register 3 platform drivers, in cpuidle-mvebu-v7.c, and let the 
registering of the cpuidle's platform device to enable the right one


[1] http://www.spinics.net/lists/arm-kernel/msg341541.html


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
