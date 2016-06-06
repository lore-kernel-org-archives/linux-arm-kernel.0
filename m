From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 6 Jun 2016 13:23:54 +0200
Subject: [PATCH 5/9] clocksource/drivers/exynos_mct: Convert init function
 to return error
In-Reply-To: <575555CC.1020906@samsung.com>
References: <1464770093-12667-1-git-send-email-daniel.lezcano@linaro.org>
 <1464770093-12667-6-git-send-email-daniel.lezcano@linaro.org>
 <575555CC.1020906@samsung.com>
Message-ID: <57555D4A.8010001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016 12:51 PM, Krzysztof Kozlowski wrote:
> On 06/01/2016 10:34 AM, Daniel Lezcano wrote:
>> The init functions do not return any error. They behave as the following:
>>
>>   - panic, thus leading to a kernel crash while another timer may work and
>>     make the system boot up correctly
>>
>>   or
>>
>>   - print an error and let the caller unaware if the state of the system
>>
>> Change that by converting the init functions to return an error conforming
>> to the CLOCKSOURCE_OF_RET prototype.
>>
>> Proper error handling (rollback, errno value) will be changed later case
>> by case, thus this change just return back an error or success in the init
>> function.
>
> I don't see the benefits of this change alone. You are replacing one
> non-return code to another always-return-success code. The effect is
> exactly the same. It would make sense to change it to CLOCKSOURCE_OF_RET
> along with proper error handling.
>

Hi Krzysztof,

I can understand you expect an error handling but, as stated in the 
changelog, proper error handling will be done later. Currently, there 
are roughly 80 drivers to changes the init function to return a value in 
order change the CLOCKSOURCE_OF_DECLARE macro. That is a quite important 
number and changing also the internals will introduce bugs.

So the series (and there is a huge one coming right after this one), 
will focus only on changing the init function to return a value, so we 
can swap the clocksource table and rename CLOCKSOURCE_OF_DECLARE_RET 
without the '_RET'. I want this to be done before the next PR in order 
to prevent to have a double clksrc table.

If error handling is already taken into account and is trivial, I try to 
do the change, otherwise I let the function to return a success value.

Regarding the important number of drivers, if you have time to change 
the init function in the exynos_mct, that will be more than welcome :)

   -- Daniel




-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
