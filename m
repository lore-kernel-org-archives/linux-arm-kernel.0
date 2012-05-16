From: khilman@ti.com (Kevin Hilman)
Date: Wed, 16 May 2012 16:07:21 -0700
Subject: [PATCHv2 10/19] ARM: OMAP4: PM: Work-around for ROM code BUG
 of IVAHD/TESLA
In-Reply-To: <87zk976827.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-11-git-send-email-t-kristo@ti.com> <87zk976827.fsf@ti.com>
Message-ID: <4FB43329.50505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2012 04:05 PM, Kevin Hilman wrote:
> Tero Kristo<t-kristo@ti.com>  writes:
>
>> From: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>
>> The ROM BUG is when MPU Domain OFF wake up sequence that can compromise
>> IVA and Tesla execution.
>>
>> At wakeup from MPU OFF on HS device only (not GP device), when
>> restoring the Secure RAM, the ROM Code reconfigures the clocks the
>> same way it is done at Cold Reset.
>
> Ouch.
>
>> The IVAHD Clocks and Power Domain settings are:
>> 	IVAHD_CM2 IVAHD_CLKCTRL_MODULE_MODE = DISABLE
>> 	IVAHD_CM2 SL2_CLKCTRL_MODULE_MODE = DISABLE
>> 	IVAHD_CM2 SL2_CLKSTCTRL_CLKTRCTRL = HW_AUTO
>> 	IVAHD_PRM IVAHD_PWRSTCTRL_POWERSTATE = OFF
>> The TESLA Clocks and Power Domain settings are:
>> 	TESLA_CM1 TESLA_CLKCTRL_MODULE_MODE = DISABLE
>> 	TESLA_CM1 TESLA_CLKSTCTRL_CLKTRCTRL = HW_AUTO
>> 	TESLA_PRM TESLA_PWRSTCTRL_POWERSTATE = OFF
>>
>> This patch fixes the low power OFF mode code so that the these
>> registers are saved and restore across MPU OFF state.
>>
>> Also because of this limitation, MPU OFF alone is not targeted without
>> device OFF to avoid IVAHD and TESLA execution impact
>
> I don't see where this restriction is implemented.
>
> And, can this be hooked into cluster PM notifiers.

Especially since this only effects a subset of revisions, installing the 
notifier only on effected revisions also removes any overhead on working 
revisions.

Kevin
