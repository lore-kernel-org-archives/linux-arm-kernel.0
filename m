From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 12 Mar 2015 13:34:08 +0100
Subject: [RFC PATCH v15 04/11] ARM: cpuidle: Register cpuidle_ops for
 QCOM cpus
In-Reply-To: <5500866F.6080704@codeaurora.org>
References: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
 <1425914206-22295-5-git-send-email-lina.iyer@linaro.org>
 <5500866F.6080704@codeaurora.org>
Message-ID: <550187C0.4020006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2015 07:16 PM, Stephen Boyd wrote:
> On 03/09/15 08:16, Lina Iyer wrote:
>> Register cpuidle ops for Krait Processor Sub-System.
>> Supports v1 and v2 versions of KPSS.
>>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>   arch/arm/include/asm/cpuidle_ops.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/cpuidle_ops.h b/arch/arm/include/asm/cpuidle_ops.h
>> index be0a612..40cb262 100644
>> --- a/arch/arm/include/asm/cpuidle_ops.h
>> +++ b/arch/arm/include/asm/cpuidle_ops.h
>> @@ -1,3 +1,8 @@
>>   /*
>>    * List of cpuidle operations
>>    */
>> +
>> +#if IS_ENABLED(CONFIG_QCOM_PM)
>
> Why not #ifdef CONFIG_QCOM_PM? I thought IS_ENABLED was for C code where
> you want to put it in an if () statement.

This is right. But the IS_ENABLED is also valid.

It seems the current trend is to replace #ifdef with #if IS_ENABLED. It 
is supposed to prevent to create or'ed conditional with the module support.

eg:

#if defined(CONFIG_FOO) || defined(CONFIG_FOO_MODULE)

is replaced by:

#if IS_ENABLED(CONFIG_FOO)

Lina: By the way, it would be preferable to use the 
CONFIG_ARM_QCOM_CPUIDLE where IS_ENABLED makes more sense even the 
drivers are not modules (who knows if they are converted as module again 
hence #ifdef will be invalid).



>> +CPUIDLE_OPS(qcom_kpss_v1)
>> +CPUIDLE_OPS(qcom_kpss_v2)
>> +#endif
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
