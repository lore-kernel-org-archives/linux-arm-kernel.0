From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 19 Apr 2012 16:49:12 +0200
Subject: [PATCH 06/17][V2] ARM: OMAP4: cpuidle - use the omap4_idle_data
 variable directly
In-Reply-To: <87r4vw8qfd.fsf@ti.com>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
 <1333570371-1389-7-git-send-email-daniel.lezcano@linaro.org>
 <87r4vw8qfd.fsf@ti.com>
Message-ID: <4F9025E8.9020707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2012 12:56 AM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> We are storing the 'omap4_idle_data' in the private data field
>> of the cpuidle device. As we are using this variable only in this file,
>> that does not really make sense. Let's use the global variable directly
>> instead dereferencing pointers in an idle critical loop.
>
> Did you notice a performance impact before this change?

No, I didn't and I don't think I will be able to measure it. But by 
experience, when dereferencing a pointer that could leads to a cache 
miss and impact the performances. That may not be the case here, so I 
won't argue with that as I won't able to prove it :)

>> Also, that simplfies the code.
>
> possibly, but at the expense of clean abstractions which IMO helps readability.
>
> Unless there is a real performance hit here (which I doubt), I'd prefer
> to leave this as is.

There are two reasons of this change. We are storing 'state_count' times 
a pointer in a private structure for state_usage but the information is 
already available in the file and easily accessible.
Also, this is set in the fill_cstate function I am removing to let all 
the initialization to be done at compile time.

Furthermore, I don't get why we have a 'driver data' area in a structure 
which is dedicated for the states statistics, IMHO that does not help 
understanding. My mid-term cleanup is to kill the 'driver_data' field in 
the cpuidle core because I don't think it is at the right place.

An idea I had for consolidate all the cpuidle driver was to use the 
containerof macro to define the architecture specific structure and 
declare inside this structure the cpuidle driver and the devices. It is 
similar on how are implemented the 'routes' for the network stack or the 
cgroup subsystems, there is a core engine handling generic structure 
which a contained by the specific structure related to the engine's 
user. That helps a lot for readability.

Well this is an idea but before I have to unify the cpuidle drivers code 
to make it clear what is doable or not.



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
