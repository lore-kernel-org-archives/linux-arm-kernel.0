From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 21 Mar 2012 17:42:27 +0100
Subject: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
In-Reply-To: <CAORVsuUeE046O7YJ_fE49NbW1OjZHZX+GuNiDkF0AnzBnSMbxA@mail.gmail.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
 <4F69A872.50203@ti.com>
 <CAORVsuUeE046O7YJ_fE49NbW1OjZHZX+GuNiDkF0AnzBnSMbxA@mail.gmail.com>
Message-ID: <4F6A04F3.6050306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2012 02:43 PM, Jean Pihet wrote:
> On Wed, Mar 21, 2012 at 11:07 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> Daniel,
>>
>> On Wednesday 21 March 2012 02:57 PM, Daniel Lezcano wrote:
>>> This patchset is a proposition to improve a bit the code.
>>> The changes are code cleanup and does not change the behavior of the
>>> driver itself.
>>>
>>> A couple a things call my intention. Why the cpuidle device is set for cpu0 only
>>> and why the WFI is not used ?
>>>
>>> Daniel Lezcano (7):
>>>    ARM: OMAP4: cpuidle - Remove unused valid field
>>>    ARM: OMAP4: cpuidle - Declare the states with the driver declaration
>>>    ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
>>>    ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
>>>    ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
>>>    ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
>>>    ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at boot
>>>      time
>>>
>> The series looks fine to me in general. This clean-up is applicable
>> for OMAP3 cpuidle code as well.
> Great!
> However OMAP3 has a few specific things that cannot be removed as easily:
> - the 'valid' flag is used because only certain combinations of power
> domains states are possible,

When I look the board-rx51 code I see:

static struct cpuidle_params rx51_cpuidle_params[] = {
	/* C1 */
	{110 + 162, 5 , 1},
	/* C2 */
	{106 + 180, 309, 1},
	/* C3 */
	{107 + 410, 46057, 0},
	/* C4 */
	{121 + 3374, 46057, 0},
	/* C5 */
	{855 + 1146, 46057, 1},
	/* C6 */
	{7580 + 4134, 484329, 0},
	/* C7 */
	{7505 + 15274, 484329, 1},
};

If C3, C4, C6 are not valid, so AFAICS never used in the cpuidle code
why the values are 'exit_latency' and 'target_residency' specified ? I 
mean why don't we have { 0, 0, 0 } ? Is it just for information ?

I understand the purpose of this code but it looks a bit tricky and hard 
to factor out. Is it acceptable to create a new cpuidle driver for rx51 
then we factor out the code between omap3, omap4 and rx51 when all the 
code consistent ?

> - the latency settings can be overriden by the board code, so the
> cpuidle_params struct is needed.
>
>> I want Jean to look at this series because some of his earlier
>> clean up has introduced those custom functions which
>> are getting removed in this series.
>>
>> Regards
>> santosh
>>
>>
>
> Thanks,
> Jean


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
