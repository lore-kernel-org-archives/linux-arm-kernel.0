From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 25 Apr 2014 14:56:37 +0900
Subject: [PATCHv4 3/7] ARM: EXYNOS: Support secondary CPU boot of
 Exynos3250
In-Reply-To: <5359F894.4070205@linaro.org>
References: <1398388572-30239-1-git-send-email-cw00.choi@samsung.com>
 <1398388572-30239-4-git-send-email-cw00.choi@samsung.com>
 <5359E4E6.90102@linaro.org> <5359F5F5.7030109@samsung.com>
 <5359F894.4070205@linaro.org>
Message-ID: <5359F915.6030009@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/25/2014 02:54 PM, Tushar Behera wrote:
> On 04/25/2014 11:13 AM, Chanwoo Choi wrote:
>> Hi,
>>
>> On 04/25/2014 01:30 PM, Tushar Behera wrote:
>>> On 04/25/2014 06:46 AM, Chanwoo Choi wrote:
>>>> This patch fix the offset of CPU boot address and don't need to send smc call
>>>> of SMC_CMD_CPU1BOOT command for secondary CPU boot because Exynos3250 removes
>>>> WFE in secure mode.
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>> ---
>>>>  arch/arm/mach-exynos/firmware.c | 10 ++++++++--
>>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
>>>> index aa01c42..386d01d 100644
>>>> --- a/arch/arm/mach-exynos/firmware.c
>>>> +++ b/arch/arm/mach-exynos/firmware.c
>>>> @@ -31,11 +31,17 @@ static int exynos_do_idle(void)
>>>>  static int exynos_cpu_boot(int cpu)
>>>>  {
>>>>  	/*
>>>> +	 * Exynos3250 doesn't need to send smc command for secondary CPU boot
>>>> +	 * because Exynos3250 removes WFE in secure mode.
>>>> +	 */
>>>> +	if (soc_is_exynos3250())
>>>> +		return 0;
>>>> +	/*
>>>>  	 * The second parameter of SMC_CMD_CPU1BOOT command means CPU id.
>>>>  	 * But, Exynos4212 has only one secondary CPU so second parameter
>>>>  	 * isn't used for informing secure firmware about CPU id.
>>>>  	 */
>>>> -	if (soc_is_exynos4212())
>>>> +	else if (soc_is_exynos4212())
>>>
>>> This changes is not required.
>>
>> Do you mean it as following?
>>
>> 	if (soc_is_exynos3250())
>> 		return 0
>>
>> 	if (soc_is_exynos4212())
>> 		cpu = 0;
>>
> 
> Yes, logically the flow would be same and code would be more readable.

OK, I'll fix it.

Thanks,
Chanwoo Choi
